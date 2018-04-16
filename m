Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 297D61F404
	for <e@80x24.org>; Mon, 16 Apr 2018 22:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDPWl0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 18:41:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32909 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeDPWlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 18:41:24 -0400
Received: by mail-wr0-f193.google.com with SMTP id z73so30256452wrb.0
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 15:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oImxIaZ0VQSZFUE3/CW4f3umbP5O/2MM2FmPh1Fa/SQ=;
        b=JqrgCrGa2DeP6X5BgCvIKiFKF+nyHDNJvHu+hylzxymPGv6Bs/6EAntbv1DURQ4aPa
         PU5VbVCOy7W0bfVkI+itzFDeaYmhJgRVrBDbpBmk6aBV4MeSVPxAfqoIFt+1btpwozLA
         LVa1QjH7CZhf06WyJYYPreIS3/AV5PgA3rM0Hts4yzJBC63UekHjwt4ctq5DE1prDQSG
         bFA/TzEeUDKlilIVBKxXw8eCG2HORIrrc6uq6adjAruMsmDcFcDYupprTLvabWb5ic98
         QzlgAwf7iP5M2UbvdzUUDe2YRCY8CVRFIk1RKQYA2b7YVc72k6dhmECcIEq8Y0EkEMfb
         gHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oImxIaZ0VQSZFUE3/CW4f3umbP5O/2MM2FmPh1Fa/SQ=;
        b=DArCa2MGG6Rhs7pTqap8GBJnU0dB+mC+sZk8brcM1QDL4zfTf2OtrhvcTcEhvQ9jAc
         +zCuvFRNkKCa61Zn2y0gPLR/WLRC3/VLk/YfTPb/fUs/V5AJ/xnjoQ/fzQga2V5fKxMc
         kOJTDVvXQAzwzvvx1t2vLfZiCpbyA/MKXLARJk83havGNXukeAY37MvZ2XiM0nCqfwqz
         EThPI1NcxpB6jO8w9yZufNhEGx1arNUsRYSfPgTk40hYzM83RRXpCP71ewqCMjpaDcsj
         rmRmq5DGDwJxyrh+uA4kB+0QFh+FDRAuDHLGJlwEvXWId5hLzBckfR5v8827hVnseNmu
         EoWA==
X-Gm-Message-State: ALQs6tBCVtV3i/bLOQAhMnoKB7gQYG/huRagqTEBzacRUO3KA34t3uuk
        VCB3YgN2Os3r6ir97EdRbyTUxg==
X-Google-Smtp-Source: AIpwx4/AJ08Ow51J3TR+lh7H3KSJoR9beKbYH3a/ePuAZvFmzQW4z9mpPtyrpzLJKpXpvGutSlSEuw==
X-Received: by 10.28.54.201 with SMTP id y70mr67301wmh.67.1523918483107;
        Mon, 16 Apr 2018 15:41:23 -0700 (PDT)
Received: from localhost.localdomain (x590d89db.dyn.telefonica.de. [89.13.137.219])
        by smtp.gmail.com with ESMTPSA id p128sm14977788wmd.45.2018.04.16.15.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Apr 2018 15:41:22 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Manlio Perillo <manlio.perillo@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 02/11] completion: move __git_complete_index_file() next to its helpers
Date:   Tue, 17 Apr 2018 00:41:06 +0200
Message-Id: <20180416224113.16993-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.366.gbe216a3084
In-Reply-To: <20180416224113.16993-1-szeder.dev@gmail.com>
References: <20180318012618.32691-1-szeder.dev@gmail.com>
 <20180416224113.16993-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's much easier to read, understand and modify the functions related
to git-aware path completion when they are right next to each other.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 39 +++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b09c8a2362..36d3c6f928 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -396,6 +396,25 @@ __git_index_files ()
 	done | sort | uniq
 }
 
+# __git_complete_index_file requires 1 argument:
+# 1: the options to pass to ls-file
+#
+# The exception is --committable, which finds the files appropriate commit.
+__git_complete_index_file ()
+{
+	local pfx="" cur_="$cur"
+
+	case "$cur_" in
+	?*/*)
+		pfx="${cur_%/*}"
+		cur_="${cur_##*/}"
+		pfx="${pfx}/"
+		;;
+	esac
+
+	__gitcomp_file "$(__git_index_files "$1" ${pfx:+"$pfx"})" "$pfx" "$cur_"
+}
+
 # Lists branches from the local repository.
 # 1: A prefix to be added to each listed branch (optional).
 # 2: List only branches matching this word (optional; list all branches if
@@ -712,26 +731,6 @@ __git_complete_revlist_file ()
 	esac
 }
 
-
-# __git_complete_index_file requires 1 argument:
-# 1: the options to pass to ls-file
-#
-# The exception is --committable, which finds the files appropriate commit.
-__git_complete_index_file ()
-{
-	local pfx="" cur_="$cur"
-
-	case "$cur_" in
-	?*/*)
-		pfx="${cur_%/*}"
-		cur_="${cur_##*/}"
-		pfx="${pfx}/"
-		;;
-	esac
-
-	__gitcomp_file "$(__git_index_files "$1" ${pfx:+"$pfx"})" "$pfx" "$cur_"
-}
-
 __git_complete_file ()
 {
 	__git_complete_revlist_file
-- 
2.17.0.366.gbe216a3084

