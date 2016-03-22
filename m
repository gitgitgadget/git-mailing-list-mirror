From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] branch -D: allow - as abbreviation of '@{-1}'
Date: Tue, 22 Mar 2016 10:12:00 -0700
Message-ID: <xmqqwpouigin.fsf@gitster.mtv.corp.google.com>
References: <1458635056-26633-1-git-send-email-elena.petrashen@gmail.com>
	<xmqq1t72jvac.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Matthieu.Moy@grenoble-inp.fr, sbeller@google.com
To: Elena Petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:12:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiPqk-0005vl-Go
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:12:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbcCVRMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:12:06 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbcCVRME (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:12:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 22C7F4E0DD;
	Tue, 22 Mar 2016 13:12:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N5g53xptW3l9x6TB5Aic35SK9uc=; b=u7bryp
	Cfg6aw+6/eYEvSUmzOrgS6FKETQZ1ubNMFDZAUUVZxsrTa6mfvjcEjj3mZGtd/kI
	T4gOpzfN+jCx7pfxNoULBxkL/D6qZxWWp0tIZ+tpYiYWciDMsrHPJWDYDn9LuC/v
	zUOl0jWRXsFDICN8qmp0HE7kGZ+V7UTnBeVkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QNhC2zCWUQy3h3cHxBv9D5veCce9Vq2h
	lJEpZR3jJNsK4WWKbbv/WpQ7iEnohkEKO8BzzocKQKBz6kMuE61TGBrJEwCdlZZ9
	sJ5WNHS9MKY3MwPf5Lptch3+xD63SbJM1HDXKUK24D9+xHe8BmB2fzl9s8UcbXl2
	0wprnB4AVNA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A7764E0DC;
	Tue, 22 Mar 2016 13:12:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 061FD4E0DA;
	Tue, 22 Mar 2016 13:12:01 -0400 (EDT)
In-Reply-To: <xmqq1t72jvac.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 22 Mar 2016 10:07:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 31A27BE6-F051-11E5-8A68-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289519>

Junio C Hamano <gitster@pobox.com> writes:

> I _think_ strbuf_branchname() leaves "@{-<N>}" when you do not have
> enough branch switches in the reflog, so perhaps ...

This is a tangent, but the value returned from strbuf_branchname()
is not well documented, and nobody looks at it.  It might not be a
bad idea to change the return value from the function in such a way
that it can signal "I saw @{-<N>} syntax but there weren't enough
branch switches" and also "I saw branch@{upstream} syntax but that
branch does not have an upstream configured for it" to its callers.

That way, the suggested "perhaps like this..." patch does not have
to do an ugly hack: if (starts_with(bname.buf, "@{-")).
