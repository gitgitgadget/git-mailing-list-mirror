Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB31EC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6462067C
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 17:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HecCKN7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgCLRf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:35:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55282 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgCLRf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 13:35:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id n8so7019370wmc.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oBkCuqQf7Bv2JZM6IlmCzFSFgtxykB0NJw47ydxA4Yc=;
        b=HecCKN7HzqWVyUCPpKCNZN7CVTmtq/mASY1TJykeXPsHBK3hRdN51VeLj3tyYNLOwI
         gfbcUT6tWMGFC+VGSIae4aTnehkvWPWyuTg+kDubBHLbnhO28oJG44oBtSkq9JflG5db
         yTqWab5YYivujr9BsnmiUnHMXD9I5OoTjf4dzwK/NbjA2ed6TyDH3bM80lQqSJaRoso/
         idxQI9gEhWwx5ing+ffWtUuTb/7Gqlz/kb8wmjm9Byll3ffeyCh+83KmtqpJ4jPXV3vy
         A34PRVl+fXfx6AGbeKV7KY4Ji7JqiVjP/5ISI8VYxG1LkvI7oGNCIQbz8+W4pEOd2vTw
         9jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oBkCuqQf7Bv2JZM6IlmCzFSFgtxykB0NJw47ydxA4Yc=;
        b=ohfQkBwBGpN71Ine+H7GnlsVObxRuUHY809AO4dLv7nup60kmYus72pJbtyyQhcbEI
         TsfKVFBXTlC3zXt5KeB3R4Djai3L9UK4+f8aTsLbufWYG1gcXIZs3oeRMyKMYb6DWktT
         akY3SQcts8yGkYi9SiyCjSBm2ZAABMWe0nIbRFkONo7q/4ox37c8uKYaPyT753uPTjM6
         ocIT6bjzeEapGulZKm8VauxVGMMz0dfycWK3X4Rs07lR7UTsf1CcCu8AkoGXPwqYzWcM
         S9K+nIgDKKvxiMkYPNxia2CY6L8e6xs/nYc1gf/2nMjZh7Sw3B5eTkdQOY+T8+a52bC+
         CTRg==
X-Gm-Message-State: ANhLgQ2Z4LSou5bxa35rXDQ8r3NKyx+T41lp2VOfhcr1TGwVlrfJMWNB
        LsnLB/kZLMAb+npA7s49GNw=
X-Google-Smtp-Source: ADFU+vvGT1T6A4ajHdxPqEWBTWdOT/I0RbI9WAw54wxfAMTFFiIYx2idD+Us5sKwLuVQG+cYWzszAg==
X-Received: by 2002:a1c:c257:: with SMTP id s84mr6166997wmf.9.1584034553691;
        Thu, 12 Mar 2020 10:35:53 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id c5sm11900488wma.3.2020.03.12.10.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 10:35:53 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 1/1] midx.c: fix an integer overflow
Date:   Thu, 12 Mar 2020 18:35:20 +0100
Message-Id: <20200312173520.2401776-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
References: <20200228162450.1720795-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When verifying a midx index with 0 objects, the
    m->num_objects - 1
overflows to 4294967295.

Fix this both by checking that the midx contains at least one oid,
and also that we don't write any midx when there is no packfiles.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
Should I add a test? It is a bit troublesome to generate a zero object midx
file since this patch prevents it from using 'midx write'...

 midx.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/midx.c b/midx.c
index 1527e464a7..2cece7f9ea 100644
--- a/midx.c
+++ b/midx.c
@@ -923,6 +923,12 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	cur_chunk = 0;
 	num_chunks = large_offsets_needed ? 5 : 4;
 
+	if (packs.nr - dropped_packs == 0) {
+		error(_("no pack files to index."));
+		result = 1;
+		goto cleanup;
+	}
+
 	written = write_midx_header(f, num_chunks, packs.nr - dropped_packs);
 
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
@@ -1124,22 +1130,27 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 				    i, oid_fanout1, oid_fanout2, i + 1);
 	}
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
-						 m->num_objects - 1);
-	for (i = 0; i < m->num_objects - 1; i++) {
-		struct object_id oid1, oid2;
+	if (m->num_objects == 0)
+		midx_report(_("Warning: the midx contains no oid."));
+	else
+	{
+		if (flags & MIDX_PROGRESS)
+			progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
+							 m->num_objects - 1);
+		for (i = 0; i < m->num_objects - 1; i++) {
+			struct object_id oid1, oid2;
 
-		nth_midxed_object_oid(&oid1, m, i);
-		nth_midxed_object_oid(&oid2, m, i + 1);
+			nth_midxed_object_oid(&oid1, m, i);
+			nth_midxed_object_oid(&oid2, m, i + 1);
 
-		if (oidcmp(&oid1, &oid2) >= 0)
-			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
-				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
+			if (oidcmp(&oid1, &oid2) >= 0)
+				midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
+					    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
 
-		midx_display_sparse_progress(progress, i + 1);
+			midx_display_sparse_progress(progress, i + 1);
+		}
+		stop_progress(&progress);
 	}
-	stop_progress(&progress);
 
 	/*
 	 * Create an array mapping each object to its packfile id.  Sort it
-- 
Patched on top of v2.26.0-rc1-6-ga56d361f66 (git version 2.25.1)

