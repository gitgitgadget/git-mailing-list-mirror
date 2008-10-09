From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Different svn-id URLs in history
Date: Thu, 09 Oct 2008 16:20:30 +0200
Message-ID: <48EE132E.1040407@drmicha.warpmail.net>
References: <48EB40E1.40506@3d-radar.com> <48EB79D8.6090908@drmicha.warpmail.net> <48EC546F.7060106@3d-radar.com> <48EC7022.7030707@drmicha.warpmail.net> <48EC7B52.4000100@3d-radar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org >> Git Mailing List" <git@vger.kernel.org>
To: Knut Eldhuset <knut@3d-radar.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 16:22:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnwPB-00066l-BU
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 16:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758000AbYJIOUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 10:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758753AbYJIOUh
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 10:20:37 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:41128 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753174AbYJIOUg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Oct 2008 10:20:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 174AC17808F;
	Thu,  9 Oct 2008 10:20:35 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 09 Oct 2008 10:20:35 -0400
X-Sasl-enc: Qn35xyWw5H265VI08SJi59+f4yZcb9jUE0sfN1OFdSsc 1223562034
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3BD6627C6D;
	Thu,  9 Oct 2008 10:20:34 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <48EC7B52.4000100@3d-radar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97852>

Knut Eldhuset venit, vidit, dixit 08.10.2008 11:20:
> Michael J Gruber wrote:
>> Knut Eldhuset venit, vidit, dixit 08.10.2008 08:34:
>>> Michael J Gruber wrote:
>>>> Knut Eldhuset venit, vidit, dixit 07.10.2008 12:58:
>>>>> Hi,
>>>>>
>>>>> After cloning my svn repository, I notice that the svn-id URL is 
>>>>> different when going back in history:
>>>>>
>>>>> git-svn-id: https://server/trunk@300
>>>>>
>>>>> vs
>>>>>
>>>>> git-svn-id: https://server/trunk/some_folder/project/src@250
>>>>>
>>>> I take this is as an invitation for guesswork (given the amount of
>>>> details)...
>>> Sorry about that... I'm confused.
>>>> You probably have commits which don't follow your usual svn repo layout
>>>> (trunk/some_folder/project/src) but commit to trunk/ directly. The output of
>>>>
>>>> svn log -v -r300 https://server/trunk@300
>>>> svn log -v -r250 https://server/trunk/some_folder/project/src@250
>>>>
>>>> should give some clues.
>>>>
>>> Svn log shows that the same path has been modified in both cases. I see 
>> Does "same path" mean:
>> - same relative to the above paths or
>> - same absolute path?
> 
> Both say "/trunk/some_folder/project/src/some_file".
> 
>>> something strange in git, though. Our svn repository has about 6500 
>>> commits, but git shows over 10.000. Further investigation shows that a 
>>> lot of svn commits have two entries in git. Some branches off of trunk 
>>> do not start at r1, but off of a duplicate rNNNN. Could this be due to 
>>> our unhealthy practice of creating branches off of subtrees in svn? By 
>>> this I mean create a branch off of 
>>> https://server/trunk/some_folder/project/src instead of 
>>> https://server/trunk. If so, what can be done to fix this?
>>>
>>> As a sidenote, during git svn clone, I noticed that each time a new 
>>> branch or tag was discovered, the "scanning" started back at r1. Is this 
>>> normal? I would think the history before the branch was already 
>>> imported. Of course, this could maybe be due to the bad branching 
>>> practice described above.
>> svn is typically "abused" in the sense that one svn repo is used for
>> separate projects (your subtrees). git-svn can deal with non-standard
>> repo layouts.
>>
>> I assume you can't share the svn repo publically, can you?
> 
> Sorry, no.
> 
>> So, in order to help you, we would need to know
>>
>> - the layout of your svn repo: where are trunk, branches and tags, how
>> did you create branches and tags in svn, are "projects" entirely separate
> 
> https://server/trunk
> https://server/branches
> https://server/tags
> 
> We really only have one "project" source tree at 
> https://server/trunk/some_folder/project/src
> 
> However, once the sources were at
> https://server/trunk/some_folder/project/old_source

That may be the source of the trouble. In fact, the log below indicates
that it is more like the following two paths:

https://server/trunk/project/old_source
https://server/trunk/project/src/client

> Therefore we have the following:
> 
> $ svn log -v -r4871 https://server/
> ------------------------------------------------------------------------
> r4871 | nn | 2007-09-25 13:36:25 +0200 (Tue, 25 Sep 2007) | 3 lines
> Changed paths:
>     M /trunk/project
>     D /trunk/project/old_source/some_file
>     A /trunk/project/src/client/some_file (from 
> /trunk/project/old_source/some_file:4795)
> 
>   commit-message
> ------------------------------------------------------------------------
> 
> $ svn log -v -r4869 https://server/
> ------------------------------------------------------------------------
> r4869 | nn | 2007-09-25 13:14:34 +0200 (Tue, 25 Sep 2007) | 3 lines
> Changed paths:
>     M /trunk/project
>     A /trunk/project/src
>     A /trunk/project/src/client
> 
>   commit-message
> 
> ------------------------------------------------------------------------
> 
> $ svn log -v -r4868 https://server/
> ------------------------------------------------------------------------
> r4868 | nn | 2007-09-25 13:14:28 +0200 (Tue, 25 Sep 2007) | 3 lines
> Changed paths:
>     M /trunk/project
> 
>   commit-message
> 

That one is funny. A modified directory but no paths modified
underneath. Was this a propset?

> ------------------------------------------------------------------------
> 
> $ svn log -v -r4867 https://server/
> ------------------------------------------------------------------------
> r4867 | nn | 2007-09-25 12:04:58 +0200 (Tue, 25 Sep 2007) | 3 lines
> Changed paths:
>     M /trunk/project
>     A /trunk/project/some_file
> 
>   commit-message
> ------------------------------------------------------------------------

Maybe you're trying too hard to disguise things. Are you really adding
some_file right under project here and under project/src/client in r4871?

> 
> r4868 appears twice in git. One commit is on master/trunk and has parent 
> and child, while the other is on a branch and has no parent.
> 
>> - your incarnation of git-svn
>>
> 
> # git --version
> git version 1.6.0.2

I actually meant incantation, I guess I should brush up on my little
latin, uhm ;)

So, did you use something like

git svn init -s https://server/

or

git svn init -T trunk/project/src/client -t 'tags/*/project/src/client'
-b 'branches/*/project/src/client' https://server/

My suggestion would to use two svn sections (option "-R") with different
configs for different repo structures, and to fetch the first one with
"-r1:4866" and the second one with "-r4871:HEAD". Reorganising the svn
repo layout can confuse git-svn quite a bit (and understandably so).
Using different configs for different "epochs" helps. grafts are your
friend when it comes to connecting the two.

Michael
