From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t8005: avoid grep on non-ASCII data
Date: Mon, 22 Feb 2016 14:25:59 -0800
Message-ID: <xmqq1t845qmg.fsf@gitster.mtv.corp.google.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<81ec83acd004ef050a4c8df62fb158b41f0a0a80.1456075680.git.john@keeping.me.uk>
	<CAPig+cQ9n4Eg73Uyeg_g_4wzebuwn8=0R-LMb8F9QLFxanwVVg@mail.gmail.com>
	<20160221231913.GA4094@sigill.intra.peff.net>
	<20160221234135.GA14382@river.lan>
	<20160222221811.GC18522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: John Keeping <john@keeping.me.uk>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:26:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXyvj-0007fD-Jl
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbcBVW0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:26:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932319AbcBVW0C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:26:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 070D947C76;
	Mon, 22 Feb 2016 17:26:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a33L9Q2c3GSagi/ws5jhxWkQOok=; b=MNDEer
	WiyYJLySt3PTLIADGD234O25VDkvqN7grsR5HyIpHevmKBmh8qzF5mi62P3lOvSa
	ldO8vue3VLG8E2TpjXT2/z3cZI+hHvd4UcoPUjFgtTTG57CQDENqdnUPDHI4N4fk
	CW+4jTwxrnqpAu7hiNI6G+6v6cj49hsmD/RvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L2TfrKgo/sneMrmsfCY55z/+dO6vxYoc
	V+uB+7Ego1YpOv9UlfTdr23ihAXfc1+DFeY8lyZ5MWW1+7AUZlHc//BHrljfpUc0
	t8fZX+6/G+DkVhhHSGT6XNZ/Fn3VOSdgUdL6vj2ovNcndXi1x2Gw3cGpsPTF9F8m
	G4/xc+kW+rI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDECC47C75;
	Mon, 22 Feb 2016 17:26:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1B85D47C74;
	Mon, 22 Feb 2016 17:26:01 -0500 (EST)
In-Reply-To: <20160222221811.GC18522@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 22 Feb 2016 17:18:11 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 40A0738C-D9B3-11E5-B143-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286964>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 21, 2016 at 11:41:35PM +0000, John Keeping wrote:
>
>> My original sed version was:
>> 
>> 	sed -ne "/^author /p" -e "/^summary /p"
>> 
>> which I think will work on all platforms (we already use it in
>> t0000-basic.sh) but then I decided to be too clever :-(
>> 
>> I still think sed is simpler than introducing a new function to wrap a
>> perl script.
>
> Yeah, I think that is good (personally I'd use a function anyway, but I
> think it is short enough that we could go either way).

Agreed, and because there are repeated invocation of the same sed
script in this file, it would be sensible to hide it behind a helper
function.

Thanks.
