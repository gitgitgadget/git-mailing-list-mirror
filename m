Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C4DC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjDRUkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjDRUkf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:40:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7E4A5CC
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:34 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54ee0b73e08so476888467b3.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850434; x=1684442434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GowqkZqJzwz5Wl6gCYv13LFGatPuqu0IDG+u/xSPVpI=;
        b=UUocnVVD/irqrJ0hmKF2a5Ba8spZoDzlx5ZyBOflnGTuBtr2jI6jySS3Qk+hLt4FZc
         C1ZO/JO4WbrLq/Ovek57Fqolz4bR0TV2BOjv3FbsbamW74QQE3gzri9OxVwKe+ItL9JK
         LMixRRUkmuXwHVDZZkgSVwTLNCBmjNEYF7drRqpBD3RK4tvvol2uO7k98ZuVWUWZWu6c
         eK33VMGcxz7JEha7Rw+gm+X3iuO48WnpyWcAcN1MdXmk22ZTrX5VWQSIT/C/ZmFadjgY
         rR2kOaSfMsoiXCt6lB1fMtzuswFrZztJHVPl1TSuc9pYbQ/mgY6vPJAooQ9vJ1ICXAo2
         dxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850434; x=1684442434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GowqkZqJzwz5Wl6gCYv13LFGatPuqu0IDG+u/xSPVpI=;
        b=cx2SrWnutLpkQ/P5cOdA8b36JK7MQoDZZ25+RYeo+mPirJcEjoEhCm0WRmkaQ1tQC0
         VJbLOhLZjR30gd0kP0AMB/j5Uwfs8xJsZdK2MOU7LzBstdeTQh/SgD5v3LTA1Pqw0D4S
         6zZK8WYRyUmjtjteowQD6/ZR2wmA8RfXzjrRwjc9JlJy+wx+GbuKTHrZ++8hV2fCiG9U
         oynnho7MT6gFVnWgltbdtdAOXA3y3nJyX7S4SKCjcN+A4Cl+RPoAbMDlzzaM1wofLrNm
         9edyZqwGZ+2McLQONt3xAfVF4hUk+RqCzP7ReZS9EVlk2A+xR7DxYsZSGsehsLkZjea2
         k8VQ==
X-Gm-Message-State: AAQBX9dE45LGedop6eTItYyubd825meec1w8r2kukHSY1Krm4fk3MgT/
        Y81YCW/AuS49YeOwuobyqZ8N7tXrssMJFcqO0lsULQ==
X-Google-Smtp-Source: AKy350a+ZDQBtoHCPAhypIiWwkrbC1+Or8qCDddLqqV23nDU1kmlZeKShu1mvjOFqcRQq4huhPZGkQ==
X-Received: by 2002:a0d:ef87:0:b0:551:11e7:30cc with SMTP id y129-20020a0def87000000b0055111e730ccmr947020ywe.22.1681850433967;
        Tue, 18 Apr 2023 13:40:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 4-20020a811204000000b0054f9e7fed7asm4054916yws.137.2023.04.18.13.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:40:33 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:40:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/10] pack-write.c: plug a leak in stage_tmp_packfiles()
Message-ID: <c477b754e7ddde0d6e696cfd4027ad88c18aeff3.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681850424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `stage_tmp_packfiles()` generates a filename to use for
staging the contents of what will become the pack's ".mtimes" file.

The name is generated in `write_mtimes_file()` and the result is
returned back to `stage_tmp_packfiles()` which uses it to rename the
temporary file into place via `rename_tmp_packfiles()`.

`write_mtimes_file()` returns a `const char *`, indicating that callers
are not expected to free its result (similar to, e.g., `oid_to_hex()`).
But callers are expected to free its result, so this return type is
incorrect.

Change the function's signature to return a non-const `char *`, and free
it at the end of `stage_tmp_packfiles()`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-write.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index f171405495..4da0ccc5f5 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -312,13 +312,13 @@ static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
 	hashwrite(f, hash, the_hash_algo->rawsz);
 }
 
-static const char *write_mtimes_file(struct packing_data *to_pack,
-				     struct pack_idx_entry **objects,
-				     uint32_t nr_objects,
-				     const unsigned char *hash)
+static char *write_mtimes_file(struct packing_data *to_pack,
+			       struct pack_idx_entry **objects,
+			       uint32_t nr_objects,
+			       const unsigned char *hash)
 {
 	struct strbuf tmp_file = STRBUF_INIT;
-	const char *mtimes_name;
+	char *mtimes_name;
 	struct hashfile *f;
 	int fd;
 
@@ -544,7 +544,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 			 char **idx_tmp_name)
 {
 	const char *rev_tmp_name = NULL;
-	const char *mtimes_tmp_name = NULL;
+	char *mtimes_tmp_name = NULL;
 
 	if (adjust_shared_perm(pack_tmp_name))
 		die_errno("unable to make temporary pack file readable");
@@ -568,6 +568,8 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 		rename_tmp_packfile(name_buffer, rev_tmp_name, "rev");
 	if (mtimes_tmp_name)
 		rename_tmp_packfile(name_buffer, mtimes_tmp_name, "mtimes");
+
+	free(mtimes_tmp_name);
 }
 
 void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
-- 
2.40.0.362.gc67ee7c2ff

