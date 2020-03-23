Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1178C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 22:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5BE2073E
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 22:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5aqlkt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCWWZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:25:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43120 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWWZb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 18:25:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id b2so19129548wrj.10
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erKMVXRRMKr2Wnj6FvDV9YZJSC0JpdFlqFYoAG3oJk8=;
        b=e5aqlkt2tH9Hub5Tzpy0hmssG+TwnIWE/8bqLvSceEeAS/XT6bEh1NFOv4sMrd1yg+
         qT4FLP+BGfwZpuRz+ry9S7NwDZtk041KVPT2n2XYMge4b/txjEv0YhlwCsM5Zu42zEr8
         95HYQkFqffDz5HjoXYQqJdf2FhN/PcpTC65MNM8hmuh/emOHIOjx20y8Cd0qEQvPRNu0
         Wu1nyXb9T8C4H6/0EthR5+fpOgpKSzhmO+ryL46p+MKpz2ZTE1y8xLLx+GfCv5mpCeKC
         YwlZPgq7FIEYsWpCcyqr2sncDYMQ/DXpZVTfVlSyecgheKcrWt21KreOPrFVAOIoq7mV
         oV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erKMVXRRMKr2Wnj6FvDV9YZJSC0JpdFlqFYoAG3oJk8=;
        b=a6Lv4nMcZjc0aRvUiapntMCDYlz+RvEDRgV0dX5Jjg+3vR8iz2yUa2UXZ7pLOvkEYV
         4f8Q3vsFIHvFi5jbQtBy117oAwy6qCG/4COti5SsvoZ1smZ2WTT7x9hy+y1GuWr/TgPv
         0a74ON3ifbHm/ka/yLmK9FCcyXpfFUzq1hWP8n+WWBP0D4cIo1UBN3epUyzFVpzUE6Xo
         Z19Lkt2vMDCb0NxAeGViiKM/Dn5jG6ug09D3mLAhKwKPtV3/rxLZo6puZx0g9o7vWcFX
         YBMSOtjUcXj5tnTVo70+Wmna31o2otcY11Xw4sSUcTN/FBasEV5/3JhVpMzSgIpM9I5R
         0slQ==
X-Gm-Message-State: ANhLgQ3j23N0oQyVvE3482wS212HtX35Za4XiqXE4wjWeYgi0XAcK1h3
        fgYgTG6BqwjMYe1u8cSUO88i6GGlNkw=
X-Google-Smtp-Source: ADFU+vuOcxAY7KD9dXfyJIJOscp/EX+ZD84aG8TyYIfhwnV62PEDMV8G1LNtoOFENhaifk1o1fhGZQ==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr33979978wro.115.1585002328416;
        Mon, 23 Mar 2020 15:25:28 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id q72sm1371412wme.31.2020.03.23.15.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:25:27 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        William Baker <William.Baker@microsoft.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v3 1/1] midx.c: fix an integer overflow
Date:   Mon, 23 Mar 2020 23:25:15 +0100
Message-Id: <20200323222515.779477-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312173520.2401776-1-damien.olivier.robert+git@gmail.com>
References: 
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

Update the tests so that we check that `git multi-pack-index write` does
not write an midx when there is no object.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
Since I did not receive any guidelines, I did not upload an midx with no
object to check in the tests. I just modified the current tests to check
that we don't produce an midx if there is no objects.

 midx.c                      | 13 +++++++++++++
 t/t5319-multi-pack-index.sh |  7 +++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index 1527e464a7..018acc7e76 100644
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
@@ -1124,6 +1130,13 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 				    i, oid_fanout1, oid_fanout2, i + 1);
 	}
 
+	if (m->num_objects == 0) {
+		midx_report(_("the midx contains no oid"));
+		// remaining tests assume that we have objects, so we can
+		// return here
+		return verify_midx_error;
+	}
+
 	if (flags & MIDX_PROGRESS)
 		progress = start_sparse_progress(_("Verifying OID order in multi-pack-index"),
 						 m->num_objects - 1);
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 43a7a66c9d..d90dfce268 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -42,10 +42,9 @@ test_expect_success 'setup' '
 	EOF
 '
 
-test_expect_success 'write midx with no packs' '
-	test_when_finished rm -f pack/multi-pack-index &&
-	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 0 0 4 .
+test_expect_success "don't write midx with no packs" '
+	test_must_fail git multi-pack-index --object-dir=. write &&
+	test_path_is_missing pack/multi-pack-index
 '
 
 generate_objects () {
-- 
Patched on top of v2.26.0 (git version 2.25.1)

