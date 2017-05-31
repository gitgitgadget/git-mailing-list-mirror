Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5669F1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdEaVpd (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:33 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33669 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbdEaVp0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:26 -0400
Received: by mail-pf0-f176.google.com with SMTP id e193so18629968pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IlupCx6djCCnydeTyipYPn/W1BL9i8ZOIXz7Ivg4R+4=;
        b=ovSIGrYr9cyFqQ53Q7NKYrkn3ki39dEKjB9luGNqLpbLPVqmqHfRwikGfe+Uz7iX7c
         xmoGb5G6k31wNoESzwFJjCF8Mm/jhaFwg5kZWPqZGMpam60tV3gAvlx1Sb04M2Vd8Eol
         rDq6Rdy/yA0bBqOlcU6iD6x/Gt8ArJpNzWQ7GtDjPuGmhEBEaNnI0gxB8eL9LwEW5PdT
         KP6ZwpDG+hR6uzzHFPzkeoG8Dgmju4g3RXaiINI1fPGDSzdGf0rB3raVRG5kx6IZ2mPY
         9Adn3X/n7uQMFrdZpadcxUK6F51/T6Ng6S/nI8MG0TLESotVbjPEjix8ZmYYB9S3UKS+
         Ly0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IlupCx6djCCnydeTyipYPn/W1BL9i8ZOIXz7Ivg4R+4=;
        b=l4cg4fDbIuIcwlQYXQDw+MPOoc6z1QNWJplzZe110NrignZeeH31NY23vOhpFWp4SQ
         48az15wGhsu4jNgPlz5V0Rz5BC/cmu640bTx9TF+alweiJsGxRAQwACN+7G1RrZFh7da
         iOAzz/gqsWqqN8P09yJ9ebusvO5czF9iKEC2mDySnkK1WQn0zcYmDwXWK3h9kEz01PkL
         zY/A/HJQo0BbsJ2ahWSiLxEl4gTYxtK/SUYbKUcL1kgr5fqhotF7Y8E5lGMmwHkuhBHC
         VQ0QYnn9+GMFrCpbEv6llSKXAwD3oXS5Qf5d77FnJskiEwzb1co5klHdl4j66AjO4Kpo
         2F9w==
X-Gm-Message-State: AODbwcBaa1/W8dBzMu5DOh0fPsahTo3lcFziGlVuNpHWPcu9wmL+FZn1
        iCQzNVA4cMkUidHO
X-Received: by 10.84.236.6 with SMTP id q6mr68412526plk.146.1496267121047;
        Wed, 31 May 2017 14:45:21 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:20 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 30/31] ls-files: factor out tag calculation
Date:   Wed, 31 May 2017 14:44:16 -0700
Message-Id: <20170531214417.38857-31-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 2849c9a65..6a0302a28 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -94,6 +94,30 @@ static void write_name(const char *name)
 	strbuf_release(&full_name);
 }
 
+static const char *get_tag(const struct cache_entry *ce, const char *tag)
+{
+	static char alttag[4];
+
+	if (tag && *tag && show_valid_bit && (ce->ce_flags & CE_VALID)) {
+		memcpy(alttag, tag, 3);
+
+		if (isalpha(tag[0])) {
+			alttag[0] = tolower(tag[0]);
+		} else if (tag[0] == '?') {
+			alttag[0] = '!';
+		} else {
+			alttag[0] = 'v';
+			alttag[1] = tag[0];
+			alttag[2] = ' ';
+			alttag[3] = 0;
+		}
+
+		tag = alttag;
+	}
+
+	return tag;
+}
+
 static void print_debug(const struct cache_entry *ce)
 {
 	if (debug_mode) {
@@ -264,22 +288,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 				  len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
-		if (tag && *tag && show_valid_bit &&
-		    (ce->ce_flags & CE_VALID)) {
-			static char alttag[4];
-			memcpy(alttag, tag, 3);
-			if (isalpha(tag[0]))
-				alttag[0] = tolower(tag[0]);
-			else if (tag[0] == '?')
-				alttag[0] = '!';
-			else {
-				alttag[0] = 'v';
-				alttag[1] = tag[0];
-				alttag[2] = ' ';
-				alttag[3] = 0;
-			}
-			tag = alttag;
-		}
+		tag = get_tag(ce, tag);
 
 		if (!show_stage) {
 			fputs(tag, stdout);
-- 
2.13.0.506.g27d5fe0cd-goog

