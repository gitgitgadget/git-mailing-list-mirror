From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 16:02:43 +0200
Message-ID: <20080723140243.GA6678@elte.hu>
References: <20080723130518.GA17462@elte.hu> <488734D9.9070703@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:04:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLewf-0003ub-6L
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393AbYGWOC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbYGWOC5
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:02:57 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45061 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393AbYGWOCz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:02:55 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1KLevV-0006fy-M3
	from <mingo@elte.hu>; Wed, 23 Jul 2008 16:02:54 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id A983B3E21AB; Wed, 23 Jul 2008 16:02:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <488734D9.9070703@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89656>


* Andreas Ericsson <ae@op5.se> wrote:

> Ingo Molnar wrote:
>> I've got the following, possibly stupid question: is there a way to  
>> merge a healthy number of topic branches into the master branch in a  
>> quicker way, when most of the branches are already merged up?
>>
>> Right now i've got something like this scripted up:
>>
>>   for B in $(git-branch | cut -c3- ); do git-merge $B; done 
>>
>> It takes a lot of time to run on even a 3.45GHz box:
>>
>>   real    0m53.228s
>>   user    0m41.134s
>>   sys     0m11.405s
>>
>> I just had a workflow incident where i forgot that this script was  
>> running in one window (53 seconds are a _long_ time to start doing some 
>> other stuff :-), i switched branches and the script merrily chugged 
>> away merging branches into a topic branch i did not intend.
>>
>> It iterates over 140 branches - but all of them are already merged up.
>>
>
> With the builtin merge (which is in next), this should be doable with 
> an octopus merge, which will eliminate the branches that are already 
> fully merged, resulting in a less-than-140-way merge (thank gods...). 
> It also doesn't have the 24-way cap that the scripted version suffers 
> from.
>
> If it does a good job at your rather extreme use-case, I'd say it's 
> good enough for 'master' pretty soon :-)

hm, while i do love octopus merges [*] for release and bisection-quality 
purposes, for throw-away (delta-)integration runs it's more manageable 
to do a predictable series of one-on-one merges.

It results in better git-rerere behavior, has easier (to the human) 
conflict resolutions and the octopus merge also falls apart quite easily 
when it runs into conflicts. Furthermore, i've often seen octopus merges 
fail while a series of 1:1 merges succeeded.

What i could try is to do a speculative octopus merge, in the hope of it 
just going fine - and then fall back to the serial merge if it fails?

The git-fastmerge approach is probably still faster though - and 
certainly simpler from a workflow POV.

	Ingo

[*] take a look at these in the Linux kernel -git repo:

      gitk 3c1ca43fafea41e38cb2d0c1684119af4c1de547
      gitk 6924d1ab8b7bbe5ab416713f5701b3316b2df85b
