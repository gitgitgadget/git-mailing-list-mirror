From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] demonstrate add -p and stash -p failures.
Date: Tue, 14 Apr 2015 11:00:28 -0700
Message-ID: <xmqqbniq3803.fsf@gitster.dls.corp.google.com>
References: <vpq7ftfkpue.fsf@anie.imag.fr>
	<1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Apr 14 20:00:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi58e-0001CS-N8
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 20:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbbDNSAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 14:00:36 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752480AbbDNSAc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 14:00:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 51ADE49478;
	Tue, 14 Apr 2015 14:00:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A5NDzbAAM5GUeGZvHyl4E1EXohM=; b=jyHZ2q
	ThDB74hLE0SCaU0FcunI8PBnFfarulwTmIuqo+b9cuhi5fWGIQ/RctcDolfgdBLk
	CQFzNdzGzCUurzpZOfuBDxj9iWMXjhh1iM3OVJRcG+8Wgi4Yvvo8xX/ZdOqvVvf2
	OY46FAtK+mS+aeTTy17+p/3GY7tjm2ULpRKBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bPwW5e+jYzMlrBidn/yHO1FA6NtgahAH
	OX3SuDoy9y/ebwI0sDKCERkFUeoy9A1QqW0C+cT5vdNTwpjnkeVPYWXfh8sD7A7y
	r8ifofShGd5x4ucGBNgZEGnjcTBVHmpY5Q0k8RBy5NjDaUWmgqyfNXH0ItH4NzgS
	NUe+eGzxiYU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4978E49477;
	Tue, 14 Apr 2015 14:00:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE03F49473;
	Tue, 14 Apr 2015 14:00:29 -0400 (EDT)
In-Reply-To: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Tue, 14 Apr 2015 13:32:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2323E67A-E2D0-11E4-8A22-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267155>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Playing a bit with add -p and stash -p, I can confirm the bug reported
> by Tanky. This series just adds failing tests, but I couldn't debug it.
>
> I've exhausted my Git time budget for now, so if someone wants to take
> over and fix the bugs, feel free to do it!

I do not have time to dig this either for now, but I suspect this
"split a hunk into two overlapping hunks" issue may be related to
the caveat in the very original:


http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=87197


where I seem to have said that the proposed change would make "add
-p" less robust than the original code (even without 'e'dit):

    Junio C Hamano wrote:
    > 
    > I recall that the original "add--interactive" carefully counted
    > numbers in hunks it reassembles (as it can let you split and then
    > you can choose to use both parts, which requires it to merge
    > overlapping hunks back), but if you are going to use --recount
    > anyway, perhaps we can discard that logic?  It may make the patch
    > application less robust, though.  I dunno.


It seems that we accepted that series saying "let's see what
happens" at the end, and I suspect we are seeing its consequences
;-).
