Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F877209FD
	for <e@80x24.org>; Thu, 25 May 2017 18:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424843AbdEYSgp (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 14:36:45 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35282 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938742AbdEYSgk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 14:36:40 -0400
Received: by mail-qk0-f195.google.com with SMTP id k74so31189462qke.2
        for <git@vger.kernel.org>; Thu, 25 May 2017 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0WgUAzKiInK+A9UZ16fadV0k65K5pKTfwX0mHKBHBwI=;
        b=FHTmFRnIDTO50ZawQLYtrvAQ3Lp8jYHNv2TzpTVzGmMBxI1NWMF+3p0XzsnbW1//Ll
         KbQKgYiEUtzpoArpKB1URVPLq+L/MQJnwK3e0QvUvgiXUlSTjFc7nfKiqpK+cC5SdGuj
         73zlugPCVihWTe9EF0Uf6GcMk56rvB9XPQ6D22pL6LFkGJVi9JWE16ndOYU3QKw3GAzt
         PhwkBOJyWozNlqRXtUMccg3xuNYpykIeHYZS9jVYupfPrtbRdQgGHQuyi62/3Mj5hMlw
         dBDJw/5g4xyOf+aiZFN8hyu94cKm68+kz5Cl42Sbx7yV/qkNzdMnjRrLjNolHpBe88xv
         VJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0WgUAzKiInK+A9UZ16fadV0k65K5pKTfwX0mHKBHBwI=;
        b=tshfFsq5JT+tIoDDkU1QOE7vNlvHNcTaC3YAgaeFCwB2LhuEVniiJXU0+oD8au+61/
         adP4VAs6lQUig/XaN+zmb8qo7GToD4lejUCuYDIFSASbMoMXfNCquQ5g64vyX65xkh9J
         DiOUEw+l3NJHYnIw+BP3blouArO0aRu6Ae8PLTne3wWKzDC3MwbFM5HvRvzKVSthSBKB
         NeQudHTXM3tBAeEjlYSbKh/+Q9w2CZhWhaFRhi7T4bOwXjOL+leW6TRP3HojQFRKLsLE
         hu6l0cNDiEh3PjSSLaHEn9Mxw+E/JX6xT9NekZAXr9rUovHSzOuqat2wqzpKQS52bMfS
         5lGQ==
X-Gm-Message-State: AODbwcB1oV3giziKRrcQGdxLf6hD0oH/2w8b2/58qduQEBulM52ew7OE
        e+Vze6DxIueIkg==
X-Received: by 10.233.221.129 with SMTP id r123mr23342399qkf.36.1495737399905;
        Thu, 25 May 2017 11:36:39 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id j66sm5089231qte.26.2017.05.25.11.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 May 2017 11:36:39 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v3 2/6] dir: make lookup_untracked() available outside of dir.c
Date:   Thu, 25 May 2017 14:36:08 -0400
Message-Id: <20170525183612.3128-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
In-Reply-To: <20170525183612.3128-1-benpeart@microsoft.com>
References: <20170525183612.3128-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the static qualifier from lookup_untracked() and make it
available to other modules by exporting it from dir.h.  This will be
used later when we need to find entries to mark 'fsmonitor dirty.'

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 dir.c | 2 +-
 dir.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f451bfa48c..1b5558fdf9 100644
--- a/dir.c
+++ b/dir.c
@@ -660,7 +660,7 @@ static void trim_trailing_spaces(char *buf)
  *
  * If "name" has the trailing slash, it'll be excluded in the search.
  */
-static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 						    struct untracked_cache_dir *dir,
 						    const char *name, int len)
 {
diff --git a/dir.h b/dir.h
index bf23a470af..9e387551bd 100644
--- a/dir.h
+++ b/dir.h
@@ -339,4 +339,7 @@ extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git
 extern void relocate_gitdir(const char *path,
 			    const char *old_git_dir,
 			    const char *new_git_dir);
+struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
+					     struct untracked_cache_dir *dir,
+					     const char *name, int len);
 #endif
-- 
2.13.0.windows.1.9.gc201c67b71

