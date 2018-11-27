Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 563F81F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbeK1DwK (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:52:10 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42199 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731585AbeK1DwD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:52:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so20689843lja.9
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xwVm2UlEISq0mOnHmT1GHMrl1Qe9fbMmKAMF4l/yts8=;
        b=hs4RESacump7uOQIUhfZMGNzFMHM1DzOeoBTzO46WV98u4QAqpo0dP/lFEL5M8if8d
         DrhesZXdi72GGkSseHp9oi9/EOVOOjM6atS/XXhDp4HVNY7LDlYJ0mvrSUV5O8YqP78c
         J5EecRadNURVMMM+xw/v5yRTTQQXFfV6wBKt7mA7dhdstmRh6IxkflpT9PeYXXJB9AMR
         TiPL03q4ixM3vVwKh5U1XM6v7ZD9Wtr+5Y2N173SL0CLIOZsJJd0hgHgIn7KEkdTXYFw
         ygbJDtI60DOiws5N/TgqtyD2KuwtxxaT5es75P/ggNO8mBGDQBE4eIv9e3iucZHewM3v
         F9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xwVm2UlEISq0mOnHmT1GHMrl1Qe9fbMmKAMF4l/yts8=;
        b=ncpvhLWjKIhdan3hOJC/HTX83sNS6it1bMRcXNjOykUebrmkF7kU9PZxnydTOcSgy2
         eKR36GN+XBr9Qunz9mEmNM2YFdLGKUqs11USQwmY1zhNMrWKk5Dkks3TJypeQDlZSY+p
         Y3SmLiZvgz/rY8IuqOrdLjDkO4+ooaBYsBA2rvjKORWCOXxxoymaIjk83QW+h5A9MS8g
         JwnNeYsPi4+bTzUA7oOWgTQbXD1piFzDCXdjxCk8epyqjsKTtJat1vUsHUk90wLnnI5k
         ZkWDkx3XbDfuCxTnmG/UWJw/AcQNwAJ8/FhKtB4RoL/5xciHB/H/Dtgb0u1AYsZHhR7Y
         VTpg==
X-Gm-Message-State: AA+aEWYrpv9SWqDhGKMfAFmgIST1cxqgRnilMzABp6vXzvs8FJDVd7rC
        PJ2ndpIUAkUVlomjT/Q1GXI=
X-Google-Smtp-Source: AFSGD/U0hCKufxnvsC6vjoYCNOIc6x88YvBTgCSMp7VLACr8/TMXKoOxmArdyfto9lifU6cEokMHdg==
X-Received: by 2002:a2e:99d7:: with SMTP id l23-v6mr19565108ljj.165.1543337611892;
        Tue, 27 Nov 2018 08:53:31 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm694016lfe.42.2018.11.27.08.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:53:31 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: [PATCH v2 4/7] checkout: move dwim_new_local_branch to checkout_opts
Date:   Tue, 27 Nov 2018 17:52:08 +0100
Message-Id: <20181127165211.24763-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181127165211.24763-1-pclouds@gmail.com>
References: <20181120174554.GA29910@duynguyen.home>
 <20181127165211.24763-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 211a347a0c..a50c51f287 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -44,6 +44,8 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	int dwim_new_local_branch;
+
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -1229,7 +1231,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	struct checkout_opts real_opts;
 	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
-	int dwim_new_local_branch = 1;
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
@@ -1259,7 +1260,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
+		OPT_HIDDEN_BOOL(0, "guess", &opts->dwim_new_local_branch,
 				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
@@ -1275,6 +1276,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
 	opts->show_progress = -1;
+	opts->dwim_new_local_branch = 1;
 
 	git_config(git_checkout_config, opts);
 
@@ -1339,7 +1341,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		struct object_id rev;
 		int dwim_ok =
 			!opts->patch_mode &&
-			dwim_new_local_branch &&
+			opts->dwim_new_local_branch &&
 			opts->track == BRANCH_TRACK_UNSPECIFIED &&
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-- 
2.19.1.1327.g328c130451.dirty

