Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083F21F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeGHSbw (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:31:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40368 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeGHSbu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 14:31:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id t6-v6so8697919wrn.7
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UjpaDjz7XynV04CWBAV6hhJkYhgwDtSCkbnTgySf1mk=;
        b=iWGA6VUHT8QGAygpOyCgzhhp2iN3QzFyJjw9cLcTFy1OYGjozTLDQ4TcLQWY6o84ri
         Qnp6gyCjei57oxLggQhOiz2fkzm6P3fuYSO59SAyDtXrpB7uAfVYsdNNCKwhkXp1ILXW
         Vuz6Z0Tuq1sV5FFrNhjX3G3eD5GtxgSD3VvpNYDYjTzkfWbOYshrsa9oq3I/GDoXnTa5
         pSUaE9lzpZ+7HyGEMPcvmeY6X5Y8VlWrBd+k858reZclG9OVzpDgfNl56JbvINubkSa2
         JNI0GevN75Oz1IdBAPp7pXJwL9uUZiI4tSTT0yRcD3vk9BgrVHTilhNBDkpEemV04rql
         K2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UjpaDjz7XynV04CWBAV6hhJkYhgwDtSCkbnTgySf1mk=;
        b=NuqCJh6RlLFRDeiEePr3ZIK8ljwA5ALsqn7emDYP/uAVgrarxkcQ1gdz9YK6cNV0Kc
         relLvqyqUfsE2d1R+uq5S4dJfD2Q2nShRrgMg3TXYGR/1MlaCKG/v3W8l4mbtbm0934i
         MYzi2m51DLHtyJZlGeW5lvLB7aoPitD1nSbP92IQ6o3xr/NEUSnhNGs0owmpYdD4JYTr
         ZOyCUVzQUk9mywm5JjpVbqIJs1ADUp6A49CoxvJH//PbgNBHycWFZbebBnvybL3041+5
         01rkLt9mmJmI6Pi8wd7LhLhSIrSZOa1HmsVEKcjRTDXkYIXOmUbLU4tJaPZLD9rMWed9
         bWUw==
X-Gm-Message-State: APt69E3Y6gD8DWNVeY58Ua5ls2krLqqLaYyreTFL3/0EVaMLHADbTw+B
        coYAQdbWFxHZklktBhhLPfe06liT
X-Google-Smtp-Source: AAOMgpf7sKpbW+PYRnDexy6eh2INKqWcP0Bht3q4cWXQpNkGEPPnD9rO0kRs8g3t7Nx2dE9n5VBh3w==
X-Received: by 2002:a5d:570a:: with SMTP id a10-v6mr13343156wrv.130.1531074709016;
        Sun, 08 Jul 2018 11:31:49 -0700 (PDT)
Received: from C02WQ21WHTDF.fritz.box (p5DDB5D90.dip0.t-ipconnect.de. [93.219.93.144])
        by smtp.gmail.com with ESMTPSA id c7-v6sm26114917wre.73.2018.07.08.11.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 11:31:48 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Johannes.Schindelin@gmx.de,
        jehan@orb.com, whee@smaertness.net, me@ttaylorr.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1 1/2] convert: refactor conversion driver config parsing
Date:   Sun,  8 Jul 2018 20:30:35 +0200
Message-Id: <20180708183036.29459-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708183036.29459-1-larsxschneider@gmail.com>
References: <20180708183036.29459-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Refactor conversion driver config parsing to ease the parsing of new
configs in a subsequent patch.

No functional change intended.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 64 +++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/convert.c b/convert.c
index 64d0d30e08..949bc783e4 100644
--- a/convert.c
+++ b/convert.c
@@ -1003,43 +1003,43 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	int namelen;
 	struct convert_driver *drv;
 
-	/*
-	 * External conversion drivers are configured using
-	 * "filter.<name>.variable".
-	 */
-	if (parse_config_key(var, "filter", &name, &namelen, &key) < 0 || !name)
-		return 0;
-	for (drv = user_convert; drv; drv = drv->next)
-		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
-			break;
-	if (!drv) {
-		drv = xcalloc(1, sizeof(struct convert_driver));
-		drv->name = xmemdupz(name, namelen);
-		*user_convert_tail = drv;
-		user_convert_tail = &(drv->next);
-	}
+	if (parse_config_key(var, "filter", &name, &namelen, &key) >= 0 && name) {
+		/*
+		 * External conversion drivers are configured using
+		 * "filter.<name>.variable".
+		 */
+		for (drv = user_convert; drv; drv = drv->next)
+			if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
+				break;
+		if (!drv) {
+			drv = xcalloc(1, sizeof(struct convert_driver));
+			drv->name = xmemdupz(name, namelen);
+			*user_convert_tail = drv;
+			user_convert_tail = &(drv->next);
+		}
 
-	/*
-	 * filter.<name>.smudge and filter.<name>.clean specifies
-	 * the command line:
-	 *
-	 *	command-line
-	 *
-	 * The command-line will not be interpolated in any way.
-	 */
+		/*
+		 * filter.<name>.smudge and filter.<name>.clean specifies
+		 * the command line:
+		 *
+		 *	command-line
+		 *
+		 * The command-line will not be interpolated in any way.
+		 */
 
-	if (!strcmp("smudge", key))
-		return git_config_string(&drv->smudge, var, value);
+		if (!strcmp("smudge", key))
+			return git_config_string(&drv->smudge, var, value);
 
-	if (!strcmp("clean", key))
-		return git_config_string(&drv->clean, var, value);
+		if (!strcmp("clean", key))
+			return git_config_string(&drv->clean, var, value);
 
-	if (!strcmp("process", key))
-		return git_config_string(&drv->process, var, value);
+		if (!strcmp("process", key))
+			return git_config_string(&drv->process, var, value);
 
-	if (!strcmp("required", key)) {
-		drv->required = git_config_bool(var, value);
-		return 0;
+		if (!strcmp("required", key)) {
+			drv->required = git_config_bool(var, value);
+			return 0;
+		}
 	}
 
 	return 0;
-- 
2.18.0

