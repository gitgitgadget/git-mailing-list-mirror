From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1304: Set LOGNAME even if USER is unset or null
Date: Mon, 20 Oct 2014 11:34:23 -0700
Message-ID: <xmqqk33u380g.fsf@gitster.dls.corp.google.com>
References: <12975d1f2b5b1cd4cc6052b829bf4814300a7ffd.1413581788.git.wking@tremily.us>
	<xmqqegu3r7y7.fsf@gitster.dls.corp.google.com>
	<20141020152809.GR17200@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Oct 20 20:34:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgHmo-0001UE-6H
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 20:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbaJTSe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 14:34:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750935AbaJTSeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 14:34:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 556FB16676;
	Mon, 20 Oct 2014 14:34:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lMM4I1V2sdt+L+aSsC5dBoG/ptI=; b=tPeZ8E
	Ds/HNp+mFMf22ZVx07Fq4iUXQS17OnDciT7a2TzM2MUwxZZQe95jNXPBocorTKQT
	VbC5C9rgZI70wIq2L9s1C3R3fu77bCl1/MdNzozFHCvgWWW3HaI0ktWUWSrkH/UE
	oEeZ2Hcl/CNq/qAkbJu1d+QHenv28TZW2M4uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UU0SCjr+q/bW2opTo8z6z8VJTeAlS6F6
	noaxEnWILE9phIeDGGHadCYDv6lhjjfP1ZClgK5/fNwqj5QNKTt0JRC0kvawB5qE
	x4YVjjsz+4Df6Fo6HSJ2OQBJdxxp6TnCethoA1geUcwHseShm8abyRn8ARwm8idm
	HfPNLYc3Hus=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C75C16673;
	Mon, 20 Oct 2014 14:34:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE3821666F;
	Mon, 20 Oct 2014 14:34:24 -0400 (EDT)
In-Reply-To: <20141020152809.GR17200@odin.tremily.us> (W. Trevor King's
	message of "Mon, 20 Oct 2014 08:28:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7599E6C-5887-11E4-800E-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"W. Trevor King" <wking@tremily.us> writes:

> On Sun, Oct 19, 2014 at 03:49:36PM -0700, Junio C Hamano wrote:
>> I'll queue this as-is, but it makes me wonder if we want to do this
>> without if/then/fi, e.g.
>> 
>> 	: ${LOGNAME:=${USER:-$(id -u -n)}
>
> I'm fine with that too.
>
>> Spelling everything out with if/then/fi is obviously at the other
>> extreme, i.e.
>
> And I'm fine with this ;).
>
>> More importantly, what if none of the alternatives work?  I
>> personally feel it is OK to punt and declare test_done early,
>> instead of giving false positive breakages like you saw without this
>> patch.
>
> I can put this into a v2 if you like.  Which conditional syntax do you
> prefer?

Probably

    if test -z "$LOGNAME"
    then
            LOGNAME="${USER:-$(id -u -n)}"
    else
            : cannot test acl operations without a usable user name
            test_punt!
    fi
