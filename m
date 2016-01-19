From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Tue, 19 Jan 2016 09:52:00 -0800
Message-ID: <xmqqio2pbgov.fsf@gitster.mtv.corp.google.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 18:52:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLaRz-0002e6-KV
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 18:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbcASRwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 12:52:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60932 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932590AbcASRwD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 12:52:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE51E3B931;
	Tue, 19 Jan 2016 12:52:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B00ysx4hfP/BqL2bGdkWxx54PXA=; b=JivYmU
	oJnw6dWx5CWlxDltJMgMQLufznY8PJSNeAti3qCwQx+iuqfXXyY17DEJuYhipXOC
	sBGBpoAuzPoQ5LKiNVi/Qh4yPjsX8SNMd3Ss0SXCVFesH6aAef4cmkeJOcFZUh2y
	YUGRHHGpEeP/k6BWB+HyMTrkicdP6LysSl1cI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jAqFTd2sFDNrzU8L1MLPYgEufQLcPc8f
	Xu9D16CQOP0iRxjzeCy3lh66gx9yFbp3soo3hY0rU53rk4nsNqV6yWIvik0ixw8S
	DVfhSQiP7wavsFQneEoUjY9ywbEHaWCGNnyDhMbIZs4swcOlratlniM4fMw3d6fU
	qEnfT1gaboA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6F183B930;
	Tue, 19 Jan 2016 12:52:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4CA803B92D;
	Tue, 19 Jan 2016 12:52:02 -0500 (EST)
In-Reply-To: <CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 18 Jan 2016 16:11:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 584A7896-BED5-11E5-B815-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284363>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I think POSIXPERM is all you need for this case; SANITY doesn't buy
> you anything, if I understand correctly.
>
>>> +     cat basic_message >message &&
>>> +     chmod -r message &&
>>> +     test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place message &&

The purpose of "chmod -r message" is to force interpret-trailers to
fail due to its input being unreadable; without SANITY, i.e. running
this test as root, the command would happily read from message that
is marked as unreadable by anybody, and test_must_fail will not pass.
