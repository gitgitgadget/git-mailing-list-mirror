Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FD2C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5048B2071A
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 20:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyFL0hfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgKBUoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 15:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgKBUn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 15:43:57 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE6CC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 12:43:57 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id s21so16084483oij.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 12:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NY614d/h/vzCYSbEDOYPGjZwRMoxV7s7hSmK9PfVhQY=;
        b=lyFL0hfG7pqZJVac9VkgHGFNGzDyAD1BtTozor7unOWTuxZbC/Lq18zC9FZV+uhSeW
         fhT1eZgbOIMSX8mj2KevAw47t5h1joFH791vA92VWReloE/NLQMyMUjiVZC4pdxDczem
         ko2JHExeTVZudhE7mHMz/oMRbmJ/M5sVxKvgmCwOqP7E7e8RDP1Z+KYKQdmGlfx9xctO
         kZiAX2Z6sJTSUedvp92gl8fvTFrchiXrCqwhiKqNOhUKP58EzM2GL15S/U96AWDzL/G7
         wUKNwcoL7Xo8w3MIin5N+2UEm9og4whQR7kY87CGAOD8DrgpknYRnLjuZYh498bPkHpL
         yfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NY614d/h/vzCYSbEDOYPGjZwRMoxV7s7hSmK9PfVhQY=;
        b=f/arW0wRbMJ/tmNbDx6jA2nrQujbmn4c1clFuil1QOJxEFBz4f7gA03ZTdpTOqYGxG
         F2R8TbgvVBurD9F3maefgY1WnRw1AejofSNii9CPBqZ+E1s2qLZdYrtgSJ8A6nwkaWOh
         5B41OFCFtCBAwaL/DRTUfAqdpMHFHDlKtKi/x8jAW2+SRJgDPSwYs8ZJs8LnO7TiFeBy
         NgHomP2miOjf3AXattr5tjep+XxdLQVqEPf9kWqxQeFNcbyTHCfmh7MQYZBuzeEtYo2P
         lgSAqJCPypUmG1ddMImzZaljjrjwA5q2cWdmsHVOVBygeuwOYu5zSLYX4laR1MJBD1S/
         ZOTQ==
X-Gm-Message-State: AOAM532tt5D3L4diUwAIiVWWTZxxbN5NfaV/WtbR170WDakp+cPnKSXY
        tSUpd4il58/dROx8MMqIdMuLC8GlkgeNgw==
X-Google-Smtp-Source: ABdhPJygYJEnylgh4UxXeR2jB3AuXxDIGqm36i+XLgLmaRYofpiTX730I7dKbMa5eF7cDTuoGB7eBQ==
X-Received: by 2002:aca:3343:: with SMTP id z64mr11670817oiz.45.1604349836851;
        Mon, 02 Nov 2020 12:43:56 -0800 (PST)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id t27sm3848512otc.14.2020.11.02.12.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:43:56 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 07/20] merge-ort: avoid repeating fill_tree_descriptor() on the same tree
Date:   Mon,  2 Nov 2020 12:43:31 -0800
Message-Id: <20201102204344.342633-8-newren@gmail.com>
X-Mailer: git-send-email 2.29.0.471.ga4f56089c0
In-Reply-To: <20201102204344.342633-1-newren@gmail.com>
References: <20201102204344.342633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Three-way merges, by their nature, are going to often have two or more
trees match at a given subdirectory.  We can avoid calling
fill_tree_descriptor() on the same tree by checking when these trees
match.  Noting when various oids match will also be useful in other
calculations and optimizations as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 626eb9713e..d3c1d00fc6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -99,6 +99,15 @@ static int collect_merge_info_callback(int n,
 	unsigned mbase_null = !(mask & 1);
 	unsigned side1_null = !(mask & 2);
 	unsigned side2_null = !(mask & 4);
+	unsigned side1_matches_mbase = (!side1_null && !mbase_null &&
+					names[0].mode == names[1].mode &&
+					oideq(&names[0].oid, &names[1].oid));
+	unsigned side2_matches_mbase = (!side2_null && !mbase_null &&
+					names[0].mode == names[2].mode &&
+					oideq(&names[0].oid, &names[2].oid));
+	unsigned sides_match = (!side1_null && !side2_null &&
+				names[1].mode == names[2].mode &&
+				oideq(&names[1].oid, &names[2].oid));
 
 	/* n = 3 is a fundamental assumption. */
 	if (n != 3)
@@ -154,10 +163,19 @@ static int collect_merge_info_callback(int n,
 		newinfo.pathlen = st_add3(newinfo.pathlen, p->pathlen, 1);
 
 		for (i = 0; i < 3; i++, dirmask >>= 1) {
-			const struct object_id *oid = NULL;
-			if (dirmask & 1)
-				oid = &names[i].oid;
-			buf[i] = fill_tree_descriptor(opt->repo, t + i, oid);
+			if (i == 1 && side1_matches_mbase)
+				t[1] = t[0];
+			else if (i == 2 && side2_matches_mbase)
+				t[2] = t[0];
+			else if (i == 2 && sides_match)
+				t[2] = t[1];
+			else {
+				const struct object_id *oid = NULL;
+				if (dirmask & 1)
+					oid = &names[i].oid;
+				buf[i] = fill_tree_descriptor(opt->repo,
+							      t + i, oid);
+			}
 		}
 
 		original_dir_name = opti->current_dir_name;
-- 
2.29.0.471.ga4f56089c0

