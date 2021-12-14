Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2534C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 18:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbhLNSrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 13:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbhLNSrM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 13:47:12 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F5C061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 10:47:12 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so10891395pgo.21
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 10:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U1hczffXPStPGLeheyOmcZK2GilBckca+dxk7wEucyg=;
        b=VibCTPbZV9iGDO0CevDXyttsFG83ipHBOtbNZEnQj9M4bClkTBDdpvMttdvIbQCSua
         mTdAFHEObEZWo67728gsQOKp1B3xFei9iRrpJrxaJ4E4qRsGlpK2fvO7i3NxkX+cecvP
         T8vt9igBFl37zIrR4TDoU5MmNMo58olFk+IGJ57pnKazJTTWJobaZWvtzOAgtcJEAfCi
         100JchjeTBb+xOlo62YCbr91Q/Zol+/ZIGLoujySfF+YtNxj28PQL4qX+Z9MbZtV5nFj
         ewVy37EIq0ve499fvBq1gkl8YfMc1YjYjQ/0MhzNFJlA4iA4ZUs0OXKJHpKW/bcFDAjz
         DiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U1hczffXPStPGLeheyOmcZK2GilBckca+dxk7wEucyg=;
        b=FmKkxLV+9Dzi91/M03FVis2xR1nss7W7BtTD8PRlhPSKDXaviBKpyLIKlDhWqIQdjW
         MRZYCuLKCtLBNBgX0JsM6F9F2oREKl7fofj0IKrXPbnfsM8U40CChxC5wYgFx7MpYvH6
         2+ryfh3dLVTyMoWObDLYPgBTAcoVv8jzI2zKJo6QlowqJcUKk1w36RjYGqv0scSFDMYJ
         Up/PeXivQkKyc7quvbgt2V9rX6SJOCtrhkPhtzxjdyUwtLsWz9x3N87QVF2LnhVBOBXd
         HpP8irMwqKxOLBH9uEmA5kpFfvYkO+otFoPtym1H/athvR1ILVoA0Q/L1voa1Hp/+vuO
         vtHg==
X-Gm-Message-State: AOAM533Hx1uPcy/KiQkONLOgZvpKVWZNR0xwKgpA8rPxFeHntluIgcU+
        Lly/XltugI7+1RTcLZGngRgGle0fLL5Jaw==
X-Google-Smtp-Source: ABdhPJxUxPbkSu4EItw0CYp/asLcS7YvkiRrpQJUpz/D2WXtwNB8oBJfaTSGghPMrutsPQ695QrID5p4Fcyuzw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:a986:b0:148:a2e8:2796 with SMTP
 id bh6-20020a170902a98600b00148a2e82796mr723639plb.157.1639507631980; Tue, 14
 Dec 2021 10:47:11 -0800 (PST)
Date:   Tue, 14 Dec 2021 10:47:08 -0800
In-Reply-To: <20211213232008.771414-1-jonathantanmy@google.com>
Message-Id: <kl6lr1af81n7.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lee6la07a.fsf@chooglen-macbookpro.roam.corp.google.com> <20211213232008.771414-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/5] implement branch --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com,
        emilyshaffer@google.com, avarab@gmail.com,
        levraiphilippeblain@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah, I should make my cover letter more explicit then. I believe some of
the comments are addressed in the body of the patches, but that's not
the most reviewer-friendly way to do it.

I'll address the comments out-of-order because it makes a bit more sense
this way.

All the patch snippets come from
https://lore.kernel.org/git/20211209184928.71413-5-chooglen@google.com

Jonathan Tan <jonathantanmy@google.com> writes:

> I think we need a test where the submodule is at
> $ROOT/foo/bar, not just $ROOT/foo

This scenario is tested by changing how the test repo is set up:

  +test_expect_success 'setup superproject and submodule' '
  +	git init super &&
  +	test_commit foo &&
  +	git init sub-sub-upstream &&
  +	test_commit -C sub-sub-upstream foo &&
  +	git init sub-upstream &&
  +	git -C sub-upstream submodule add "$TRASH_DIRECTORY/sub-sub-upstream" sub-sub &&
  +	git -C sub-upstream commit -m "add submodule" &&
  +	git -C super submodule add "$TRASH_DIRECTORY/sub-upstream" sub &&
  +	git -C super commit -m "add submodule" &&
  +	git -C super config submodule.propagateBranches true &&
  +	git -C super/sub submodule update --init
  +'

so the tests are now all written against a superproject with a 2-level
submodule.

> I just saw that you [...] are still using tree_entry() non-recursively
> [2]

> [2] Discussed in https://lore.kernel.org/git/20211123021223.3472472-1-jonathantanmy@google.com/

Yes, but this limitation is overcome by having
create_branches_recursively() call itself. I documented this caveat on
submodules_of_tree(), which is the function that calls tree_entry().

  +/**
  + * Given a treeish, return all submodules in the tree. This only reads
  + * one level of the tree, so it will not return nested submodules;
  + * callers that require nested submodules are expected to handle the
  + * recursion themselves.
  + */
  +void submodules_of_tree(struct repository *r,
  +			const struct object_id *treeish_name,
  +			struct submodule_entry_list *ret);

> [1] I said "If you want to use setup_tracking() through
> submodule--helper, I think that needs an explanation as to why a Git
> command wouldn't work." in
> https://lore.kernel.org/git/20211129210140.937875-1-jonathantanmy@google.com/

Now that create_branches_recursively() calls itself, I moved
setup_tracking() into create_branches_recursively() instead of having a
submodule helper that only calls create_branch() and setup_tracking().
As a result, I think this comment isn't as relevant as before.

That said, it might still be unobvious that create_branch() does not do
the right thing without setup_tracking(), i.e.

  # Why doesn't create_branch() just do the right thing?
  +	create_branch(the_repository, name, start_name, force, 0, reflog, quiet,
  +		      BRANCH_TRACK_NEVER, dry_run);
  +	setup_tracking(name, tracking_name, track, quiet, 0);

I was hoping that readers who were unclear would find the comment on
create_branches_recursively() adequate:

  + * - tracking_name is the name used of the ref that will be used to set
  + *   up tracking, e.g. origin/main. This is propagated to submodules so
  + *   that tracking information will appear as if the branch branched off
  + *   tracking_name instead of start_name (which is a plain commit id for
  + *   submodules). If omitted, start_name is used for tracking (just like
  + *   create_branch()).

