From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] provide a new "theirs" strategy, useful for rebase --onto
Date: Sun, 08 Jun 2008 06:38:06 -0700
Message-ID: <484BE0BE.1050102@gnu.org>
References: <E1K4a1Q-0002hq-QE@fencepost.gnu.org> <7vfxrqrwjm.fsf@gitster.siamese.dyndns.org> <484B49D5.8080708@gnu.org> <7vmylwl4t9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, s-beyer@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 15:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5L7d-0006S0-3T
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 15:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbYFHNiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 09:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbYFHNiW
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 09:38:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:25411 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbYFHNiV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 09:38:21 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1449268waf.23
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=/goWAUb9gMNZ54rJXd2R8VV3OAfEA/C9gJ+IRA7/sWc=;
        b=rEso2fIZRxzGGKh5KbyLetsJ3J8WbqdwR+Eg8VkqZFMpGpmQds07iIE/AelpzOUJLH
         lcmUwcaDNHvy3k+BQGGeJuIKP41levQktFbpGkc7o64wsnvUziabg35WTS3nS3QxmpRV
         i/rGiXNaSU2L+EGB0fLhCLSSmOwmwETFrNG5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=tojaf3Kj1XVuwhknjCc6/t69U1Uc2xFHp6e5kHd9SEAHzOBI1U+qj2omn1kCIx8PhB
         7m1Y+XQXHGxLP9btX6eKX+CYHPwxQUUz/xEhRf93zlw/TjzcrqyIAnsFQiV1g6EiR3VV
         CYvcnLpLF0L/ydBf+sIEPr/TPLoU3TKU+Nb7U=
Received: by 10.114.184.9 with SMTP id h9mr2219884waf.151.1212932300996;
        Sun, 08 Jun 2008 06:38:20 -0700 (PDT)
Received: from scientist-2.local ( [65.248.49.167])
        by mx.google.com with ESMTPS id q18sm11997768pog.2.2008.06.08.06.38.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 06:38:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <7vmylwl4t9.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84265>


> Yeah, but that is only about the commit log message.  The issue of
> recording a wrong tree when commits X and Y exist is not alleviated, is
> it?

No, it's not.

> On the other hand, I've sometimes heard people say "when I get a merge
> conflict, I'd want to discard what I did _only in the conflicted part_."
> I am not sure if such a conflict resolution makes much sense in practice,
> but perhaps people know that their changes are worthless crap anyway, and
> do not even care about their work themselves, to the point that they would
> rather discard what they did than spend more time to fix them up properly.
> Whether that makes sense or not, what they want is different from "theirs"
> (which is opposite of "ours"); they want to keep their own changes for
> parts that did not conflict, and give up what they did only in the
> conflicted part.  Perhaps such a kind of mixed conflict resolution should
> be supported under the name of "theirs", even though that would make
> "ours" and "theirs" _not_ the opposite of each other.  I dunno...

Hmm, anyway you do want to test what this strategy would do --- before 
merging.  The point of "ours"/"theirs" is AFAICS that they *cannot* 
produce broken trees (they can cause you to lose committed stuff if used 
carelessly, but the resulting tree is already in some branch and 
supposedly has already been tested).  So breaking the symmetry would not 
be good probably.

I guess I see the reason why "ours" is more useful than "theirs".  The 
reason is that rebase (and "rebase -i" in particular is in some sense 
different from most other git operations.  Git workflows are 
merge-based, so your checked-out branch is the one where the interesting 
stuff is happening; if you wanted a "theirs" merge, you would probably 
do it as a "ours" merge in the other branch.  Rebase instead is 
cherrypicking basically, so "ours" makes no sense (it would just *not* 
cherrypick).

(It also explains why I saw a use case for "theirs" -- as a former arch 
user, I still tend to think in terms of cherrypicks more than merges).

The correct way to proceed would be something like "git rebase -i --onto 
origin/master $(git merge-base origin/master master) master", and then 
if you have

    A--B--C--X--Y     origin/master
        \
         --C'--D--E      master

change

    pick C'
    pick D
    pick E

into

    reset C'^
    pick --strategy=theirs C'
    mark :1
    reset origin/master
    pick :1
    pick D
    pick E

Then I guess the correct way to go is to write a custom script that uses 
the sequencer to make the rebase scenario less dangerous.  You can do

    #! /bin/sh
    # git-merge-after-amend <branch>
    #
    # Makes it possible to do a fast-forward merge of <branch>
    # into HEAD, assuming that the first diverging commit of <branch>
    # is an --amend'ed version of the first diverging commit of HEAD.
    us=$(git rev-parse HEAD)
    them=$(git rev-parse $1)
    base=$(git merge-base $us $them)

    (echo reset $base
    first=t
    git rev-list --reverse $us..$them | while read i do
      if test "$first" = t; then
        first=
        echo pick --strategy=theirs $i
        echo mark :1
        echo reset $us
        echo pick --edit :1
      else
        echo pick $i
      fi
    done) | git-sequencer

This script could actually become a merge strategy, so that you could do

    git reset --hard origin/master
    git merge -s split-first HEAD@{1}

This is maybe a little contrived (what if there are conflits, ecc.), but 
I like how it shows git's pluggability.

So, as a result of the discussion, I think that:

1) it can be useful to put the "theirs" strategy into git, especially as 
the sequencer (which is cherrypick-based) becomes an important component 
of some git porcelain; I would remove the rebase example from my patch 
and make it just a power-user option (same as "-s ours").

2) user-defined merge strategies can be useful.  So it would make sense 
to modify "git-merge" so that it accepts arbitrary merge strategies 
instead of just the predefined ones.  These would default to disallowing 
fast forward and trivial merges.  (Possibly, as a safety net, "index", 
"base", "file", "one-file", "tree" should be excluded... this in turn 
means adding an interface to the commands array in git.c... again, I can 
do this -- if it is considered interesting; I'd like to know that in 
advance -- after the built-in merge is committed).

3) this scenario giveit would make sense to provide the strategy option 
to "git cherry-pick".  I can write a patch for "git cherry-pick" if you 
are interested, though I'd like to have a hint about what to do with the 
short option "-s", which is already taken by "--signoff".  The same 
thing could be done to the sequencer's pick command, so I'm also CCing 
Stephan Beyer about this.

4) A useful option for the sequencer (and possibly for git-rebase) would 
be "--batch", ensuring that a single execution of the sequencer does the 
entire job.  "--edit" would then be changed to mean "ask user to edit 
commit message" instead of "stop and let the user amend the commit"; and 
if a conflict was found, the sequencer would simply abort and exit with 
a non-zero exit status.

Thanks,

Paolo
