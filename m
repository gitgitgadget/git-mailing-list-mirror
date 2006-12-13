X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Wed, 13 Dec 2006 15:31:12 -0800
Message-ID: <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612132237.10051.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 23:31:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612132237.10051.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 13 Dec 2006 22:37:09 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34258>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudZJ-0001TY-09 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751791AbWLMXbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWLMXbQ
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:31:16 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:48588 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751751AbWLMXbO (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 18:31:14 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213233112.BYFR97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Wed, 13
 Dec 2006 18:31:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yPXQ1V0041kojtg0000000; Wed, 13 Dec 2006
 18:31:24 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> The major barrier to implementing these sorts of changes is, I
> think, worries about users of the output of these commands in
> scripts.  I say: screw them, porcelain is there for the
> breaking :-)

I like that ;-).

Thanks for the list.  I'll comment only on no brainers.  Things
I cannot decide to agree or disagree are not mentioned in this
message.

>  * git-fetch has to be in working root.  If I can do git-push
>  from anywhere in my tree, why can't I do git-fetch?
>  * git-reset has to be in working root.  If you typically sit
>  in, say "src/", it's annoying to have to change directory to
>  do a reset.
>  * git-verify-tag would be nicer as a switch to git-tag

True and true and true; let's make them happen.

>  * git-commit doesn't (generally) have output - after a
>  commit, it's difficult to know if anything happened.  Get
>  users used to the idea of hashes to identify commits by
>  telling them which one they just made.

I am moderately against making a command verbosely report when
it did exactly what it was told to do, _unless_ the command is
expected to take longer than other commands in git suite, or it
is something the user rarely runs.

>  * git-branch is not verbose enough when creating a new
>  branch, for a new user a little reassurance that what they
>  meant to happen has happened would be nice.

The same comment applies here.  

However, perhaps you could make lack of "[user] expert = true"
in ~/.gitconfig to trigger more verbose messages that say "yes
sir I did what I was told to do".

Not interested in implementing that myself at all, though.

>  Tell them if they
>  made a branch as well, which branch they are now on.

I think you are talking about "checkout -b" not commit here;
this might be a borderline (branch creation is less often done
and it might warrant assuring feedback), but I think it still
falls into the "doing exactly what it was told to do" category.

>  * git-init-db says "defaulting to local storage area", as if that is
>    meant to be a helpful message

It probably used to be back when the original tutorial Linus
wrote was still called tutorial.txt; but I agree that the
message is not helpful anymore.

>  * git-merge output is horrible - this affects git-pull,
>  git-rebase, and git-cherry-pick.  Issuing "fatal" errors and
>  then carrying on is very confusing.  Errors in merges appear
>  multiple times.  The files upon which which there is a
>  conflict are spread throughout the output.  Most of the
>  output is not relevant to an average user.

Yes.

>  * git-apply output is horrible.  It says a few things about
>  whitespace on stdin then just finishes.  When it succeeds.
>  When it fails, it just says failed, it doesn't say why a
>  particular hunk failed.

No.  It either says patch is corrupt, or a hunk at this line
does not apply.  I do not see what more would you would want to
ask it to say.

>  * git-commit without "-a" and without an "update-index" says "nothing
>    to commit", which isn't an adequate message to help a user who hasn't
>    realised they need to update the index

Perhaps.

"\n(hint: 'git add' to stage your changes, or 'git commit --all')\n"
in wt-status.c under "[user] expert = false" mode?

>  * git-rebase --skip requires that the offending file be clean with
>      git-checkout HEAD file
>    before the skip will work.  Why?  The fact of the skip is enough
>    knowledge for rebase to know that I don't care if the merge is lost

As long as your solution does not accidentally lose local,
unrelated changes, changing "git-rebase --skip" to do the needed
clean-up itself for the user would be Ok (I think we would want
to loosen the requirement for starting in a totally clean
working tree in the future).

>  * git-rebase/git-cherry-pick/git-reset/etc should all tell
>  the user that they need to run git-prune to tidy up after
>  themselves.

While I agree the users need to be taught about 'prune', I do
think immediately after running the above commands is exactly
the wrong point to run 'prune'.  'prune' should not be run while
you are busily munging the tip of the branch with rebase and
reset to come up with something that you can call "oh, I am done
with this series for now."  Otherwise even lost-found would not
be able to help you.

Also, this sequence creates crufts that need to be pruned:

	edit hello.c
	git add hello.c
        edit hello.c
        git add hello.c

I do not think we would want to suggest 'git prune' upon every
'git add'.

>  * git-add has no output, whether it works or not

"git add no-such-file" complains, and I think that is adequate.
Now with Nico's 'add means adding contents, not path' change is
in, we _might_ want to differentiate adding a path that was
untracked before and updating the contents, but I think this
again falls into "doing exactly as told" category.

>  * git-cat-file is badly named.  git-cat-object would be slightly
>    better.

Not a Porcelain.

We might want to add a pair of built-in internal aliases though:

	[alias]
        	cat = cat-file -p
                less = -p cat-file -p

or have these as samples in template .git/config file.

>  * In general the principle for messages should be the same as for 
>    presentations:
>     - say what you're going to do
>     - do it
>     - say what you did
>    So for example, "git-branch newbranch existingbranch" would say
>     Branching at "existingbranch", hash XXXXXXXXXXXXXXXXXX
>      - created branch "newbranch"
>      - your working branch is "existingbranch"
>    Rather than the nothing that it currently outputs.

In general the principle ought to be not to say anything if the
command does exactly what it was told to do successfully, unless
the operation is expected to take longer than other normal
commands in the git suite, or something that is rarely used.

Perhaps under "[user] expert" control.
