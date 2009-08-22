From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/9] sequencer: add "do_fast_forward()" to perform a fast forward
Date: Sat, 22 Aug 2009 13:19:37 +0200
Message-ID: <200908221319.37737.chriscool@tuxfamily.org>
References: <20090822041157.4261.92491.chriscool@tuxfamily.org> <20090822041616.4261.40442.chriscool@tuxfamily.org> <7vab1s5mtc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 13:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeocW-0002Vw-2s
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 13:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259AbZHVLSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 07:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933248AbZHVLSm
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 07:18:42 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:58142 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933163AbZHVLSl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 07:18:41 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 9D2008180E3;
	Sat, 22 Aug 2009 13:18:33 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 89643818057;
	Sat, 22 Aug 2009 13:18:30 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vab1s5mtc.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126805>

On Saturday 22 August 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > From: Stephan Beyer <s-beyer@gmx.net>
> >
> > This code is taken from the sequencer GSoC project:
> >
> >     git://repo.or.cz/git/sbeyer.git
> >
> >     (commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20)
> >
> > but the messages have been changed to be the same as those
> > displayed by git-rebase--interactive.sh.
>
> Hmm, forgot to amend, or perhaps you sent out a wrong series?

Your comments on the v2 series were in a message replying to patch 5/9, so I 
amended only 5/9 and after it, because I thought that you had already 
reviewed those before 5/9 and they were ok.

> The log message does not explain:
>
>  - why the patch adds a new static function that nobody calls;
>  - what the new function is good for;
>
> which are the most important things in order to defend the change.

Yes, but the function contains only 5 lines of code and it mostly only calls 
reset_almost_hard() that is already documented by a big comment before its 
definition.

> "The messages have been changed to..." hints that the original commit by
> Stephan had different messages produced, perhaps so that it can be used
> in a different context.  I hoped, in an ideal world, perhaps Stephan
> defended why the change was relevant to his project in some way, and
> because you are using it in a different context that needs modification
> of the message, perhaps Stephan's defense of his commit could be reworded
> to defend your change here.
>
> So I decided to take a look at the quoted commit to see if I can reword
> this mess.
>
> But the quoted commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20 does not
> even seem to be a commit that corresponds to this change.  It is a merge
> from upstream.
>
>     commit e7b8dab0c2a73ade92017a52bb1405ea1534ef20
>     Merge: 0c73ae7 99ddd24
>     Author: Stephan Beyer <s-beyer@gmx.net>
>     Date:   Wed May 20 10:54:37 2009 +0200
>
>         Merge branch 'junio/master' into seq-builtin-dev
>
>         After this merge f79d4c8 "teach git-am to apply a patch to an
> unborn branch" has to be reimplemented in sequencer by allowing the
> "patch" insn on unborn branches.
>         The related test in t/t4150-am.sh is set to test_expect_failure.
>
>         Conflicts:
>             git-am.sh

This is the commit at the point where I took the code of the function, not 
the commit that introduce the function. This is because some functions like 
pick() in patch 5/9 evolve a lot in the sequencer repo after they are 
introduced.

