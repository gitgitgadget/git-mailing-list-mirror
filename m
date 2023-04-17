Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BC4C77B78
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDQU44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjDQU4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:56:41 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D3EC648
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:28 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-54fb615ac3dso219273367b3.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681764857; x=1684356857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEoLssQdCNMXu2B6skyMInK1O7b8/2PI/cmR41Be7RU=;
        b=NcnMv58NbqaqsNVAbSOS/Zz9yBK0pBnDEyj5q7F9mBrClUV7JCf+CezyvMszJG5C8r
         63bmEww3GNpIvPSNgCTS2PJ5BgPiF8TXaxDdvbaJVO/wK7q7UuBYW9nKJOmUfDxS/zeG
         WMGN9XOyTBSIvb3F6Omr1j2OnCZOht2dMUPoG8QdpB0z/wFrlc3SWE6zSlZUaqywthxz
         E2gYEfJyrdmrQu1+Vcf/wUi/BmZrk2Z55LG1XDmzj8/1Agz34f+TebIyk5Q8/MfV8weB
         JRVQV5DRKxdYkCTlJg4DkMck7eIUC/dUD6o9VPAJKqnViCxFqR0NWcb+o4X89jxVA8h4
         Ncqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764857; x=1684356857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEoLssQdCNMXu2B6skyMInK1O7b8/2PI/cmR41Be7RU=;
        b=IM8hJOX8ZYVD4y5rWtq8BZfOwxVBuwr2b33S/6DbdVJrN4oQZrcAmeHzlatkoqmyDk
         L3/ihIUKLvVNEarMB3W19MKwftQDHsMxy5e2UcASt/tEsCUHrD07o0FfbsCKN0Nmnokz
         6idtl9s4c/WB8/O0FbMmX7RmG/87lCKciAALjUjjVnM+VTAo8TpiUDD4+g/PZ82xT41J
         maNSgUdNFqXoyAIoEwXndBls91lD7NO4q4rGZ+rjq+EVKri6ydb1lAokCEcsJkwHFHa6
         +XOGuP8FfRHIUQ/RusPEYagaOOodT3TkNsTjkOfncgM0D2rJ1uIgSj4H8psDxzX4Dj17
         qTSQ==
X-Gm-Message-State: AAQBX9eiue33pKoePT9s7QCMkZDvKPls9rB0CWiT5NMGOvZgVTQ/TPX9
        3bCfWDHMCZF5avvZDr+fdN0sCthu+O+VhKw6DderBQ==
X-Google-Smtp-Source: AKy350YtW9WwhvCmxDl28dDIbv0ZCm8FG5rBmHZaSCO3skYY1z1xMeYGVNGZ7I9e4Mu8rgZI/aLqhQ==
X-Received: by 2002:a0d:cbc8:0:b0:552:a147:c50b with SMTP id n191-20020a0dcbc8000000b00552a147c50bmr10913724ywd.23.1681764856724;
        Mon, 17 Apr 2023 13:54:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 189-20020a8117c6000000b00545a08184b1sm3306277ywx.65.2023.04.17.13.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:54:16 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:54:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/10] pack-write.c: plug a leak in stage_tmp_packfiles()
Message-ID: <65ac7ed9b843a83f7b4cc0acd7b4e70d98ca20aa.1681764848.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
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
2.38.1

