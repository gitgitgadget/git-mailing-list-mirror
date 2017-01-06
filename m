Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1DB20A99
	for <e@80x24.org>; Fri,  6 Jan 2017 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbdAFVEK (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 16:04:10 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34537 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbdAFVDf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 16:03:35 -0500
Received: by mail-pg0-f47.google.com with SMTP id 14so10476680pgg.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2017 13:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/+q1kosv1PqkYX6U7iuUH/oFlprs6kmGvX7qh9wU4H0=;
        b=Xv4kZW6L7qqoCnlOxHQDh0HgoPfCYFtPJCsF30Rgzr1CNwDvNBUqdh2CgmAw0O2CJ/
         r+tBZjw7BjAcm80se1dKuCbKE+D148o5PQTlc+IsstXNxJIc55T7eLIJYZXKT4FovtnG
         CwhOSsA0pgcENb9griI0kVeL4Grt58/npaLAPcOzfx94xXjDHf+iFA6FSWpVXA7AEh0o
         SVpadYB9SX8eMQU++2Xpu5UoGaAYARws48Wrr/r4XBA1Q2kpXLaQ+wUh1LMTyUow45zM
         lQ8gYBJ5hzyYjyxPpGGtru9SQz5WTh41ihnsxqUmHJIz641pjMPug+OP5D4LrIWu6G7t
         l+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/+q1kosv1PqkYX6U7iuUH/oFlprs6kmGvX7qh9wU4H0=;
        b=N0Mx10hsdtujgsurrbk1dBjxfLEYvgQ13JgUEA9/I90i11YxBdP5K+LAJ4ZoftUrBI
         5mgFy19ENw7gaufYuwxPxynC5KSL8kSNh+cpeAMfXVi1I9Y5jTofHDrbX/xTNkGLPv6m
         90P98D0ynyvhTIeQEwNz6OJXEJaGkkVUiLtkeYQMjjK810nEBf06aqJJuRb5RmD8k9qS
         itYs6dHxMTbudPteeVdYmp8mKTq30rsOXMUQLYiGOjFtajZzGbZs6YwvGsnyvlRugMrz
         tIyBdzJAUNXj5X9UojAvnAgvAY6852xp6g/vKWc1LTLih9LDGxLiYLlNqEHd1VFGY5gZ
         q0yQ==
X-Gm-Message-State: AIkVDXL7/it8Jwy7oiaDlVPoa1DI7oW5t8YfkFVRDFApMk28p7NrmssO+rNFfB+tAlQ6lRkR
X-Received: by 10.99.168.69 with SMTP id i5mr146162058pgp.10.1483736615059;
        Fri, 06 Jan 2017 13:03:35 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:b5c6:5d9b:cb8b:89ed])
        by smtp.gmail.com with ESMTPSA id t67sm161939406pfg.13.2017.01.06.13.03.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Jan 2017 13:03:34 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, l.s.r@web.de
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] unpack-trees: remove unneeded continue
Date:   Fri,  6 Jan 2017 13:03:27 -0800
Message-Id: <20170106210330.31761-3-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.31.g919a8d0.dirty
In-Reply-To: <20170106210330.31761-1-sbeller@google.com>
References: <CAGZ79kaM=Uosm7KAvAP-8w59Tyfc7LZiV3ZOr=PZnBgMCzr2AA@mail.gmail.com>
 <20170106210330.31761-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The continue is the last statement in the loop, so not needed.
This situation arose in 700e66d66 (2010-07-30, unpack-trees: let
read-tree -u remove index entries outside sparse area) when statements
after the continue were removed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 unpack-trees.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 55c75b4d6a..f16ef14294 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -272,31 +272,30 @@ static int check_updates(struct unpack_trees_options *o)
 
 		progress = start_progress_delay(_("Checking out files"),
 						total, 50, 1);
 		cnt = 0;
 	}
 
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKOUT, index);
 	for (i = 0; i < index->cache_nr; i++) {
 		const struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_WT_REMOVE) {
 			display_progress(progress, ++cnt);
 			if (o->update && !o->dry_run)
 				unlink_entry(ce);
-			continue;
 		}
 	}
 	remove_marked_cache_entries(index);
 	remove_scheduled_dirs();
 
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
 		if (ce->ce_flags & CE_UPDATE) {
 			if (ce->ce_flags & CE_WT_REMOVE)
 				die("BUG: both update and delete flags are set on %s",
 				    ce->name);
 			display_progress(progress, ++cnt);
 			ce->ce_flags &= ~CE_UPDATE;
 			if (o->update && !o->dry_run) {
-- 
2.11.0.31.g919a8d0.dirty

