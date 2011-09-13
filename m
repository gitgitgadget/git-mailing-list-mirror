From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t3200: test branch creation with -v
Date: Tue, 13 Sep 2011 14:12:52 +0200
Message-ID: <4E6F48C4.3030407@drmicha.warpmail.net>
References: <20110909193033.GA31184@sigill.intra.peff.net> <49578782dd114220aa2562b5bd29755fc2bdd0fa.1315597137.git.git@drmicha.warpmail.net> <20110909194357.GA31446@sigill.intra.peff.net> <4E6B6647.7090802@drmicha.warpmail.net> <20110913035724.GA4828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 13 14:13:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3RrJ-0003nf-8Z
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 14:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab1IMMM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 08:12:56 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:43119 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753147Ab1IMMMz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 08:12:55 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5DE222B158;
	Tue, 13 Sep 2011 08:12:55 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 13 Sep 2011 08:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=gRAgUXnhZkpJ7ezodXWWXV
	2RMQc=; b=eoxYKR9lAeS80YYK1JsC780/khrJ0vSGtoQNVafye52+M56LrEHiBW
	qqYhfJkLHIdZwtlZ03MGHvWNTmJu1OTovcU6h19ShEcWALtcSh3RfTwmBCTLDkYW
	swyYTt8fuHRf5vXZlsbzSO5DmBCI6KH18N/OflQaIFo/apoBjs9n4=
X-Sasl-enc: MdnxtCTx4VpfMzR+71hiH48Yxwi4MeBLfJpeKdpmizin 1315915974
Received: from localhost.localdomain (p4FC616C4.dip0.t-ipconnect.de [79.198.22.196])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 71A329C0A61;
	Tue, 13 Sep 2011 08:12:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <20110913035724.GA4828@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181284>

Jeff King venit, vidit, dixit 13.09.2011 05:57:
> On Sat, Sep 10, 2011 at 03:29:43PM +0200, Michael J Gruber wrote:
> 
>> Jeff King venit, vidit, dixit 09.09.2011 21:43:
>>> On Fri, Sep 09, 2011 at 09:40:59PM +0200, Michael J Gruber wrote:
>>>
>>>> +test_expect_success 'git branch -v t should work' ' +	git branch
>>>> -v t && +	test .git/refs/heads/t &&
>>>
>>> test -f ?
>>>
>>> Also, don't we have test_path_is_file which yields slightly prettier 
>>> output (and maybe some portability benefits; I don't remember)?
>>>
>>>> +	git branch -d t && +	test ! -f .git/refs/heads/t
>>>
>>> Ditto for 'test_path_is_missing' here.
>>>
>>> -Peff
>>
>> Well, I tried to follow the surrounding style. That t3200 could benefit
>> from some attention, though, which I did not want to mix in with the
>> issue at hand.
> 
> The "test_path_is_file" thing is style. But not using "test -f" is just
> wrong; you are testing "is .git/refs/heads/t an empty string?" which is
> useless.
> 
> You want this on top of what's in mg/branch-list:

Yes, sorry. How did I miss that?

I'd prefer your style anyway, but also prefer changing t3200 in one go.

> 
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index c466b20..b513115 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -100,14 +100,14 @@ test_expect_success 'git branch -m q r/q should fail when r exists' '
>  
>  test_expect_success 'git branch -v -d t should work' '
>  	git branch t &&
> -	test .git/refs/heads/t &&
> +	test -f .git/refs/heads/t &&
>  	git branch -v -d t &&
>  	test ! -f .git/refs/heads/t
>  '
>  
>  test_expect_success 'git branch -v -m t s should work' '
>  	git branch t &&
> -	test .git/refs/heads/t &&
> +	test -f .git/refs/heads/t &&
>  	git branch -v -m t s &&
>  	test ! -f .git/refs/heads/t &&
>  	test -f .git/refs/heads/s &&
> @@ -116,7 +116,7 @@ test_expect_success 'git branch -v -m t s should work' '
>  
>  test_expect_success 'git branch -m -d t s should fail' '
>  	git branch t &&
> -	test .git/refs/heads/t &&
> +	test -f .git/refs/heads/t &&
>  	test_must_fail git branch -m -d t s &&
>  	git branch -d t &&
>  	test ! -f .git/refs/heads/t
> @@ -124,7 +124,7 @@ test_expect_success 'git branch -m -d t s should fail' '
>  
>  test_expect_success 'git branch --list -d t should fail' '
>  	git branch t &&
> -	test .git/refs/heads/t &&
> +	test -f .git/refs/heads/t &&
>  	test_must_fail git branch --list -d t &&
>  	git branch -d t &&
>  	test ! -f .git/refs/heads/t
> 
> I suspect you didn't notice the bogosity before because those are just
> confirming the precondition that "git branch" actually created the file.
> 
> -Peff
