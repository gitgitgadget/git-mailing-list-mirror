Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8C9C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 01:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349756AbiELBBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 21:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245021AbiELBBc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 21:01:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C916F6FA08
        for <git@vger.kernel.org>; Wed, 11 May 2022 18:01:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r190-20020a632bc7000000b003c6222b2192so1790938pgr.11
        for <git@vger.kernel.org>; Wed, 11 May 2022 18:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=2JAp7eTFeiqqi1QRWd6FhdVOnGCc/GgLDxQz9e630F0=;
        b=Z/wluSdry4Eg5YUkeMogdpR1z435rva+6TIO1yW9NVj0W+48+vkFdBIKrbH8A+3zdi
         JbzrCpcrqyy6D8VQQGM84DHGYWjLBBDIDiGW8ZNuFvYPGxZUa/Wo/5qkPPSqKqhi37CH
         42dm1iswq4+R4kIN1e4rjPNkrcK1XoAYqApm49oBltx0I4/3R7mG/IJPwqyOTKEpxI8Z
         7mCQjhwBJe1+8noam9afqb8Acjv/tRTv+6yK1Oj0cjgd/FyNsbQZGee78pqTlZDxz2dc
         Pavayr4pWjeyq3+Pn1NwTheoV23ar0cGITQOYZ7S/IYE0n7npGRgVVIuOY8gkFDWK5T5
         o39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=2JAp7eTFeiqqi1QRWd6FhdVOnGCc/GgLDxQz9e630F0=;
        b=1ixM161cF0Z3s5Cj+SjyZ17d7Ys0droRv5VgYqWWCYzyojfg+klXkOdCOfsX07HmaZ
         /QAYoGNKifIPMs3RPEA3aeEranVlxa/t21wLZ+8s2bDg1cDnUX+WjNaogRCvuZoXHbV8
         TVnjZvNO6hbIyI6P1nDwzJ5WXtg3UCpyaUqtY3M9bLyaOBJ4n6JJHppcVZsW3Rc8ntHK
         dl7HUNuRuwO11MweRjp65Qwr9NWhZOhq17yxT3JayhtrfsVeUQocfAV7zEh/AAAmPQiz
         BJPvbQeBxUE30/MKEao/dUSKBAWTimXgDQhF3ovnaN/Mt1XRZl+DQXKMw8rpKqzOITf8
         uR8g==
X-Gm-Message-State: AOAM533prePavy5fUgXUOuSPs0Ii1kKND1J5PBOQN3hkRECXZPawtejY
        qijhdzZR0V4uOkrt1a9W4w8IZlp2mBqcr9NtzxQG
X-Google-Smtp-Source: ABdhPJwzplHClJ4BpHlbEAnL+MdAKqQFqENktggFWCeGOJfZl09H2FnHt16z2Ljb6+/71uXp54DwFOgnSkx3Clxscx5F
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:2241:b0:1dc:d4d3:3047 with
 SMTP id hk1-20020a17090b224100b001dcd4d33047mr8111750pjb.128.1652317290165;
 Wed, 11 May 2022 18:01:30 -0700 (PDT)
Date:   Wed, 11 May 2022 18:01:23 -0700
In-Reply-To: <e733c2fd9f497a8d80555126ec2e166e182ab8db.1652225552.git.gitgitgadget@gmail.com>
Message-Id: <20220512010124.1800540-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: Re: [PATCH v3 5/6] stash: apply stash using 'merge_ort_nonrecursive()'
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -551,10 +553,26 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  	if (o.verbosity >= 3)
>  		printf_ln(_("Merging %s with %s"), o.branch1, o.branch2);
>  
> -	bases[0] = &info->b_tree;
> +	head = lookup_tree(o.repo, &c_tree);
> +	merge = lookup_tree(o.repo, &info->w_tree);
> +	merge_base = lookup_tree(o.repo, &info->b_tree);
> +
> +	repo_hold_locked_index(o.repo, &lock, LOCK_DIE_ON_ERROR);

What's the reason for locking the index? I would think that
merge_ort_nonrecursive() does not modify the index (in any case, I
removed the locking code and the tests still pass). And as for changes
in the worktree, I ran "strace" on the "stash apply" in the test and I
didn't see any changes in the worktree from here until the lock is
released.

Other than that, this patch set looks good to me.