> It does not help that the function that is crucial to the implemention of
> this new function, reset_almost_hard(), is not explained at all in the
> earlier commit in the previous series (36f692b (sequencer: add
> "reset_almost_hard()" and related functions, 2009-08-05).
>
> The log message to the commit does not even hint in what sense "almost"
> the function is, iow, in what situation it behaves exactly like "reset
> --hard", and in what other situation it doesn't, and more importantly why
> that distinction is there.  I thought I asked these questions when the
> previous series was submitted, but I do not remember ever seeing
> satisfactory answers to them.

You asked questions about reset_almost_hard() and I added the big comment 
before its definition, see:

http://git.kernel.org/?p=git/git.git;a=commitdiff;h=9d41fbd28f1ba3d07cd2e0f547521f9dced4cfd2

As you merged the series in pu, I thought that it was ok.

> I am afraid that the whole cc/sequencer-rebase-i series needs a serious
> reroll before it gets near 'next'.

Ok, I will reroll everything to try to improve commit messages.

> Before giving up, I'll quickly re-review how (un)readable the log of each
> commit is in the series.  The following comments are mostly about the log
> messages, which are supposed to entice people to review the code, and
> more importantly, used as part of the release notes to summarize what the
> newly added toys are about.  If they are horrible, the code has little
> chance to be even read, and I'll have a hard time merging the series up
> into a new release.

About the release notes, as "git sequencer--helper" is not for public use, 
and as many functions like reset_almost_hard() are static, perhaps it would 
be ok to have only something like:

(developers)

- parts of "git rebase -i" have been ported to C using "git 
sequencer--helper"

- cherry-pick and revert functionality is available using new functions 
declared in "pick.h"

> 6db6551 sequencer: add "builtin-sequencer--helper.c"
>
> Good.
>
> b512803 sequencer: add "make_patch" function to save a patch
>
> Passably okay, but the limitation that it always writes into a file with
> a fixed name "$SEQ_DIR/patch" should be noted in the log.

Ok.

> 0ccc92b sequencer: free memory used in "make_patch" function
>
> Should be squashed to the previous.

Will do.

> f121b06 rebase -i: use "git sequencer--helper --make-patch"
>
> Good.
>
> 36f692b sequencer: add "reset_almost_hard()" and related functions
>
> Horrible.  See above.
>
> 9d41fbd sequencer: add comments about reset_almost_hard()
>
> Should be squashed to the previous---lift some text to justify the
> existence of the function in the commit log message.

Will do.

> Even though 
> allow_dirty is referred to in the comment as affecting the behaviour, it
> is unclear who sets that global variable using what interface, making the
> reader suspect that maybe it should be a function parameter instead of a
> global (but the other parts of the helper may also look at allow_dirty
> and the internal implementation might be--I am just guessing--simpler
> this way, in which case _that_ should be explained and justified).

Will have a look.

> 022a9e7 sequencer: add "--reset-hard" option to "git sequencer--helper"
>
> This by itself is Okay, provided if 36f692b were made readable.  Then you
> can expect the reader to know why reset_almost_hard() needs to be there,
> and you need an interface to that function.  Until then, it is totally
> unclear why you need this, instead of using "reset --hard" itself.

Ok.

> ad28459 rebase -i: use "git sequencer--helper --reset-hard"
>
> Ditto.
>
> e4b3f0f sequencer: add "do_fast_forward()" to perform a fast forward
>
> See above.
>
> 1d88073 sequencer: add "--fast-forward" option to "git sequencer--helper"
>
> Okay.
>
> 6eff656 sequencer: let "git sequencer--helper" callers set "allow_dirty"
>
> Why?  What for?

Daniel asked me to make it available so people interested can test. I will 
state this in the commit message.

> 877ddc1 rebase -i: use "git sequencer--helper --fast-forward"
>
> It is unclear how this relates to the previous one, nor why it is more
> appropriate than "reset-hard" it replaces.

It is more appropriate because it makes the rebase -i shell code a little 
bit shorter. I will add that to the commit message.

> ff312f0 revert: libify pick
>
> Almost good.

Will try to improve.

> ab67716 pick: libify "pick_help_msg()"
>
> Good.
>
> d871b0e sequencer: add "do_commit()" and related functions
>
> We can see from "git show" what static functions that are never called in
> this commit are added, but nobody explains why they are needed.  For
> example, do_commit() may create a new commit object, but does not share
> the code with what "git commit" and/or "git commit-tree" do?  If so, how?
> If not, why not?

Will have a look.

> ac5fc4d sequencer: add "--cherry-pick" option to "git sequencer--helper"
>
> Passably okay.  I can see ff312f0 made about a half of cherry-pick
> accessible to the sequencer, and this patch uses it to finish the other
> half, although that is not explained in the log message.  Also it is
> unclear why the resulting "libified" code does not share more
> infrastructure with "git cherry-pick" itself (and "git revert").

Will have a look.

> 664c7ab rebase -i: use "git sequencer--helper --cherry-pick"
>
> Passably okay, even though it is not quite convincing why using
> sequencer-helper's cherry-pick option makes it easier to later port the
> script, than keeping calls to cherry-pick.

Will have a look.

Thanks,
Christian.
