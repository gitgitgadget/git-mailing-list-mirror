Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 888FA1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbeBFAFs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:05:48 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37116 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeBFAFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:05:39 -0500
Received: by mail-pl0-f66.google.com with SMTP id ay8so102064plb.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IQzM1eww+ziN2AxWmQTXODDhxwUjWtCDfuGqS6VnPv4=;
        b=HJeo7dRhy9JL5TjkbQGyO+kbIXuka52Ohi/OPJ2kaoEz5DNF9aRENacmLomizzOVge
         xVySScBNlOTmzy507VZx3n60UFpmDQriKEgg9ahIkUqcU0FqlHrzY9Iv9Xu6ZXIopAfv
         lMkYlP0gbVS9JUB5RtthGPWe52/7OwOXC6FOgLUCj+s7w5SYiE5ac8NdcV/a/O0EYb7c
         yK3TktVrOQjSy6JYDWosmOSaM2hgROmFF9h1xuOWNb+5YOHBiBvjqDFB3zKcRofmpJJs
         QkFXEN4uGfqztibmD1paFFmPdLZJCZV/WnxDfsdlT2bNJpQ1X4npQ2p3z5PCcC9t1Xow
         Oxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IQzM1eww+ziN2AxWmQTXODDhxwUjWtCDfuGqS6VnPv4=;
        b=Kt5hxtq9PUxuV6OnQA3D0ypOX2gjdtcSd1A9/iRRcVqUHz6GQmOpSmUa5kpj0toF5d
         PtOY3g/RuEYACWvcgsarHVSooleCXCP3ne6nqPgzDzhV+ZU2IYwdQK0V8illLmqWIQZ6
         JR0z+It8nW4iahO6+KqoIGCBADx8V0lHjDeCumO48kGWZlvd3I6dvWNXpmli5io9hlN9
         AFyUSOIY3bnwfF/2IREaSUOP+JjxdFhbYFoLH70juK7EIjx56mnTR0K0fLdgK6vsE0Up
         2YZlacvmpWT67fEKNVLRi/fnX+Xp4pBhwRgNgcZ/7TUAYJHqFJ6RudgrcayObfrC+yHS
         chUQ==
X-Gm-Message-State: APf1xPCr5VD+HbiXCIfy/jgKT22Vb92Iv6aHLbQUTWZGd2+H0uV3uGU9
        YvvoLfPQOhFdXcno4y3oHUufrr6nstI=
X-Google-Smtp-Source: AH8x226jM7I4eQgHnzw6Pvh+EW0M0gG0/w1KS+zEbo1NgTrzjVniKZOXF+VXMOYsTyecjq5cZ6UjYQ==
X-Received: by 2002:a17:902:1703:: with SMTP id i3-v6mr500748pli.145.1517875538754;
        Mon, 05 Feb 2018 16:05:38 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id i128sm18588139pfg.83.2018.02.05.16.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:05:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 056/194] replace-object: allow replace_object_pos to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:55:17 -0800
Message-Id: <20180205235735.216710-36-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 4a07f82aa0..c30bee2e69 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -11,12 +11,10 @@ static const unsigned char *replace_sha1_access(size_t index, void *table)
 	return replace[index]->original;
 }
 
-#define replace_object_pos(r, s) \
-	replace_object_pos_##r(s)
-static int replace_object_pos_the_repository(const unsigned char *sha1)
+static int replace_object_pos(struct repository *r, const unsigned char *sha1)
 {
-	return sha1_pos(sha1, the_repository->objects.replacements.items,
-			the_repository->objects.replacements.nr,
+	return sha1_pos(sha1, r->objects.replacements.items,
+			r->objects.replacements.nr,
 			replace_sha1_access);
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

