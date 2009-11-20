From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: Headless tags don't have a follows or precedes?
Date: Thu, 19 Nov 2009 17:07:46 -0800 (PST)
Message-ID: <1258679266168-4035472.post@n2.nabble.com>
References: <1257067898626-3926483.post@n2.nabble.com> <4AEEA96F.7080609@drmicha.warpmail.net> <1257167247221-3931674.post@n2.nabble.com> <4AEF009E.5060005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 02:08:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBHyg-0002ej-CH
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbZKTBHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756963AbZKTBHl
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:07:41 -0500
Received: from kuber.nabble.com ([216.139.236.158]:39696 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842AbZKTBHk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:07:40 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NBHyU-0000VC-5b
	for git@vger.kernel.org; Thu, 19 Nov 2009 17:07:46 -0800
In-Reply-To: <4AEF009E.5060005@drmicha.warpmail.net>
X-Nabble-From: Tim Mazid <timmazid@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133274>


Hey list,

I was just wondering if there were any updates to this?

Also, I believe I forgot to mention the gitk version, it's 1.6.5.3-1.

Cheers,
Tim.


Michael J Gruber-2 wrote:
> 
> Tim Mazid venit, vidit, dixit 02.11.2009 14:07:
>> Michael J Gruber-2 wrote:
>>>
>>> Would would help:
>>>
>>> - saying you're talking about gitk/git view/whatever it is you're
>>> "clicking" on
>>>
>> My apologies, yes, in gitk.
>> 
> 
> Now we only need the version... but we'll see if current versions
> reproduce it.
> 
>> Michael J Gruber-2 wrote:
>>>
>>> - providing a minimal example others can reproduce. That would be one
>>> where a tag on a detached head (assuming that's what you mean) has no
>>> precedes/follow but a tag "on a branch" does have that info
>>>
>> 
>> Example (unless specified, commands as entered into bash)
> 
> Great example, thanks!
> 
>> 
>> mkdir temp
>> cd temp
>> git init
>> gitk --all &
>> git commit --allow-empty -m '1'
>> git tag v1
>> git commit --allow-empty -m '1.1'
>> git tag v1.1
>> git commit --allow-empty -m '1.2'
>> git tag v1.2
>> (in gitk, press ctrl+f5; all follows and precedes info is there)
>> git checkout v1.1
>> git commit --allow-empty -m '1.1.1'
>> git tag v1.1.1
>> (in gitk, press f5; follows and precedes info missing for v1.1 and
>> v1.1.1)
> 
> For me, v1.1.1 has no info and v1.1 is missing v1.1.1 in its precedes.
> 
>> (close gitk)
>> gitk --all &
>> (info still missing)
>> git commit --allow-empty -m '1.1.2'
>> git tag v1.1.2
>> (in gitk, press f5, info still missing)
> 
> v1.1.1 and v1.1.2 missing all follow/precede info.
> 
>> git checkout master
>> git commit --allow-empty -m '1.3'
>> git tag v1.3
>> (in gitk, press f5, info still missing)
> 
> Now, even v1.3 is missing its follows and v1.2 its precedes, even though
> they've got nothing to do with the "detached branch".
> 
>> git commit --allow-empty -m '1.4'
>> git tag v1.4
>> (in gitk, press f5, info still missing)
>> git checkout -b temp v1.2
>> git commit --allow-empty -m '1.2.1'
>> git tag v1.2.1
>> (in gitk, press f5, info still missing)
>> git checkout master
>> git branch -D temp
>> git commit --allow-empty -m '1.5'
>> git tag v1.5
>> (in gitk, press f5, info still missing)
>> 
>> 
>> In the end, the only follows/precedes info is:
>> v1: precedes v1.1
>> v1.1: follows v1, precedes v1.2
>> v1.2: follows v1.1
>> All the rest is missing.
> 
> So basically, all connectivity which has been created after detaching
> the head is missing, even that which has been created on a "proper
> branch", which means (to me) it has nothing to do with git's revision
> parsing (such as missing out on lightweight tags on detached heads).
> 
> I looked at the gitk code and got the expected result: no clue (tcl/tk
> doesn't tick my fancy). gitk's parsing of ancestry relations seems to be
> done completely in tcl (rather then relaying a lot to git-rev-parse,
> which may not be efficient here). So I'll take the liberty to cc the
> main gitk guy. A few more notes:
> 
> After generating v1.1.1 (which misses "follows"), .git/gitk.cache has
> this (\n added for clarity):
> 
> 1 1\n
> 6bfcf857ceef0507bb50ee17302c1d068b697540
> b67f4651e49a33ee8cc77157e4e51d1e635a7c0d
> {540abf2b75aec7ccbd8c0413863a018fc1c1eb37
> b67f4651e49a33ee8cc77157e4e51d1e635a7c0d}\n
> 1\n
> 
> If I move that out of the way and rerun gitk, everything's in apple pie
> order, and the cache file is:
> 
> 1 3\n
> 2fd83b12ccea07c88f5998aa6303003ef1e4858b
> 540abf2b75aec7ccbd8c0413863a018fc1c1eb37
> 540abf2b75aec7ccbd8c0413863a018fc1c1eb37\n
> 6bfcf857ceef0507bb50ee17302c1d068b697540
> 540abf2b75aec7ccbd8c0413863a018fc1c1eb37
> 540abf2b75aec7ccbd8c0413863a018fc1c1eb37\n
> 540abf2b75aec7ccbd8c0413863a018fc1c1eb37
> b67f4651e49a33ee8cc77157e4e51d1e635a7c0d
> b67f4651e49a33ee8cc77157e4e51d1e635a7c0d\n
> 1\n
> 
> Unsurprisingly, v1.1.2 (committed & tagged on a detached head) trips
> things up again, moving gitk.cache out of the way helps again.
> 
> Surprisingly, v1.3 (committed and tagged on a checked out branch) trips
> things up again, moving... helps again.
> 
> Paul, I hope you can make sense of this. Something in gitk.cache
> prevents gitk from rescanning for new children, an empty cache gets it
> right, but only until the next run.
> 
> Michael
> 

-- 
View this message in context: http://n2.nabble.com/Headless-tags-don-t-have-a-follows-or-precedes-tp3926483p4035472.html
Sent from the git mailing list archive at Nabble.com.
