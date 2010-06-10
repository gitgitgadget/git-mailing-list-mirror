From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Misterious warning about file system boundaries [It's a bug,
 not a mystery.]
Date: Thu, 10 Jun 2010 12:36:30 +0200
Message-ID: <4C10C02E.50502@drmicha.warpmail.net>
References: <4C0FF7B9.8040007@drmicha.warpmail.net>	<4C109C4F.1030809@op5.se>	<4C10AAC4.90405@drmicha.warpmail.net> <AANLkTimwhDGNTMiOaW8_AGGd4PvFtyILEikePdC4zGDo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 10 12:37:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMf8V-0005XH-24
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 12:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab0FJKhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 06:37:06 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:39591 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753823Ab0FJKhF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 06:37:05 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8BA66F69D6;
	Thu, 10 Jun 2010 06:37:03 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 10 Jun 2010 06:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=o1mNtVVpT2hcKXcy7yttMUJsnuM=; b=F0imVRHhE6HVDllTtDYrB3KnZ1BIzZLlw9gfbxwL8944O8QnoHlijVZDREUTLNL87ylcy9f6qjm4satIBwr/uDPUX58kRInmQLztH2TPYiDyNdHI74d9vBCkVM5fGZiantT+6Q7txfMMlTLNHa9S+IvZ3wTQMPlwG+mnTXQRWbc=
X-Sasl-enc: 1HtNgQhAklxcdIq0yRhjK5PdJQPdtJfjqzmyg4Bvyy46 1276166222
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5F3254E7D41;
	Thu, 10 Jun 2010 06:37:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTimwhDGNTMiOaW8_AGGd4PvFtyILEikePdC4zGDo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148852>

Erik Faye-Lund venit, vidit, dixit 10.06.2010 11:39:
> On Thu, Jun 10, 2010 at 11:05 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Andreas Ericsson venit, vidit, dixit 10.06.2010 10:03:
>>> On 06/09/2010 10:21 PM, Michael J Gruber wrote:
>>>> Heya,
>>>>
>>>> now what is going on here? After upgrading to current next I get
>>>>
>>>> warning: working tree spans across filesystems but
>>>> GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.
>>>>
>>>> in several repos, such as my local git.git repo. That is certainly on a
>>>> single file system only (ext4 over lvm over luks, all on one partition,
>>>> Fedora 13). I also get this for another repo, but not for every repo. It
>>>> goes away when I set the var and comes back when I don't set it, of course.
>>>>
>>>> Although I haven't bisected this should be due to
>>>> 52b98a7 (write-index: check and warn when worktree crosses a filesystem
>>>> boundary, 2010-04-04).
>>>>
>>>> How does the code detect a file system boundary, and where could it go
>>>> wrong?
>>>>
>>>
>>> According to the patch, it checks if the device id recorded from stat(2)
>>> is the same for all files and, if not, warns about it.
>>>
>>> It seems that your interpretation of "one partition" differs from that
>>> reported by the kernel. Why that is so, I have no idea.
>>>
>>
>> I'm sorry, but "my interpretation"? WTF? This is all on
>> /home/mjg/src/git which has no bind mounts whatsoever.
>>
>> I actually mixed up my / and /home situation above, /home is even
>> simpler: single ext3 over luks dm device over single "real" partition.
>> All of this (except for single ext3 part.) should not matter, of course.
>>
>> I bisected it just be sure, and it boils down to 9780e62 which is the
>> commit merging 52b98a7 to next.
>>
>> git ls-files|xargs stat -c "%d %D" |sort|uniq
>>
>> gives
>>
>> 64772 fd04
>>
>> which is, in particular, 1 device only. Now, here comes funny. After
>> changing write_index() to print the two ce_dev's which differ, i.e.
>> printf("%d %d\n", ce->ce_dev, cache[first_valid_ent]->ce_dev);
>>  I have:
>>
>> ./git-status -s|sort|uniq -c
>> warning: working tree spans across filesystems but
>> GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.
>>    150 64770 64772
>>    662 64771 64772
>>      1  M read-cache.c
>>
>> WTF???
>>
>> git reset --hard doesn't help this.
>>
>> rm .git/index && git reset does help.
>>
> <snip>
>>
>> Also, having git reset --index do the equivalent of "rm .git/index &&
>> git reset" might be good to have.
>>
> 
> Doesn't "git update-index --refresh" do the trick?
> 

No.

And neither does --really-refresh.

I guess we need --I-really-mean-it-refresh.

In fact, not even after recompiling with USE_STDEV=y that
--really-refresh helps which stomps me.But what do I know.

Michael
