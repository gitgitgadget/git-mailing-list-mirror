From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] repack: rewrite the shell script in C
Date: Tue, 17 Sep 2013 09:42:47 -0700
Message-ID: <xmqqwqmfz9fc.fsf@gitster.dls.corp.google.com>
References: <1379259202-5042-1-git-send-email-stefanbeller@googlemail.com>
	<CALkWK0nG4+pdSEEUhHrN=+kXEetJ4sJxVOc0VWSweRuJUL-jsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 18:43:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLyMc-0003xg-7M
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 18:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab3IQQmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 12:42:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48861 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253Ab3IQQmx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 12:42:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A005420C0;
	Tue, 17 Sep 2013 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GEzvb5uOHbQHVgGRatBrO58s1GQ=; b=icS7JH
	it4wKRo1P/ai8ahJuyFV6FNbZCmkaGAC/Vpy9wGdPOd5lkIuUeFrfJUnmQacgXfg
	9MMKUJpA5MOY9GtmdlG4IDOq3I7QY/MmO9nvoamqh0Vq7ZT6dc5x/8Qk4OCGVl/M
	lGlV1aGi6OK9Q5uwx+0PGZVKDjAu/SqfH68Ak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AI9arFfwDb0VltyzMmeD5G3JxOIQ2vfr
	5M1d4f9DrKfKPfXzHD2M6EsMGLM00cSXb0z3J38OuJKZ6BXEpAkpKVFRYkGGODOh
	u1r0puu+PBPhTa27yZzTbyWji9tYFC03l/0o5X119utJLWS8kjlggLe950Rh+a//
	5km9N9Z/CC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D755420BD;
	Tue, 17 Sep 2013 16:42:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89D45420BB;
	Tue, 17 Sep 2013 16:42:50 +0000 (UTC)
In-Reply-To: <CALkWK0nG4+pdSEEUhHrN=+kXEetJ4sJxVOc0VWSweRuJUL-jsA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 15 Sep 2013 23:24:34 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 30E0F85C-1FB8-11E3-9099-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234887>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Is $GIT_OBJECT_DIRECTORY a standard variable, or should it be
> $GIT_DIR/objects?

"man git" ;-)  It has been there since early May 2005
