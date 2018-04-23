Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2DA1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932825AbeDWXnv (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:43:51 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39209 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932749AbeDWXnn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:43:43 -0400
Received: by mail-pg0-f68.google.com with SMTP id b9so9460455pgf.6
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ziv5AqzgKaZdx3w+jtKMy4uBdNXynUariux1wfmIjbE=;
        b=gust6hnAnF50LG9/A1EXBXh1c/vLD/hUaFvq4tcKjKuKJ7fJ10XdDybpX2y1zbT2bu
         CUtp0dBiyVGzp6XDP6RFNXHTar0S1Jqn++Rl5Av4ziFzKW0kmcTJ9h6YTGyXFtB4C5dU
         fGGCQTCG9FkZOlYaaOZIHBy0KbJ00JgBTqzFM9R1orlz8ITqjuxYRGzlmWQAP+BuPno5
         yh5EBun5acj4dYvjlZOKXXUno7mGdFJ+g22nElotCYKivpLXAK5zs7mLRnCxIwqDJWC9
         /JyJLAZTTGcalP+g6/Wa85afzuW8zr6xtIddj6Jug/tBnxTvzC4uErlsbKvd5yWJU1gM
         AzQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ziv5AqzgKaZdx3w+jtKMy4uBdNXynUariux1wfmIjbE=;
        b=NPRdvgFFpSUi3iv1ZaC/IXxIZfhh+AGbSf5f9iXgkL7ENOuoVpnCK2ofRk2t1g/IMG
         HT/H71dNwllUmhpqwUoaXnAnjvEHyys0Wdb+bmlHDFRUYDHkN2YydexJXxCyualouDBw
         okhGtVOY9d/hD9/1gOvLBefRGGhlIbkvvK+bF0MOnlTUGr5PalLjv/mp3BSGYxASVruR
         l78grm23UdMZu1f9LZ0ogDggtkNI+a/q3vzeE+wlTCG5bE/weI5bYGOH5aI7049+qV8X
         Wj3vtoXEwEzW04qDsgiAZ3hdh46VEnEcwA+QWZjJFilSya/pLCo45oOHGd/b/x92bx9J
         03CA==
X-Gm-Message-State: ALQs6tBgzlaj2Z2KbJVT6fc6kygc5XNiwngOTq0ggGjXMKHjz1cj6tif
        QaShrC7XaNEhKkI43z6RyBtJS1SGs2k=
X-Google-Smtp-Source: AIpwx4/XOiAf0myTyhC2Uc7hjGlbiXSyiZogAxhZx9gZLapiXeAuD6Di5TEKku0cSFvS7ADvp4Sz3g==
X-Received: by 10.98.14.198 with SMTP id 67mr17452731pfo.36.1524527022221;
        Mon, 23 Apr 2018 16:43:42 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id y7sm26779526pfy.55.2018.04.23.16.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:43:41 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 8/9] packfile: add repository argument to cache_or_unpack_entry
Date:   Mon, 23 Apr 2018 16:43:26 -0700
Message-Id: <20180423234327.250484-9-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180423234327.250484-1-sbeller@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of cache_or_unpack_entry
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/packfile.c b/packfile.c
index d5ac48ef18..8de87f904b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1272,7 +1272,8 @@ static void detach_delta_base_cache_entry(struct delta_base_cache_entry *ent)
 	free(ent);
 }
 
-static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
+#define cache_or_unpack_entry(r, p, bo, bs, t) cache_or_unpack_entry_##r(p, bo, bs, t)
+static void *cache_or_unpack_entry_the_repository(struct packed_git *p, off_t base_offset,
 	unsigned long *base_size, enum object_type *type)
 {
 	struct delta_base_cache_entry *ent;
@@ -1346,7 +1347,7 @@ int packed_object_info_the_repository(struct packed_git *p, off_t obj_offset,
 	 * a "real" type later if the caller is interested.
 	 */
 	if (oi->contentp) {
-		*oi->contentp = cache_or_unpack_entry(p, obj_offset, oi->sizep,
+		*oi->contentp = cache_or_unpack_entry(the_repository, p, obj_offset, oi->sizep,
 						      &type);
 		if (!*oi->contentp)
 			type = OBJ_BAD;
-- 
2.17.0.484.g0c8726318c-goog

