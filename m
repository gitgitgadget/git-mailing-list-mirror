Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD45C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331A16521A
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhCDBf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhCDBeA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:34:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7455C061574
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 17:33:20 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s7so7957147plg.5
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 17:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=21uVu/xu5vHRnCXcuHDZnptKwhPMniCJVom4TzqoHFQ=;
        b=HZYi1v7TX/3xnnHBPtDTUJ4P0El1jvE9P7DypUTkGxQDjgPNeiKfGNk4azRukAX3zF
         rtzOQGaVCvPy8nnGx2IAcHVZLW4A/LA6eo8Yt2sgfpciin4vUHML+sKJiykjJEgz2DzU
         uV4tmNl2D4YeFdb18qpLWRZozN4X8olk7uQUr5yJmxoFQxFVP8KS1YW6p0XgQzhPb0tM
         C9Ets/zb7e6GRTC+AVdkwCFcCRZssOYzRyya7IbEKbeqY06JJVhCiLte8RPOIYrUiYco
         jWQLIv7pYcv+AJAxxKJEvm3Q3WY2bbjUxCpL7QBT0VYWZB/RlHruH6583wn4oOP8Pdt5
         VVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21uVu/xu5vHRnCXcuHDZnptKwhPMniCJVom4TzqoHFQ=;
        b=ObDGZMgi8gNoZlVJEQT34pFvzkbWYnQrM7R0QBbffeKMLeP4pG4FyE96JEeKcTYQJu
         CYkm13qP+a4fen7yIK4/LJof7qeo5KfUFs97U6vE6ZHXN7h+HuZWJrDCp7lTxJlDA7QJ
         oALgUQlHHWj3umdiBsZuDJ+m4JLYdIXlgt57jo+pTQrvBpskUD4cZy2aL0VcdizttqTf
         z+Mi6/c07jKxHgFqK0O3Z61hkr2Vk/hTVqF1svNdhSFqrY1YEbAbAPjlVLhrUpHbyNPd
         lITU+zK3B5tAoKZ/AUdFwgVuJW4NKH1kADdrnWzE3Ik4+xItoiFhZFZMLmv09FQ5pWPg
         cnhg==
X-Gm-Message-State: AOAM533rSOlPAN9cZWBfb4qTsvXqRNRbJu2Lvi88qbpIqJlPrzaFTFLi
        BR2kbGGzKRRgmBb8LRtTQqs=
X-Google-Smtp-Source: ABdhPJym75nfqXUggKrerQMx1JhKJ8RGjgpWm+YAK0v69GJEpG2IKUpt5PXZxGi6DWDpgTx3evwESg==
X-Received: by 2002:a17:90a:ea96:: with SMTP id h22mr1682937pjz.24.1614821600313;
        Wed, 03 Mar 2021 17:33:20 -0800 (PST)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id 68sm12333923pfd.75.2021.03.03.17.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 17:33:19 -0800 (PST)
Date:   Wed, 3 Mar 2021 17:33:17 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/2] stash show: learn --include-untracked and
 --only-untracked
Message-ID: <YEA43VRbgdA36MV1@generichostname>
References: <cover.1613459474.git.liu.denton@gmail.com>
 <cover.1614770171.git.liu.denton@gmail.com>
 <xmqq4khrhhx4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4khrhhx4.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Mar 03, 2021 at 04:38:31PM -0800, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > A blindspot that I've noticed in git is that it's not possible to
> > properly view a stash entry that has untracked files via `git stash
> > show`. Teach `git stash show --include-untracked` which should do this.
> > In addition, this series also teaches `--only-untracked` and the
> > `stash.showIncludeUntracked` config option.
> >
> > This series is based on 'dl/stash-cleanup'.
> >
> > Changes since v3:
> >
> > * Incorporate Junio's SQUASH??? commits
> >
> > * Implement a custom unpack_trees() callback to detect the case where
> >   there are duplicate entries in worktree and untracked commits
> 
> I actually expected the latter enhancement to be done outside the
> scope of this series.  I briefly looked at the callback but I am not
> convinced that it is correct (e.g. how do you notice and barf when
> the untracked tree records foo/bar.txt and the index or the working
> tree records foo as a file?).

From my testing, the conflict is detected just fine. The following
test-case should confirm it:

-- >8 --
From: Denton Liu <liu.denton@gmail.com>
Subject: [PATCH] fixup! stash show: teach --include-untracked and --only-untracked

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3905-stash-include-untracked.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index b470db7ef7..470aa65b44 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -405,4 +405,27 @@ test_expect_success 'stash show --include-untracked errors on duplicate files' '
 	test_i18ngrep "worktree and untracked commit have duplicate entries: tracked" err
 '
 
+test_expect_success 'stash show --include-untracked errors on directory/file conflict' '
+	git reset --hard &&
+	git clean -xf &&
+	>tracked &&
+	git add tracked &&
+	tree=$(git write-tree) &&
+	i_commit=$(git commit-tree -p HEAD -m "index on any-branch" "$tree") &&
+	test_when_finished "rm -f untracked_index" &&
+	u_commit=$(
+		GIT_INDEX_FILE="untracked_index" &&
+		export GIT_INDEX_FILE &&
+		rm tracked &&
+		mkdir tracked &&
+		>tracked/file &&
+		git update-index --add tracked/file &&
+		u_tree=$(git write-tree) &&
+		git commit-tree -m "untracked files on any-branch" "$u_tree"
+	) &&
+	w_commit=$(git commit-tree -p HEAD -p "$i_commit" -p "$u_commit" -m "WIP on any-branch" "$tree") &&
+	test_must_fail git stash show --include-untracked "$w_commit" 2>err &&
+	test_i18ngrep "worktree and untracked commit have duplicate entries: tracked" err
+'
+
 test_done
-- 
2.31.0.rc1.228.gb75b4e4ce2

