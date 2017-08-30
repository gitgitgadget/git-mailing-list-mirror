Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDA4208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdH3HOy (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:14:54 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33003 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdH3HOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:14:53 -0400
Received: by mail-pg0-f66.google.com with SMTP id m15so4509096pgc.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f9i8l2aw1fJ8jJQQ+JiDQ/XsAHwl9CZ/jq2VIgmLkks=;
        b=fqhRbeJ/Y4bKKP3NVkxMsKNvScf4si+uYYzmo+2Ja0bnXNnq5tNOqE2z3D8WqGaKUJ
         9zx2Ss3F70VazCF13dLNaphvoWGXD7D4o3g6ct+jHBfsm1pSnS2qrxX+J8c28zOc35Gu
         XS5mxFiSM+ZCIedAYGNIfxPZtD7GdjR2S4cNd9POCrt6f6pWQLouzOmWd3n9gYpCKR7R
         Samf82YVTkgMhvYGC/t3rPxF3wRbFndhIamem44DfB57+n7wOsC6NoOuatFDXQJBKV4F
         7P07HFtHGxOuyPCAevzt3sFw4XpPTiTZdkaZHgvKu7aU1dub4s2vwNCXAzpGqMGukv36
         MoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f9i8l2aw1fJ8jJQQ+JiDQ/XsAHwl9CZ/jq2VIgmLkks=;
        b=tRPmUb2E7kHLf3MpUUJcnTu9G7wLG3zy0RIz7p7ldz8iGkYo3zgIdbi3mK1iWNBiUQ
         uvU+xgfmS+oHFmXYIw106bxOfUZdXtU88NxueimgwaZfW/myK4uD3AQcXKrH9dlC6781
         /DjXRgY31E5nXjfX68Dcq7AMmjtl5QV6Po6vxQiUc7oAfgLlzO5Jq3Iz9Abrhq/lEnb3
         jmot3qBwi7hcZBvpgYkbGIbtTLS4sdkZL3M/dZRKEteOPIOMDgENBrPrZvlvEe1Ipbmq
         YSz5Nv2Ag6r1twdNI527qC6/YBhXGp5vZrmeFp9ip2L38hdNK+LG1FnSnXEjMRBBCIWL
         KXkQ==
X-Gm-Message-State: AHYfb5hEwyO++P4Nde1Qzt4PcX/6xl1ysJaTn3yJ2zwWwUnarZWqBncX
        2sPNYegmtZqZuJt0BJI=
X-Received: by 10.99.108.199 with SMTP id h190mr599293pgc.195.1504077292999;
        Wed, 30 Aug 2017 00:14:52 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id e188sm7620548pgc.17.2017.08.30.00.14.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:14:52 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:14:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 34/39] pack: allow sha1_file_name to handle arbitrary
 repositories
Message-ID: <20170830071450.GI153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
index 518da80367..fe2187fd65 100644
--- a/object-store.h
+++ b/object-store.h
@@ -60,8 +60,7 @@ struct packed_git {
  * The return value is a pointer to a statically allocated buffer that
  * is overwritten each time the function is called.
  */
-#define sha1_file_name(r, s) sha1_file_name_##r(s)
-extern const char *sha1_file_name_the_repository(const unsigned char *sha1);
+extern const char *sha1_file_name(struct repository *r, const unsigned char *sha1);
 #define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
 extern void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
 
diff --git a/sha1_file.c b/sha1_file.c
index 81bc1ab309..ac57eea0f2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -254,12 +254,12 @@ static void fill_sha1_path(struct strbuf *buf, const unsigned char *sha1)
 	}
 }
 
-const char *sha1_file_name_the_repository(const unsigned char *sha1)
+const char *sha1_file_name(struct repository *r, const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
 
 	strbuf_reset(&buf);
-	strbuf_addf(&buf, "%s/", get_object_directory());
+	strbuf_addf(&buf, "%s/", r->objectdir);
 
 	fill_sha1_path(&buf, sha1);
 	return buf.buf;
-- 
2.14.1.581.gf28d330327

