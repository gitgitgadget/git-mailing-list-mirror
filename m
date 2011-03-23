From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git cherry improvements suggestions
Date: Wed, 23 Mar 2011 15:44:17 +0100
Message-ID: <4D8A0741.9000506@drmicha.warpmail.net>
References: <AANLkTimk0bkOGVy2W+XddHRuf-1xw+d0RwzPhnk40vi8@mail.gmail.com>	<4D89CF8E.4070100@drmicha.warpmail.net>	<AANLkTinXh_Y9ft5Pd5SxOEXvKNm3HLmsiut8WrvFZrdQ@mail.gmail.com>	<4D89F6BC.2040902@drmicha.warpmail.net> <AANLkTin7Du5RYt946hNjP-y53puNykebCjiKk5Ju_igr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 15:48:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2PLz-0006tF-TC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 15:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932958Ab1CWOry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 10:47:54 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41067 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932833Ab1CWOrw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 10:47:52 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3D06A2041F;
	Wed, 23 Mar 2011 10:47:51 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 23 Mar 2011 10:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=vnO4f9kz8JvyydBm4sGta3kD13c=; b=n88vr/2fsRSNKluQgZiT2OVPtmGrpqwbFA8Yn5cAakmOmCYOeTRt511F1aQxQIuoO5SVTHKSlG/99E6moSagMvye6kJLc6OEkqhDrqek68KIaiQ7IRwMC5g9Y898sSN7qgani2dKEFsGgFDWKx0tdb7Kb/JTj1iFBFk6r5GuBrw=
X-Sasl-enc: +xyLAkOHD6FWpleovMAnLneEIr4/kwWsSh7Xr1PA48Io 1300891670
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B99B04065FB;
	Wed, 23 Mar 2011 10:47:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTin7Du5RYt946hNjP-y53puNykebCjiKk5Ju_igr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169838>

Piotr Krukowiecki venit, vidit, dixit 23.03.2011 15:43:
> On Wed, Mar 23, 2011 at 2:33 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Piotr Krukowiecki venit, vidit, dixit 23.03.2011 14:23:
>>> Just some stats:
>>>
>>>    git log --cherry-mark --left-right --oneline --date-order branch...trunk
>>>
>>> lists 1004 commits, takes about 20s and memory peaks to about 670MB
>>> twice during the run (I'm on linux with AMD Phenom II X4 945)
>>>
>>> With limit it prints X last commits (the limiting seems to take place after all
>>> work, on the output list only).
>>>
>>> branch..trunk is 551 commits, the other way is 453 commits.
>>> 710 commits are found to be "=", 98 "<", 196 ">".
>>>
>>> Note, I'm not saying it's too slow, or that it's working incorrectly, I'm just
>>> giving real-life stats if anyone was interested.
>>> I suspect such checks won't be done frequently.
>>
>> You don't need to say it's slow - I've said so already :(
>>
>> http://permalink.gmane.org/gmane.comp.version-control.git/169725
> 
> In the link above:
>   git cherry A B: 0.4s
>   git rev-list --cherry A...B: 1.7s
> 
> So rev-list is 4.25x slower.
> 
> In my case it's only 1.23x slower:
> 
>    $ time git rev-list --cherry branch...trunk  > /tmp/rev-list
>    real	0m18.627s
>    user	0m17.710s
>    sys	0m0.900s
> 
>    $ time git cherry  branch trunk  > /tmp/cherry
>    real	0m15.345s
>    user	0m14.310s
>    sys	0m1.020s
> 
> 

How's that with > /dev/null (or with --count for rev-list)? Also, how
many merge bases do you have:

git merge-base --all branch trunk | wc -l

Thanks!
Michael
