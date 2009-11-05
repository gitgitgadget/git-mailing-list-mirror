From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Problem signing a tag
Date: Thu, 05 Nov 2009 09:29:24 +0100
Message-ID: <4AF28CE4.5000906@drmicha.warpmail.net>
References: <200911021558.17550.joshua@eeinternet.com> <200911030911.47030.joshua@eeinternet.com> <4AF18F7A.2000904@drmicha.warpmail.net> <200911040947.50226.joshua@eeinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Joshua J. Kugler" <joshua@eeinternet.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 09:29:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5xit-00027q-6j
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 09:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634AbZKEI32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 03:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756646AbZKEI32
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 03:29:28 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43936 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755727AbZKEI31 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Nov 2009 03:29:27 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4F843B59CE;
	Thu,  5 Nov 2009 03:29:32 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 05 Nov 2009 03:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=uYDepAcC27A/97O6YiKvuMCHL5M=; b=l4mga36MVUIIUrg1ggARllHUeUsOlsxnau/YzjuFHE+7rHkixOmkYCk8rq98N1HoAzdp6sj+bU47Oho9qWP1yUc7VfqKEF1s0H25LvE2mfqnrASB/yqWzzRcv//ugmvMgKGj80iunBzdAkSjp+RJHqWgdrnfI7HMGouQvWX2Arw=
X-Sasl-enc: VP9UpI3t39FFH0peXWxXHRH4w8HaY5o7PqlJyM1SJVGm 1257409771
Received: from localhost.localdomain (p5DCC17C2.dip0.t-ipconnect.de [93.204.23.194])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 534FA3BEE;
	Thu,  5 Nov 2009 03:29:31 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091104 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <200911040947.50226.joshua@eeinternet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132211>

Joshua J. Kugler venit, vidit, dixit 04.11.2009 19:47:
> On Wednesday 04 November 2009, Michael J Gruber said something like:
>>> gpg: problem with the agent - disabling agent use
>>> error: gpg failed to sign the tag
>>> error: unable to sign the tag
>>> $ echo $?
>>> 128
>>>
>>> And when I sign at the prompt:
>>>
>>> $ gpg -sa
>>>
>>> You need a passphrase to unlock the secret key for
>>> user: "Joshua J. Kugler <joshua@azariah.com>"
>>> 1024-bit DSA key, ID 14EA086E, created 2009-08-09
>>>
>>> gpg: problem with the agent - disabling agent use
>>> Blah blah blah blah
>>> Blah blah blah blah
>>> $ echo $?
>>> 2
>>
>> [...]
>>
>> I assume you don't want to use gpg-agent, that should be the easy way
>> out.
> 
> Well, I could, but I just haven't set it up. :)
> 
>> If that helps you can put "--no-use-agent" in your gpg config.
> 
> I commented out use-agent in the config. That worked. THANKS!
> 
>> 2 is a non-fatal error, 128 a fatal one, btw.
> 
> Well, the 2 was from running gpg alone, and 128 was from git erroring 
> out.  According to the gpg docs:
> 
> "The program returns 0 if everything was fine, 1 if at least a signature 
> was bad, and other error codes for fatal errors."
> 
> So, the docs consider 2 a fatal error, even though it appears it isn't.  
> It seems that 
> http://github.com/git/git/blob/a6dbf8814f433a7fbfa9cde6333c98019f6db1e4/builtin-tag.c#L202 
> needs to be patched to something along the lines of:
> 
> rv = finish_command(&gpg)
> if ((rv && rv !=2)  || !len || len < 0)
> 
> Probably digging in to the gpg source code to figure out what errors are 
> and aren't fatal would be in order.
> 
> Thanks again for your help! Glad to know what I needed to do to sign my 
> tags!

Dig dig dig... gpg exits with 2 in a lot of cases, one would need to
parse fd-error to find out more. But it also looks as if gpg exits
normally with a good passphrase. So I tried, and at least with gpg 1.4.9
and git 1.6.5.2 I can sign tags with "use-agent" and without a running
agent: I get asked for the passphrase (after reporting the agent MIA),
and everything's fine.

My gpg returns 0 in this case; it returns 2 only if I don't enter the
passphrase. So, this seems to depend on the version of gpg. Or on
entering the correct passphrase ;)

Michael
