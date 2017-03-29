Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6578A20958
	for <e@80x24.org>; Wed, 29 Mar 2017 15:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbdC2PyJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 11:54:09 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34818 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932160AbdC2PyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 11:54:08 -0400
Received: by mail-qt0-f196.google.com with SMTP id r5so2537241qtb.2
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oPcp6BELrG51wL6HA93F0cE9gryCA90lecHXEqpyDzU=;
        b=CCoOFRRHupSGenenW5v/61WWPoWblBFBYH5SHHIlUfipoUdzrTOSMjHtoU1TvQYKt/
         Zn5VmPfM0FD/YM7bVOuhRROq/HNW89vGUpU70FptDoAsmi+TVbjD9UDaoydUjr0F2wm/
         OGCevIMOpe0i5bgalwlcUeapstXRcQ/rHXbrdBM1Wiks0Xgj4DeGSffNlOAI6FWFJbf2
         yabR2ftSHD+/FPT6Y0NCVCUNFvDLOEQSlqgTlXHoqzAY7+//y52K4QX2dusDhll9K5dX
         9GlRSieaJFdCx6Q2R0kogvfMsQLXIgWgvW8jIvE6WfCwmc4GIG4wHhGy8iSvB5jSMsOt
         k/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oPcp6BELrG51wL6HA93F0cE9gryCA90lecHXEqpyDzU=;
        b=Ehz6q6ddJoDKgRY5qVJS54e6uCZ07IQmc1a9THekEfXvBKHj8VyzHAnmvMcACwOFsd
         TJjh++5PlHPvk7SuuCtxLg/SQNI2fKKAdxPpyG/ZL9tfT9KcdfoLOCMrEmWJy2o70HSp
         xIzVooaiwGVhppk/876uz+A9KRuvfrtJRxGesD9cCD60H+IMTqw6ChO3fU+ip5DatqNr
         mWH8HUxB7VjIGNl0ps0jjXC7R7MDwqlE/YFUpLtxuJLz3szAdTgrVdaXVpBOSQoJ84Cl
         QdIqn7duTsDxD35jI00Su2D+bu7SYwU+ygw38zD6qQi3h61xagz0ZDbpQRuShHbMcWCi
         x1YQ==
X-Gm-Message-State: AFeK/H1pBn+tU5WQ57z3/FifdrOMYxfRUDtLEnhUxM8Xk9iQIHZSdmfipnz4ko5yz6DJOw==
X-Received: by 10.200.43.17 with SMTP id 17mr1199483qtu.199.1490802847210;
        Wed, 29 Mar 2017 08:54:07 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id o92sm5148566qkh.48.2017.03.29.08.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 08:54:06 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: [PATCH v3 2/8] convert: Update convert to use new packet_writel() function
Date:   Wed, 29 Mar 2017 11:53:24 -0400
Message-Id: <20170329155330.12860-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.1.gvfs.1.18.ge47db72
In-Reply-To: <20170329155330.12860-1-benpeart@microsoft.com>
References: <20170329155330.12860-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

convert.c had it's own packet_write_list() function that can now be
replaced with the new packet_writel() function from pkt-line.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 convert.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/convert.c b/convert.c
index 8d652bf27c..793c29ebfd 100644
--- a/convert.c
+++ b/convert.c
@@ -521,25 +521,6 @@ static struct cmd2process *find_multi_file_filter_entry(struct hashmap *hashmap,
 	return hashmap_get(hashmap, &key, NULL);
 }
 
-static int packet_write_list(int fd, const char *line, ...)
-{
-	va_list args;
-	int err;
-	va_start(args, line);
-	for (;;) {
-		if (!line)
-			break;
-		if (strlen(line) > LARGE_PACKET_DATA_MAX)
-			return -1;
-		err = packet_write_fmt_gently(fd, "%s\n", line);
-		if (err)
-			return err;
-		line = va_arg(args, const char*);
-	}
-	va_end(args);
-	return packet_flush_gently(fd);
-}
-
 static void read_multi_file_filter_status(int fd, struct strbuf *status)
 {
 	struct strbuf **pair;
@@ -616,7 +597,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
-	err = packet_write_list(process->in, "git-filter-client", "version=2", NULL);
+	err = packet_writel(process->in, "git-filter-client", "version=2", NULL);
 	if (err)
 		goto done;
 
@@ -632,7 +613,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
 	if (err)
 		goto done;
 
-	err = packet_write_list(process->in, "capability=clean", "capability=smudge", NULL);
+	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
 
 	for (;;) {
 		cap_buf = packet_read_line(process->out, NULL);
-- 
2.12.1.gvfs.1.18.ge47db72

