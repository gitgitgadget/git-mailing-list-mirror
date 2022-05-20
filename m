Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65828C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 16:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348046AbiETQgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 12:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiETQgR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 12:36:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A723F18E07
        for <git@vger.kernel.org>; Fri, 20 May 2022 09:36:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u27so11394653wru.8
        for <git@vger.kernel.org>; Fri, 20 May 2022 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BmTiAkVYoR93MdSa64nyFHNT4Ez18yBQk+EcmDmEZiM=;
        b=LXi1FqqJluXDkkB5MxNOpJuTdv/QbkbIKLWvTAk7JXKa4krJCzBCbG3GnW3ZBtIKat
         IFzi+evIC+XnFDrnClyPNK3l81INoArL6myBIOrfknl0f6h0dgN/ozn4V2uwSP4pNKhn
         D9xVcCJ/yYPwcTikOg0NupFjaC6taLEiz0a0AxWEygw47g3cJcimrqedTwWGyIoKkFvN
         WGD48iLkF0UWSmMqyxlMYwf34DSlFHb+xQy0kFfka9fYSO6qELAO2xa4XK6zACZMdwJ0
         +cghyK2L7q1ujxjuaM3nRRLTaPn6CPlMlo9kmCsnNSf86i1McMWbx1V+pbm0iJuPLwv5
         NTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BmTiAkVYoR93MdSa64nyFHNT4Ez18yBQk+EcmDmEZiM=;
        b=UiIuHbtXXqjj27qlpu3JJr3G4nY+Ko+z7htZvibiX57jZlYd2d7pMByG5vqlndW00u
         dfWiyERzlsRZWmdT/xuQOYM4nLtsT8isjR8goovt/Iw5m8cVq2ONKGfIU1Bv5SVF5ApY
         y4hTiQsWJS44UHbGPVQftV0o4fk807WK9TPnHY6StzAvza7hJwblOIIFMxygKFxe4KCq
         Wy6lyHLyJOCmO0j7vK/Ja2AT4wVaAMLF0flc8mz8o30gV4o0zCLBnPzFmI3LddG+H7a1
         OdOI7y3s+qAzM7uvhP+s74O5QSKr3WQfOc7sT3SQ6RW7Mg9huK/qwK+WjMpwFP9FOY0o
         OMXg==
X-Gm-Message-State: AOAM533WPG6snkIK3AnLmA9dyDyWcAteQGP2UYv9F9BL5E+59nXeYh49
        dkO9NXXWuIvGEAYj50zTDQ0Jf50SuWM=
X-Google-Smtp-Source: ABdhPJx0XAlUSXEEkLhgCuBeqa1rSwUzxyZyhSobyLIKiO8Hpz5ddsaqhiX41GjuGJ4P10rs+uCL5Q==
X-Received: by 2002:a5d:4bd0:0:b0:20d:7859:4160 with SMTP id l16-20020a5d4bd0000000b0020d78594160mr9094289wrt.296.1653064573619;
        Fri, 20 May 2022 09:36:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a21-20020a7bc1d5000000b00397259c2a64sm2291301wmj.38.2022.05.20.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:36:12 -0700 (PDT)
Message-Id: <pull.1235.git.1653064572170.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 16:36:12 +0000
Subject: [PATCH] repack: respect --keep-pack with geometric repack
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update 'repack' to ignore packs named on the command line with the
'--keep-pack' option. Specifically, modify 'init_pack_geometry()' to treat
command line-kept packs the same way it treats packs with an on-disk '.keep'
file (that is, skip the pack and do not include it in the 'geometry'
structure).

Without this handling, a '--keep-pack' pack would be included in the
'geometry' structure. If the pack is *before* the geometry split line (with
at least one other pack and/or loose objects present), 'repack' assumes the
pack's contents are "rolled up" into another pack via 'pack-objects'.
However, because the internally-invoked 'pack-objects' properly excludes
'--keep-pack' objects, any new pack it creates will not contain the kept
objects. Finally, 'repack' deletes the '--keep-pack' as "redundant" (since
it assumes 'pack-objects' created a new pack with its contents), resulting
in possible object loss and repository corruption.

