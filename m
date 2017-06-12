Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D92F320401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbdFLWPR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:15:17 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36242 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbdFLWOb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:31 -0400
Received: by mail-pg0-f43.google.com with SMTP id a70so50758831pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0nNnGcJpKdMlvxle39KLTxpYm7WioJwhvrnlqvMZMbA=;
        b=kLOFb5HYjV4deQZrwSaK0MmVM3M/oq9eGTEg+o2uUeU2r3zFesnCZIAOwCHlBN0OFf
         TxCYGGK6OtF4YrKINZe8YT2JEInt/DOd8XeASH/jlOxQmpj2jjUVb32SxEJZ87qG9eKr
         7VnL+f0mw97oqbmgYjdMnxtagWNf9LIj5Of022g34V0qJDLMoWPoouBM7YvmjladeW2r
         s9F6643dJB2IWeKn7Nocz+wxszPJib3s5RdnE/AefiYkNAJuKaTz6DvhGsvU62yuR7Qt
         DSInjwIaMYI6qT1Ptu0wN1fmh1QefTFcQ0ZPErYhSId8jnH500Fg/jjEKdPmpJgORHO1
         1yCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0nNnGcJpKdMlvxle39KLTxpYm7WioJwhvrnlqvMZMbA=;
        b=QprhnTf5jP8/95oRZAcsr3C2h6OGNQBH51VaoHsj0nGvF5+j1GnaVbs548o27+w/4q
         /HYjF1k4kPfeEe7VaxxDJI10gvGsttx5+JqDQ1nC2I0sBeYNRomBQF8GV2osxXH+TTrD
         fea6SYryWLa6+SyS+pz3c6tz5zmsLyVpg+p8Ck43Xrcm7hLb7LFG0iC1e+qwzYZVyQn7
         iMDlxtOgIlU3UG+v0wzLEw3R2LoRuW4dOwF21lJkruI5C5LmLToQ/tbW8OlZvE6TFCri
         goCdaKWSZpSvjWoW3ci4urrgpUNxc1qt6avP46lGX4w+ydG/MEJGnDO7FkJoTbvjdCI5
         J+Gg==
X-Gm-Message-State: AKS2vOxsWLPctX4WwjqIozHDDilnZhxz7WaWsCENc281cRUe/1lHtjSk
        h1p2KpkxdsrO0mPbaxwOIg==
X-Received: by 10.99.124.65 with SMTP id l1mr45224pgn.279.1497305670332;
        Mon, 12 Jun 2017 15:14:30 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:29 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 08/17] ls-files: convert write_eolinfo to take an index
Date:   Mon, 12 Jun 2017 15:13:59 -0700
Message-Id: <20170612221408.173876-9-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
In-Reply-To: <20170612221408.173876-1-bmwill@google.com>
References: <20170612221408.173876-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a78b291ab..8c3f3d8ca 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -53,17 +53,16 @@ static const char *tag_modified = "";
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
@@ -105,7 +104,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_eolinfo(NULL, ent->name);
+	write_eolinfo(NULL, NULL, ent->name);
 	write_name(ent->name);
 }
 
@@ -275,7 +274,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 			       find_unique_abbrev(ce->oid.hash, abbrev),
 			       ce_stage(ce));
 		}
-		write_eolinfo(ce, ce->name);
+		write_eolinfo(&the_index, ce, ce->name);
 		write_name(ce->name);
 		if (debug_mode) {
 			const struct stat_data *sd = &ce->ce_stat_data;
-- 
2.13.1.518.g3df882009-goog

