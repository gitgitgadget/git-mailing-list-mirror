Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C95201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932652AbdERXWv (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:51 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35334 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755001AbdERXWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:37 -0400
Received: by mail-pg0-f46.google.com with SMTP id q125so29494670pgq.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qkjB/OEShIBuZ2WbXsSbux1vQEUs5InZFHE2oPxNMYs=;
        b=o+VI1/Edq118XTmCuVftTIRMELq5U56KbiEaNP23D/43pTLbvaGuYGxdz0p2rPnqGW
         mjqGitKO2lp1NCpAi7J1fAhvDR6DeNvI/ekns3e6vmksgLgjSEUWHYwp/m432gGrFrWa
         p9UK26Ld3YfG3AXZsfXY8FdC6ItLNI5KpBtzPf85MplAOCrbgHG1IyckTxH5x1FauD/m
         pPO1EXeJd/e8cnA4ygfBo60VLCEftm0f4euWGSIhQa+AQMepkTG4emIs8hntjoYhI7Kp
         Hp4De+TNfeKulf1b78K/b7yAWveTjB46bqQLaTinQbKl4I+VU6DScUWcDD2s+sSuQYz0
         MEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qkjB/OEShIBuZ2WbXsSbux1vQEUs5InZFHE2oPxNMYs=;
        b=sw+9fR5E/qUcwdDaBOtVkRSFQ6H+g3CtbNEJRntZf+vJ/Ck2NkktO+yTJ9UKbQpXMs
         sa23ZZlul3IMoVH2RQ1rpegB7Z+uixIKW8zlVon62yLhdyhsqNhUiZuQIxWRMl6au9Zz
         A4kkd3lh/79t80R1qDYVziwt7gDheFAv806t2ucb61AmwP7c3K5vIh44pnjOQ1BOrgtf
         SoZZkWgvUcis9pPtFEhmbIkp1PC5ZjYq/teKd8iZLrOJiRiSf6iUeERL6aQvz8en4Wsx
         fu4jAsQ0402uRgP+y8nV/HwxUiQZO6ZVCVtiBeuQHZVdTdB9TnYHr1nqDbhDPeapJVq4
         zgBw==
X-Gm-Message-State: AODbwcB0fu3JcgaVjHSfJ8ObyAO+tHiPhn5gVClO0SOv9MAxFzIrm3V3
        n3Rv3EbZxIKGXeWK
X-Received: by 10.84.196.164 with SMTP id l33mr7854323pld.0.1495149750723;
        Thu, 18 May 2017 16:22:30 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 16/23] ls-files: factor out tag calculation
Date:   Thu, 18 May 2017 16:21:27 -0700
Message-Id: <20170518232134.163059-17-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6603538ec..456df61e4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -93,6 +93,30 @@ static void write_name(const char *name)
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
@@ -263,22 +287,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
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
2.13.0.303.g4ebf302169-goog

