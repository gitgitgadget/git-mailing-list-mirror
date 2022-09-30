Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDD2C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiI3SLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiI3SKe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:10:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8661F11CB
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s14so8045620wro.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=0ZhSqpT1qQrF6f/ZQsLpA5ch5frFTxTddgP83bBNYwU=;
        b=TvhyPbfi4C+j4ui+AM6n68v99CsHyPuzsCYvVUYHv86BQRHSSHfEjCcz9Hz1qSsIi7
         vL+9GjGZBjJtNRiZbSK/8orTZMZTWWLSjJB4Jrqaoye0mZ1VIAGR8u7KQlZt5J4RnAzZ
         yDf4ccwgbMGdzBS+bRA2R10/1qO7JjqSBNZEtrk+HFaPQN4WUGa0QRhdXfrrys81eQqJ
         zZTIY5INsopKDO69oSaeQXBeH8uoz1pbnBVAj2MrYI6D851ipCPSEDO97oIOAfzTauB0
         T2n16aDpeay9VpTxWHoYyhtcO5W6IvFzUqjZkjJzRIZjz5tShw66bXU2Bzn9WaYyacLl
         lg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=0ZhSqpT1qQrF6f/ZQsLpA5ch5frFTxTddgP83bBNYwU=;
        b=524Sc7SfnS9r4wadUCFqQyEplaeD9X4znIjN2F0IzaZ0x+ddAc8ShyCU4bkKaJIbTv
         gO/M0prpXKZsei3vWJ+5zAMcComvBYIrDVMIAXILY5DLSGeQ2U5WvGu51HitAIuvnZ7q
         FPF0w5bVHkDrS2z0ROGbSlJ1y5TvHTvXNgRZNUVgrwhWafLV7l10cnHQpXjio9xna2HO
         KoBiNR1LrgBGheifJKU9Utx1mnyxYEU7sBK0NjTRlVxGmdfXa9HPRPLdHjGhhrtzHoMd
         8vjpxYJHLgSmlUd9n7CF0/iqyJtvYbKjDTbucEeKEH6n2pnLxOF4uAJ3zyIQE98ZpU8P
         DHuw==
X-Gm-Message-State: ACrzQf12aFDwpNuTa3TRWracRdzRyr60+6eO3OpuyC3ZY5fVbHMPNz3D
        puyCpe6Dbs04BKc2XTjnAbgCSCvkKYahXQ==
X-Google-Smtp-Source: AMsMyM7waOpwnpESjITyg6yFjhpISJD1k5FbUZsOPx9fjIULBvFj1qJcHdoP3u6UwvSBKKQSjMbrfw==
X-Received: by 2002:a05:6000:904:b0:21a:3dca:4297 with SMTP id bz4-20020a056000090400b0021a3dca4297mr6559531wrb.487.1664561367551;
        Fri, 30 Sep 2022 11:09:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:09:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 23/36] doc txt & -h consistency: make "read-tree" consistent
Date:   Fri, 30 Sep 2022 20:07:46 +0200
Message-Id: <patch-v3-23.36-01e20b8e452-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The C version was right to use "()" in place of "[]", let's update
the *.txt version accordingly, and furthermore list the *.c options in
the same order as the *.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-read-tree.txt | 2 +-
 builtin/read-tree.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index b9bfdc0a319..7567955bad8 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -9,7 +9,7 @@ git-read-tree - Reads tree information into the index
 SYNOPSIS
 --------
 [verse]
-'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
+'git read-tree' [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)
 		[-u | -i]] [--index-output=<file>] [--no-sparse-checkout]
 		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index b3a389e1b1f..f4cbe460b97 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -39,7 +39,7 @@ static int list_tree(struct object_id *oid)
 
 static const char * const read_tree_usage[] = {
 	N_("git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>)\n"
-	   "              [-u | -i]] [--no-sparse-checkout] [--index-output=<file>]\n"
+	   "              [-u | -i]] [--index-output=<file>] [--no-sparse-checkout]\n"
 	   "              (--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])"),
 	NULL
 };
-- 
2.38.0.rc2.935.g6b421ae1592

