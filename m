Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F831F51C
	for <e@80x24.org>; Thu, 17 May 2018 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeEQTrN (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 15:47:13 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:42978 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQTrK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 15:47:10 -0400
Received: by mail-pf0-f179.google.com with SMTP id p14-v6so2579934pfh.9
        for <git@vger.kernel.org>; Thu, 17 May 2018 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sQ50byT9odCxerOSlwHfHjIx4fVwgngSKhyY3hv+InQ=;
        b=ayIuIUuK0PVYNxrqKLCS5DaxzJdX2ZBbz5jWFVGrv8sSIBMBBFxYvijaRebl1Hpwcr
         zY+Diwtfwoh8yXszWfXunfb4VUnbW0L8z/o1Pvxvu3wydRXAvjflVuF4l3G6nKQJ9/WQ
         nootxFEuwxy9gmq7R5xGXH4+GFu5rmWvLU0ABQcW1jAuchcEHZdHmmiUvK5q36QjdepI
         5aqPj3ACbPxdxewYI0Snhg9wC1TC2D1S/4ElxK66zbJM8A83ayDH9k0449XIwF+NgL1y
         ZbzyCLD3J9nCuvjqiM8654fU9WKa3uttZKsZQYO44wzPD0jvmYNysMceN8/PddrPsW1q
         G1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sQ50byT9odCxerOSlwHfHjIx4fVwgngSKhyY3hv+InQ=;
        b=e2lse0cMpPzx811e2Q8YMrBIddt7OSb8Jm/NY1mhPtFvmjnkndxbWtOLmZzO8cIQwD
         QCS2TUz66WgSnUrfRPDeDYxMV6rKpyTYj782dZQciAYg+yWWFjG/7YcrlqbpF8QPHd0g
         61bjsqq3OVBX4F0up/SW5a7O/hGaM+k6VyK1CBNZk3iPdF1v0O0YVP4uqf4rT9J45q6/
         PvTD4KWESgs/NjNfCdfau+qrGUN5nxWO+1OsUgB8K+hS7EHlCGYKZoHZbcGjV7i6buYc
         9EnE1nozWIXRPP02CTDBTl7ZPu1RgOMtZ/21J0XUp44NWZhKu0kOEJejOVr42FimwCFo
         7gpg==
X-Gm-Message-State: ALKqPwfVAfyqV9byepyzjuSAb6hNzLGzMqFeI5fNvRlqlARBmTDS3wZh
        SiJzwLfWVjv/Tm1aRSFPmjcQMA==
X-Google-Smtp-Source: AB8JxZrje5JPgeve5DOYUe9CE/aWRig+dnKo2T+GLc+oexEDXyGoJ4ZFW4Xbx/LijkxIjYmdewi8XQ==
X-Received: by 2002:a63:6703:: with SMTP id b3-v6mr4922288pgc.176.1526586429189;
        Thu, 17 May 2018 12:47:09 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y7-v6sm11058820pfy.52.2018.05.17.12.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 12:47:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com
Subject: [PATCH 4/8] diff.c: adjust hash function signature to match hashmap expectation
Date:   Thu, 17 May 2018 12:46:49 -0700
Message-Id: <20180517194653.48928-5-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <20180517194653.48928-1-sbeller@google.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
 <20180517194653.48928-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the follow up patch easier.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index ce7bedc1b92..d1bae900cdc 100644
--- a/diff.c
+++ b/diff.c
@@ -707,11 +707,15 @@ struct moved_entry {
 	struct moved_entry *next_line;
 };
 
-static int moved_entry_cmp(const struct diff_options *diffopt,
-			   const struct moved_entry *a,
-			   const struct moved_entry *b,
+static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
+			   const void *entry,
+			   const void *entry_or_key,
 			   const void *keydata)
 {
+	const struct diff_options *diffopt = hashmap_cmp_fn_data;
+	const struct moved_entry *a = entry;
+	const struct moved_entry *b = entry_or_key;
+
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
 				    diffopt->xdl_opts);
@@ -5534,10 +5538,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		if (o->color_moved) {
 			struct hashmap add_lines, del_lines;
 
-			hashmap_init(&del_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
-			hashmap_init(&add_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
+			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
+			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
-- 
2.17.0.582.gccdcbd54c44.dirty

