Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1222F1FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdEaVp0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:45:26 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36076 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdEaVpW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:45:22 -0400
Received: by mail-pf0-f180.google.com with SMTP id m17so18555685pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KBFTpkg2WvFtRRV7NA8E/nfKYqJ6URskh9HQAr1j4j4=;
        b=HiJryjCBQAqj4onGjCHfo2SzyXTwmq4GFHh+n8sICVFunXsz5ww7rlgsSlrY5rmsvn
         R03igVtGs2nfnXZS/Za0pKGL1w0NT2/QT6N8w/B9QKSkMq1Jxc//nbY+2VKiaZBZ9pgI
         qM5KKKXgTgG9jri65p9blqfbuLfmwOPk2tJj3ysWE9dWPaKy5GqioovVI8UbVl4bdi0R
         TcdOLcxUv+8vPaaWg65+wuxCYWJ3MoA+gOryrC9MAc3nWpRU0cfmw7lSyZiYUs/VkLGO
         8YQkVyXMdWnPSoepqaalToGr1VyX7AG12Dw/GdaxY2vIw90NSeqlOmAKrHiUB9kvv2KC
         w3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KBFTpkg2WvFtRRV7NA8E/nfKYqJ6URskh9HQAr1j4j4=;
        b=g77YQpZtiI9y1mn5oz4lTi+h82KMBrYQYHw1QixeGQ2+Q/cX+z+cQ9QjWzTMR2xHVO
         iubUWfIYc2aza5LJf4UfAZUDiT1xGyBeK2n3mA1tbr8IKxjFLrRXRXU+DcSUsDTZEBc3
         DeFq0SNdf0r0G0+cGYsswQieKSWFtLWqbJL8+dHh3oXkzoygZLJ0egEnGulJQ0ORSExp
         KX75xHgZP+nMXv/mp/Q2LfAx9wTCg3uQSO/zoe0SjfMy/msCjchuEoPO7UD7pOSTmzus
         frh870mh3Xnrhl7NCfyIkPKegb1ruhCom30HRhHVZaWCWxnKqyfD3PWL24ID6U1mNzxk
         nR8w==
X-Gm-Message-State: AODbwcCdWEhAgGbxvPqrca9dE6gu69Eu+DBGDDqN0k/FfPy5zNHLGYo3
        1XU78Ljq58XJftGG
X-Received: by 10.84.233.199 with SMTP id m7mr92160318pln.108.1496267111231;
        Wed, 31 May 2017 14:45:11 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 187sm26952745pgj.66.2017.05.31.14.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 May 2017 14:45:10 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 24/31] ls-files: convert show_other_files to take an index
Date:   Wed, 31 May 2017 14:44:10 -0700
Message-Id: <20170531214417.38857-25-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170531214417.38857-1-bmwill@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f9578cf9f..d00ca7810 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -109,13 +109,14 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	write_name(ent->name);
 }
 
-static void show_other_files(struct dir_struct *dir)
+static void show_other_files(const struct index_state *istate,
+			     const struct dir_struct *dir)
 {
 	int i;
 
 	for (i = 0; i < dir->nr; i++) {
 		struct dir_entry *ent = dir->entries[i];
-		if (!cache_name_is_other(ent->name, ent->len))
+		if (!index_name_is_other(istate, ent->name, ent->len))
 			continue;
 		show_dir_entry(tag_other, ent);
 	}
@@ -337,7 +338,7 @@ static void show_files(struct dir_struct *dir)
 			dir->flags |= DIR_COLLECT_KILLED_ONLY;
 		fill_directory(dir, &the_index, &pathspec);
 		if (show_others)
-			show_other_files(dir);
+			show_other_files(&the_index, dir);
 		if (show_killed)
 			show_killed_files(&the_index, dir);
 	}
-- 
2.13.0.506.g27d5fe0cd-goog

