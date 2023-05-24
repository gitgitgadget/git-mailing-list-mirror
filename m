Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5880C77B7A
	for <git@archiver.kernel.org>; Wed, 24 May 2023 23:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjEXXVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEXXVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 19:21:45 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5314B99
        for <git@vger.kernel.org>; Wed, 24 May 2023 16:21:44 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25338b76f79so503643a91.3
        for <git@vger.kernel.org>; Wed, 24 May 2023 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684970504; x=1687562504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WWxDOTOcTV6aO9WnThQoEm8SdTF+NCmt7rnGafWzSbY=;
        b=qBY5p1vfeMbg0W8tqhE3HtQowndW4NopZxWCUHsiz/mekZQJGLWRaj7ekYUB3LjENk
         iesrkpifaklStfdiCqF4N1JPXvhKtq1CDyy0yh5AFUnT46H8ZXHhkgRtRucUz3V1Gl7U
         wPRYT5ZGpilwe9o2EZ2jo2DPoatbedjONiCByXxop76ykI4Ed8Y1wLlVzl519Om6a0UV
         kkEm+tpCzBM7wfQjxSve/FE0tJMP9pi2BfuuTw8I230fEw+kS7AU6KU3XgjCbGNNW1bo
         wS36kMd4na5WhQqyaem47iyEhPWLB/OAMv1TGccGCo9vnWXRJBgIkgOmuQ9TIkV0ehNA
         lakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684970504; x=1687562504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWxDOTOcTV6aO9WnThQoEm8SdTF+NCmt7rnGafWzSbY=;
        b=HK4qoQyPhiLkNdx5AnfJkUEMYML2sfcmapvwA030P4X/WMdv2ZJ5/qR+cOsqIlaR2j
         giiBecws+3H+8mZ1Is45wOs+DyLH9faGL4915stTHQbUjQV1hxwFDjRqyh8pzFsccIkB
         Xajhl77XHr55ge+VRCRwHT8ZyzhGVXImG9gUV7bOyq43kBT+rqHLfvENH+3L5PzrVwQV
         q0bYFksMiNNSlmP3tBll6iz9zU9r/MQtV3drkXrIDCr+bHabDyesE8puSnIlZxHCXKMr
         yZO5rZ9+98KLfprPry17vYV9qzhi6kUq6hxVSVsZCaFIg4mrgfo0pItXtTQjS+r9vUev
         YwgQ==
X-Gm-Message-State: AC+VfDw5OQkGEhPrULPuSbPcRwUuJln6E9C3w4rY+es2GwYKRvlIIPIn
        ZL4Wms3x8MvScaFMDBIdHEn5FlGVY5l9dw==
X-Google-Smtp-Source: ACHHUZ5QS2uG1+cXWSnMoFX6tqsO9DWt3JTF6rDzt+CHBLA0OJ9lEqSIIqDILNsckC+7Rlv5pYvGZVwyQQIgZg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:c210:b0:253:8261:c4f4 with SMTP
 id e16-20020a17090ac21000b002538261c4f4mr4579706pjt.7.1684970503865; Wed, 24
 May 2023 16:21:43 -0700 (PDT)
Date:   Wed, 24 May 2023 16:21:34 -0700
In-Reply-To: <18e50d2517ba4cc81d4bafb0b029ca7a770f23a7.1684196634.git.me@ttaylorr.com>
Mime-Version: 1.0
References: <cover.1683847221.git.me@ttaylorr.com> <cover.1684196634.git.me@ttaylorr.com>
 <18e50d2517ba4cc81d4bafb0b029ca7a770f23a7.1684196634.git.me@ttaylorr.com>
Message-ID: <kl6l1qj5z56p.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 2/2] gc: introduce `gc.recentObjectsHook`
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>, <me@waleedkhan.name>,
        <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor! It was great seeing you at Review Club today :)

If you'd like, the notes are available at:

  https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3stCuS_w/edit

but that's optional, since a ground rule is that all important feedback
should be sent to the mailing list.

Taylor Blau <me@ttaylorr.com> writes:

> This patch introduces a new multi-valued configuration option,
> `gc.recentObjectsHook` as a means to mark certain objects as recent (and
> thus exempt from garbage collection), regardless of their age.
>
> However, we have no convenient way to keep certain precious, unreachable
> objects around in the repository, even if they have aged out and would
> be pruned. Our options today consist of:
>
>   - Point references at the reachability tips of any objects you
>     consider precious, which may be undesirable or infeasible.

What I like about the hook is that it matches the desired use case quite
well - if an object is precious but unreachable, it can't be because Git
thinks it's precious. Rather, something else thinks it's precious, so
the obvious fix is for Git to learn how to listen to that tool. Based
off only what's in this commit message though, this feature doesn't seem
sufficiently justified yet. In particular, it's not immediately clear
how this fits in with the alternatives, especially pointing refs at
precious objects (which is probably the most popular way people have
been doing this). It would be useful to flesh out why keeping these
extra refs are either "undesirable" or "infeasible". Presumably, you
already have some idea of why this is the case for the GitHub 'audit
log'.

