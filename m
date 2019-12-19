Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDBFC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F1B24672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 18:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpbVmvNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfLSSCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:02:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33300 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLSSCG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 13:02:06 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so5784489edq.0
        for <git@vger.kernel.org>; Thu, 19 Dec 2019 10:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aYqtUfxrzTqHVRn2pfoo5R2+4lk0OX725HiLpzyYtMg=;
        b=HpbVmvNHE/6fhCTtM5K9mjv0NWRGqaZEqWoMURcQCwqFznoQ5IYy3S1AR3cVXe/2a3
         zSmcHZQ1AOTck2LXNeBKNaJLpuJhbQ9/ZfC4PqCJi/7hkmePa1uORLOrZY5ZpTDhlFCo
         FKjKh5+Jrg9uEuhhT8TEMKYzznNIlG0REExx9i9dg6gjqodSz+3n/k0eCU50IbJg7Z2L
         0HlcXqDZTSlj6ppwpB2+wOGOUPnDVZQlnEOPZB/e7V7VjNPxZ5VAfwfyQ+odkIJwvAlP
         sfWLTW2h0DxKSLjiTWoo9Oqeem5/HpcE66DdRHHLLdHpiAiiuHzNpkUQn+DID1rWPzzZ
         EGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aYqtUfxrzTqHVRn2pfoo5R2+4lk0OX725HiLpzyYtMg=;
        b=eTfvbxg5V3Y4f8q+d7LFdpCxZtmqAV1X8erm63Z/PIxS8Iqyi+FkArT//ga7Y25xjr
         LWj2TOWVC6RJkJSgD/prfqxjVIDK9CZrbTG5tBV6HfXE9hbxcVGfGyzeYR8CrbA4juAt
         ekm64j+Vt7uB+T6nKUFmwzOD73nHYsbEAMxY84ddkyC07N8D3MBlVfZBvW5O66oGz7Qw
         CXsc8u/BFnmLxYuzIRAp/WhRWsmIvsoPY4F+WVeT6Y3siAtfz8+XobgP20jnMcWa8yC4
         UHMBe/SsUOelQ0t5qjezTBs3nyDi2/6SpjFrz81f6wL+oqtpxG/9uJFqOYcEopa3HjdC
         RLhg==
X-Gm-Message-State: APjAAAWt+Sbdl4wlOEhhDmoBEXgB7y0lHOXYGIAICHTrBknGkbkmhY7o
        RoXg8UhbBmmfyuyNZL8kX3zJq4/Z
X-Google-Smtp-Source: APXvYqx54LrRnp8SfdsVl2uVMedcy84kfiiL8fSxGWaDQQSfVVGooIpFuI1sr6hKx9v2XRSmRucXYA==
X-Received: by 2002:a50:d905:: with SMTP id t5mr10724362edj.67.1576778525286;
        Thu, 19 Dec 2019 10:02:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm560573edv.63.2019.12.19.10.02.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Dec 2019 10:02:04 -0800 (PST)
Message-Id: <5a4a538fa624c5d06f504bd81e103e8068744aab.1576778515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
References: <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
        <pull.490.v3.git.1576778515.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Dec 2019 18:01:44 +0000
Subject: [PATCH v3 07/18] doc: checkout: remove duplicate synopsis
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

It was added in [1]. I understand that the duplicate change was not
intentional and comes from an oversight.

Also, in explanation, there was only one section for two synopsis
entries.

Fix both problems by removing duplicate synopsis.

<paths> vs <pathspec> is resolved in next patch.

[1] Commit b59698ae ("checkout doc: clarify command line args for "checkout paths" mode" 2017-10-11)

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 Documentation/git-checkout.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index cf3cac0a2b..2011fdbb1d 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -13,7 +13,6 @@ SYNOPSIS
 'git checkout' [-q] [-f] [-m] [--detach] <commit>
 'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
 'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
-'git checkout' [<tree-ish>] [--] <pathspec>...
 'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]
 
 DESCRIPTION
@@ -79,7 +78,7 @@ be used to detach `HEAD` at the tip of the branch (`git checkout
 +
 Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
-'git checkout' [<tree-ish>] [--] <pathspec>...::
+'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...::
 
 	Overwrite paths in the working tree by replacing with the
 	contents in the index or in the `<tree-ish>` (most often a
-- 
gitgitgadget

