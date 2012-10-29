From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] replace: parse revision argument for -d
Date: Mon, 29 Oct 2012 11:08:50 +0100
Message-ID: <508E55B2.6060502@drmicha.warpmail.net>
References: <807340e40adb1fc97cd97161fe1fabd292bc79c3.1351258394.git.git@drmicha.warpmail.net> <20121029065836.GC5102@sigill.intra.peff.net> <508E4637.2060903@drmicha.warpmail.net> <20121029090419.GA29464@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 11:09:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSmHK-00069v-CE
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 11:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab2J2KIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 06:08:54 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51624 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752111Ab2J2KIx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Oct 2012 06:08:53 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4A1272030A;
	Mon, 29 Oct 2012 06:08:53 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 29 Oct 2012 06:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Cws3WpBQsV2gTrqbB9HqPQ
	Br9ok=; b=KYvAynH8mNKycvn1HrFlrgJzS5j+KD+G5Rq6gIR8Th2lf0rSGXiguC
	sAK0p78M3E2n3Dhcpq/TKMeT0NgvM7AdEM31oAOVWduelWNd59wSuCO4XSHQB94T
	3fSinx8RaHiAY7Jmxs9TLNcYZckFsPsQa6ZgYgtgkdrjI2/mE4XnA=
X-Sasl-enc: aselTcKHvTOW9v6Evn/eYnBUZ3vLxVMail0gLIAabvpU 1351505333
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C289B482664;
	Mon, 29 Oct 2012 06:08:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <20121029090419.GA29464@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208609>

Jeff King venit, vidit, dixit 29.10.2012 10:04:
> On Mon, Oct 29, 2012 at 10:02:47AM +0100, Michael J Gruber wrote:
> 
>> Jeff King venit, vidit, dixit 29.10.2012 07:58:
>>> On Fri, Oct 26, 2012 at 03:33:27PM +0200, Michael J Gruber wrote:
>>>
>>>>  	for (p = argv; *p; p++) {
>>>> -		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
>>>> +		q = *p;
>>>> +		if (get_sha1(q, sha1))
>>>> +			warning("Failed to resolve '%s' as a valid ref; taking it literally.", q);
>>>> +		else
>>>> +			q = sha1_to_hex(sha1);
>>>
>>> Doesn't get_sha1 already handle this for 40-byte sha1s (and for anything
>>> else, it would not work anyway)?
>>
>> What is "this"???
>>
>> So far, "git replace -d <rev>" only accepts a full sha1, because it uses
>> it literally as a ref name "resf/replace/<rev>" without resolving anything.
>>
>> The patch makes it so that <rev> gets resolved to a sha1 even if it is
>> abbreviated, and then it gets used.
>>
>> Or do you mean the warning?
> 
> Sorry, yeah, I meant the warning and fallback.
> 
> If I understand correctly, the fallback will never work unless we are
> fed a 40-byte sha1. But get_sha1 should always return a 40-byte sha1
> without doing any further processing.

You do understand correctly, and I misunderstood get_sha1(). I does not
check for the presence of that sha1 in the object db, so that it
succeeds no matter what, that is: if it's valid hex. So I should
probably rewrite the error handling: no more need to check for lengths.

Michael
