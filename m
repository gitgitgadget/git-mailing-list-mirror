Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFA7C77B6C
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 22:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDLWUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDLWUj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 18:20:39 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7069383C2
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:29 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54ee0b73e08so249763567b3.0
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681338028; x=1683930028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=veA3cT8nwAjRstGR+3jsN+Mqq+aC6f8PYllE4p98wu8=;
        b=bs7mjJhGTJTUSeLj9iGmXDSD9TiBdBolpFq9IxFGBweMxLd/APDFykVF/up7PVFMqB
         lqraEJwUdeXLiKGiRebM3j+3o8W+wPTmC8ovp/+vAuO4H/6hoTuhUbydyytTNcmAvp9q
         xBX2ti4GuLCaxibb9xai1DVuKXsrVm6KQFkht7Yx21bG/2P+0WP+FQBOHv9Bf92fgyzS
         KNeB1rFV0BsGRk1H92rJm8kXs1QxSBhHP/X35UNfT0pyYoCmPqqD6oB+ahQFEkgaqBKI
         5ZL5dMnJLEQK+bfvKJkWaLv6mjOz670tb3S3amc/m6KLnkflnvyY4VbagZFDo+aCtdka
         jKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681338028; x=1683930028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veA3cT8nwAjRstGR+3jsN+Mqq+aC6f8PYllE4p98wu8=;
        b=CJlQb+dCtgGI1uAr+0AhXwbwDMtXdTdBSlZT79KlQINVL+52pyHkY+O7fst84FWb0v
         GKi2g9XCb4o27h9WROSmosLX4UfTFFPg9Fms3Kb4IevSYklY/cNcrWFiTvOQyI/9uUUx
         q1P2Ly9Uqcd5cKR1B5Qax8C9jJy7vYeXgt3XqW07kNajQdSZFaL0MctufGuTyMfTfZ1D
         JSODwg7Q+cj7+CDGuHVDurRkHGk17aRfQi4xbOP9SNN6iib0UQJeXqa0ymLGPIJvT86K
         H296SsdTUmefABGLTs7i24r95m95nsJy0FII1hECT5SLA0uQUEP+TBxTlZprB3jq/slW
         4+pw==
X-Gm-Message-State: AAQBX9eAfEULmBI3HNnGj6GfIX1COKXdSA3Y/AOt245pEyCYkfJl25We
        a4470mdQIQzUKhJImyxLybSLlDbeNr7IXJytWnhgDQ==
X-Google-Smtp-Source: AKy350Zq8MB1AguzcFlZjph64ig5N9a73tQzvZy7GdRMGGaLB8Xmm3I9ZE0a3wlVl7gXPIxGubuS+Q==
X-Received: by 2002:a81:6a07:0:b0:541:876d:ae50 with SMTP id f7-20020a816a07000000b00541876dae50mr72550ywc.44.1681338028441;
        Wed, 12 Apr 2023 15:20:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d123-20020a811d81000000b0054f856bdc4dsm23824ywd.38.2023.04.12.15.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:20:28 -0700 (PDT)
Date:   Wed, 12 Apr 2023 18:20:27 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] pack-revindex: introduce
 GIT_TEST_REV_INDEX_DIE_ON_DISK
Message-ID: <8eec5bacd3a39d4d1586459f4a23422aff903139.1681338013.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <cover.1681338013.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681338013.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ec8e7760ac (pack-revindex: ensure that on-disk reverse indexes are
given precedence, 2021-01-25), we introduced
GIT_TEST_REV_INDEX_DIE_IN_MEMORY to abort the process when Git generated
a reverse index from scratch.

ec8e7760ac was about ensuring that Git prefers a .rev file when
available over generating the same information in memory from scratch.

In a subsequent patch, we'll introduce `pack.readReverseIndex`, which
may be used to disable reading ".rev" files when available. In order to
ensure that those files are indeed being ignored, introduce an analogous
option to abort the process when Git reads a ".rev" file from disk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 3 +++
 pack-revindex.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index e3d69cc0f7a..44e1b3fed95 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -205,6 +205,9 @@ static int load_revindex_from_disk(char *revindex_name,
 	size_t revindex_size;
 	struct revindex_header *hdr;
 
+	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_ON_DISK, 0))
+		die("dying as requested by '%s'", GIT_TEST_REV_INDEX_DIE_ON_DISK);
+
 	fd = git_open(revindex_name);
 
 	if (fd < 0) {
diff --git a/pack-revindex.h b/pack-revindex.h
index 3d1969ce8b9..ef8afee88b0 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -36,6 +36,7 @@
 
 #define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
 #define GIT_TEST_REV_INDEX_DIE_IN_MEMORY "GIT_TEST_REV_INDEX_DIE_IN_MEMORY"
+#define GIT_TEST_REV_INDEX_DIE_ON_DISK "GIT_TEST_REV_INDEX_DIE_ON_DISK"
 
 struct packed_git;
 struct multi_pack_index;
-- 
2.40.0.323.gedff6a80c63

