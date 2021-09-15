Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186C1C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC487611C8
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhIOS0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhIOS0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:26:03 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC13C061575
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:44 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id j18so4643970ioj.8
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gz4CvzE8Ph4NOcoOPKTuVPvwpTkyX8ozHsM8dxdWibA=;
        b=aSYpaq/gkSyPzV8BhQutGLm8iBn/dGCIRU2LID0w4LePtNy4L8S+hxmkdUrayyZabG
         YzUyY8/eONztz+8wyx8sYQVRihWj6vo+MGW7jWL5vrPATfvAuacGLVMZdA/vYEh3vMmL
         mImi5Av3E46y7j69nOj/fClIc5KbU50BNztyJYHOlqFKDg+M54HmO9Jux4R+2bTVMDNg
         89g2Rq+AAuKrNhKW9a1PRNI1xDOcmQUGNY6l+UQWiHqwMm76Auame7lN/Ja9IkAcPlcn
         njYbtzAgYFQjqTpiqSPVx97gH8HNK1DYofgXYXs3m/4r7pnItEWsgVEXMWml+4yjS7tX
         Hjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gz4CvzE8Ph4NOcoOPKTuVPvwpTkyX8ozHsM8dxdWibA=;
        b=8BlTfyRZPmLb3zFTIUI2jTHr/Fc+uGo0e/+4SO9h8rMgNuaRG7IcwzFn74mgUeSwXy
         E2P0Zbu3PAPqU3EgdsVBqIPcAjlGKAQvCZeR65XBrkXziSKTKfGHtIijKX2zwB2356vL
         j9JoAAl8qOLQEk47jbNzlv2IOCcR8kfDBn5YxNij40QOJfnSsHwUGALFFYAbLWUBStUr
         YlGTQX+KeHGcSSPbpjO5ftbylrHNRxczJIVjjGXaq3BepHgI86qRSCWtlMSHpZtLNYcy
         jnSXHgdmUCOYVLvDbNqtYGHEPrKsQiEqCNetD7AhoFa6rgA2FjiZPfOgupQ7e5fFafwD
         dtUw==
X-Gm-Message-State: AOAM531orEWKk+cnbWMkfFEW+kIwq6H1aWToLgVa3GnUV6lloT/Espvb
        nUEwwjjkEbM+3To3ws/gyQOa5jNCV0IjRBZ6
X-Google-Smtp-Source: ABdhPJz+TpTeQGMxaxcZGU2Tm43Y7qlNnZTQlJy6hjs6NTNCfKrm+4yQaW1vHSeqs3Tnw8yKFyNg8g==
X-Received: by 2002:a02:b0d1:: with SMTP id w17mr1183132jah.46.1631730283940;
        Wed, 15 Sep 2021 11:24:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f17sm385182ilq.44.2021.09.15.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:24:43 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:24:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 4/8] builtin/repack.c: keep track of existing packs
 unconditionally
Message-ID: <c0d045a9de1a5e75d684b0dd2009a3137b6e5c59.1631730270.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
 <cover.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to be able to write a multi-pack index during repacking, `git
repack` must keep track of which packs it wants to write into the MIDX.
This set is the union of existing packs which will not be deleted,
new pack(s) generated as a result of the repack, and .keep packs.

Prior to this patch, `git repack` populated the list of existing packs
only when repacking all-into-one (i.e., with `-A` or `-a`), but we will
soon need to know this list when repacking when writing a MIDX without
a-i-o.

Populate the list of existing packs unconditionally, and guard removing
packs from that list only when repacking a-i-o.

Additionally, keep track of filenames of kept packs separately, since
this, too, will be used in an upcoming patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 49 ++++++++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 27158a897b..e55a650de5 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -98,8 +98,9 @@ static void remove_pack_on_signal(int signo)
  * have a corresponding .keep file. These packs are not to
  * be kept if we are going to pack everything into one file.
  */
-static void get_non_kept_pack_filenames(struct string_list *fname_list,
-					const struct string_list *extra_keep)
+static void collect_pack_filenames(struct string_list *fname_list,
+				   struct string_list *fname_kept_list,
+				   const struct string_list *extra_keep)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -112,21 +113,20 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 		size_t len;
 		int i;
 
+		if (!strip_suffix(e->d_name, ".pack", &len))
+			continue;
+
 		for (i = 0; i < extra_keep->nr; i++)
 			if (!fspathcmp(e->d_name, extra_keep->items[i].string))
 				break;
-		if (extra_keep->nr > 0 && i < extra_keep->nr)
-			continue;
-
-		if (!strip_suffix(e->d_name, ".pack", &len))
-			continue;
 
 		fname = xmemdupz(e->d_name, len);
 
-		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
-			string_list_append_nodup(fname_list, fname);
+		if ((extra_keep->nr > 0 && i < extra_keep->nr) ||
+		    (file_exists(mkpath("%s/%s.keep", packdir, fname))))
+			string_list_append_nodup(fname_kept_list, fname);
 		else
-			free(fname);
+			string_list_append_nodup(fname_list, fname);
 	}
 	closedir(dir);
 }
@@ -440,6 +440,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
+	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
 	int i, ext, ret;
@@ -572,9 +573,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (use_delta_islands)
 		strvec_push(&cmd.args, "--delta-islands");
 
+	collect_pack_filenames(&existing_packs, &existing_kept_packs,
+			       &keep_pack_list);
+
 	if (pack_everything & ALL_INTO_ONE) {
-		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
-
 		repack_promisor_objects(&po_args, &names);
 
 		if (existing_packs.nr && delete_redundant) {
@@ -683,17 +685,19 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	reprepare_packed_git(the_repository);
 
 	if (delete_redundant) {
-		const int hexsz = the_hash_algo->hexsz;
 		int opts = 0;
-		string_list_sort(&names);
-		for_each_string_list_item(item, &existing_packs) {
-			char *sha1;
-			size_t len = strlen(item->string);
-			if (len < hexsz)
-				continue;
-			sha1 = item->string + len - hexsz;
-			if (!string_list_has_string(&names, sha1))
-				remove_redundant_pack(packdir, item->string);
+		if (pack_everything & ALL_INTO_ONE) {
+			const int hexsz = the_hash_algo->hexsz;
+			string_list_sort(&names);
+			for_each_string_list_item(item, &existing_packs) {
+				char *sha1;
+				size_t len = strlen(item->string);
+				if (len < hexsz)
+					continue;
+				sha1 = item->string + len - hexsz;
+				if (!string_list_has_string(&names, sha1))
+					remove_redundant_pack(packdir, item->string);
+			}
 		}
 
 		if (geometry) {
@@ -739,6 +743,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	string_list_clear(&names, 0);
 	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_packs, 0);
+	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
 	strbuf_release(&line);
 
-- 
2.33.0.96.g73915697e6

