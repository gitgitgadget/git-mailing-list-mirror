From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 10:23:04 +0200
Message-ID: <51949768.5020305@drmicha.warpmail.net>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com> <5194921F.4080103@drmicha.warpmail.net> <CAMP44s3s_Tg=FX8emOC1Gs_LqPU-i-mWNswoOT82MkNBUUsjUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 10:23:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UctSx-0004pk-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728Ab3EPIXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:23:05 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60055 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756219Ab3EPIXB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 May 2013 04:23:01 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9042320E91;
	Thu, 16 May 2013 04:22:59 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 16 May 2013 04:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=923YwlnsgyfYryY8Qthj4G
	gSnkE=; b=cEQbi2OvN0fJld2oRrQp1hfOGQvHF4gtd8kh7IXkfHxCrQ5BhSyaIP
	AIaz7idErL+r+RPLmJvnMMWp2kIR/zrzDr1GbdMTsBHB8rsbllQAYlKAq7f3Q+Nf
	/uoVA5YDUdeWkNSqx7PCHKWYAOmObGDB/YiVyDomIoOVzBluO1jMk=
X-Sasl-enc: R11SgAZIf/YMROduY9Gr95NelgThuZRdZd6meMdZZ4mY 1368692575
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0A4C9200316;
	Thu, 16 May 2013 04:22:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <CAMP44s3s_Tg=FX8emOC1Gs_LqPU-i-mWNswoOT82MkNBUUsjUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224497>

Felipe Contreras venit, vidit, dixit 16.05.2013 10:09:
> On Thu, May 16, 2013 at 3:00 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Felipe Contreras venit, vidit, dixit 16.05.2013 09:48:
>>> Showing the tracking information for all the branches takes significant
>>> amount of time. The user might not want that. The --no-show-tracking
>>> option allows that.
>>
>> I really like the idea of allowing that - not just because I've
>> suggested so myself in the past ;)
>>
>> I feel, though, that we're really exploding our option and config realm.
>> For "git branch" in list mode, we are already able to stack "-v", i.e.
>> "-v" and "-vv" do different things. How about maybe adding "-vvv" and
>> arranging things so that the verbosity and the run time increases with
>> the number of v's?
>>
>> -v list with sha1 + subject of last commit
>> -vv add upstream branch name
>> -vvv add ahead/behind info (the only costly mode)
>> -vvvv same with "--cherry" (ahead/behind/same)
> 
> Yeah, I thought about that too.
> 
>> Or maybe combine the middle two cases into "-vv", which means it would
>> be the same as "-vv", with only "-v" changing what it does now.
> 
> Please no, I would like to see 'upstream', but not ahead/behind info.
> In fact, that's my whole motivation behind this patch.

I'd be fine with combining the first two also.

>> Yes, this changes current behavior (at least fpr -v), which sucks
>> anyways because of the costly lookup. And those scripting around "branch
>> -v" should get what they deserve. (I may sound annoyed by our
>> compatibility brakes, but here's a case where breaking it should be OK.)
> 
> I also agree that it would be OK to break this.
> 
> Alternatively, I've been thinking that we should have a v2.0 mode, or
> a v2.0 branch, where all the compatibility breakage things go. We have
> been so careful at not breaking things, that we have been too good at
> stacking hacks and configurations all over the place, and in my
> experience it's not unusual that right after an incompatibility
> release, someone realizes that we forgot some compat breakage things,
> and oh, well, maybe for v3.0.
> 
> The ones I have in mind are:
> 
> color.ui=true
> merge.defaulttoupstream=true
> format.coverletter=auto
> branch.autosetupmerge=always
> mergetool.prompt=false
> 
> Cheers.

Yes. Additionally, there are things which we can break during normal
releases, but somehow the compatibility discussions have kept us from
doing so. Maybe we need a clearer separation of porcellain and plumbing
again? Or a clearer definition of x, y, z in x.y.z releases? We haven't
even used y increases for incompatible ui changes that much.

Michael
