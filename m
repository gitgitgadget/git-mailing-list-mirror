Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A42F1F404
	for <e@80x24.org>; Thu, 26 Apr 2018 07:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeDZHrd (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 03:47:33 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42022 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753582AbeDZHrc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 03:47:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id o16so17593385pfk.9
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YuLzuBj5C65ReZVec18FYukMn1JvPo+fMmhF4OUNdII=;
        b=XB+MmDjdV9vXQ/iBoqBlK4CKE/YLWo6S8Yk+r4dlcbuRDLM7PeMbVkWDnJd4DE/xVo
         rZQcS82H0gst1fzxmtsP9AT+paGHCRxd/xzZGp2qnFY6fCX+GemIGZ8YazAd9tPeb6h0
         LJuJ3rEVJLswkCPOTJiFU/MNVHYpFe+TU4pPpGm6T7/U3Y1BmEpquKR+mVLX9r77gR37
         FaHKZGsKMkojBynY2vv8iCIuC4frkNb0uuMLlZ3GFPGvYUw1FdY0uYHegvwSm6lhIJPv
         OU66oZou/R/d2ZfKFekGaObQQOlDyF40/AE5RdBp2MDRCTVVb6EHiVnZ2ya/uQzxNYnu
         6VxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YuLzuBj5C65ReZVec18FYukMn1JvPo+fMmhF4OUNdII=;
        b=EQjtl7ov9o2srxeocWhm09I5t4mhJzFkq1ehA2neKTG4bTJVfonT4ZYg88shbG+3qp
         h7fTq727wrvxy230bl86jj9Vun63sz3tJRvqGLZAXemhMWmY5eVMKzzrYQjJCuoH81ZM
         +i0ywjH2NoIr1P2Nz7UlRACACmBSXf4ByWf9gvaKDIfpo+FYqWy1H9s1R8o8FetdaEHr
         nhVSg3G5lxXNrmcdDFumLOT6dzy0eySItWR73PH+3GlwbVUh6a4FjuufxjMzsEqojILp
         RXNwDpz96qdpaduFY8OkLrkl7nqjQoaSbumtOk4NFBgQKoHITN9S4igyec60kb/ZApRT
         kU0w==
X-Gm-Message-State: ALQs6tDQO70YCWPkt7eeeXUQ4hS80+eJvsUcruduCVv7E31VSStmPeQ2
        OtbKo10a82Cyko7o/SJI4XjZ4g==
X-Google-Smtp-Source: AIpwx49kzc+rI0zdpQaEC1ewDWSPu1WdIOvuCd83M56lPpedYGikS8L21HWtF3Hs5OeaADcMHyACTw==
X-Received: by 10.101.89.14 with SMTP id f14mr16121515pgu.282.1524728851744;
        Thu, 26 Apr 2018 00:47:31 -0700 (PDT)
Received: from C02VT0RZHTDG.office.atlassian.com ([103.233.242.8])
        by smtp.gmail.com with ESMTPSA id e10sm31007774pfn.67.2018.04.26.00.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 00:47:31 -0700 (PDT)
From:   istephens@atlassian.com
To:     sunshine@sunshineco.com
Cc:     szeder.dev@gmail.com, gitster@pobox.com, git@vger.kernel.org,
        peff@peff.net, bturner@atlassian.com, jacob.keller@gmail.com,
        Isabella Stephens <istephens@atlassian.com>
Subject: [PATCH v4 2/2] log: prevent error if line range ends past end of file
Date:   Thu, 26 Apr 2018 17:45:02 +1000
Message-Id: <20180426074502.78318-3-istephens@atlassian.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180426074502.78318-1-istephens@atlassian.com>
References: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
 <20180426074502.78318-1-istephens@atlassian.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Isabella Stephens <istephens@atlassian.com>

If the -L option is used to specify a line range in git log, and the end
of the range is past the end of the file, git will fail with a fatal
error. This commit prevents such behaviour - instead we perform the log
for existing lines within the specified range.

This commit also fixes a corner case where -L ,-n:file would be treated
as a log over the whole file. Now we complain that this is an empty
range.

Signed-off-by: Isabella Stephens <istephens@atlassian.com>
---
 line-log.c          | 10 +++++++---
 t/t4211-line-log.sh | 11 -----------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/line-log.c b/line-log.c
index cdc2257db..ad3987062 100644
--- a/line-log.c
+++ b/line-log.c
@@ -599,11 +599,15 @@ parse_lines(struct commit *commit, const char *prefix, struct string_list *args)
 				    lines, anchor, &begin, &end,
 				    full_name))
 			die("malformed -L argument '%s'", range_part);
-		if (lines < end || ((lines || begin) && lines < begin))
-			die("file %s has only %lu lines", name_part, lines);
+		if (!begin && end < 0)
+			die("-L invalid empty range");
+		if ((!lines && (begin || end)) || lines < begin)
+			die(Q_("file %s has only %lu line",
+				   "file %s has only %lu lines",
+				   lines), name_part, lines);
 		if (begin < 1)
 			begin = 1;
-		if (end < 1)
+		if (end < 1 || lines < end)
 			end = lines;
 		begin--;
 		line_log_data_insert(&ranges, full_name, begin, end);
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index d0377fae5..0b96496e3 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -60,7 +60,6 @@ test_bad_opts "-L 1:nonexistent" "There is no path"
 test_bad_opts "-L 1:simple" "There is no path"
 test_bad_opts "-L '/foo:b.c'" "argument not .start,end:file"
 test_bad_opts "-L 1000:b.c" "has only.*lines"
-test_bad_opts "-L 1,1000:b.c" "has only.*lines"
 test_bad_opts "-L :b.c" "argument not .start,end:file"
 test_bad_opts "-L :foo:b.c" "no match"
 
@@ -84,16 +83,6 @@ test_expect_success '-L ,Y (Y == nlines)' '
 	git log -L ,$n:b.c
 '
 
-test_expect_success '-L ,Y (Y == nlines + 1)' '
-	n=$(expr $(wc -l <b.c) + 1) &&
-	test_must_fail git log -L ,$n:b.c
-'
-
-test_expect_success '-L ,Y (Y == nlines + 2)' '
-	n=$(expr $(wc -l <b.c) + 2) &&
-	test_must_fail git log -L ,$n:b.c
-'
-
 test_expect_success '-L with --first-parent and a merge' '
 	git checkout parallel-change &&
 	git log --first-parent -L 1,1:b.c
-- 
2.14.3 (Apple Git-98)

