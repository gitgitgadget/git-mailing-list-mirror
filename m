Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E59C28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 12:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29042075B
	for <git@archiver.kernel.org>; Sun,  3 May 2020 12:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnHE/Au0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgECMFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 08:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728399AbgECMFu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 May 2020 08:05:50 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1386DC061A0C
        for <git@vger.kernel.org>; Sun,  3 May 2020 05:05:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l12so4302962pgr.10
        for <git@vger.kernel.org>; Sun, 03 May 2020 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ydNvOllajXuLAxFHD26TO9vaN1hacBtHmVS5miSpLsM=;
        b=lnHE/Au0JLNSV5/oZNgWgqBkXATC6cuhMeX8lRqtywn3L4lIyv02s0aJqYLOo9RFc3
         tyLrSfi0x8vKxqzi5qA2/mV4Mlgvhayacyw1Ba1amqMWNQFCmOrW4gibMCE1U1cgRUUr
         x18bH1jBJZVABLJuo3Prjw63zFiQsGdailOpMkmMpQykR1RL4tlZ57t7lD1Hp8ppsNBd
         tFIeqDoeLyAjs/wNmripwgcVfAAeWZRiNkctu6X+5vhSVKuoxq/ZKxt3Qj3tpFKPFcBJ
         i0TUoVDVjjUaPcK5sPU9O3WJbxqVsSKnK1cUCRdkBSRZASt//YffPy6huH1Aq3hX/nF4
         sJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ydNvOllajXuLAxFHD26TO9vaN1hacBtHmVS5miSpLsM=;
        b=F4ycMgujMbTiOXDwIUHiKs2F27kK654V2cW9mSk+c+xQ6wL+vMrMEYFcYgkLTbPv3g
         4/sZSNq4JmeEftlZtVmFGUAtnHBkASIsskpjg44VeCDrHE8t11rg0Ue2qxJoCiFKkNRj
         7dq7lHtxRG9a/pjHQH+1wGARRS42CARxZKla83HrXDK84HVFbmraBtLyhoGmSe+jqKJv
         2OxlvxMTGVQXErUHeJFKBlV6yI3q6bi6r8ZXGnCftA+DbzYrIAZvty9mMoPmfUtrERx2
         6XXBZEYZpY/ZTAusB7qjLgPFYs6zKh5wDahVpXp8zUNrvUqxt3wg9gp8LMoWi4gG1N8m
         rrDQ==
X-Gm-Message-State: AGi0PuakqfLJFUkDxUwyzdOdxk6A5MGYG69s6911WrArqEFsUBKFptS5
        QNIVdgxfl41vViHSSvBg9rY=
X-Google-Smtp-Source: APiQypJeyGww+9Dd641uXFjqJ9CEdotBBkhekFCPrDQ9pwC7McXFX5L5LjK2rLYHW6+6xBANhjJJmg==
X-Received: by 2002:a62:7cc1:: with SMTP id x184mr12362154pfc.282.1588507549461;
        Sun, 03 May 2020 05:05:49 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id nu10sm4451505pjb.9.2020.05.03.05.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 05:05:48 -0700 (PDT)
Date:   Sun, 3 May 2020 19:05:46 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: respect the [skip ci] convention in our GitHub
 workflow "CI/PR"
Message-ID: <20200503120546.GB28680@danh.dev>
References: <pull.776.git.git.1588432087854.gitgitgadget@gmail.com>
 <20200503093646.GC170902@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200503093646.GC170902@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-03 05:36:46-0400, Jeff King <peff@peff.net> wrote:
> On Sat, May 02, 2020 at 03:08:07PM +0000, Johannes Schindelin via GitGitGadget wrote:
> 
> >     It was mentioned to me that it might not be totally helpful to run all 
> >     the builds whenever an in-progress branch is pushed to GitHub. For
> >     example, if a contributor has dozens of topic branches in flight, they
> >     might not want to have all of them built whenever a new end-of-day push
> >     happens.
> 
> As I was probably (one of) the mentioners here, thank you for looking
> into this. This definitely _helps_, and if you don't want to go further
> I could certainly make do with it[1].
> 
> But here are some thoughts on what a more ideal solution would look
> like (to me, anyway).
> 
> What I'd _most_ like is a separately-maintained list of branches (or
> branch patterns) on which to run CI.  I mostly care about just testing
> my personal equivalent of "next" (which is really "next" plus my stable
> topics), and I'd probably only list that branch. Plus potentially a
> special CI branch that I'd use when chasing down a failure that I can't
> reproduce locally.
> 
> But I don't think there's any good way to implement that via GitHub
> Actions. I thought perhaps we could pull data from a different branch in
> the same repo, but referring to external "Actions" seems to require a
> full repo name (and obviously putting git/git in that name doesn't help
> anybody who's trying to override something in a fork).
> 
> Another alternative: could we trigger CI based on branch-names? Locally,
> I call my unstable branches "jk/something-wip", and I'd like to skip all
> of the "-wip" branches. That's basically equivalent to "[skip ci]" in
> that I could just amend the tip commit of the -wip branches to say "skip
> ci". But what if we flipped the default to _not_ build? I.e.:
> 
>   - continue to build all pull requests; if you opened one, you're
>     serious enough to have other people look and should get CI feedback
> 
>   - build branches with a few well-known names or patterns. Maybe
>     names like "master"? Or maybe "refs/heads/build-ci/*"? Or maybe
>     anything in "refs/heads/<initials>/*"? We'd have to decide on a
>     convention as a community.

I think this is better approach for Junio, and we can help people opt
in by asking them to push into "for-ci/<some-name>.

This is my proposal for it:

------------------8<-------------
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Sun, 3 May 2020 18:56:50 +0700
Subject: [PATCH] CI: GitHub: limit GitHub Action to intergration branches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 .github/workflows/main.yml | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index fd4df939b5..303393ba73 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -1,6 +1,19 @@
 name: CI/PR
 
-on: [push, pull_request]
+on:
+  pull_request:
+    branches:
+      - '*'
+  push:
+    branches:
+      - maint
+      - master
+      - next
+      - jch
+      - pu
+      - 'for-ci/**'
+    tags:
+      - '*'
 
 env:
   DEVELOPER: 1
-- 
2.26.2.672.g232c24e857

