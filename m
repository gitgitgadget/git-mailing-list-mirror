From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 7/7] Improve error handling when parsing dirstat
 parameters
Date: Thu, 28 Apr 2011 12:20:12 -0700
Message-ID: <7vd3k641zn.fsf@alter.siamese.dyndns.org>
References: <1303892653-3958-1-git-send-email-johan@herland.net>
 <1303953442-26536-1-git-send-email-johan@herland.net>
 <1303953442-26536-8-git-send-email-johan@herland.net>
 <7vhb9i43sl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:20:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFWlO-0004LV-7c
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 21:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955Ab1D1TU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 15:20:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914Ab1D1TUY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 15:20:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE64B4820;
	Thu, 28 Apr 2011 15:22:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9aZfEe0G32g/I0ks4ONARMpTs7w=; b=d9dwc5
	Ivq38xUxUDdDwkpfZDnNMPgMy2pfqermoQvSLqqP4xG17YC+Rdof1X0TZyLzTZJv
	u+jDRFWTEq7rgNPUGpBEUhcN9mDFKZ35HOdTdnHCpNwcRocaLYR4ykPfhbrT9Eeo
	O83hrRrhmU0Vw6DaLITWjw0tisRvXYqByfQqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t72W6TqozYXJrAUnFVQ3J2KIIqmot8yu
	21MZChdSSFHYUQ6fRGa1lntgeOaUXNabTkloWlzm7Myc7tTtpXcbKJ1jcDkNxt1v
	4vq777k8jNgS2XKUToAY1H60w44kuyn4mAEqe83wi4HmXCAb032kQ9Z77UdirPOh
	XLwtOHUTKyA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AD0B3481E;
	Thu, 28 Apr 2011 15:22:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8DF5D4817; Thu, 28 Apr 2011
 15:22:17 -0400 (EDT)
In-Reply-To: <7vhb9i43sl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 28 Apr 2011 11:41:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D70D3B6A-71CC-11E0-A5B8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172396>

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if three combinations (vanilla, -M and -C -C) need to be
> tested to produce an empty result.  If so, it would make it easier to read
> if they are split into three tests, or at least have a blank line between
> them, but I suspect that you would agree that it is not worth to have
> three separate test_expect_success for these.

I think it makes sense to cull these three cases into one for the case we
expect the command to stop without doing anything, but we would still want
to validate the output for three variants in the "config" case.

Also I forgot to say that the new "grep" invocations added to check the
error output might have to be test_i18ngrep.  Please check with

    make GETTEXT_POISON=YesPlease test

The configuration variable names and typo in user input should appear
somewhere in the output for any real locale, but I think gettext-poison
would throw these away.

By the way, should the following two entries make any difference, and if
so how?

	[diff]

        	dirstat = unknown,0,lines
                dirstat = 0,lines,unknown