Another potential use case I can think of is client-side third party Git
tools that implement custom workflows on top of a Git repo, e.g.
git-branchless (https://github.com/arxanas/git-branchless) and jj
(https://github.com/martinvonz/jj/, btw I contribute a little to jj
too). Both of those tools reference commits that Git can consider
unreachable (e.g. they support anonymous branches and "undo"
operations), and so they both create custom refs to keep those commits
alive. The number of refs isn't huge, though it is more than what a
typical repo would see (maybe in the 100s), and ISTR that some users
have reported that it's enough to noticeably slow down the "git fetch"
negotiation. I don't think managing these refs is "infeasible", and
there are workarounds to shrink the number of refs (e.g. creating an
octopus merge of the commits you want and pointing a ref at it), but it
would certainly be a lot easier to use the hook instead.

I've cc-ed the maintainers of both projects here in case they have more
to share.

> +gc.recentObjectsHook::

I have a small preference to use "command" instead of "hook" to avoid
confusion with Git hooks (I've already observed some of this confusion
in off-list conversations). There's some precedent for "hook" in
`uploadpack.packObjectsHook`, but that's a one-off (and it used to
confuse me a lot too :P).

> +	When considering the recency of an object (e.g., when generating
> +	a cruft pack or storing unreachable objects as loose), use the
> +	shell to execute the specified command(s). Interpret their
> +	output as object IDs which Git will consider as "recent",
> +	regardless of their age.

From a potential user's POV, two things seem unclear:

- What does "recenct" mean in this context? Does it just mean
  "precious"?
- What objects do I need to list? Is it every object I want to keep or
  just the reachable tips?

Documentation/git-gc.txt has some pointers:

  . Any object with modification time newer than the `--prune` date is kept,
    along with everything reachable from it.

but it seems quite hard to discover this and put the pieces together. I
wonder if we could make this easier by:

- Replacing "recent" with "precious" (if this is really what we mean),
  and the fact that we use the recency check is an implementation
  detail.
- Explicitly saying that everything reachable from the object is also
  kept.

In the code changes, I noticed a few out-of-date references to "cruft
tips", but everything else looked reasonable to me.

> diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
> index 303f7a5d84..3ae61ca995 100755
> --- a/t/t5329-pack-objects-cruft.sh
> +++ b/t/t5329-pack-objects-cruft.sh
> @@ -739,4 +739,175 @@ test_expect_success 'cruft objects are freshend via loose' '
>  	)
>  '
>  
> +test_expect_success 'gc.recentObjectsHook' '
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		# Create a handful of objects.
> +		#
> +		#   - one reachable commit, "base", designated for the reachable
> +		#     pack
> +		#   - one unreachable commit, "cruft.discard", which is marked
> +		#     for deletion
> +		#   - one unreachable commit, "cruft.old", which would be marked
> +		#     for deletion, but is rescued as an extra cruft tip
> +		#   - one unreachable commit, "cruft.new", which is not marked
> +		#     for deletion
> +		test_commit base &&
> +		git branch -M main &&
> +
> +		git checkout --orphan discard &&
> +		git rm -fr . &&
> +		test_commit --no-tag cruft.discard &&
> +
> +		git checkout --orphan old &&
> +		git rm -fr . &&
> +		test_commit --no-tag cruft.old &&
> +		cruft_old="$(git rev-parse HEAD)" &&
> +
> +		git checkout --orphan new &&
> +		git rm -fr . &&
> +		test_commit --no-tag cruft.new &&
> +		cruft_new="$(git rev-parse HEAD)" &&
> +
> +		git checkout main &&
> +		git branch -D discard old new &&
> +		git reflog expire --all --expire=all &&
> +
> +		# mark cruft.old with an mtime that is many minutes
> +		# older than the expiration period, and mark cruft.new
> +		# with an mtime that is in the future (and thus not
> +		# eligible for pruning).
> +		test-tool chmtime -2000 "$objdir/$(test_oid_to_path $cruft_old)" &&
> +		test-tool chmtime +1000 "$objdir/$(test_oid_to_path $cruft_new)" &&
> +
> +		# Write the list of cruft objects we expect to
> +		# accumulate, which is comprised of everything reachable
> +		# from cruft.old and cruft.new, but not cruft.discard.
> +		git rev-list --objects --no-object-names \
> +			$cruft_old $cruft_new >cruft.raw &&
> +		sort cruft.raw >cruft.expect &&
> +
> +		# Write the script to list extra tips, which are limited
> +		# to cruft.old, in this case.
> +		write_script extra-tips <<-EOF &&
> +		echo $cruft_old
> +		EOF
> +		git config gc.recentObjectsHook ./extra-tips &&
> +
> +		git repack --cruft --cruft-expiration=now -d &&
> +
> +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
> +		git show-index <${mtimes%.mtimes}.idx >cruft &&
> +		cut -d" " -f2 cruft | sort >cruft.actual &&
> +		test_cmp cruft.expect cruft.actual &&
> +
> +		# Ensure that the "old" objects are removed after
> +		# dropping the gc.recentObjectsHook hook.
> +		git config --unset gc.recentObjectsHook &&
> +		git repack --cruft --cruft-expiration=now -d &&
> +
> +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
> +		git show-index <${mtimes%.mtimes}.idx >cruft &&
> +		cut -d" " -f2 cruft | sort >cruft.actual &&
> +
> +		git rev-list --objects --no-object-names $cruft_new >cruft.raw &&
> +		cp cruft.expect cruft.old &&
> +		sort cruft.raw >cruft.expect &&
> +		test_cmp cruft.expect cruft.actual &&
> +
> +		# ensure objects which are no longer in the cruft pack were
> +		# removed from the repository
> +		for object in $(comm -13 cruft.expect cruft.old)
> +		do
> +			test_must_fail git cat-file -t $object || return 1
> +		done
> +	)

Thanks for the comments. The tests are quite verbose, and I wouldn't
be able to understand them otherwise. I thought it would be nice to have
a test helper to check that the cruft pack contains the expected objects
(replacing the "git show-index" + "cut | sort" + "test_cmp" recipe), but
this test fits in with the existing style, so I don't consider that a
blocker.
