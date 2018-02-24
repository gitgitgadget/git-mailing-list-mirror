Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C8B1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeBXAse (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:34 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35550 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeBXAsa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:30 -0500
Received: by mail-pl0-f66.google.com with SMTP id bb3so5851744plb.2
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0SrFhJs8t7j/CMWBwBosZ09fPFuxJ/Ej9Ay7L+0RvxA=;
        b=hdjENmJ4W/+of1oidFLl2WJFCmLELGfugP/IT7PbiuOHXxF6S+nG6VMHLl/WsQovIP
         X9/KZuyz+UIrmQrJerpxZtKPqfajlEtEN8bWsjzQdQNBX8xRLXbaA1nfL/ZhKfwaOK25
         4i0Gb7JqwGujMdTTHvvDPtNLfwObJ/inHVQmRdQMjMbm1StIfWbTJLkPeP8l7w9TzeM9
         oq+PamDN8pTrO8/ErtRHhGFvyoEizajG6WiraXWHypzlq8rDLtwf6t9BnJM0Tj7/18u7
         UduWpfX0gfLmWn3wTQUKQL8tab4MFzt2ISW2Iao/5JwsFAw7gEsWcIx6sr1GCYKHyDoL
         Azqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0SrFhJs8t7j/CMWBwBosZ09fPFuxJ/Ej9Ay7L+0RvxA=;
        b=Db5RX6yV0pMWlLVGUcSuKLeN/PGNB32+feaAjTS3m3oM+6odJQsSoakHB/t9d7DQVx
         cpg9dV9XyB4+oQCDQ7cdbuyl1Tk4kmlPC3M3QHwfvXFIArLsdtTDsN5HHC2DuA/tdz1X
         xXJOVcfmaQdmRYNjjKrquTU24/G02AWwKftvTDfs85KocA1iuYHCt4WV0a/46n/JE+1h
         5zXYOlgWmz9R0ZRbhZpgm153uqvHECGxnFyb9ZVJ3NycKAlmM6Kq+axxBXOaklk/ea92
         iE3IbtHAxfpnpHq+QV+uxPp5s8STwX1h6DYJYtNd9Mk3DMruac074nqsLfkn1bwPWmtv
         fsuQ==
X-Gm-Message-State: APf1xPB2hZUOs9cHNqAOFqKiAbb6IYWqMqaBt9r4LBi3YzZqMFAlgWAB
        P50IOxoP6SQhM9OCK95z7GBCiA==
X-Google-Smtp-Source: AH8x224dmwprFw4KSQ8sVYVXMUUAihzRWCKduKj8JxNuCSMksj2iDBkJXZHj7EREmvF16v/eKTs8Iw==
X-Received: by 2002:a17:902:8604:: with SMTP id f4-v6mr3325157plo.380.1519433309855;
        Fri, 23 Feb 2018 16:48:29 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id u85sm6945381pfi.80.2018.02.23.16.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:29 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 23/27] sha1_file: allow stat_sha1_file to handle arbitrary repositories
Date:   Fri, 23 Feb 2018 16:47:50 -0800
Message-Id: <20180224004754.129721-24-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 59993a0878d..952deb02195 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -869,23 +869,22 @@ int git_open_cloexec(const char *name, int flags)
  * Note that it may point to static storage and is only valid until another
  * call to sha1_file_name(), etc.
  */
-#define stat_sha1_file(r, s, st, p) stat_sha1_file_##r(s, st, p)
-static int stat_sha1_file_the_repository(const unsigned char *sha1,
-					 struct stat *st, const char **path)
+static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
+			  struct stat *st, const char **path)
 {
 	struct alternate_object_database *alt;
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	sha1_file_name(the_repository, &buf, sha1);
+	sha1_file_name(r, &buf, sha1);
 	*path = buf.buf;
 
 	if (!lstat(*path, st))
 		return 0;
 
-	prepare_alt_odb(the_repository);
+	prepare_alt_odb(r);
 	errno = ENOENT;
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		if (!lstat(*path, st))
 			return 0;
-- 
2.16.1.291.g4437f3f132-goog