Add a test ensuring that '--keep-pack' packs are now appropriately handled.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    repack: respect --keep-pack with geometric repack

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1235%2Fvdye%2Fbugfix%2Frepack-kept-pack-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1235/vdye/bugfix/repack-kept-pack-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1235

 builtin/repack.c            | 40 +++++++++++++++++++++++++++----------
 t/t7703-repack-geometric.sh | 34 +++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index d1a563d5b65..0b636676056 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -332,17 +332,34 @@ static int geometry_cmp(const void *va, const void *vb)
 	return 0;
 }
 
-static void init_pack_geometry(struct pack_geometry **geometry_p)
+static void init_pack_geometry(struct pack_geometry **geometry_p,
+			       struct string_list *existing_kept_packs)
 {
 	struct packed_git *p;
 	struct pack_geometry *geometry;
+	struct strbuf buf = STRBUF_INIT;
 
 	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
 	geometry = *geometry_p;
 
+	string_list_sort(existing_kept_packs);
 	for (p = get_all_packs(the_repository); p; p = p->next) {
-		if (!pack_kept_objects && p->pack_keep)
-			continue;
+		if (!pack_kept_objects) {
+			if (p->pack_keep)
+				continue;
+
+			/*
+			 * The pack may be kept via the --keep-pack option;
+			 * check 'existing_kept_packs' to determine whether to
+			 * ignore it.
+			 */
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, pack_basename(p));
+			strbuf_strip_suffix(&buf, ".pack");
+
+			if (string_list_has_string(existing_kept_packs, buf.buf))
+				continue;
+		}
 
 		ALLOC_GROW(geometry->pack,
 			   geometry->pack_nr + 1,
@@ -353,6 +370,7 @@ static void init_pack_geometry(struct pack_geometry **geometry_p)
 	}
 
 	QSORT(geometry->pack, geometry->pack_nr, geometry_cmp);
+	strbuf_release(&buf);
 }
 
 static void split_pack_geometry(struct pack_geometry *geometry, int factor)
@@ -714,17 +732,20 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		strbuf_release(&path);
 	}
 
+	packdir = mkpathdup("%s/pack", get_object_directory());
+	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
+	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
+
+	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
+			       &keep_pack_list);
+
 	if (geometric_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
-		init_pack_geometry(&geometry);
+		init_pack_geometry(&geometry, &existing_kept_packs);
 		split_pack_geometry(geometry, geometric_factor);
 	}
 
-	packdir = mkpathdup("%s/pack", get_object_directory());
-	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
-	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
-
 	sigchain_push_common(remove_pack_on_signal);
 
 	prepare_pack_objects(&cmd, &po_args);
@@ -764,9 +785,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	if (use_delta_islands)
 		strvec_push(&cmd.args, "--delta-islands");
 
-	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
-			       &keep_pack_list);
-
 	if (pack_everything & ALL_INTO_ONE) {
 		repack_promisor_objects(&po_args, &names);
 
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index bdbbcbf1eca..f5ac23413d5 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -180,6 +180,40 @@ test_expect_success '--geometric ignores kept packs' '
 	)
 '
 
+test_expect_success '--geometric ignores --keep-pack packs' '
+	git init geometric &&
+	test_when_finished "rm -fr geometric" &&
+	(
+		cd geometric &&
+
+		# Create two equal-sized packs
+		test_commit kept && # 3 objects
+		test_commit pack && # 3 objects
+
+		KEPT=$(git pack-objects --revs $objdir/pack/pack <<-EOF
+		refs/tags/kept
+		EOF
+		) &&
+		PACK=$(git pack-objects --revs $objdir/pack/pack <<-EOF
+		refs/tags/pack
+		^refs/tags/kept
+		EOF
+		) &&
+
+		# Prune loose objects that are now packed into PACK and KEEP
+		git prune-packed &&
+
+		git repack --geometric 2 -dm --keep-pack=pack-$KEPT.pack >out &&
+
+		# Packs should not have changed (only one non-kept pack, no
+		# loose objects), but midx should now exist.
+		test_i18ngrep "Nothing new to pack" out &&
+		test_path_is_file $midx &&
+		test_path_is_file $objdir/pack/pack-$KEPT.pack &&
+		git fsck
+	)
+'
+
 test_expect_success '--geometric chooses largest MIDX preferred pack' '
 	git init geometric &&
 	test_when_finished "rm -fr geometric" &&

base-commit: 277cf0bc36094f6dc4297d8c9cef79df045b735d
-- 
gitgitgadget
