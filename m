Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A33C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 21:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357271AbiFNV2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 17:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345162AbiFNV17 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 17:27:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE617289AA
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n185so5327921wmn.4
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 14:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZPl6Zq2JI8wNCS5ZExHetDtnJijrCm3i3KuNoQFRYMM=;
        b=CPKXMFsAtuK42HHT+rli2k5B4AzCqcEtX9DRhfizATWnH0pCOB0ZJ0kHDvlbywswYr
         ZS58hcaUWG4kiZgAe1ILVbe4IoFQdSxu27R0wyXj53MCcxGwr6eP2cuAAk5PoBUg+y+y
         IffEiA5K6FbsVgFYWs9QiMwPmK7jdhJiyNNcnQH+oPz3Qllx3NcN3NCbPxQ20TFEpZ79
         Xd0c0YfxsoihDyfOkEqPvMrZ3Fmsw208B7EbnxdlqGc+DdVqsNf1gv15OgyvpDharkRW
         5UKNKOm61MdZ25enUmK3DJv7/SNCvC2JQ2FJprxA0dlZHPwGqIza4cb4X0/YLbGcjud/
         jgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZPl6Zq2JI8wNCS5ZExHetDtnJijrCm3i3KuNoQFRYMM=;
        b=m4zym0VFEdNWv3bBO52tDHwxLXlnNeaP+DLd8bIn9YUjS95ZiAJ6tieDXGOWxk6VQY
         9ryDPLq7n37pthb3hu1uVBCcI2WshQtCcXKwFptBmWJJOv3au9Y5loaABw9FY+cJfQdm
         VIDIA0POOMc41RtG29GVpiVGDcSn1JD6o4xkZNMek6Tcm6uwkuEFOP6n2v+CFLfApVhO
         XbT2DJToBMXYwyQo/smZSXCjHvdYPxrzgKGZMnIqvhnYtzTzpOJ6N4LcjFlSYzHg8L33
         edHu9ugolfZ2N0EWlznu1vWcYVuxQxAIwAWwW8RUktkwt9SmJ2HAypSmA7p/LtZFg2s0
         TBEA==
X-Gm-Message-State: AOAM531I6jgBbaxFz0YHFbOAqdQOY4CgWA98XExRpgBVjrc4WdNZ2WUL
        ExwVXyNCCeK6akHftWjwMWYodDYGJSjs/A==
X-Google-Smtp-Source: ABdhPJy8fdxwLHb5NSgE7acciL7EqMNyoYMC7vybRA8VsfIxhJ5RL3TjQO/HS0GY0ykNCbQCpcVNOQ==
X-Received: by 2002:a05:600c:414e:b0:397:55aa:ccc0 with SMTP id h14-20020a05600c414e00b0039755aaccc0mr6438545wmm.51.1655242075952;
        Tue, 14 Jun 2022 14:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b0039c4ba160absm6413310wmq.2.2022.06.14.14.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 14:27:55 -0700 (PDT)
Message-Id: <b67e110bf60e820874de94c64ee8c32d69413877.1655242070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
References: <pull.1261.git.1655242070.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jun 2022 21:27:49 +0000
Subject: [PATCH 3/4] pack-write: drop always-NULL parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

write_mtimes_file() takes an mtimes parameter as its first option, but
the only caller passes a NULL constant. Drop this parameter to simplify
logic. This can be reverted if that parameter is needed in the future.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 pack-write.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 23c0342018f..00787e306db 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -310,26 +310,21 @@ static void write_mtimes_trailer(struct hashfile *f, const unsigned char *hash)
 	hashwrite(f, hash, the_hash_algo->rawsz);
 }
 
-static const char *write_mtimes_file(const char *mtimes_name,
-				     struct packing_data *to_pack,
+static const char *write_mtimes_file(struct packing_data *to_pack,
 				     struct pack_idx_entry **objects,
 				     uint32_t nr_objects,
 				     const unsigned char *hash)
 {
+	struct strbuf tmp_file = STRBUF_INIT;
+	const char *mtimes_name;
 	struct hashfile *f;
 	int fd;
 
 	if (!to_pack)
 		BUG("cannot call write_mtimes_file with NULL packing_data");
 
-	if (!mtimes_name) {
-		struct strbuf tmp_file = STRBUF_INIT;
-		fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
-		mtimes_name = strbuf_detach(&tmp_file, NULL);
-	} else {
-		unlink(mtimes_name);
-		fd = xopen(mtimes_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
-	}
+	fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
+	mtimes_name = strbuf_detach(&tmp_file, NULL);
 	f = hashfd(fd, mtimes_name);
 
 	write_mtimes_header(f);
@@ -561,7 +556,7 @@ void stage_tmp_packfiles(struct strbuf *name_buffer,
 				      pack_idx_opts->flags);
 
 	if (pack_idx_opts->flags & WRITE_MTIMES) {
-		mtimes_tmp_name = write_mtimes_file(NULL, to_pack, written_list,
+		mtimes_tmp_name = write_mtimes_file(to_pack, written_list,
 						    nr_written,
 						    hash);
 	}
-- 
gitgitgadget

