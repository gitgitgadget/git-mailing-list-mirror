From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [question] how can i verify whether a local branch is tracking
   a remote branch?
Date: Tue, 07 Apr 2009 09:59:47 +0200
Message-ID: <49DB07F3.4000704@drmicha.warpmail.net>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com> <20090405144413.GC2076@sigill.intra.peff.net> <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com> <20090406043426.GC12341@coredump.intra.peff.net> <49D9EEE2.3000607@drmicha.warpmail.net> <20090406212935.GB882@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 07 10:01:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6FN-0007ww-Mo
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbZDGH7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbZDGH7y
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:59:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41551 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751621AbZDGH7x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 03:59:53 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B30343115E7;
	Tue,  7 Apr 2009 03:59:51 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 07 Apr 2009 03:59:51 -0400
X-Sasl-enc: LpqHm+hQpLcy6eQIIKFqklY8LJYrqKM2oCJqfsYT/YC1 1239091191
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E4A18BEA2;
	Tue,  7 Apr 2009 03:59:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090407 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090406212935.GB882@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115926>

Jeff King venit, vidit, dixit 06.04.2009 23:29:
> On Mon, Apr 06, 2009 at 02:00:34PM +0200, Michael J Gruber wrote:
> 
>>> +		if (!strcmp(name, "tracking")) {
>>> +			struct branch *branch;
>>> +			if (prefixcmp(ref->refname, "refs/heads/"))
>>> +				continue;
>>> +			branch = branch_get(ref->refname + 11);
>>> +			if (branch && branch->merge && branch->merge[0] &&
>>> +			    branch->merge[0]->dst)
>>> +				v->s = branch->merge[0]->dst;
>>
>> Isn't that missing out on those cases where you --track (i.e. follow) a
>> local (upstream) branch? See
>> 5e6e2b4 (Make local branches behave like remote branches when --tracked,
>> 2009-04-01)
> 
> I thought the logic was in branch_get to handle it. And indeed:
> 
>   $ git checkout --track -b new master
>   Branch new set up to track local branch master.
>   Switched to a new branch "new"
>   $ git for-each-ref --format='%(refname) %(tracking)'
>   refs/heads/master
>   refs/heads/new refs/heads/master
> 
> So it will point either to something in refs/remotes or in refs/heads,
> as applicable.

Uhm, yes, sorry for the noise. It was actually me who fixed branch_get()...

> 
>> If we hook it up into git-branch there would be to useful directions:
> 
> The difference being that git-branch is porcelain and git-for-each-ref
> is plumbing. So they really serve different purposes.
> 
>> - "git branch --follows foo" could list all branches which follow foo,
>> analogous to --contains. It gives you all your feature work on top of
>> foo, all branches affected by rebasing foo etc.
> 
> Sure, that would probably be useful.
> 
>> - "git branch --whatever foo" could list the branch whoch foo follows.
>>
>> I just notices that "git branch -v foo" does not give me the "-v" output
>> for foo... Improving that would open up the possibility to go for -vv foo.
> 
> See the "-vv" patch I just posted elsewhere in the thread.

I'll comment there ;)

Michael
