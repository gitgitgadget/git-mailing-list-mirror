Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F25C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 19:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237932AbiHVTvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 15:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbiHVTut (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 15:50:49 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174434DB08
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:46 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id e4so8954753qvr.2
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=arZxlmoQFLEphCbCK0kNlqnrKdx4dYYcctDBCHQpTIU=;
        b=b3ImRhFDw1xW161y7U1NBd8z/ZcZ0y9BfuZyo3FQAeRxaSSbCezFZZkveJsXUUxO46
         ch3o/Qdh95LSRaCKJaGdyUrLFaRTHNxSPvA+oQ0c6iCiNB32FRblvE7FpYFY5lgf/+bY
         PRDi31WE5nlIRneJblaMtmpN1M8xhmmYW6u0b2/JNeqLsZ9yIlJ6Sd90ot9y2GHIatWq
         /yo6U+9X0hq9Yg6EOwAAUXz1CSzs9rDUbj5MkE07aHLZLFHJQ9yEdTC2ptfLz4JNEQ1t
         daRZOCbAficUYzF/TTnnnmo5tF6Ws7OoPZ0OXliT4Yl5ubhIfm2pTWLsTIkgR9m7C6uS
         2RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=arZxlmoQFLEphCbCK0kNlqnrKdx4dYYcctDBCHQpTIU=;
        b=g7h4W4LROlUH9nlZ86amhQXU9ewHe5xrHkU/ofTKwUafvEHyDfRq59OCsrVmy0vMv3
         wYK3IX+4QeY8uu6XsjjVerUMSwcJZ9zbSy2BkWuOAPDKzeOeJYC14zrCli+EeXfmwZhd
         aliuhe1PJARFpHcTilDCvK3v4VAyC/TDcVukBgLWumcDI5SanltEu3OY2aFZFEaqv70E
         /bxdN6AGzyoXmfe1T8yCIlCzz9tEzvCgRqD2QvNx6Mf3DsYLj+qG53lZhfSK+GzMzF4/
         I94ZJ6cViWdxLOkq1EaqqfIZvMYmNwrInQNx8Gr7rIB2XlpGPSVPERJDAwSfg+n2vED2
         5tUw==
X-Gm-Message-State: ACgBeo3SjobRO7dNK/aQ1LRB5NFo09sb8orHys0Bd/GkKKtih7Fb114s
        1BVD8mILCxfVbek/AKka/NMluLnah0+K4ANk
X-Google-Smtp-Source: AA6agR7UMtL4wYg4nhlVWCtGbqQacNdltHB7XtGKP7dyBOrGwQ7b8nSi0cFL+vaW7ndwUAokDkZawQ==
X-Received: by 2002:ad4:5f8d:0:b0:496:d7c3:17eb with SMTP id jp13-20020ad45f8d000000b00496d7c317ebmr8012887qvb.114.1661197844989;
        Mon, 22 Aug 2022 12:50:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s19-20020a05622a019300b00342f97dc84fsm10225574qtw.76.2022.08.22.12.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:50:44 -0700 (PDT)
Date:   Mon, 22 Aug 2022 15:50:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH v2 5/7] midx.c: extract `midx_fanout_add_pack_fanout()`
Message-ID: <845e1484b49f88bdd64faec2b7e61eddf2e3045c.1661197803.git.me@ttaylorr.com>
References: <cover.1660944574.git.me@ttaylorr.com>
 <cover.1661197803.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1661197803.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a routine to add all objects whose object ID's first byte is
`cur_fanout` from a given pack (identified by its index into the `struct
pack_info` array maintained by the MIDX writing routine).

Unlike the previous extraction (for `midx_fanout_add_midx_fanout()`),
this function will be called twice, once for all new packs, and again
for the preferred pack (if it appears in an existing MIDX). The latter
change is to resolve the bug described a few patches ago, and will be
made in the subsequent commit.

Similar to the previous refactoring, this function also enhances the
readability of its caller in `get_sorted_entries()`.

Its functionality is unchanged in this commit.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/midx.c b/midx.c
index 0d40089c4d..be8186eec2 100644
--- a/midx.c
+++ b/midx.c
@@ -618,6 +618,31 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
 	}
 }
 
+static void midx_fanout_add_pack_fanout(struct midx_fanout *fanout,
+					struct pack_info *info,
+					uint32_t cur_pack,
+					int preferred,
+					uint32_t cur_fanout)
+{
+	struct packed_git *pack = info[cur_pack].p;
+	uint32_t start = 0, end;
+	uint32_t cur_object;
+
+	if (cur_fanout)
+		start = get_pack_fanout(pack, cur_fanout - 1);
+	end = get_pack_fanout(pack, cur_fanout);
+
+	for (cur_object = start; cur_object < end; cur_object++) {
+		midx_fanout_grow(fanout, fanout->nr + 1);
+		fill_pack_entry(cur_pack,
+				info[cur_pack].p,
+				cur_object,
+				&fanout->entries[fanout->nr],
+				preferred);
+		fanout->nr++;
+	}
+}
+
 /*
  * It is possible to artificially get into a state where there are many
  * duplicate copies of objects. That can create high memory pressure if
@@ -663,22 +688,10 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 						    cur_fanout);
 
 		for (cur_pack = start_pack; cur_pack < nr_packs; cur_pack++) {
-			uint32_t start = 0, end;
 			int preferred = cur_pack == preferred_pack;
-
-			if (cur_fanout)
-				start = get_pack_fanout(info[cur_pack].p, cur_fanout - 1);
-			end = get_pack_fanout(info[cur_pack].p, cur_fanout);
-
-			for (cur_object = start; cur_object < end; cur_object++) {
-				midx_fanout_grow(&fanout, fanout.nr + 1);
-				fill_pack_entry(cur_pack,
-						info[cur_pack].p,
-						cur_object,
-						&fanout.entries[fanout.nr],
-						preferred);
-				fanout.nr++;
-			}
+			midx_fanout_add_pack_fanout(&fanout,
+						    info, cur_pack,
+						    preferred, cur_fanout);
 		}
 
 		midx_fanout_sort(&fanout);
-- 
2.37.0.1.g1379af2e9d

