Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D036B1FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 23:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbdFHXl4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 19:41:56 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35088 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbdFHXly (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 19:41:54 -0400
Received: by mail-pf0-f178.google.com with SMTP id l89so22167877pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nYl3uyh3DMKGk5F15DL1kEuhjzU6qGnCjft4ttg1JIQ=;
        b=CYsx37zlTGFMsEn4uRVhAeBbFOqlZhr+OKCaedcDQdofyX2RDe1MtO9K5xGDzJZHYo
         qDXY0y+jBTc6Yg2cfFAjmxmDIZZOFvDBUDKKaKolTWYziaza9T/bkGlyvKD5OFxbxbD9
         vLLzOSuQmagm+V5Rmh8N6WxR5B/W8E38dsmLomTG+nuNK+zvzkhoXxgjsHT8kBTVmXVX
         NR787byJvlLWrBAYgQhlnWTZ25SO3WnEyf4eZ+CzTbeld8PPxaLlPUjF9iaD0tc09CiL
         PN4/7LcMA71OxlPNqskLYrDQjNpMKVlrjFIf6lJIlXkSRjVL0doKs+2iPp3M/c86cQh9
         xOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nYl3uyh3DMKGk5F15DL1kEuhjzU6qGnCjft4ttg1JIQ=;
        b=iQCvQbOzy2g9npo+JQLiUAzK9vqdNn9+weD5SEGPQTt7N5WKuq1QMFfbO6/bccYEnQ
         seaCnCxqsmrvSr5WB6ICo1CFUAGOKFFkxFWpbsQPGHmWxyPnqjgpONqKB46UpQReUBvf
         sgKSRxM8a6VXiMix0Vwepecg/mrstGxGWnKrvYWFDFVEYquUs7YFpJiwulJQfQahg+Tp
         Y0iUNt+/u+rTCyX4CeNb/ELrZ7/+kIPVLu7+Qir+zI/VZpAqBbungexkQZdHS9+DwHd1
         SYfdkYxlAZ0by6YZxbA7NDkrm8wtCrHzRb+0j+Nid7DRE2fj+dV6qhlGyXepmEifaO1/
         Riqg==
X-Gm-Message-State: AODbwcBtkrTYIQkPc6YRve7cdL7f4fus+zgkcp37rJl6Fx9IXSqpSxic
        OLuAYUewbducIjPX9iwhXQ==
X-Received: by 10.84.178.129 with SMTP id z1mr37027736plb.171.1496965313639;
        Thu, 08 Jun 2017 16:41:53 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m65sm11745237pfg.94.2017.06.08.16.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 16:41:52 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 23/32] ls-files: convert write_eolinfo to take an index
Date:   Thu,  8 Jun 2017 16:40:51 -0700
Message-Id: <20170608234100.188529-24-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.508.gb3defc5cc-goog
In-Reply-To: <20170608234100.188529-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a5ceeb052..c37e9de11 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -54,17 +54,16 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_eolinfo(const struct cache_entry *ce, const char *path)
+static void write_eolinfo(const struct index_state *istate,
+			  const struct cache_entry *ce, const char *path)
 {
-	if (!show_eol)
-		return;
-	else {
+	if (show_eol) {
 		struct stat st;
 		const char *i_txt = "";
 		const char *w_txt = "";
 		const char *a_txt = get_convert_attr_ascii(path);
 		if (ce && S_ISREG(ce->ce_mode))
-			i_txt = get_cached_convert_stats_ascii(&the_index,
+			i_txt = get_cached_convert_stats_ascii(istate,
 							       ce->name);
 		if (!lstat(path, &st) && S_ISREG(st.st_mode))
 			w_txt = get_wt_convert_stats_ascii(path);
@@ -106,7 +105,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_eolinfo(NULL, ent->name);
+	write_eolinfo(NULL, NULL, ent->name);
 	write_name(ent->name);
 }
 
@@ -276,7 +275,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 			       find_unique_abbrev(ce->oid.hash, abbrev),
 			       ce_stage(ce));
 		}
-		write_eolinfo(ce, ce->name);
+		write_eolinfo(&the_index, ce, ce->name);
 		write_name(ce->name);
 		if (debug_mode) {
 			const struct stat_data *sd = &ce->ce_stat_data;
-- 
2.13.1.508.gb3defc5cc-goog

