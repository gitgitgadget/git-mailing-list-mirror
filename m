Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9498F20188
	for <e@80x24.org>; Sun, 14 May 2017 03:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758905AbdENDRM (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:17:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33486 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758573AbdENDQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id h4so14344234oib.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Qr2PMZn7BJpu9EiEbv8SDFAD2R11rsZPqTf07a2vdo=;
        b=rRoB22AK6qptUZZOuGdRypZ1AMSDWUWOl5eQDD3XdGlZR64ztSmRGN8LluJD5XfXUx
         gm+ce/VYYZ0JL2ppVCOEvpnjBii7EPow3aJ3Hs7Cd/LEUvyC5527j62VybTITUNc2/nE
         ioSK7l3rggIaUU7SFh6Az33hnupdLiHhI85aivlOTuy1uaXTrEaK2dQ5gXymzrAf6ihD
         mHzVuMO3kPx70h3Ut0UANC0fuZ6g3bYO0oLhpi1B+C30o0GPo8ZKNz5VDRp1K35ksigy
         flbr9Tt8d1yDvInDnsBQOo1ylrjWWKnQknjVuZugoK1FCHBLhi/6+Pzqq+Cj1jgCw3Ys
         kPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Qr2PMZn7BJpu9EiEbv8SDFAD2R11rsZPqTf07a2vdo=;
        b=UMJQrBrgVGA/kFAZL+66WpvBMAc+p0MVI0JVBF3hxek91byGu1D43w/a7XUuALxgqs
         ZFPyTMg9k5sqLYG/tge5/L8qXxTuQ/oUrnIX2I1+JwT58KXmkfe6zicJZnmiXz41RgH8
         qz0tnnpuL/ttogvWRZ5Af0sSU99Qp4/8Z5l8FogFJbBK7yN20Noq1fMyV2EYZUJ2dYbu
         cA+HpLMR/tNqP8qs+OBS6t+XL+IMFlS35M73C/hgGlKAR02VocwPLUMZ/98rk26fhOZm
         PmyJok9tEYMP0xVigZNJh67zpGcoz8zUvVxjhOFevywT8VYVGdWMjRZM/1NDSzNxqo03
         T/tQ==
X-Gm-Message-State: AODbwcCrroIN5ipaBnr+aZ1mmB9qhwidP/HaBTe5cR0Z1h5KXrkUr1Go
        txrMFmQV9qMPOw==
X-Received: by 10.202.78.207 with SMTP id c198mr5553998oib.222.1494731781447;
        Sat, 13 May 2017 20:16:21 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:20 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 12/22] blame: move no_whole_file_rename flag to scoreboard
Date:   Sat, 13 May 2017 22:15:03 -0500
Message-Id: <20170514031513.9042-13-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The no_whole_file_rename flag is used in parts of blame that are being
moved to libgit, and should be accessible via the scoreboard structure.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.h         | 1 +
 builtin/blame.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/blame.h b/blame.h
index 42a948d..c140f41 100644
--- a/blame.h
+++ b/blame.h
@@ -133,6 +133,7 @@ struct blame_scoreboard {
 	int reverse;
 	int show_root;
 	int xdl_opts;
+	int no_whole_file_rename;
 };
 
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index d3af02b..bd295eb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1285,7 +1285,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	 * The first pass looks for unrenamed path to optimize for
 	 * common cases, then we look for renames in the second pass.
 	 */
-	for (pass = 0; pass < 2 - no_whole_file_rename; pass++) {
+	for (pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
 		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
 		find = pass ? find_rename : find_origin;
 
@@ -2763,6 +2763,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	sb.show_root = show_root;
 	sb.xdl_opts = xdl_opts;
+	sb.no_whole_file_rename = no_whole_file_rename;
 
 	read_mailmap(&mailmap, NULL);
 
-- 
2.9.3

