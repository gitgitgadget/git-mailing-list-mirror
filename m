Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9E61F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeBFAWU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:22:20 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42137 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeBFAWS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:22:18 -0500
Received: by mail-pl0-f65.google.com with SMTP id 11so120355plc.9
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2X53XxCpZyEGbH6S4W+ANAmn3crFMAbaewublQZLaIo=;
        b=CYZBH3K0Ztjb8CYg5VJYgUYZDP9WmWqi+Y5KG7WRZFco54/SwT/bbhDX9kWgx+DLqM
         KvqBTWcoFDcBpzhIPKZjoiNhR6gKS8k5b9eFv2meND1hIorDUQBaG/RKXzIEP5QMZxVY
         /LBWh9CwWp7F3tmbelw+KJ21Xn+6/WUPMAHReAGRoVnnluWnZtdK9P4hHSBlq2x5zmG8
         UkI/D1qTsJn5bKeDEx82c7Nb1KtOJE2PJ9uDSE47ibelYPt7c4ceTdxHygis6JzuocLh
         fl2oVzcMoEPT3jabUrFEm3k+cHINnHjg2S+tNBIHZPx18b5I1XElWW2AHyz1CcBoHEmj
         qQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2X53XxCpZyEGbH6S4W+ANAmn3crFMAbaewublQZLaIo=;
        b=GsCRJKmgrwOml8rCosNbq0YMww2Tqvf8nA6hDGbDoh9NP/6ItX/5fUnX1ATC5LLLGG
         NYfAI+Zi6w5r27DRpMe6aziGPYH6oT1Llkd2n+Y36koucbdvDGrt8o+9/NpYE3oeuPZa
         4Ox48pYvy/8DjdTxx7xm69xdYS/4i9f0uaDtnk8eLpr9LxIp+dbGz7EXbYZiMuLOlSvg
         TE55mweyQVlu7FhpCENYARvZ4ZkT6/MKqAAzU0SJgYNQyYsIUJPzzj1D02GIa7lSoFY/
         LILbGw3yL829TVY41aUE0O6huEfgpnW3/RWlg/wVLSSyQ2SV+IHAT9n6McsDJUF3fYzI
         3gsA==
X-Gm-Message-State: APf1xPDhikx/xNA47AJNwBRYj5VUTlLi+eNCvdHNeMZh7jH8yzOKafq6
        enJBzs53Wrn/hJxUtfu8yUReb8TdlSE=
X-Google-Smtp-Source: AH8x224BeFrUB5CVxnPvQqU7r4ER6VLyVsD0wSr2MGfQZ4leGEIWOauML7vT9+6UbHBEELgiBmv/3Q==
X-Received: by 2002:a17:902:44a4:: with SMTP id l33-v6mr542383pld.115.1517876537667;
        Mon, 05 Feb 2018 16:22:17 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p69sm19970176pfk.7.2018.02.05.16.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:22:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 126/194] streaming: allow open_istream to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:41 -0800
Message-Id: <20180206001749.218943-28-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 streaming.c | 11 ++++++-----
 streaming.h |  3 +--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/streaming.c b/streaming.c
index cd52f517eb..2373395afe 100644
--- a/streaming.c
+++ b/streaming.c
@@ -137,22 +137,23 @@ static enum input_source istream_source(struct repository *r,
 	}
 }
 
-struct git_istream *open_istream_the_repository(const unsigned char *sha1,
+struct git_istream *open_istream(struct repository *r,
+				 const unsigned char *sha1,
 				 enum object_type *type,
 				 unsigned long *size,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
 	struct object_info oi = OBJECT_INFO_INIT;
-	const unsigned char *real = lookup_replace_object(the_repository, sha1);
-	enum input_source src = istream_source(the_repository, real, type, &oi);
+	const unsigned char *real = lookup_replace_object(r, sha1);
+	enum input_source src = istream_source(r, real, type, &oi);
 
 	if (src < 0)
 		return NULL;
 
 	st = xmalloc(sizeof(*st));
-	if (open_istream_tbl[src](the_repository, st, &oi, real, type)) {
-		if (open_istream_incore(the_repository, st, &oi, real, type)) {
+	if (open_istream_tbl[src](r, st, &oi, real, type)) {
+		if (open_istream_incore(r, st, &oi, real, type)) {
 			free(st);
 			return NULL;
 		}
diff --git a/streaming.h b/streaming.h
index 9f4d5aeee2..cb36ce4c02 100644
--- a/streaming.h
+++ b/streaming.h
@@ -8,8 +8,7 @@
 /* opaque */
 struct git_istream;
 
-#define open_istream(r, s, t, sz, f) open_istream_##r(s, t, sz, f)
-extern struct git_istream *open_istream_the_repository(const unsigned char *, enum object_type *, unsigned long *, struct stream_filter *);
+extern struct git_istream *open_istream(struct repository *, const unsigned char *, enum object_type *, unsigned long *, struct stream_filter *);
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, void *, size_t);
 
-- 
2.15.1.433.g936d1b9894.dirty

