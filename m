Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD35C43216
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 07:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2073C60FA0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 07:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhH3HXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 03:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhH3HXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 03:23:46 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2DC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 00:22:52 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id u7so14980991ilk.7
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1KmupRbyBMA7HuxUooODp9wpT4UAupG40yeufOLyqY=;
        b=KJhJDdr+VZ34eQ5rG4gdECWh3e7Hw2WpgaEvcCA73CZRNHiBRSD0rgbR+/K+ra89Nu
         pNcdHANVrHvyN5q7TOB7Q+HlyhzMd1Pa9zdEKbuWTDPh6oIFrtmH44RocFOEY/AKm6q/
         fW9FhQsi9kwLk59rS/n35X08qr6RQNafnGouKrHphjeyqGJFwiqipP/zs9z7czTz2wBb
         vSdI2kQbLam46et7RyRK4Y+qSaVmQpgAiDiMZHh+5IyEBh9D1HeKIvg4jYH5X018Azor
         S5zHfijdS4u+OuYHhifZYquNZKWE8h39EX+HWBleWL8dNgDYDSgVDqBeErI5PcfSOMSo
         CaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=w1KmupRbyBMA7HuxUooODp9wpT4UAupG40yeufOLyqY=;
        b=YDvC/6evskL4M8CpMAK9LLyBYD2M9ezMLKRPTgCQa1X+fFVkFlzRdi+b685U3kklbP
         sIU2RFYn5smgrKuN/8vSKheQWO048oSv/kvlHQMOfLp/Xc9GhwJju+1Oxg27skYD0QW7
         ND8EV5hDZZ/TWUzx3RQX25rRvxrc0arhfJUqKKmDDfoY2qx8IEhGzi8gjUNOq5QMfiDe
         1B4o2kX7h/0NXM/2tydejZBEsjUoE0uEfEdMGwUCCLxflmKEV0dhxclrX9HN2IxO1Fp0
         ev3SBvKa9ofG21WMaOrMJE4zpodQRt1Kfll7tVReJBwpc0IVPLir61umg62qQqb3Q+YR
         b0gA==
X-Gm-Message-State: AOAM533I3GKaRdaYrNZsMLlB0mndiWuwU+wRlCL1PePK184E5m4D70Sq
        kEiDuDrkT1JLxxCeyXnrO+I+ibU6mbo=
X-Google-Smtp-Source: ABdhPJxSjc2cAXOktgyKQ1d9fsG5CGezb/28y2p4G0usJKY7jT7RhZvnLqVYj4+GWmAT8yOi8ndpjw==
X-Received: by 2002:a92:d282:: with SMTP id p2mr14458148ilp.259.1630308172008;
        Mon, 30 Aug 2021 00:22:52 -0700 (PDT)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id a6sm7903840ilb.59.2021.08.30.00.22.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 00:22:51 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] t3303/t9301: make `notes` tests less brittle
Date:   Mon, 30 Aug 2021 03:21:17 -0400
Message-Id: <20210830072118.91921-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24
In-Reply-To: <20210830072118.91921-1-sunshine@sunshineco.com>
References: <20210830072118.91921-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests care about whether intended notes-related functionality
occurred, but they check for the expected result in a brittle way by
consulting the default output of `git log` which is intended for human,
not machine, consumption. Make the tests more robust by requesting the
desired information in a stable machine-consumable format.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3303-notes-subtrees.sh    | 13 ++++++++-----
 t/t9301-fast-import-notes.sh | 36 +++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index d47ce00f69..abffa10564 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -171,13 +171,16 @@ INPUT_END
 }
 
 verify_concatenated_notes () {
-	git log | grep "^    " > output &&
+	git log --format="tformat:%B%N" >output &&
 	i=$number_of_commits &&
 	while [ $i -gt 0 ]; do
-		echo "    commit #$i" &&
-		echo "    first note for commit #$i" &&
-		echo "    " &&
-		echo "    second note for commit #$i" &&
+		cat <<-EOF &&
+		commit #$i
+		first note for commit #$i
+
+		second note for commit #$i
+
+		EOF
 		i=$(($i-1));
 	done > expect &&
 	test_cmp expect output
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 1ae4d7c0d3..123323b2bb 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -259,29 +259,31 @@ EOF
 
 INPUT_END
 
-whitespace="    "
-
 cat >expect <<EXPECT_END
-    fourth commit
-    pre-prefix of note for fourth commit
-$whitespace
-    prefix of note for fourth commit
-$whitespace
-    third note for fourth commit
-    third commit
-    prefix of note for third commit
-$whitespace
-    third note for third commit
-    second commit
-    third note for second commit
-    first commit
-    third note for first commit
+fourth commit
+pre-prefix of note for fourth commit
+
+prefix of note for fourth commit
+
+third note for fourth commit
+
+third commit
+prefix of note for third commit
+
+third note for third commit
+
+second commit
+third note for second commit
+
+first commit
+third note for first commit
+
 EXPECT_END
 
 test_expect_success 'add concatenation notes with M command' '
 
 	git fast-import <input &&
-	GIT_NOTES_REF=refs/notes/test git log | grep "^    " > actual &&
+	GIT_NOTES_REF=refs/notes/test git log --format="tformat:%B%N" >actual &&
 	test_cmp expect actual
 
 '
-- 
2.33.0.153.gba50c8fa24

