Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52840C433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 20:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiBXUjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 15:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbiBXUjN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 15:39:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B61E179A14
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id p9so1405793wra.12
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 12:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oncpURorPax8mzkt34OazX8EncUMvSMsGuwytMmjXG8=;
        b=WWKxWwGjYLgCDgHtB6AzY2MDL0Ct6PngnrrnHys3TuX0Z0neISYDb2Nv+Yep007IAv
         NTqxffIm7932BpzdL4u93wOmuXtAawRRp7vt9DiKRE2R5wbMy0dicY/yvppIXoCNbpgr
         kliN4JL4ZGMpkIc/WxGcmJS2AccYFhhl901IlQuygm/4KBe4tBOrFOTHe7iRa+mK40kt
         sQ4bmDS77UnWreDszcc+uqYwmp9Y4wG9tYMgryYAuBJaozbPhB9bIXEF9u2+EcjNsDD8
         E/MFBm+yb0ZfZw2GLVgZg0ebO4eqz346dWOvATAj5plwHGlkHSwcYpXXamN42DnyDP90
         avZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oncpURorPax8mzkt34OazX8EncUMvSMsGuwytMmjXG8=;
        b=i7kKUk5sPNNz9roz7gOXsJo9YCwTEK7ci31Ix9sCHe8kTn39Xb3IDiAvn69vG5qFHd
         ZafANSv/faQoR5wY2csen0ySWD9SNG/pqqL99rRa8kxf++nSxUyNJhW5lfBXUr25riO9
         oc2o1M91fD/XrcP63NqZcLOyv6+Rs4fMmZuV2bATkmHqJb3AQqi3qb3EKqQPaP+Q+Gli
         OmyhxYdG6a9fQi/CFWLHDDh28oU6soZIDrj1a94Ck4TxOEjLiWT7r5578ocrS49SoEGl
         TwAAyLTAEWhYDYTSbumcFSueFiFncKoMilYBKq1kkZ8ZqtebY2K68Dh56PY3rD00XiO3
         /rbA==
X-Gm-Message-State: AOAM530+cxwW0gpYXQfojl040zii/QJwu770i3Ty1tug8CnLPS0ixoC9
        9cyVvKWdVLl8+CJ02L1bUXiGCzc596g=
X-Google-Smtp-Source: ABdhPJw/aplz7STll390pWz6OKVnbZvyGC+GufTveOSzq1eErE4ZEA3tGS9NlLIjbBMqaSkNVeHNDg==
X-Received: by 2002:a5d:6205:0:b0:1e4:b3fd:9ba8 with SMTP id y5-20020a5d6205000000b001e4b3fd9ba8mr3514219wru.426.1645735121413;
        Thu, 24 Feb 2022 12:38:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q11-20020adfcd8b000000b001e320028660sm285328wrj.92.2022.02.24.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:38:40 -0800 (PST)
Message-Id: <de7ab2f39d90c6b33b21a5adf126ec2ef5ce27e6.1645735117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
References: <pull.1163.git.1645735117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 20:38:33 +0000
Subject: [PATCH 4/7] commit-graph: fix generation number v2 overflow values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The Generation Data Chunk was implemented and tested in e8b63005c
(commit-graph: implement generation data chunk, 2021-01-16), but the
test was carefully constructed to work on systems with 32-bit dates.
Since the corrected commit date offsets still required more than 31
bits, this triggered writing the generation_data_overflow chunk.

However, upon closer look, the
write_graph_chunk_generation_data_overflow() method writes the offsets
to the chunk (as dictated by the format) but fill_commit_graph_info()
treats the value in the chunk as if it is the full corrected commit date
(not an offset). For some reason, this does not cause an issue when
using the FUTURE_DATE specified in t5318-commit-graph.sh, but it does
show up as a failure in 'git commit-graph verify' if we increase that
FUTURE_DATE to be above four billion.

Fix this error and update the test to require 64-bit dates so we can
safely use this large value in our test.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 commit-graph.c          |  2 +-
 t/t5318-commit-graph.sh | 21 +++++++++++++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 8e52bb09552..b86a6a634fe 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -806,7 +806,7 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
 				die(_("commit-graph requires overflow generation data but has none"));
 
 			offset_pos = offset ^ CORRECTED_COMMIT_DATE_OFFSET_OVERFLOW;
-			graph_data->generation = get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
+			graph_data->generation = item->date + get_be64(g->chunk_generation_data_overflow + 8 * offset_pos);
 		} else
 			graph_data->generation = item->date + offset;
 	} else
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 1afee1c2705..5e4b0216fa6 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -815,6 +815,19 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 	)
 '
 
+# The remaining tests check timestamps that flow over
+# 32-bits. The graph_git_behavior checks can't take a
+# prereq, so just stop here if we are on a 32-bit machine.
+
+if ! test_have_prereq TIME_IS_64BIT
+then
+	test_done
+fi
+if ! test_have_prereq TIME_T_IS_64BIT
+then
+	test_done
+fi
+
 # We test the overflow-related code with the following repo history:
 #
 #               4:F - 5:N - 6:U
@@ -832,10 +845,10 @@ test_expect_success 'corrupt commit-graph write (missing tree)' '
 # The largest offset observed is 2 ^ 31, just large enough to overflow.
 #
 
-test_expect_success 'set up and verify repo with generation data overflow chunk' '
+test_expect_success TIME_IS_64BIT,TIME_T_IS_64BIT 'set up and verify repo with generation data overflow chunk' '
 	objdir=".git/objects" &&
 	UNIX_EPOCH_ZERO="@0 +0000" &&
-	FUTURE_DATE="@2147483646 +0000" &&
+	FUTURE_DATE="@4000000000 +0000" &&
 	test_oid_cache <<-EOF &&
 	oid_version sha1:1
 	oid_version sha256:2
@@ -867,4 +880,8 @@ test_expect_success 'set up and verify repo with generation data overflow chunk'
 
 graph_git_behavior 'generation data overflow chunk repo' repo left right
 
+# Do not add tests at the end of this file, unless they require 64-bit
+# timestamps, since this portion of the script is only executed when
+# time data types have 64 bits.
+
 test_done
-- 
gitgitgadget

