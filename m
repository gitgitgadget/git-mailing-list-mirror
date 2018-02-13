Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4CC71F404
	for <e@80x24.org>; Tue, 13 Feb 2018 01:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933247AbeBMBXX (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 20:23:23 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38829 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933237AbeBMBXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 20:23:21 -0500
Received: by mail-pg0-f67.google.com with SMTP id l24so2708590pgc.5
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 17:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RK8asG1eQHkfA+SySd/GQWhxbitqjXuPJ0QrOc1bVTM=;
        b=uf945Ry88p8b+zPHyxt2VH72aLxCzx6qEuxUetEzfn/W/saxULNSkCFCoapaTW/Zhf
         uyNetV0ID+0Gml2M9SC+S8N55dyc2X0BdC30UXBDudBRaMbDCNkFoOklOC0IBpbZEUO1
         i4wUVE8ER1SwVM9kewf4uAYzuWKY7mIgpwq51as7xw3GaRYx6qV5pRf+OYNBDNwrZO7T
         FdyQiXUJzq/LKxIzBleM/iis8JJB4/XJmivn+cDk3jcNgLxs5HS65dPetVq6rONSZFPt
         1oiXzejNf4jMAS0VkNjYeDvgitw0hzuSDYrQ52ImL4IPgtTRN7lfwxm9qi4su64nS311
         gnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RK8asG1eQHkfA+SySd/GQWhxbitqjXuPJ0QrOc1bVTM=;
        b=e1Ya3muYzUI1ss5QK7gqHV8teGdCRVNok2AWeCTH7k+F7G2NeDY065/NukSZesfPiO
         89oZ1HHR2274nublifn/DnSNVhg93/WqhCYFxwL/FZQehvOGymsFndHxq/r4YCO9gLi/
         av650IC+muu5QWjIvD2XHDHd0EgiXHxol1XYBNsQBEiBNxmSkb8BoYRgs7Rw0Voobj+A
         Zu1BlgMCwq5lRbWBnZx9Ip9eBcxXLpE2gp663fj4eZmfZHZ+46jcMJXt3XgQ94Q7WIsA
         GBqT899tLqxUPDVluQNoUxy0dC5doUcFRG9CL0+A7RqM8T4GlfA7dRDJBiWfWY32EmrM
         FMFw==
X-Gm-Message-State: APf1xPDdmTD4Jc8LN95RpMOgEkQTrP/z5D07rZofuoMNE6W9ZEmQE7fc
        gi5RXoUqSkzqV4V61owk2wmRtg==
X-Google-Smtp-Source: AH8x225yY0eRIDucBT27FyNSbVz9s5R58Gw3XBzGNYtvaKiuYQdbuI5HFy4Fr76dILMYid+LVihvXA==
X-Received: by 10.101.92.138 with SMTP id a10mr10718516pgt.191.1518485000473;
        Mon, 12 Feb 2018 17:23:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id e23sm8080461pfm.125.2018.02.12.17.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 17:23:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 21/26] sha1_file: allow sha1_file_name to handle arbitrary repositories
Date:   Mon, 12 Feb 2018 17:22:36 -0800
Message-Id: <20180213012241.187007-22-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.73.ga2c3e9663f.dirty
In-Reply-To: <20180213012241.187007-1-sbeller@google.com>
References: <20180213012241.187007-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index 0a4561f476..b4756444bb 100644
--- a/object-store.h
+++ b/object-store.h
@@ -67,8 +67,7 @@ struct packed_git {
  * The return value is a pointer to a statically allocated buffer that
  * is overwritten each time the function is called.
  */
-#define sha1_file_name(r, s) sha1_file_name_##r(s)
-const char *sha1_file_name_the_repository(const unsigned char *sha1);
+const char *sha1_file_name(struct repository *r, const unsigned char *sha1);
 #define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
 void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
 
diff --git a/sha1_file.c b/sha1_file.c
index d0bc09a089..fddada5756 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -323,12 +323,12 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name_the_repository(const unsigned char *sha1)
+const char *sha1_file_name(struct repository *r, const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/", get_object_directory());
+	strbuf_addf(&buf, "%s/", r->objects.objectdir);
 
 	fill_sha1_path(&buf, sha1);
 	return buf.buf;
-- 
2.16.1.73.ga2c3e9663f.dirty

