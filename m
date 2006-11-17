X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Re: [DRAFT] Branching and merging with git
Date: 16 Nov 2006 22:17:47 -0500
Message-ID: <20061117031747.30672.qmail@science.horizon.com>
References: <7vac2q281q.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Fri, 17 Nov 2006 03:18:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vac2q281q.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31663>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkuEq-0004Nd-Cp for gcvg-git@gmane.org; Fri, 17 Nov
 2006 04:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424756AbWKQDRt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 22:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424758AbWKQDRt
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 22:17:49 -0500
Received: from science.horizon.com ([192.35.100.1]:54058 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S1424756AbWKQDRs (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 22:17:48 -0500
Received: (qmail 30673 invoked by uid 1000); 16 Nov 2006 22:17:47 -0500
To: junkio@cox.net, linux@horizon.com
Sender: git-owner@vger.kernel.org

Overall, thank you.  I'm trying to merge all your comments
into the document to make it better, but there are enough that
it's taking me a while.

>> One outstanding problem with git's man pages is that often the most detail
>> is in the command page that was written first, not the user-friendly
>> one that you should use.
> 
> This is a very important point to remember not for users but for
> us in git community.  Thanks for writing it down.

There's a great example coming up, in the git-show
example you gave me.  That's a very sparse man page...

> Dodecapus would find a few, no hits on doedecapus ;-).

Wups, thanks.

>> * Deleting branches
>>
>> "git branch -d <head>" is safe.  It deletes the given <head>, but first
>> it checks that the commit is reachable some other way.  That is, you
>> merged the branch in somewhere, or you never did any edits on that branch.
> 
> It is not "somewhere" but "in the current branch", so in a sense
> it is a bit stricter than that.  While on 'master' "branch -d
> topic" would not remove the topic branch head if it is not fully
> merged to my 'master' so that is a reasonable safety measure,
> but when I am on 'next' it will happily remove it.  It is
> recoverable because it is reachable from 'next', though.

Oh!  Thanks for the info.  The limitation makes a certain
amount of sense, and as I'd never run into it, I'm not going to
complain.

> The reason is because 'git pull $url $branch' (typical Linus's
> use) and 'git pull' (defaulting to 'origin' and using the
> tracking branch mapping stored in .git/remotes/origin prepared
> by git-clone) are sign of very different workflows.  The former
> tends to be a one-shot event while the latter is most often
> synchronizing with either an upstream or a common distribution
> point (i.e. shared central repostiory).  When you are fetching
> from somebody in a one-shot manner, most likely as a part of
> 'pull', you do not want to get the tag the other person has made
> to mark his private work in progress.  But in the latter case,
> the other end is where everybody who works in the same area
> fetches from, and sharing the tags found there among the
> developers by default is desirable, and more importantly there
> is no risk of accidentally getting private tags, since the other
> end is a public distribution point and by definition should not
> have private tags that would clutter your refs/tags hierarchy.

I'll work this in somehow, thanks.

> Here you _might_ want to mention an alternative workflow that
> uses rebase, which seems to be the way Wine folks run their
> project.  Talking about all the different possibilities tends to
> cloud things and may not add value to the document, so I am just
> mentioning it as a possibility but I do not know if talking
> about rebase is useful in the context of this document.

Done, thanks.

>> The primitive that does the merging is called (guess what?) git-merge.
>> And you can use that if you want.  If you want to create a so-called
>> octopus merge, with more than two parents, you have to.
> 
> This is not true; "git pull . topicA topicB topicC" works as
> expected.  But we probably would not want to even talk about
> Octopus in a document like this.  It is a curosity, and
> sometimes tends to make histories even less cluttered, but
> otherwise it does not add much value.

Sorry; the SYNOPSIS line for git-pull had me fooled.

>> However, it's usually easier to use the git-pull wrapper.  This merges
>> the changes from some other branch into the current HEAD and generates
>> a commit message automatically.
>>
>> git-merge lets you specify the commit message (rather than generating it
>> automatically) and use a non-HEAD destination branch, but those options
>> are usually more annoying than useful.
> 
> I haven't tried for a long time, but I do not think non-HEAD
> destination even works at all.  It might be better not to even
> mention git-merge at this point of the document.

Well, I want to at least say "you think so, wouldn't you?"

>> * How merging operates
> 
> You might also want to mention that recursive first 3-way merges
> the renames.  If O->A renames a path while O->B keeps it, the
> resulting stages are written under the new name.

Thanks!  I wondered how that happened!

>> * When merging goes wrong

> Another tool to help the user decide how the mess should be
> sorted out is "git log --merge -- $path".  It gives the logs of
> commits that touched the path while the two branches were forked.

The things I never knew about...

>> Git-rebase can also help you divide up work.  Suppose you've mixed up
>> development of two features in the current HEAD, a branch called "dev".
> 
> Ancestry graph before and after this procedure would help the
> reader a lot here.

I figured the (excellent) pictures in git-rebase would save me the
trouble, but yeah, I suppose so.

> They were conflicts during the virtual ancestor computation by
> recursive (the merge between 'a' and 'b' commits in your earlier
> example).  When a virtual ancestor is created, it can textually
> have conflicted merge, but that is recorded along with conflict
> markers without manual resolving for obvious reasons.  If two
> branches that use the virtual ancestor modifies the conflicted
> region the same way (because they needed to resolve that
> conflict in their branch), the final 3-way merge that uses the
> virtual ancestor as the merge-base will replace that conflicted
> region with their changes.  This "even conflict markers can be
> eliminated by a merge resolution" behaviour is what inspired
> git-rerere, by the way.

Cool, thanks!  I added mention of this.

> If you are using this particular commit as an example, you might
> also want to tell your readers about:
> 
> 	git show -M 3f69d405
> 
> (-M is there to make the output more readable, because this
> merge involved a few renames).

I'm wondering what the heck that does!  I get a super-short diff with
no mention of any renames at all.  Is this passed on to git-diff-tree?
What does "detect renames" mean if it doesn't tell me about them?
I'm actually confused.

diff --cc builtin-read-tree.c
index ec40d01,99e7c75..716f792
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@@ -9,9 -9,9 +9,10 @@@
  
  #include "object.h"
  #include "tree.h"
+ #include "cache-tree.h"
  #include <sys/time.h>
  #include <signal.h>
 +#include "builtin.h"
  
  static int reset = 0;
