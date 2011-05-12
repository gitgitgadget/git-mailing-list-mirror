From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Adds 'stash.index' configuration option
Date: Thu, 12 May 2011 10:14:49 +0200
Message-ID: <4DCB96F9.2020700@drmicha.warpmail.net>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com> <4DCB88C1.20105@drmicha.warpmail.net> <20110512080425.GA11870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Pisoni <dpisoni@gmail.com>,
	GIt Mailing List <git@vger.kernel.org>,
	Git Maintainer <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 10:15:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKR2x-0005oV-Ka
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 10:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753468Ab1ELIOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 04:14:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54852 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751449Ab1ELIOw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 04:14:52 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6B78820E3D;
	Thu, 12 May 2011 04:14:51 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 12 May 2011 04:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dOdLeiEl9iCrH5eWRlc9oxd2MRc=; b=KRXgScS+YbqrEGjpuZrRT19lBWretylSYX4D2UI+FBbTzSA2PZ3Loy8fHFnCT6H9Df1HhRwhszZvSYx/HVWT2SlMXsedBjEgwyUcSVrzObNNvSWYip9ErxKjamkIS1UpTDvb+Hg2rGQbc78wovBKv47QPq3bw6cKuzoNohmRlJc=
X-Sasl-enc: qFc/4RBatLa/O0/16eSDWSEzPZX0eeMl1/iBSec67mQA 1305188091
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AD364441B24;
	Thu, 12 May 2011 04:14:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110512080425.GA11870@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173447>

Jeff King venit, vidit, dixit 12.05.2011 10:04:
> On Thu, May 12, 2011 at 09:14:09AM +0200, Michael J Gruber wrote:
> 
>> This is yet another incarnation of
>>
>> foo.bar = true
>>
>> meaning that command "git foo" defaults to "git foo --bar". (Admittedly,
>> this is about subcommands of foo.)
>>
>> It has the same problems (possibly breaking scripts). But more
>> importantly, it inflates the code with every such incarnation we add.
>> Have we really agreed that we introduce these one-by-one rather than
>> doing something generic like
>>
>> uiopts.<cmd> = <optionlist>
>>
>> with which you would do
>>
>> uiopts.stash = "--index"
>>
>> and hopefully be script-safe (again, ignoring the subcommand issue)?
> 
> I would love to see something like this, but have we yet figured out all
> of the issues, like:
> 
>   1. How do scripts wanting to call git programs suppress expansion of
>      uiopts when they want predictable behavior?
> 
>   2. Depending on the solution to (1), how do scripts specify that they
>      _do_ want to allow uiopts (e.g., because they know they are
>      presenting the output to the user) for certain commands?
> 
>   3. Depending on (1) and (2), how do scripts differentiate when some
>      options are OK in uiopts, but others are not? For example, it may
>      be desirable for an invocation of diff-tree to have renames turned
>      on by the user, but not for them to change the output format.
> 

We haven't figured that out, but was the consensus: "Whatever, let's
just keep adding single options." ?

> As much as it sucks to have a config option for each individual option,
> there is at least some oversight of which options will not cause too
> much of a problem when triggered automatically.

I just think we have too many commands which are ui and are used in
scripts (e.g. log, commit, stash, just to name a few) for being able to
decide that ourselves. Are we saying that people using "git stash" in a
script have to deal themselves with a breakage caused by "--index" being
a default for some users now?

With a generic approach, we could protect all git-sh-setup using scripts
right from the start, for example, while still allowing to override some
options or to protect only a few (based on the explicit wishes of a
uiopts-aware script).

Michael
