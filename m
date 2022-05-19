Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF2C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 11:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbiESLmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 07:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiESLml (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 07:42:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1FDB36C1
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:42:39 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so4844623wmj.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UbevvdZJ7DTYFDKAd/1eGib4lOj1YFg7yg03weeMwVQ=;
        b=Cx97yEBKO9VL4dIu6IefQEC78gqbKkOntXCcswMq7/yKvnvfDcCscXxU5RduEFRLqL
         0zpo4S78vuoNF4RbBVPAguZyvqBXXPVyRddoJ+M3X8vnzAymvb4hnQR/+jYF9fCbbYW4
         eQyvZpX1F3E5Xk4JizkLfwmg1oGcqAHEgrnNQWtx30Jok90+7Ijl030PBgtzmPU2LSS1
         0Bw8W4AUkQTM4FcrxZXxlh8bExhMu7c4uuQlJL/6jaYSWleGtEGIHG5Otf99FfGl973H
         kxprrrdbJU0NAAw/Vcvjot+8h0fTNpovdg9iJnSLRhpULD7oQYVjCE4gNPJZwUbj1fLL
         rzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UbevvdZJ7DTYFDKAd/1eGib4lOj1YFg7yg03weeMwVQ=;
        b=DC07aGDM1uNCbCZ5nZqjjaQCF/pDeookc5UfSZ6dx49FKCfx7XaqicfLtDGk03m0dE
         Z+6KEr3hiGN4v9X3bVX3Qanl9WREA+D/CLM3BDceeQ1FXOV7ANjit2Ds09E7CVQdwfEK
         UKRyock6A0bp/vGERpzhdp+JdiYWNmb2vpaqPsRJez5WcPvhxdldjaIWk0WpG3FYP8VY
         mHJ7Bo4bsndXXTW7ORkKXoA6/94ZlkwEtIDXVcnE4CKUInFu+QR36Abak9fcn4R6BCKd
         cRYHxQI6LUch+ZtdTCF9dDvfjpWOiflEYoNkb0zBnKRhx7Ja7HClHqF16b/GqdWk+OnC
         bi5w==
X-Gm-Message-State: AOAM53237FFS5gyGP224ybvQ6+FXndssOtyV4N95v9oKY6l489Nnw4Pv
        CtGn+aw9HLh3+0y7I6wH+IvBuQvuc2St1w==
X-Google-Smtp-Source: ABdhPJwXM9dN3uynZIVLQVZyn4RiYD8dauyd6LdyIqv7/Xcx9fojZMc9oMqou4nRKoRct2C5i3IM4w==
X-Received: by 2002:a7b:cc8e:0:b0:393:fbf9:ab72 with SMTP id p14-20020a7bcc8e000000b00393fbf9ab72mr4000575wma.70.1652960558039;
        Thu, 19 May 2022 04:42:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f25-20020a1c6a19000000b003942a244f45sm6561984wmc.30.2022.05.19.04.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 04:42:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/2] packfile API: add and use a pack_name_to_ext() utility function
Date:   Thu, 19 May 2022 13:42:27 +0200
Message-Id: <RFC-patch-1.2-d8c3c03e90f-20220519T113538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.952.g6652f7f0e6b
In-Reply-To: <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
References: <cover.1652915424.git.me@ttaylorr.com> <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and use a pack_name_to_ext() utility function for the copy/pasted
cases of creating a FOO.ext file given a string like FOO.pack.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pack-bitmap.c   |  6 +-----
 pack-revindex.c |  5 +----
 packfile.c      | 14 ++++++++++----
 packfile.h      |  9 +++++++++
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 97909d48da3..0c3770d038d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -302,11 +302,7 @@ char *midx_bitmap_filename(struct multi_pack_index *midx)
 
 char *pack_bitmap_filename(struct packed_git *p)
 {
-	size_t len;
-
-	if (!strip_suffix(p->pack_name, ".pack", &len))
-		BUG("pack_name does not end in .pack");
-	return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
+	return pack_name_to_ext(p->pack_name, "bitmap");
 }
 
 static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
diff --git a/pack-revindex.c b/pack-revindex.c
index 08dc1601679..69dc5688796 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -179,10 +179,7 @@ static int create_pack_revindex_in_memory(struct packed_git *p)
 
 static char *pack_revindex_filename(struct packed_git *p)
 {
-	size_t len;
-	if (!strip_suffix(p->pack_name, ".pack", &len))
-		BUG("pack_name does not end in .pack");
-	return xstrfmt("%.*s.rev", (int)len, p->pack_name);
+	return pack_name_to_ext(p->pack_name, "rev");
 }
 
 #define RIDX_HEADER_SIZE (12)
diff --git a/packfile.c b/packfile.c
index 835b2d27164..bd6ad441bf5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -191,15 +191,12 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 int open_pack_index(struct packed_git *p)
 {
 	char *idx_name;
-	size_t len;
 	int ret;
 
 	if (p->index_data)
 		return 0;
 
-	if (!strip_suffix(p->pack_name, ".pack", &len))
-		BUG("pack_name does not end in .pack");
-	idx_name = xstrfmt("%.*s.idx", (int)len, p->pack_name);
+	idx_name = pack_name_to_ext(p->pack_name, "idx");
 	ret = check_packed_git_idx(idx_name, p);
 	free(idx_name);
 	return ret;
@@ -2266,3 +2263,12 @@ int is_promisor_object(const struct object_id *oid)
 	}
 	return oidset_contains(&promisor_objects, oid);
 }
+
+char *pack_name_to_ext(const char *pack_name, const char *ext)
+{
+	size_t len;
+
+	if (!strip_suffix(pack_name, ".pack", &len))
+		BUG("pack_name does not end in .pack");
+	return xstrfmt("%.*s.%s", (int)len, pack_name, ext);
+}
diff --git a/packfile.h b/packfile.h
index a3f6723857b..6890c57ebdb 100644
--- a/packfile.h
+++ b/packfile.h
@@ -195,4 +195,13 @@ int is_promisor_object(const struct object_id *oid);
 int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	     size_t idx_size, struct packed_git *p);
 
+/**
+ * Given a string like "foo.pack" and "ext" returns an xstrdup()'d
+ * "foo.ext" string. Used for creating e.g. PACK.{bitmap,rev,...}
+ * filenames from PACK.pack.
+ *
+ * Will BUG() if the expected string can't be created from the
+ * "pack_name" argument.
+ */
+char *pack_name_to_ext(const char *pack_name, const char *ext);
 #endif
-- 
2.36.1.952.g6652f7f0e6b

