Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD6B215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 23:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933465AbcJLXka (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 19:40:30 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32943 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932370AbcJLXk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 19:40:28 -0400
Received: by mail-pf0-f182.google.com with SMTP id 128so25740262pfz.0
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 16:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Ur2C7hwoFVPa5/Q2Mxe9mDOfRULVAMIByb1GhiZY1aM=;
        b=HFVIdYEoeAoq8g8GTUB5xJgt8ifv51SoC3+jZeLh16BhnIL5m4NNJX9KhnWq8uAApr
         fo4e5NPHYBLuw+BznvxTiNLRr2WyiYHuVH4UOUbAZPXfZ6ZiIlGkAxpQ4Huei15cmtH9
         caLX44l9n5Oo8mLo7NakKnXdXJwkTgRJ/Bi7kDBcsBEnfeFciJnEKK9vZgbaBJjldKjY
         +3ozxFW+NX6C/6W+PxPhAXoZStx4lQyPKT6M88VJWBqmemLV/b3+Y9vrETd8fWyUdoGo
         O2lmzJxNkt5Y5DSZysoh+jeab9fEPI3l9lB9NA3Lydm7hJayefFrpPGH54J9m9Lc3T4R
         jqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Ur2C7hwoFVPa5/Q2Mxe9mDOfRULVAMIByb1GhiZY1aM=;
        b=ZDtYYPYhH4DgTO7PzuU12gtVaBf7bWMa97MhoFgyuKakeDXajtPcPNPdWH//WmhvHk
         OLwaTu7VvOAMtYLE93TmJ4OIW2SAQp1Hvpf/T1idK9sHdPq1QwxmQEj/kvv6vEznDA44
         cVZDy40FPecewZALoPOrMwTgMZP4yytkDG+teicsEG9SJWNUKj8gVrN+Tha2YiMTe3Om
         ClgEDAeVtTnoCh09n3dZO4PnSFJIByiolcDR3fgA4HRz4p9rGK32nMENwIFTNIFPpTqK
         FDJinKnd94zQnIzeWH+Hl6VqREnVTFGqhUP+5HD6RL7w9MLvkouRri6SEI3HNI78YrHD
         v1Xg==
X-Gm-Message-State: AA6/9RlTj4j1GWSwBaaJtTE36B0sCsWAYRzlTIlLd10TguR22/WeaF4Bbz/+PaE3qCRMw2FP
X-Received: by 10.99.131.66 with SMTP id h63mr4658398pge.103.1476315626889;
        Wed, 12 Oct 2016 16:40:26 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id k67sm14294945pfb.86.2016.10.12.16.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 12 Oct 2016 16:40:25 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, christian.couder@gmail.com
Subject: [PATCH v2 1/6] trailer: improve const correctness
Date:   Wed, 12 Oct 2016 16:40:16 -0700
Message-Id: <4300c7b0aca2c07a9d65ae5a715ec66536461d1b.1476314576.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1476314576.git.jonathantanmy@google.com>
References: <cover.1476314576.git.jonathantanmy@google.com>
In-Reply-To: <cover.1476314576.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1476314576.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "const char *" to "char *" in struct trailer_item and in the
return value of apply_command (since those strings are owned strings).

Change "struct conf_info *" to "const struct conf_info *" (since that
struct is not modified).
---
 trailer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index c6ea9ac..1f191b2 100644
--- a/trailer.c
+++ b/trailer.c
@@ -27,8 +27,8 @@ static struct conf_info default_conf_info;
 struct trailer_item {
 	struct trailer_item *previous;
 	struct trailer_item *next;
-	const char *token;
-	const char *value;
+	char *token;
+	char *value;
 	struct conf_info conf;
 };
 
@@ -95,8 +95,8 @@ static void free_trailer_item(struct trailer_item *item)
 	free(item->conf.name);
 	free(item->conf.key);
 	free(item->conf.command);
-	free((char *)item->token);
-	free((char *)item->value);
+	free(item->token);
+	free(item->value);
 	free(item);
 }
 
@@ -215,13 +215,13 @@ static struct trailer_item *remove_first(struct trailer_item **first)
 	return item;
 }
 
-static const char *apply_command(const char *command, const char *arg)
+static char *apply_command(const char *command, const char *arg)
 {
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const char *argv[] = {NULL, NULL};
-	const char *result;
+	char *result;
 
 	strbuf_addstr(&cmd, command);
 	if (arg)
@@ -425,7 +425,7 @@ static int set_if_missing(struct conf_info *item, const char *value)
 	return 0;
 }
 
-static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
+static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
 {
 	*dst = *src;
 	if (src->name)
-- 
2.8.0.rc3.226.g39d4020

