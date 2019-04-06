Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C8C20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDFLgr (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34221 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLgr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so4505503pgq.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mk/AggNO03fk2G0u4xF9XXptVhBAQp2iIFzsp49nKTY=;
        b=D/pgfBc/dmOn9rxZLdQpaOWBoeiOxDe7IjiBWBOHBAZ17DvcLkELvgSpcq5zTeo3jo
         7YsujW9mmlE0etY5FKC7JjelP+/Z2ozMlnhsoCoDNBcT84hAcoLRCSwrifMmjkGh53lh
         O3lXl3lvYgddj1JwmxsZV0JzbSMcbCfbhe/xq14rgJPVj6C+PJC33Ext3SlL+2m2nfDY
         w11jI2MLU4x4q7A/eMFfxJmgveNQJYAS6LuWeNcHOUV5ro1V86k/wxfOqLwo7velc7cf
         2XgzDepJtBD5Ba9fOFFydVcAEV6BSdZKm+eWg1ZQO0P/Qg3QVvpLgg2NzHPviHyjGQmQ
         Bicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mk/AggNO03fk2G0u4xF9XXptVhBAQp2iIFzsp49nKTY=;
        b=KkURqpsf7RR0DACAE+bygjaPTVLWKjf78rLHQ30QlP7t4B72a9GaZyDctcXfBXZykm
         WDS1bCb0INRQ2bov4jAgIIaCMLDxo7wjdQbRffGys8wt0+6zidEI4innii8aK43n1KL9
         MDz5VTiRrw6dL4rMqNlil3QoUlKAQt8Ad3T/6Hl4KJnyNe8l7Los7SyLrLrwKJwIFh9o
         +vUjdYkQ9a3ke6je4Cjt9YDcW19pkFnlFscP3IlaMW4/w/ZuIdGmM8QxLFSfO108i+Fs
         o2UryVZKBQLB7m972g4zUErC5eOuKKaJ5gHOP+dkZPMlDPWAOalT+kXPVM4+tlrrfNDJ
         3QTQ==
X-Gm-Message-State: APjAAAXbpTDkBuMeN7vh7MPrwxvjE33Z/GCSTE5zLpXgZZS0ZrDXGnEL
        j6gS/T4+X9uejCCIJOHHMcA=
X-Google-Smtp-Source: APXvYqxXNGgGEU6xNTJWRJoON3Zr2qsxwxrP/rezkOl77NusDvrMBTjHf16DJBgN/uNUtY0cX/i/0A==
X-Received: by 2002:a63:e845:: with SMTP id a5mr17857290pgk.246.1554550606714;
        Sat, 06 Apr 2019 04:36:46 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id l2sm24486212pgl.2.2019.04.06.04.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:46 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 17/33] sha1-name.c: remove the_repo from get_short_oid()
Date:   Sat,  6 Apr 2019 18:34:37 +0700
Message-Id: <20190406113453.5149-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index cdcf84b826..2643b75b54 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -436,7 +436,8 @@ static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
 	sort_ambiguous_repo = NULL;
 }
 
-static enum get_oid_result get_short_oid(const char *name, int len,
+static enum get_oid_result get_short_oid(struct repository *r,
+					 const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
 {
@@ -444,7 +445,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	struct disambiguate_state ds;
 	int quietly = !!(flags & GET_OID_QUIETLY);
 
-	if (init_object_disambiguation(the_repository, name, len, &ds) < 0)
+	if (init_object_disambiguation(r, name, len, &ds) < 0)
 		return -1;
 
 	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
@@ -482,8 +483,8 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 			ds.fn = NULL;
 
 		advise(_("The candidates are:"));
-		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		sort_ambiguous_oid_array(the_repository, &collect);
+		repo_for_each_abbrev(r, ds.hex_pfx, collect_ambiguous, &collect);
+		sort_ambiguous_oid_array(r, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
@@ -855,7 +856,8 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 
 	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_oid(str, len, &tmp_oid, GET_OID_QUIETLY)))
+	     !get_short_oid(the_repository,
+			    str, len, &tmp_oid, GET_OID_QUIETLY)))
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
@@ -1109,7 +1111,8 @@ static int get_describe_name(const char *name, int len, struct object_id *oid)
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
-				return get_short_oid(cp, len, oid, flags);
+				return get_short_oid(the_repository,
+						     cp, len, oid, flags);
 			}
 		}
 	}
@@ -1163,7 +1166,7 @@ static enum get_oid_result get_oid_1(const char *name, int len,
 	if (!ret)
 		return FOUND;
 
-	return get_short_oid(name, len, oid, lookup_flags);
+	return get_short_oid(the_repository, name, len, oid, lookup_flags);
 }
 
 /*
-- 
2.21.0.479.g47ac719cd3

