Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1322C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7228F2084D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSVwLkQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfK0TxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45197 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0TxO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id w7so10275080plz.12
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJOtIL+cfbhl9dwPpTN/bZ6NZM7pqVzyL6qjSsZmjfU=;
        b=PSVwLkQWI2yLuMw/shdyg7ZsBUzHICSpK+0cUABlFeVjUWDI8ydrKKEcJK7ngTmmqg
         MYRJY6gLTvV7WEcC//oSposLIqS7K1KeAkAkcWocmoNeO6/y5V6T5bk9ngPZ7aQqS8wz
         4DP+uaJoRzS5R5O9y582Ftvt4tjoiVU3IgO8ANWvZWO9G4tj02t2D3IOTNkKqDwFBQV4
         jOVP5Sia/s53DFfGNv0t5Yo8pBfxWJELa0el2/p96s3F0SQRWjz937Y72BGI9FddDaey
         POum52w7dsj2fyse8wnyDSoGRfyoMqinmy2ncRf7xs3/bt9Ua0hcP7n4KFSnWOfwlXP4
         Jk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJOtIL+cfbhl9dwPpTN/bZ6NZM7pqVzyL6qjSsZmjfU=;
        b=RhF1z8UXxEyPksajAc967YINGAliLlF9LDy9wHiuZqOuy6R9XK8277lxzhLbF32OGQ
         s6omrJXap0BTwxv3S361bjU738j1jYNi6fADTE4fbvo6dVWL5fXkb1REZjV4798Wo0+Y
         jb5lkyiHdnj9harZL+a6U7Mtp+k2VuEqg1TogUFHMGlkU8G2xz6Ylpxd4DVBi/JrLLl9
         c8PAGAcYsSlyZnEuRM3IBy14b93oJa7EkP5It2eRBzN4fl4q4yHMfjgRAFRBVme/f1al
         NcFJRmPR8XZ0FAGNNmPWd3Mx1noes/bqO6HYLXZFOfrp/U93SMiYduGC9z9ELAUcq3rp
         JoaQ==
X-Gm-Message-State: APjAAAWcOkh21GoceTwl5iBE7bcm37IWn1B2DFCPsTjzc+Rv7/y5bzss
        tNn78T3wlUD62wCmoWTNHynp0BAd
X-Google-Smtp-Source: APXvYqwHwhg36RZ7poLYU72AUv5xLUyhKXSssk9UqgcuGmkiBc0WXAy4LrijbGc1Kt+LXCA7LSBi0g==
X-Received: by 2002:a17:90a:77c8:: with SMTP id e8mr7824816pjs.83.1574884393450;
        Wed, 27 Nov 2019 11:53:13 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id a25sm16919261pff.50.2019.11.27.11.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:12 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 04/26] t0090: stop losing return codes of git commands
Message-ID: <7d33586b214f8dfd8e027b3bc618ca908799b560.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In generate_expected_cache_tree_rec(), there are currently two instances
of `git ls-files` in the upstream of a pipe. In the case where the
upstream git command fails, its return code will be lost. Extract the
`git ls-files` into its own call so that if it ever fails, its return
code is not lost.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t0090-cache-tree.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index ce9a4a5f32..5a633690bf 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -21,9 +21,10 @@ generate_expected_cache_tree_rec () {
 	parent="$2" &&
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
-	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
+	git ls-files >files &&
+	subtrees=$(grep / files|cut -d / -f 1|uniq) &&
 	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 != "" {++c} END {print c}') &&
-	entries=$(git ls-files|wc -l) &&
+	entries=$(wc -l <files) &&
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
 	for subtree in $subtrees
 	do
-- 
2.24.0.504.g3cd56eb17d

