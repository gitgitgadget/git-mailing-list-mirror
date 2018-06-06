Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988661F403
	for <e@80x24.org>; Wed,  6 Jun 2018 07:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932279AbeFFHjv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 03:39:51 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44531 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932134AbeFFHjs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 03:39:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id 36-v6so7540115lfr.11
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 00:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=On6o8HUHOTTxiiS9KhMFX/PrBnZW6xB8vvPhBydwVB4=;
        b=g+lw3V+3Od7usS8M1PbWuT7LJN77Mb3Mmofy2H0aevaXk3nHdMVQpQRjBPsKe2ofgJ
         jk1hjs7DYCe9K1JIQz1O0cBZzl91ghZ3cbGeJQYKuQJcMVcrsp8RFc4PtsBneRYprtML
         vH7g98puXUy/FfXVrf8Bdueaqb5lGcxXdmdZDNGr0KM3qDd9tM3sQ89Y53sH7lIR4d3r
         0eNXMabTbiaKoKT0edWHU6fAf8OveSX4ny80o4QfgnqrQj10TOX6RaDQsC1ObVd1MRCw
         /ACNqN9h+YBvT36n69dvH/xEwsGy9MNW3Rc0EDCBNN/tC4zgyxcjLTd0+bLPJie8pbeH
         Xa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=On6o8HUHOTTxiiS9KhMFX/PrBnZW6xB8vvPhBydwVB4=;
        b=mELdFKfeM1pflUWBcUhQrSahMGa0LZ2k61na+k7nGSy3KgB9SRhEjDLoVG5IqsnjPj
         2r52UlQVNF82UX/lmYyXlu3PcA3LIMA6hdGDMsRIxxM7RbrQu3wZrPvn2S2hUaZHOApI
         AvZxL/Co++fhUHyznn3D5RLL3QJnhC61ySTbAuUI9Ud81p/XHOujfR+Q/HgyoYx2W4uk
         h5sR9G9yCMaJXL9ZZ4C722scRk8mOxo8vAjuc3tHMi8c+Ntjlf/PEi/7oNMXLiTmUZz6
         BYuBWk5uqX4CvpbIoq8L80S2h64Ty7vbryeGsrY7kwYFgOpWocLrQaurjASDdwAMsy8v
         NT+g==
X-Gm-Message-State: APt69E1bLcmq84vDlDP9kLCf9VqSg41mc8/o4Px0GusqnwHYfxJcZ39N
        EmGfBOtRwivpdIiZeAiqLYI=
X-Google-Smtp-Source: ADUXVKIC3gdTzsjynDDsYksqBaI82jYRFFfsEj40BQayAN4ViePqcp6OWS1RcFV3mkmDg1id1cCwcw==
X-Received: by 2002:a2e:8257:: with SMTP id j23-v6mr1228420ljh.1.1528270786674;
        Wed, 06 Jun 2018 00:39:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u3-v6sm4189048lji.4.2018.06.06.00.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 00:39:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, newren@gmail.com,
        ramsay@ramsayjones.plus.com
Subject: [PATCH v3 02/20] unpack-trees: add a note about path invalidation
Date:   Wed,  6 Jun 2018 09:39:15 +0200
Message-Id: <20180606073933.14755-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606073933.14755-1-pclouds@gmail.com>
References: <20180606050207.13556-1-pclouds@gmail.com>
 <20180606073933.14755-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 unpack-trees.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3a85a02a77..5d06aa9c98 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1545,6 +1545,17 @@ static int verify_uptodate_sparse(const struct cache_entry *ce,
 	return verify_uptodate_1(ce, o, ERROR_SPARSE_NOT_UPTODATE_FILE);
 }
 
+/*
+ * TODO: We should actually invalidate o->result, not src_index [1].
+ * But since cache tree and untracked cache both are not copied to
+ * o->result until unpacking is complete, we invalidate them on
+ * src_index instead with the assumption that they will be copied to
+ * dst_index at the end.
+ *
+ * [1] src_index->cache_tree is also used in unpack_callback() so if
+ * we invalidate o->result, we need to update it to use
+ * o->result.cache_tree as well.
+ */
 static void invalidate_ce_path(const struct cache_entry *ce,
 			       struct unpack_trees_options *o)
 {
-- 
2.18.0.rc0.333.g22e6ee6cdf

