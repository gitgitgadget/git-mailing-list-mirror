From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Wed, 26 Apr 2006 13:25:36 +0200
Message-ID: <444F58B0.6090603@op5.se>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>	<e2kgga$d7q$1@sea.gmane.org>	<7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0604250811230.3701@g5.osdl.org>	<Pine.LNX.4.64.0604250833540.3701@g5.osdl.org> <BAYC1-PASMTP086A906CFB378AB229C2D8AEBF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, junkio@cox.net,
	git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 26 13:25:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYi9N-0005Fc-RZ
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 13:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWDZLZj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 07:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWDZLZj
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 07:25:39 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:25541 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932391AbWDZLZi
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 07:25:38 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id A42EA6BCBE; Wed, 26 Apr 2006 13:25:36 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP086A906CFB378AB229C2D8AEBF0@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19199>

sean wrote:
> On Tue, 25 Apr 2006 08:40:25 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
>>On Tue, 25 Apr 2006, Linus Torvalds wrote:
>>
>>>I want the git objects to have clear and unambiguous semantics. I want 
>>>people to be able to explain exactly what the fields _mean_. No "this 
>>>random field could be used this random way" crud, please.
>>
>>Btw, if the whole point is a "leave random porcelain a field that they can 
>>use any way they want", then I say "Hell NO!".
>>
>>Random porcelain can already just maintain their own lists of "related" 
>>stuff, any way they want: you can keep it in a file in ".git/porcelain", 
>>called "list-commit-relationships", or you could use a git blob for it and 
>>have a reference to it in .git/refs/porcelain/relationships or whatever. 
>>
>>If it has no clear and real semantic meaning for core git, then it 
>>shouldn't be in the core git objects.
>>
>>The absolute last thing we want is a "random out" that starts to mean 
>>different things to different people, groups and porcelains.
>>
>>That's just crazy, and it's how you end up with a backwards compatibility 
>>mess five years from now that is totally unresolvable, because different 
>>projects end up having different meanings or uses for the fields, so 
>>converting the database (if we ever find a better format, or somebody 
>>notices that SHA1 can be broken by a five-year-old-with-a-crayon).
>>
>>There's a reason "minimalist" actually ends up _working_. I'll take a UNIX 
>>"system calls have meanings" approach over a Windows "there's fifteen 
>>different flavors of 'open()', and we also support magic filenames with 
>>specific meaning" kind of thing.
>>
> 
> 
> It's a fair point.  But adding a separate database to augment the core 
> information has some downsides.  That is, that information isn't pulled, 
> cloned, or pushed automatically; it doesn't get to ride for free on top 
> of the core.
> 
> Accommodating extra git headers (or "note"'s in Junio's example) would allow
> a developer to record the fact that he is integrating a patch taken 
> from a commit in the devel branch and backporting it to the release 
> branch.   Either by adding a note that references the bug tracking #, or 
> a commit sha1 from the devel branch that is already associated with the bug.
> 

This information is something I, as a human, would definitely want to 
read. What's the point of recording it in the commit-header if we're not 
going to show it to users anyway? I'm with Linus on this one. Keep 
headers as simple as possible.

> Of course that information could be embedded in the free text area, but 
> you yourself have argued vigorously that it is brain damaged to try and rely
> on parsing free form text for these types of situations.

Why would there be a need to parse it? The entire *point* of history is 
to present it to readers in an as accessible and understandable way as 
possible. Git's sha1 hashes mean absolutely nothing, so a note saying 
something was cherry-picked from commit 
"89987987ad987aef987987aff987987d" on branch "devel" will be pointless 
unless the one doing the committing states the why as well as the what 
in the commit-message anyways.

Besides, only developers will likely ever look at the commit-messages, 
and they will likely only ever do it when they are bisecting or looking 
for the implementation date of a certain feature or other.

>  Most of the potential 
> uses aren't really meant for a human to read while looking at the log anyway, 
> they just get in the way.

I still fail to see a use case for this. Could you give me some examples 
to when information recorded isn't meant for being presented to the user?

> 
> But if the information is in the actual commit header it gets to tag along
> for free with never any worry it will be separated from the commit in question.
> So when the developer above updates his official repo the bug tracker system 
> can notice that the bug referenced in its system has had a patch backported 
> and take whatever action is desired.  
> 

We already have something like this. All commits with a top-line message 
containing "bug #" followed by a number automatically updates our 
bugtracking system with the commit-message in its entirety. If the word 
before "bug #" matches "fix.*" then the status of the bug is set to that.

This might seem cumbersome to some but it's really very straightforward, 
and for a couple of reasons it's a very good solution:
1. Devs who Do It Right don't have to fiddle with their browser just to 
enter the info twice, so they learn fast. :)
2. BT history (viewed by non-devs too) gets updated with accurate 
information promptly.
3. No matter how you solve the problem you're going to need to write a 
custom commit/update hook anyway, so this is as good as having the info 
in the note.
4. The info going to the BT is easily modifiable, so if someone screws 
up they can fix it later. Fixing an already written git commit takes 
some doing if there are commits on top.

> Of course there are other ways to do this, but integrating it into git means it
> gets a free ride on the core, and it shouldn't really get in the way of core 
> any more than email X- headers get in the way of email flowing.
> 

True. I've suggested before that arbitrary headers could be added to git 
commits by prefixing them with X- (preferrably followed by an abbrev of 
the porcelain name adding the note). This way it's easy to filter, you 
get the free ride, and porcelains can do whatever they want while core 
git can strip everything following the sequence "\nX-" up to and 
including the next newline.

This way you have only one special byte-sequence with special meaning 
that the plumbing has to know it should ignore, which is a lot more 
extensible (not to mention easier to code).

In addition, if those X- lines aren't included in the sha1 computation 
they can easily be removed and added to without affecting the ancestry 
chain. This would probably have quite a performance impact though.

That said, I don't think even "X-" headers is a very good idea. Perhaps 
i've just got poor imagination but I can't think of a good use for them.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
