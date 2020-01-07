Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC2FC33CA1
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7FF20880
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYKQbBTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgAGV1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:27:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39693 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgAGV1H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 16:27:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so353959wmj.4
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 13:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XVpcX1FNjQBSLwuDzC5QigI1qBeT7d7bMFwBxefL1UI=;
        b=HYKQbBTIqBRFOS+o2wEsGuFVaLDe2jxpjKmcYLa6I6hQf3iBNbvQHdJ0s1sJe4gem2
         OI/3HQeBkqk5t7khjP+G894BwOSfxEbyVOpZdwG6DzZzqMdtG76EIkylS22yVpwM+Sk0
         vOdW9S3rq8HkvYhdUNLv9hWTnybOgM/Ngt1B0fpRoiKujhjr5q98lTRNhma3fAo/5CyA
         be93Ih8RHGvMlN7q8vDj8Lqltviqe5qC1qrYdKchVqmsXkBir3nukq65BCufdmA+oSr7
         d2bHw3Ckj2v1oWIhkEJSYRcvdGVoCypd/8dY4l43m9V03W5c6kfYc9aJ+4+NaBEuisSm
         RXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XVpcX1FNjQBSLwuDzC5QigI1qBeT7d7bMFwBxefL1UI=;
        b=aYBJ8DSqzPGJtSOwQ9Rf1XkWtCqC4+76tFrzRjPEqR1SiRLKBW9Wt2rl2HBsxw9gTH
         BMi059GgHF6yBzIbiy1qcE2ugwwqnqQa3iNdbd91M5xd/C1ZDzXHCPgluQHjfNgVQAJn
         Gl1pYFWC90czukX81syn9gwBIvKl94zaueuSvROCVPuCrdc2Ndg5QhDZCQQQZL7f5gSM
         jW3H/UeePuxNmbCQVSttVsDThE6ETaLPp0sGrIhn1itrOduM0Wd9SLMf2S5gtVzM0kqP
         ua+gaMZlcCeL7PzZF4Ou4klJVXV2HD4ot6okqIdWLUAEmfRWG2ua9OHSNprPZwH1K+8M
         E2/Q==
X-Gm-Message-State: APjAAAUEpDio1CODAPyhAupshDPvVn7RGJeLpEPDWNseFWxfuAr7jrc4
        XkX3iUVkzMwh0y9cNouB5TDf6ubY
X-Google-Smtp-Source: APXvYqxaKRNIaJM6g5cZCvl6MXAK9W2N/Ymbkyf271v5AuNOp0kg0QdpAfeodA3nS6CKuwBwgU9tvA==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr364302wmk.50.1578432424933;
        Tue, 07 Jan 2020 13:27:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g199sm1109144wmg.12.2020.01.07.13.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:27:04 -0800 (PST)
Message-Id: <11887bd38d73b48c6677ef1e8fe2b9f0c295c8a0.1578432422.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.517.v2.git.1578432422.gitgitgadget@gmail.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
        <pull.517.v2.git.1578432422.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 21:27:02 +0000
Subject: [PATCH v2 2/2] graph: fix lack of color in horizontal lines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, brad@brad-smith.co.uk, sunshine@sunshineco.com,
        James Coglan <jcoglan@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In some cases, horizontal lines in rendered graphs can lose their
coloring. This is due to a use of graph_line_addch() instead of
graph_line_write_column(). Using a ternary operator to pick the
character is nice for compact code, but we actually need a column to
provide the color.

Add a test to t4215-log-skewed-merges.sh to prevent regression.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 graph.c                      | 13 +++++++++----
 t/t4215-log-skewed-merges.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/graph.c b/graph.c
index f514ed3efa..aaf97069bd 100644
--- a/graph.c
+++ b/graph.c
@@ -1063,7 +1063,7 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 	int i, j;
 
 	struct commit_list *first_parent = first_interesting_parent(graph);
-	int seen_parent = 0;
+	struct column *parent_col = NULL;
 
 	/*
 	 * Output the post-merge row
@@ -1117,12 +1117,17 @@ static void graph_output_post_merge_line(struct git_graph *graph, struct graph_l
 			graph_line_addch(line, ' ');
 		} else {
 			graph_line_write_column(line, col, '|');
-			if (graph->merge_layout != 0 || i != graph->commit_index - 1)
-				graph_line_addch(line, seen_parent ? '_' : ' ');
+			if (graph->merge_layout != 0 || i != graph->commit_index - 1) {
+				if (parent_col)
+					graph_line_write_column(
+						line, parent_col, '_');
+				else
+					graph_line_addch(line, ' ');
+			}
 		}
 
 		if (col_commit == first_parent->item)
-			seen_parent = 1;
+			parent_col = col;
 	}
 
 	/*
diff --git a/t/t4215-log-skewed-merges.sh b/t/t4215-log-skewed-merges.sh
index ddf6f6f5d3..5661ed5881 100755
--- a/t/t4215-log-skewed-merges.sh
+++ b/t/t4215-log-skewed-merges.sh
@@ -282,4 +282,33 @@ test_expect_success 'log --graph with multiple tips' '
 	EOF
 '
 
+test_expect_success 'log --graph with multiple tips and colors' '
+	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
+	cat >expect.colors <<-\EOF &&
+	*   6_I
+	<RED>|<RESET><GREEN>\<RESET>
+	<RED>|<RESET> <GREEN>|<RESET> *   6_H
+	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET><BLUE>\<RESET>
+	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 6_G
+	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> * 6_F
+	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET><GREEN>|<RESET>
+	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET><GREEN>/<RESET>
+	<RED>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET><GREEN>/<RESET><BLUE>|<RESET>
+	<RED>|<RESET> <GREEN>|<RESET><GREEN>/<RESET><YELLOW>|<RESET> <BLUE>|<RESET>
+	<RED>|<RESET> <GREEN>|<RESET> * <BLUE>|<RESET> 6_E
+	<RED>|<RESET> * <CYAN>|<RESET> <BLUE>|<RESET> 6_D
+	<RED>|<RESET> <BLUE>|<RESET> <CYAN>|<RESET><BLUE>/<RESET>
+	<RED>|<RESET> <BLUE>|<RESET><BLUE>/<RESET><CYAN>|<RESET>
+	* <BLUE>|<RESET> <CYAN>|<RESET> 6_C
+	<CYAN>|<RESET> <BLUE>|<RESET><CYAN>/<RESET>
+	<CYAN>|<RESET><CYAN>/<RESET><BLUE>|<RESET>
+	* <BLUE>|<RESET> 6_B
+	<BLUE>|<RESET><BLUE>/<RESET>
+	* 6_A
+	EOF
+	git log --color=always --graph --date-order --pretty=tformat:%s 6_1 6_3 6_5 >actual.colors.raw &&
+	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
+	test_cmp expect.colors actual.colors
+'
+
 test_done
-- 
gitgitgadget
