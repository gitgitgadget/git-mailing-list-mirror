Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA71D20281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969200AbdEXFRl (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:41 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33624 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969147AbdEXFQn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:43 -0400
Received: by mail-oi0-f65.google.com with SMTP id h4so31066592oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aH3zvqCHcj7Ubv5JlH4huqC4CecxXA2xZ6komyVzrNI=;
        b=S200g41vXVCcuRacOE2+vyDhFf+fP4pkZuVBALDzikLtpr3A47/6uUg5pO+z81i00P
         Ezl9kjaw/T+gQr3tIHUiQzBQb9iJGMXXcdHGKtmVBVRSRtC1VjkgcYr90Yoqr4lTIZsi
         06HTE5VfMfrwFeYiTXRkisMbAGsBf5E5E3KWHhHmoBJmFXFvLGKRVsHGbEFPZP5hEOET
         y4m7CPmEfpV5aBWIBfr6DM59SNndT71Wy6iSJ021rwp+EuCT3Gp+P4Rt5VDFvQjk4bhK
         IMZlw0ycjHh1693KDSVL+Ci+37rk+zR8D75NXq4i1nfYYqfSOUBL+/lggpEOTYUw6tA5
         9f/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aH3zvqCHcj7Ubv5JlH4huqC4CecxXA2xZ6komyVzrNI=;
        b=M70ns8+Zfxm0/LWQwoGdf6hJXfQ7dLLx9bH2AdjFwOq5tj8IsaeLwH2pgDZgCnftro
         6p2cYJ4Ef/S2xswOg78I3xADlW+zR2BHENn7JsfzuhqUGmDEyju0Ey28tF79SxOZBhvo
         Qlcearn4WeSt3sg8T9BLR2J0uuGLdP+8GLFwNoELy3TA1QSKRR0ZL5P5otQ187+j/MZ1
         w2n0SitZnEO8m+QxtQSMfEY9ouxSkprZcK7HCIO9GvcJP/tZ058e0VcuJgf76CtOQLci
         KncVY3qTXEcRHMvcTTZbKS4QnFcUJpdtgCLQDXV1jsFb/rc91ywYoaN7BBZj+1lpzXZC
         yxQQ==
X-Gm-Message-State: AODbwcB20ok3VqKLF1/+vjYHPYz8gy5XRb6HATreJtGhUhaxWr1p7xzI
        MlRDt8zvua9hnw==
X-Received: by 10.202.78.207 with SMTP id c198mr16741911oib.222.1495602997666;
        Tue, 23 May 2017 22:16:37 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:36 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 15/29] blame: move xdl_opts flags to scoreboard
Date:   Wed, 24 May 2017 00:15:23 -0500
Message-Id: <20170524051537.29978-16-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The xdl_opts flags are used in parts of blame that are being moved to
libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index fdd41b4..8e676fb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -125,7 +125,7 @@ struct progress_info {
 };
 
 static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b,
-		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data, int xdl_opts)
 {
 	xpparam_t xpp = {0};
 	xdemitconf_t xecfg = {0};
@@ -385,6 +385,7 @@ struct blame_scoreboard {
 	/* flags */
 	int reverse;
 	int show_root;
+	int xdl_opts;
 };
 
 static void sanity_check_refcnt(struct blame_scoreboard *);
@@ -948,7 +949,7 @@ static void pass_blame_to_parent(struct blame_scoreboard *sb,
 	fill_origin_blob(&sb->revs->diffopt, target, &file_o, &sb->num_read_blob);
 	sb->num_get_patch++;
 
-	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d))
+	if (diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, sb->xdl_opts))
 		die("unable to generate diff (%s -> %s)",
 		    oid_to_hex(&parent->commit->object.oid),
 		    oid_to_hex(&target->commit->object.oid));
@@ -1097,7 +1098,7 @@ static void find_copy_in_blob(struct blame_scoreboard *sb,
 	 * file_p partially may match that image.
 	 */
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	if (diff_hunks(file_p, &file_o, handle_split_cb, &d))
+	if (diff_hunks(file_p, &file_o, handle_split_cb, &d, sb->xdl_opts))
 		die("unable to generate diff (%s)",
 		    oid_to_hex(&parent->commit->object.oid));
 	/* remainder, if any, all match the preimage */
@@ -2887,6 +2888,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		sb.copy_score = blame_copy_score;
 
 	sb.show_root = show_root;
+	sb.xdl_opts = xdl_opts;
 
 	read_mailmap(&mailmap, NULL);
 
-- 
2.9.3

