Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E1FC433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A7F2063A
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+j0+Iwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgF2Ss7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbgF2Srn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69D2C030F0A
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 09:20:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so8524979pgk.4
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=npGNPLdctP/MRaUBR6QwFrAOOfz9ykL/OWd1HgJTBFc=;
        b=o+j0+IwvsnKGqYBPv4KzJZBSg65gASEay7nQKMy/UFJc1y0exQgjEo/qugvKH1E5QO
         UMyJYGPH9nuTYjfp38wBxFz6/W8za01T6QfZS0yU3AmMD/BVJMmalSafDlgZfnQAKgKh
         j4621CTj0rlubojO1QIQjH+UVnM3mB+dn2kka2ItGTKthr0TmDVeAYFfde9HeHDbuCBN
         iZ7Z3EAljfFRlSRF0jTretIK7e3MThfMpwGQIH6Fyet03CGLN7qVJQHsA5/6mjyEHqsM
         hZyZy+GKTOk9Vn7APWYuBnos77aO/OA02o+HRWV2L9LUlX1FCuADcycgtoT/eeWixwVk
         u0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=npGNPLdctP/MRaUBR6QwFrAOOfz9ykL/OWd1HgJTBFc=;
        b=sxF84Rku5qXO4kcIjmC0e0qotlbNYZCr1qhpiIDP/i1Fp5pJe43fJmCDdu6g8RGMae
         uU8CWf013yVYoqqhq3xCTybVXJkHpd/GKTmSQXNVayN98Ebm64w2z9WE6O51sB3VmWIX
         07q1kP0V5hOTAWYGPlbAjeswPk8KWKSqhuam4LVwyvZeTfy7ppQouKbF644DUnMu4ZMx
         GAnp+8U5Rhbse1qqqF/5xv1XIAX6cMakAxZYo2GDqzEHyk+SsvpXper2/7IJl11es//d
         R8ZQk2NaPl7oR6ZSc5MkTp6VrV7WVp7c0BI80CXv+pP5j4yVRmJ6PYcswolIY/z5WNhI
         Ga7A==
X-Gm-Message-State: AOAM530IdugB+ZJa6fau3b0LPm6mPb0+I//xvobJbxP9mxrou31t2xlO
        QZiOU/pMpLfVYUpto2kpobgz8mRhHFs=
X-Google-Smtp-Source: ABdhPJzZGLIlpd2CjXhGRp9mrrCS68n5oULZCYuupMaGYAdG4XQ4yC5wG2kRUjrJm0Zsh84Ec/2ZRA==
X-Received: by 2002:a63:7c51:: with SMTP id l17mr10876662pgn.303.1593447606287;
        Mon, 29 Jun 2020 09:20:06 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id n4sm216059pfq.9.2020.06.29.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:20:05 -0700 (PDT)
Date:   Mon, 29 Jun 2020 23:20:03 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/9] fmt-merge-msg: stop treating `master` specially
Message-ID: <20200629162003.GD20303@danh.dev>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
 <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
 <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1593009996.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fffdb9944fc2672ccb7eac776cdd18855a1f99dc.1593009996.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-06-24 14:46:28+0000, Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> In the context of many projects renaming their primary branch names away
> from `master`, Git wants to stop treating the `master` branch specially.
> 
> Let's start with `git fmt-merge-msg`.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Hi Dscho,

This change will also affect git-subtree test.
We'll need this patch for subtree:
----------------8<-------------------
From: =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?=
 <congdanhqx@gmail.com>
Date: Mon, 29 Jun 2020 22:56:37 +0700
Subject: [PATCH] contrib: subtree: adjust test to change in fmt-merge-msg
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We're starting to stop treating `master' specially in fmt-merge-msg.
Adjust the test to reflect that change.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 contrib/subtree/t/t7900-subtree.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 57ff4b25c1..53d7accf94 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -196,7 +196,8 @@ test_expect_success 'merge new subproj history into sub dir/ with --prefix' '
 		cd "$subtree_test_count" &&
 		git fetch ./"sub proj" master &&
 		git subtree merge --prefix="sub dir" FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+		check_equal "$(last_commit_message)" \
+			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
 	)
 '
 
@@ -273,7 +274,8 @@ test_expect_success 'merge new subproj history into subdir/ with a slash appende
 		cd "$test_count" &&
 		git fetch ./subproj master &&
 		git subtree merge --prefix=subdir/ FETCH_HEAD &&
-		check_equal "$(last_commit_message)" "Merge commit '\''$(git rev-parse FETCH_HEAD)'\''"
+		check_equal "$(last_commit_message)" \
+			"Merge commit '\''$(git rev-parse FETCH_HEAD)'\'' into master"
 	)
 '
 
-- 
2.27.0.111.gc72c7da667
Danh
