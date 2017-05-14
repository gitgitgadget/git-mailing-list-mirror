Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A577920188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758798AbdENDQa (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:30 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33482 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758669AbdENDQV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:21 -0400
Received: by mail-oi0-f66.google.com with SMTP id h4so14344196oib.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y6Jl/MIeqEwJmat6l7WdbsTN8Upvr+YTgsmct52lfCY=;
        b=P7T7bR1ktU+ENpb9gqDVU/ciAI5xfeqayPysSSK8Y3ht/P2McmcYmMxYBwHxRlvLFJ
         nXcTcLnSYno/RE9BuvNiN8AGn30VNB5KgAUsGbS1lJA9ypDrlp08tkwOhPT9GnkhKLBZ
         k9hVF86bKm7HiFHf6fTFEKIVOQcBMjDpUY+yYQI2bxqO45nt0iR31xESXyGDEO+0ZxpC
         7kfn/WinaXd4xfkpIBKdd8vZVjqEimtMEhwzSAHnaTx/v+X3i2n2o5freNBSxwoPFxQc
         o4TKd9Nbwod6blUlSIFPrA9RN/s5oj09Q4gf0sem505aDQY6AwHh8YNM/58sBcxw9rBD
         eqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y6Jl/MIeqEwJmat6l7WdbsTN8Upvr+YTgsmct52lfCY=;
        b=pzn5cRYlpYMAcUU4srsOXZ1pwXnAaNEVQXwtB7mLZuymGLIlKshMYRBqSCrHyReKPx
         Ni2lrqJHIQp/sfVrNsAD0qVRnFNKbEQrq4A1BCx7hX8Aqg0Z/oqKlgTuGd0Dc7u1kWu9
         nTB1d4iTFbGUfI0+Q7VkoPLO9wOf2WFzlwrzf4xLRJ3C3dkkuxZUr9OJS3CVt2emt9M9
         LUgtSDr+oSwiKwFb9c+ucJVAquasUj2Iak+bBCusOvKCD2zyHq7HGywFZIFlTvqojwZ2
         QUkM1VWK4zBzOzjv7ryWjVKXvDrF4kHqHRZ3bh2O8wET9uKFWZ0HzFmmQaRtvAuJafUz
         cTcg==
X-Gm-Message-State: AODbwcBArz5UHP47BVugvIF/sctVTTGnDYpvmdUkrnkl9OWd95y1+0XH
        FvRf67feElK4HQ==
X-Received: by 10.202.57.4 with SMTP id g4mr6126630oia.197.1494731780326;
        Sat, 13 May 2017 20:16:20 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:19 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 11/22] blame: move xdl_opts flags to scoreboard
Date:   Sat, 13 May 2017 22:15:02 -0500
Message-Id: <20170514031513.9042-12-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The xdl_opts flags are used in parts of blame that are being moved to
libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         | 1 +
 builtin/blame.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/blame.h b/blame.h
index 7691256..42a948d 100644
--- a/blame.h
+++ b/blame.h
@@ -132,6 +132,7 @@ struct blame_scoreboard {
 	/* flags */
 	int reverse;
 	int show_root;
+	int xdl_opts;
 };
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 77fb71f..d3af02b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -80,7 +80,7 @@ struct progress_info {
 };
 
 static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
-		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
 {
 	xpparam_t xpp = {0};
 	xdemitconf_t xecfg = {0};
@@ -823,7 +823,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
 	sb->num_get_patch++;
 
-	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d))
+	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
 		die("unable to generate diff (%s -> %s)",
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
@@ -972,7 +972,7 @@ static void find_copy_in_blob(struct blame_scoreboard *sb,
 	 * file_p partially may match that image.
 	 */
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	if (diff_hunks(file_p, &file_o, handle_split_cb, &d))
+	if (diff_hunks(file_p, &file_o, handle_split_cb, &d, sb->xdl_opts))
 		die("unable to generate diff (%s)",
 		    oid_to_hex(&parent->commit->object.oid));
 	/* remainder, if any, all match the preimage */
@@ -2762,6 +2762,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		sb.copy_score = blame_copy_score;
 
 	sb.show_root = show_root;
+	sb.xdl_opts = xdl_opts;
 
 	read_mailmap(&mailmap, NULL);
 
-- 
2.9.3

