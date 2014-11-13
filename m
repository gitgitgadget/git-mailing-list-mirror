From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1410: fix breakage on case-insensitive filesystems
Date: Thu, 13 Nov 2014 08:30:10 -0800
Message-ID: <xmqqy4rf2hd9.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QiFvwMiwVCdVju_vJKK_HVndpQf4VyrEaHeeVVN6rgYgA@mail.gmail.com>
	<20141109014354.GA23883@peff.net> <20141109015918.GA24736@peff.net>
	<5463C106.5090803@kdbg.org> <20141112215923.GB6801@peff.net>
	<546470D0.3080809@kdbg.org> <20141113090832.GA8329@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Michael Blume <blume.mike@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:30:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoxHp-0005GD-PP
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 17:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933359AbaKMQaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 11:30:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933113AbaKMQaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 11:30:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5F971DE5E;
	Thu, 13 Nov 2014 11:30:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8S8FN1cR9BVUJ08cKaA1dR1UPY8=; b=Q1jxFs
	QyolrofwTCpYWJSLnku1u52JL2fylIGOZY7iL5vlrUX8wVUjNs/oWflJiNxNTjLM
	BJGM6jL5jo3pk9lCH4BP2Tsi4xC/cmNuEXmwd8YVZDu1jrMo+I9QE6J7vFeYIqJu
	83UIinodKDU8Xe8JRJgxh2NOdu9OuwRGbXwnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UAytzuuJc5mgXQb2CpCwM/IiCzVaBIAl
	lk5ZEkj5Y3VpO7USDGXuXScACHTE5lo8N9n1EK5b4vXlUVCN/zTWJf0dyHwjZiiZ
	ivsKt/+zfarhaOgxvLJAaE+PzSyh4Zl89o8NJFoNdA1IMOCliWxMT1dWCZwm96qL
	FcevmskYzd8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BD101DE5D;
	Thu, 13 Nov 2014 11:30:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE4AA1DE59;
	Thu, 13 Nov 2014 11:30:11 -0500 (EST)
In-Reply-To: <20141113090832.GA8329@peff.net> (Jeff King's message of "Thu, 13
	Nov 2014 04:08:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 570244F0-6B52-11E4-AECA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The patch you are responding to is a fix-up for 9233887, which tweaked
> the code and added those tests in the first place (I doubt it would work
> for you, though, as it has a problem on case-insensitive filesystems).
>
>> But the sequence works as expected with a version built
>> in September:
>
> Hmph. So that would mean my theory is not right. Or maybe I am not
> accounting for something else in my analysis.
>
> I guess it is odd that the test right before the failing one passes (it
> is basically that same sequence, with reflogs turned on for both
> operations), which implies that we are properly getting EISDIR. The only
> difference in the failing test is that reflogs are turned off for the
> "git branch one" operation. But I cannot see why that would be broken if
> the other one passes.

Hmph, or perhaps "branch -d one/two" fails to remove the reflog and
does not notice the failure?  But creation of "one" with reflog
disabled shouldn't be affected in such a case, either.  Puzzled...

> I wish it were easy for me to ssh into a Windows VM and run gdb. ;)

likewise.
