From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jc/rerere-multi
Date: Thu, 21 Jan 2016 14:07:31 -0800
Message-ID: <xmqq7fj2y4bg.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
	<56A0CA5D.8080407@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 23:07:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMNOG-0000Tf-Ev
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 23:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbcAUWHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 17:07:37 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750789AbcAUWHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 17:07:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4214A3CEFB;
	Thu, 21 Jan 2016 17:07:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pFzQDY5FgFWICZWIhjkvylKDj/Y=; b=HU5TTf
	aDx6b6WW1jZNv5MqL0cG7vQujjxCkIpIyEZ6ozPFRkuXWBaamv65becgn+gcrwjT
	Dw97BtAFGFP75KYOrPvlenKnS1mLllV/bHNg2ViWA0XFYrsOnxfKzsETgwcAQqzh
	u8Oytnrbkg8vWG16IMM55RlvJQYFwbpg6bW4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ahCl0X5FAXy4+STreTrO8j5ZOtwXG8DY
	kQ46eLPRNLCsFgl2UNVF4dH6dakL1CoY8eUWYelnyeigjZSHwWtqrHXwu8AJHzhR
	C9J2o6TA0xaRMxxdbuQgAJ3mSjL/pYJI8OSXUGyhdQFrTsx1lYDdYyRMYtd8nyYV
	iHAN/sdepDo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2159F3CEFA;
	Thu, 21 Jan 2016 17:07:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8270B3CEF7;
	Thu, 21 Jan 2016 17:07:32 -0500 (EST)
In-Reply-To: <56A0CA5D.8080407@kdbg.org> (Johannes Sixt's message of "Thu, 21
	Jan 2016 13:09:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5EA46FDC-C08B-11E5-B6EC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284533>

Johannes Sixt <j6t@kdbg.org> writes:

> I finally found some time to test and review this series. I have one
> case where there are many identical conflicts (up to 15!) that rerere
> was unable to resolve. But with this series applied, all of them are
> now resolved automatically and correctly. That's a nice achievement!
>
> Tested-by: Johannes Sixt <j6t@kdbg.org>
>
> I don't have the original submission anymore. So, I'm responding here.
>
> Generally, the patches make sense.

Thanks.  As the tip commit says, this is still incomplete in that
"record and replay" part should work reasonably well, but things
like "forget" and "gc" are areas that needs further looking into.

> Except for 510936082eb4 "handle leftover rr-cache/$ID directory and
> postimage files": After the subsequent e2a6344cca47 "delay the
> recording of preimage" is in place, nothing of what the former patch
> changed (except test cases) remains, and the problem that the former
> solved is still solved, and in addition the NEEDSWORK that the former
> introduced is resolved by the latter. I think the two should be
> squashed together.

Yeah, they were originally done as separate patches as I felt 'delay
the recording' step was much riskier and I was shooting for a series
whose earlier parts can be moved forward independently if necessary
in order to keep the size of the really hard part that has to be in
flight longer time manageably small.

But re-reading these two with fresh eyes, I think it is OK to squash
them into one.

> e2a6344cca47 (rerere: delay the recording of preimage) needs this
> fixup, I think:

Thanks for catching this (and this needs to be carried forward to
7/7 as well, I think).  This shows how little testing the new code
has gone through--a test certainly would have prepared an entry in
the rerere database with a stale postimage without the matching
preimage and noticed that things going wrong.
