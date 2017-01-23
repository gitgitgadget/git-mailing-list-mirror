Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7176620AC5
	for <e@80x24.org>; Mon, 23 Jan 2017 22:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbdAWWwn (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 17:52:43 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:36504 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdAWWwl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 17:52:41 -0500
Received: by mail-wj0-f195.google.com with SMTP id kq3so2872536wjc.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 14:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EDIdjho4zcpsk2up51iUZf7aOkQiuWRi8ekaaIeMiYM=;
        b=rEr0NHiDW3aXVYcsp3m4OjYkR9MUb1zkwVC/TMG4CN+BMOmCbPGULZB7OmlhubK9ef
         7ShrKN4TGAk2K3DoRwotxKRmP/msSjOEBv4bjgn4Z4sxRPXyqW2m6L4FdtkhKAG01o6l
         ZT3S0etmuNOY1kymGgpFWFZKSsyVBuOnN5wKVE/9PGDM8yRI8Hs1UmfgMaOnYZ37IF8Q
         IWpt5S40VdrcZolPGVpjTwiwOgYuvLKIyOPbEtUwn9sAwWbrCvSoC/9KaiNMZVo//nhG
         AIdAGhv5GGhQDuhQZobx7uXhhtSLeg4GaTEl/Uj1E9j2SUrCi4xyf+sDEugiNaDVRqCI
         frXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EDIdjho4zcpsk2up51iUZf7aOkQiuWRi8ekaaIeMiYM=;
        b=bblJ+2vWNVEyONRPO+127pXwjQoWqdNa3Ft7yZq4yNF9AODIqlUM2zvR8sl0yXKBM3
         GVN6RRmpA20YE2bhKR1/PNSmR4OAWwCH6uZLv+InO/4HQlEtbzwVRn6st17/0p2G8DO5
         8Da51QGIEyzMHptBPsmvuOUQQPobbABpUHeXAuGbrBSuoXMg9j0O566vLtpIFEagJz8l
         ooG5NOcTI+xVUNJRfBTwKYh4IBsSdk/WCSZPPBhd/57i6PUX14NeWWDYsRFbtO6dCUai
         e/D7QxJ8+z+HmfGy8tgcNwmqPc84xQFrvwPZbYikTNmNUbHuAbRyw56P/Qe8WMkoIETW
         J0BA==
X-Gm-Message-State: AIkVDXL68UM+NKdKMNG00tKfwHBItvlk2x1gjCKcvU8mw7jIU4JC5afmG/pB6ALd0R7MxA==
X-Received: by 10.223.168.111 with SMTP id l102mr25053995wrc.150.1485211959743;
        Mon, 23 Jan 2017 14:52:39 -0800 (PST)
Received: from localhost ([151.74.133.189])
        by smtp.gmail.com with ESMTPSA id k43sm16868306wrc.46.2017.01.23.14.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jan 2017 14:52:38 -0800 (PST)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 2/5] sequencer: save/load all options
Date:   Mon, 23 Jan 2017 23:52:18 +0100
Message-Id: <20170123225221.3659-3-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.11.0.616.gd72966cf44.dirty
In-Reply-To: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
References: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the missing replay_opts to save_opts and populate_opts, so that an
interrupted cherry-pick will continue with the same setup it had before
the interruption.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 sequencer.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 672c81b559..3d2f61c979 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -985,6 +985,14 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
 		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.rerere-autoupdate"))
+		opts->allow_rerere_auto = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.allow-empty"))
+		opts->allow_empty = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.allow-empty-message"))
+		opts->allow_empty_message = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.keep-redundant-commits"))
+		opts->keep_redundant_commits = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value);
 	else if (!strcmp(key, "options.gpg-sign"))
@@ -1233,6 +1241,14 @@ static int save_opts(struct replay_opts *opts)
 		res |= git_config_set_in_file_gently(opts_file, "options.signoff", "true");
 	if (opts->allow_ff)
 		res |= git_config_set_in_file_gently(opts_file, "options.allow-ff", "true");
+	if (opts->allow_rerere_auto)
+		res |= git_config_set_in_file_gently(opts_file, "options.rerere-autoupdate", "true");
+	if (opts->allow_empty)
+		res |= git_config_set_in_file_gently(opts_file, "options.allow-empty", "true");
+	if (opts->allow_empty_message)
+		res |= git_config_set_in_file_gently(opts_file, "options.allow-empty-message", "true");
+	if (opts->keep_redundant_commits)
+		res |= git_config_set_in_file_gently(opts_file, "options.keep-redundant-commits", "true");
 	if (opts->mainline) {
 		struct strbuf buf = STRBUF_INIT;
 		strbuf_addf(&buf, "%d", opts->mainline);
-- 
2.11.0.616.gd72966cf44.dirty

