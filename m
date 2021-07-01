Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B57AC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732806141F
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbhGAPBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 11:01:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55701 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbhGAPBT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 11:01:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FE02E2511;
        Thu,  1 Jul 2021 10:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ob2aDr8RjtgHbksO7+EYvj8IbsBi0UFGCVK1lg
        wWKC4=; b=dTBoxKrwKCKgGU+h+8ELMgZMC/8CpRLG9H6aKWIn4BAHZdCsRBQ1SC
        vpympUsDh0dcMchXsmrIZ/5woETyxTq8erIvISnYPOoQg2d8ckt0S/0CkPo9EYn5
        uU48GpdIyPvULNSPUpJPqeUKJZBoDaaZvMtiLinS2DiWlnbpXq1oM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16AA5E2510;
        Thu,  1 Jul 2021 10:58:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 825DAE250F;
        Thu,  1 Jul 2021 10:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin <git@mfriebe.de>
Cc:     git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqk0mcy6g2.fsf@gitster.g>
        <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
        <xmqqpmw4uwh2.fsf@gitster.g>
        <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
        <xmqqy2arrmba.fsf@gitster.g>
        <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
Date:   Thu, 01 Jul 2021 07:58:46 -0700
In-Reply-To: <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de> (Martin's
        message of "Thu, 1 Jul 2021 12:06:17 +0200")
Message-ID: <xmqqh7hersgp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D68FE0C4-DA7C-11EB-A0E3-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> Anyway, can we agree, that there are people who (mistakenly)
> use/understand "branch" as including the objects?
> Enough people to call it a "common mistake".
> If so, then we should not ignore this.

I do not think it is a mistake at all.  In a history where the
branch B points at commit Z, we do say the branch contains commits Z
and Y and we do say the branch does not contain commits X or W, for
example.

                 W---X
                /
        ---o---V---Y---Z
                       ^ we're here (branch B)

This is even true if the user is not yet familiar with the
"snapshots" view of the world (which is based on "the objects"), but
has the "changes" view of the world.  The branch has the change that
took Y to Z and the change that took V to Y, but it does not have
the change that took W to X or the change that took V to W.

> With this use of "branch" in mind, (re-)creating an existing
> branch on a new startpoint, does to the inexperienced user read
> like a rebase. It recreates all the commits.

If I understand you correctly, the confusion your hypothetical
newbie would have is caused by the word "start-point" in 

	git branch -f <branch-name> <start-point>

That is, if we repoint the branch that is currently at Z to point at
X with "git branch -f B X", it is possible to imagine that we build
more history on top of "X" simply because "X" is called "start-point",
i.e. we start at X and do something more.

And _your_ particular hypothetical user would imagine that that
something more is to replay Y and Z on top.

But I find two problems with the proposed solution to solve that
confusion.

 * Replaying Y and Z on top of X is not the only possible way to
   build "more" history on top of "start-point" that is X.  It is,
   for example, entirely plausible to look at the remote-tracking
   branch of B and rebuild the history missing from there on top of
   X, just like your version of confusion rebuilt the history
   missing from the tip of old B on top of X.  Saying "Z and Y will
   not be replayed on top of X after resetting the tip of the branch
   to X" may help _your_ version of confusion, but not other
   confusion.

 * In general, when an explanation in the documentation says that
   a command does A, it shouldn't have to say "the command does A
   but does not do B or C on top of that".

I think the source of the confusion is the <start point>.  It does
not change what the explanation wants to say at all if we changed
it to <end point>.  It is where the branch's tip ends up to be after
"git branch -f" (or "git switch -C") finishes, so it might even be
technically more correct.

The only reason why we use <start point> is purely historical.  We
used that phrase from the very beginning.  The explanation did not
consider the use of "gir branch -f" is the *end* of the world.  It
intended the user to use "gir branch [-f]" to start or restart a
branch as the first step of many other things the user will do to
build a history on the branch, and that is the reason why the word
"start" is used.

Perhaps along the lines of the attached patch would be an
improvement without adding "we do not do B, we do not do C, we do
not do anything else we do not say we do in this documentation".

Note that the following is *not* meant to be a full illustration;
there are many leftover <start-point> in these pages after this
patch gets applied that need to be adjusted, if we were to go this
route.

 Documentation/git-branch.txt |  4 ++--
 Documentation/git-switch.txt | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git c/Documentation/git-branch.txt w/Documentation/git-branch.txt
index 94dc9a54f2..5e6a32da04 100644
--- c/Documentation/git-branch.txt
+++ w/Documentation/git-branch.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
-'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
+'git branch' [--track | --no-track] [-f] <branchname> [<commit>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -115,7 +115,7 @@ OPTIONS
 
 -f::
 --force::
-	Reset <branchname> to <startpoint>, even if <branchname> exists
+	Reset <branchname> to <commit>, even if <branchname> exists
 	already. Without `-f`, 'git branch' refuses to change an existing branch.
 	In combination with `-d` (or `--delete`), allow deleting the
 	branch irrespective of its merged status. In combination with
diff --git c/Documentation/git-switch.txt w/Documentation/git-switch.txt
index 5c438cd505..c8ea86d385 100644
--- c/Documentation/git-switch.txt
+++ w/Documentation/git-switch.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git switch' [<options>] [--no-guess] <branch>
-'git switch' [<options>] --detach [<start-point>]
-'git switch' [<options>] (-c|-C) <new-branch> [<start-point>]
+'git switch' [<options>] --detach [<commit>]
+'git switch' [<options>] (-c|-C) <new-branch> [<commit>]
 'git switch' [<options>] --orphan <new-branch>
 
 DESCRIPTION
@@ -39,9 +39,9 @@ OPTIONS
 <new-branch>::
 	Name for the new branch.
 
-<start-point>::
-	The starting point for the new branch. Specifying a
-	`<start-point>` allows you to create a branch based on some
+<commit>::
+	The commit pointed at by the new branch. Specifying a
+	`<commit>` allows you to create a branch based on some
 	other point in history than where HEAD currently points. (Or,
 	in the case of `--detach`, allows you to inspect and detach
 	from some other point.)
@@ -59,7 +59,7 @@ out at most one of `A` and `B`, in which case it defaults to `HEAD`.
 -c <new-branch>::
 --create <new-branch>::
 	Create a new branch named `<new-branch>` starting at
-	`<start-point>` before switching to the branch. This is a
+	`<commit>` before switching to the branch. This is a
 	convenient shortcut for:
 +
 ------------
@@ -70,7 +70,7 @@ $ git switch <new-branch>
 -C <new-branch>::
 --force-create <new-branch>::
 	Similar to `--create` except that if `<new-branch>` already
-	exists, it will be reset to `<start-point>`. This is a
+	exists, it will be reset to `<commit>`. This is a
 	convenient shortcut for:
 +
 ------------
