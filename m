Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20438C77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 16:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjDQQVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDQQVs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 12:21:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7044524A
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:46 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so21323725wmb.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681748505; x=1684340505;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBAxlDoDIUCetTwSWTjui5SaY8g5aiwMN4pSeJeGQW4=;
        b=FkI467A8fRIlGFgUL2e4ld+mb61h34a66RawE3dNAIdLf1XbeBMPcMc2v3VbBbutUv
         kz/g7Tng1ZZmxo4DLlzpJKECCnyMR63RozwPrfe3bEpDclbICgD5fX7KgCDrSaA1NaOv
         QLYukrnDDP+Kew68N1RsZY+JJnqajPESjWD8osWuBj4l3BN6k/uPlX6XLDUPAD/UNA83
         cRJj6s7fPXDFr+qAMp8F7I4c+SE7BerMEbhIxEKXb8ESKrYmo0pncjmmEgOubDfn0JtC
         tITuRGknB84YLmPx6qqx1BGMIM/CWrBWjw4kW4vn6XkD3kw4q5GYyCngXIX62YYkGbo8
         GIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681748505; x=1684340505;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBAxlDoDIUCetTwSWTjui5SaY8g5aiwMN4pSeJeGQW4=;
        b=ENVaRBkn05EUqeQ+CMHS3pVkHKo6aRkNaGD/zgmxMSTzmjAKpJH19mqe8WMmR9dsIV
         77Ak64bJ1GV1xN6inudkAKGLIpDS4p8hJgrv5XjEP81MLAz7CEj3hxdAoJIDaUzWuInI
         KVAaetvizdxqvPQHw/+j+Re36p2HMVImhFShQ4bjLo2kofdRfMdAgZdV0WqwvNmNnmQ4
         37n+fsh6GfOZHXkisvmmPoCLXwUnFS7Bt+177h7kLuXUy7uSm1fJ50IPJijenuZ/MP/y
         FTllGodFt7I3W0XnDqDqL9CmXj6OJsiVCA03z9kJw03zU5CkZRsoROJ3sWP8RJPRmWH8
         h3FA==
X-Gm-Message-State: AAQBX9cg996MKhy7CNOTWgWEaLpvRyjzQJNuuwpPOiv2LYMQ55Ru/dtB
        vgRx35RTXvBqTv8P6wsIxwiJIiD3My0=
X-Google-Smtp-Source: AKy350ab2+3gv18Dgg81uI9nPNFsXlBWXJBh7VsdadVM3iw4kFEn3IpVn/KnLuY7GrqS8I1aRg6lvQ==
X-Received: by 2002:a05:600c:4688:b0:3f1:65d4:30f7 with SMTP id p8-20020a05600c468800b003f165d430f7mr6054265wmo.10.1681748505120;
        Mon, 17 Apr 2023 09:21:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16-20020adff290000000b002f53fa16239sm10851664wro.103.2023.04.17.09.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 09:21:44 -0700 (PDT)
Message-Id: <7db4ec3e327ed3695f4f5409cb2dc80c72688758.1681748502.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
References: <pull.1512.git.1681748502.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Apr 2023 16:21:39 +0000
Subject: [PATCH 2/4] fsck: check rev-index checksums
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change added calls to verify_pack_revindex() in
builtin/fsck.c, but the implementation of the method was left empty. Add
the first and most-obvious check to this method: checksum verification.

While here, create a helper method in the test script that makes it easy
to adjust the .rev file and check that 'git fsck' reports the correct
error message.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 pack-revindex.c          | 10 ++++++++++
 t/t5325-reverse-index.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index c3f2aaa3fea..007a806994f 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -5,6 +5,7 @@
 #include "packfile.h"
 #include "config.h"
 #include "midx.h"
+#include "csum-file.h"
 
 struct revindex_entry {
 	off_t offset;
@@ -309,6 +310,15 @@ int load_pack_revindex(struct repository *r, struct packed_git *p)
  */
 int verify_pack_revindex(struct packed_git *p)
 {
+	/* Do not bother checking if not initialized. */
+	if (!p->revindex_map)
+		return 0;
+
+	if (!hashfile_checksum_valid((const unsigned char *)p->revindex_map, p->revindex_size)) {
+		error(_("invalid checksum"));
+		return -1;
+	}
+
 	return 0;
 }
 
diff --git a/t/t5325-reverse-index.sh b/t/t5325-reverse-index.sh
index 206c412f50b..6b7c709a1f6 100755
--- a/t/t5325-reverse-index.sh
+++ b/t/t5325-reverse-index.sh
@@ -145,4 +145,44 @@ test_expect_success 'fsck succeeds on good rev-index' '
 	)
 '
 
+test_expect_success 'set up rev-index corruption tests' '
+	git init corrupt &&
+	(
+		cd corrupt &&
+
+		test_commit commit &&
+		git -c pack.writeReverseIndex=true repack -ad &&
+
+		revfile=$(ls .git/objects/pack/pack-*.rev) &&
+		chmod a+w $revfile &&
+		cp $revfile $revfile.bak
+	)
+'
+
+corrupt_rev_and_verify () {
+	(
+		pos="$1" &&
+		value="$2" &&
+		error="$3" &&
+
+		cd corrupt &&
+		revfile=$(ls .git/objects/pack/pack-*.rev) &&
+
+		# Reset to original rev-file.
+		cp $revfile.bak $revfile &&
+
+		printf "$value" | dd of=$revfile bs=1 seek="$pos" conv=notrunc &&
+		test_must_fail git fsck 2>err &&
+		grep "$error" err
+	)
+}
+
+test_expect_success 'fsck catches invalid checksum' '
+	revfile=$(ls corrupt/.git/objects/pack/pack-*.rev) &&
+	orig_size=$(wc -c <$revfile) &&
+	hashpos=$((orig_size - 10)) &&
+	corrupt_rev_and_verify $hashpos bogus \
+		"invalid checksum"
+'
+
 test_done
-- 
gitgitgadget

