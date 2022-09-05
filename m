Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2B6ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiIEI2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiIEI1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1FC2AC6C
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t7so5249918wrm.10
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=EHDJwswvPcjIuxhps3s3VPdprxGtqOdJSZIwd68bPeA=;
        b=FE4eDIZkQ+R2EZlf22osZPuxVTY+mxZbWct8f1e79FpireBGozQuYNySyicw7eprXb
         zcvlyj0c/DYBFtHaJCikzi5At/iiZYpMFajOmp4Q89QmJJ96EAW+BJCHHFPVieuHPEXY
         jSKMv+CQirb8+W2Vi/xIALD1yKxiLHtby4o/DSOAaG+g+SsrXxnsHrsib0VY+Nds+mDX
         v2t8pC3M27VgzYotYHlLcz9cadD51wIXnG8zJHXINZTsJG+8JSmQQeW3FfNOur03VtVY
         r2gMWH5dASbWoZGPTg2EWHHk6LVm+/iKRE8+Z9IItDMfEsmh/KV0YdTobsbLlM6kgdUG
         reRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EHDJwswvPcjIuxhps3s3VPdprxGtqOdJSZIwd68bPeA=;
        b=CnqEh/atVruiLRonqKkv9Abqpfzz1Dyip6nNTkD4FB5Y+I0hXJZkkKhZaAF0vzex+u
         fd0cr3aOTsc/Y4Pv0vQo3dMuWogSLeKRjW9cUP84rFiZdQAvvBfAhMisRZoL9/zVxg1y
         ELq5XMMo2uLYtJ6sRZdWhgG2V7HN5MXb6pPKB4Kf4ViXt54dkuOrNZ1XfXt0gBnklQ3R
         dLqQqN1T0Vjop1Jm3Jce5Nh53Mv5QvcU3+zd5rDa6PJMUFcGKRBWr/fVbIVjAMb9advA
         YoXQQb20MKWwd/m7iXzLKS5y2u08ucSeYeY2qoVxX6SdixWirjQs2tkdIdvBUHMZCuAy
         QJ4w==
X-Gm-Message-State: ACgBeo09KjGq2DyvnC0yYczHUFWx37MyA4oPG5Wop0FFSmOE/KLDXYcm
        i8kxUu7jPFnz3O7bDB9XbKmvjTTW84JzyA==
X-Google-Smtp-Source: AA6agR44GwrhcC4lMmbZYXSmqE2j0f7YlLjtEcmxsj6M0JvCFGA+VWEREOAqZk12agsTGTEl4v6qwQ==
X-Received: by 2002:a5d:5887:0:b0:220:81ca:ec4f with SMTP id n7-20020a5d5887000000b0022081caec4fmr23096329wrf.263.1662366433402;
        Mon, 05 Sep 2022 01:27:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 22/34] doc txt & -h consistency: make "read-tree" consistent
Date:   Mon,  5 Sep 2022 10:26:33 +0200
Message-Id: <patch-22.34-92c178d5303-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
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
2.37.3.1425.g73df845bcb2

