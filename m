Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E46C433E1
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF07B206B5
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 14:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTV8K5Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHXOv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHXOvv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 10:51:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B591C061574
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 07:51:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w13so8667267wrk.5
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 07:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=muyzJYsLU1GY871woUoRsJEEQGMLFvvxTVJGrJdIBVM=;
        b=mTV8K5Fm/VbEbi4F6b2c5Amb81IZN3tPcNdcaMDBfI/+Dud5Ee9Ic6Nfana+TDEFWj
         dXszhBkxhRbpa1oLeIwG3MEfaUb5eqj3ApaN9PQTdpc40ni/4Zvsh8rgUNa4RzeY+oP+
         YzZxE1fh9Pz/XLXr5KlZoV0wFkD7SSmJjK5yasP9l3yGxeTFs5C7ABs88YOH2lfnYAlq
         oGMBtcYLH62uNGfr38MiG2Y1ZyJk7LAggwwwO883530AMGtXHnYWzU8lY58MDg9LHlst
         Tn5q4IlOUs6+bZWQDj07A+nz/aN9I4snO3az7cB7LpmMXYd4cTcG+Sw0+OPvzRFJZ1X2
         cxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=muyzJYsLU1GY871woUoRsJEEQGMLFvvxTVJGrJdIBVM=;
        b=NmxjU55CQOCJQWbZHbR9S3x3xUTiijTohcHtpI3YssN1hkjpdvXuzB1WywNIZiT9uw
         +r0iv1DxZJ4DnJ9SHNbi3Jz/nF36Y1V7FEhcIh8eGf/0Ve9+gPMkyx6yI4zjCRuY0dxL
         vDejxlgAADHhMUF834sIzIitm3lInxjLqlZda1DbdPpOHCH5cfZ4U0UY2One/d8wbihG
         9Re2R0vhtBdww8ZSO0DCT6QnI3iv+GnfA0UYXyOa8GQlFLEd2BRskcwhcaUDRJaIsG1c
         DR5C159rOuD9HYmDyrnyPRlF/QmUevHn0n/GUdHq74a8TMxZaPB4K6cCjpidrtI+fUSA
         SDxg==
X-Gm-Message-State: AOAM531tjKBCdKyIDD/nfmtKFIR4VAG7C8BHrOEsMi+b2+IkXjzQpqFI
        rXlgsaRXx0Cr2arfkdN7q18CrIXDiNs=
X-Google-Smtp-Source: ABdhPJxAWzOZYdAoggq8nN5tlzcVJMII6lzRn5vQvDArDOOHRZT5FBgA8RYEkjC0j2v4QAtqgBqMjQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr6077746wrn.65.1598280709205;
        Mon, 24 Aug 2020 07:51:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm22989334wra.56.2020.08.24.07.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:51:48 -0700 (PDT)
Message-Id: <fc2138e1db2de46793100b87c00dbde270f6b350.1598280704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.708.git.1598280703.gitgitgadget@gmail.com>
References: <pull.708.git.1598280703.gitgitgadget@gmail.com>
From:   "Vadim Sannikov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Aug 2020 14:51:42 +0000
Subject: [PATCH 1/2] Unify `update-index --cacheinfo` usage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Vadim Sannikov <vsj.vadim@gmail.com>,
        Vadim Sannikov <vsj.vadim@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vadim Sannikov <vsj.vadim@gmail.com>

The old three separate parameters format (`<mode> <object> <path>`)
is replaced with the modern, single-parameter form
(`<mode>,<object>,<path>`).

Different parts of Git code use different syntax, so the commit unifies
it. According to `git-update-index` manual page, the new form is
preferred.

Signed-off-by: Vadim Sannikov <vsj.vadim@gmail.com>
---
 git-merge-one-file.sh | 6 +++---
 git-mergetool.sh      | 2 +-
 merge-recursive.c     | 2 +-
 po/bg.po              | 4 ++--
 po/ca.po              | 4 ++--
 po/de.po              | 4 ++--
 po/el.po              | 2 +-
 po/es.po              | 4 ++--
 po/fr.po              | 4 ++--
 po/git.pot            | 2 +-
 po/it.po              | 4 ++--
 po/ko.po              | 4 ++--
 po/ru.po              | 8 ++++++--
 po/sv.po              | 4 ++--
 po/tr.po              | 4 ++--
 po/vi.po              | 4 ++--
 po/zh_CN.po           | 4 ++--
 po/zh_TW.po           | 4 ++--
 18 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index f6d9852d2f..5691c4e7ff 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -71,7 +71,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 ".$2.")
 	# the other side did not add and we added so there is nothing
 	# to be done, except making the path merged.
-	exec git update-index --add --cacheinfo "$6" "$2" "$4"
+	exec git update-index --add --cacheinfo "$6","$2","$4"
 	;;
 "..$3")
 	echo "Adding $4"
@@ -80,7 +80,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "ERROR: untracked $4 is overwritten by the merge." >&2
 		exit 1
 	fi
-	git update-index --add --cacheinfo "$7" "$3" "$4" &&
+	git update-index --add --cacheinfo "$7","$3","$4" &&
 		exec git checkout-index -u -f -- "$4"
 	;;
 
@@ -95,7 +95,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		exit 1
 	fi
 	echo "Adding $4"
-	git update-index --add --cacheinfo "$6" "$2" "$4" &&
+	git update-index --add --cacheinfo "$6","$2","$4" &&
 		exec git checkout-index -u -f -- "$4"
 	;;
 
diff --git a/git-mergetool.sh b/git-mergetool.sh
index e3f6d543fb..ad37b15f4b 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -224,7 +224,7 @@ stage_submodule () {
 	)
 	test -n "$work_rel_path" ||
 	die "fatal: unable to get path of module $path relative to work tree"
-	git update-index --add --replace --cacheinfo 160000 "$submodule_sha1" "${work_rel_path%/}" || die
+	git update-index --add --replace --cacheinfo 160000,"$submodule_sha1","${work_rel_path%/}" || die
 }
 
 checkout_staged_file () {
diff --git a/merge-recursive.c b/merge-recursive.c
index d0214335a7..dfe6f67ec8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1259,7 +1259,7 @@ static int merge_submodule(struct merge_options *opt,
 		       "If this is correct simply add it to the index "
 		       "for example\n"
 		       "by using:\n\n"
-		       "  git update-index --cacheinfo 160000 %s \"%s\"\n\n"
+		       "  git update-index --cacheinfo 160000,%s,\"%s\"\n\n"
 		       "which will accept this suggestion.\n"),
 		       oid_to_hex(&merges.objects[0].item->oid), path);
 		break;
diff --git a/po/bg.po b/po/bg.po
index a189b16dc4..517c0e6b49 100644
--- a/po/bg.po
+++ b/po/bg.po
@@ -4737,13 +4737,13 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "Ако това е така, добавете го към индекса с команда като следната:\n"
 "\n"
-"    git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "Това приема предложеното.\n"
 
diff --git a/po/ca.po b/po/ca.po
index c43c21bc22..61c3a7f9b0 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -4592,12 +4592,12 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "Si això és correcte simplement afegiu-ho a l'índex per exemple utilitzant "
-"git update-index --cacheinfo 160000 per cents \"%s\" que acceptaran aquest "
+"  git update-index --cacheinfo 160000,%s,\"%s\" que acceptaran aquest "
 "suggeriment.\n"
 
 #: merge-recursive.c:1268
diff --git a/po/de.po b/po/de.po
index 656de24218..ec0106f2b8 100644
--- a/po/de.po
+++ b/po/de.po
@@ -4641,14 +4641,14 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "Falls das korrekt ist, fügen Sie es einfach der Staging-Area, zum Beispiel "
 "mit:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "hinzu, um diesen Vorschlag zu akzeptieren.\n"
 
diff --git a/po/el.po b/po/el.po
index 703f46d0c7..e775885187 100644
--- a/po/el.po
+++ b/po/el.po
@@ -3075,7 +3075,7 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
diff --git a/po/es.po b/po/es.po
index 41a72ca6fb..1c1aeebe47 100644
--- a/po/es.po
+++ b/po/es.po
@@ -4572,14 +4572,14 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "Si esto es correcto simplemente agrégalo al índice por ejemplo\n"
 "usando:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "el cual aceptará esta sugerencia.\n"
 
diff --git a/po/fr.po b/po/fr.po
index d20fc440ab..157c41ff4c 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -4714,14 +4714,14 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "Si c'est correct, ajoutez le simplement à l'index\n"
 "en utilisant par exemple :\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "qui acceptera cette suggestion.\n"
 
diff --git a/po/git.pot b/po/git.pot
index 198b6e0a4a..2d50bebf5a 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -4256,7 +4256,7 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
diff --git a/po/it.po b/po/it.po
index 53523e76df..c8264dd7bc 100644
--- a/po/it.po
+++ b/po/it.po
@@ -4649,14 +4649,14 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "Se è corretta aggiungila semplicemente all'indice, ad esempio\n"
 "usando:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "per accettare questo suggerimento.\n"
 
diff --git a/po/ko.po b/po/ko.po
index dcfe21c223..47b611edee 100644
--- a/po/ko.po
+++ b/po/ko.po
@@ -2361,14 +2361,14 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "이 제안이 맞으면 인덱스에 추가하면 됩니다. 예를 들어\n"
 "다음 명령을 사용하면:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "제안을 받아들이게 됩니다.\n"
 
diff --git a/po/ru.po b/po/ru.po
index a77b462e62..a928cd879e 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -3523,10 +3523,14 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
-msgstr "Если оно верное, то просто добавьте его в индекс, например так:\n\n  git update-index --cacheinfo 160000 %s \"%s\"\n\nтем самым принимая это предположение.\n"
+msgstr "Если оно верное, то просто добавьте его в индекс, например так:\n"
+"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
+"\n"
+"тем самым принимая это предположение.\n"
 
 #: merge-recursive.c:1252
 #, c-format
diff --git a/po/sv.po b/po/sv.po
index 93f3c6f3f7..f5a850f0b7 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -4551,14 +4551,14 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "Om detta är riktigt lägger du bara till det i indexet, till\n"
 "exempel så här:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "vilket godtar lösningen.\n"
 
diff --git a/po/tr.po b/po/tr.po
index 9a17c19b25..af5f9ba7f8 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -4619,13 +4619,13 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "Eğer bu doğruysa yalnızca indekse ekleyin, örneğinbu öneriyi kabul edecek:\n"
 "\n"
-"\tgit update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "komutunu kullanmanız yeterlidir.\n"
 
diff --git a/po/vi.po b/po/vi.po
index d730cf1141..beec050125 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -4548,14 +4548,14 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "Nếu đây là đúng đơn giản thêm nó vào mục lục ví dụ\n"
 "bằng cách dùng:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "cái mà sẽ chấp nhận gợi ý này.\n"
 
diff --git a/po/zh_CN.po b/po/zh_CN.po
index a531819623..69dd29140b 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -4567,13 +4567,13 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "如果这个正确，将其添加到索引，例如使用命令：\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "以接受此建议。\n"
 
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 9334b46faa..18e6b8985a 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -4692,13 +4692,13 @@ msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
 "如果這個正確，將其新增到索引，例如使用指令：\n"
 "\n"
-"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"  git update-index --cacheinfo 160000,%s,\"%s\"\n"
 "\n"
 "以接受此建議。\n"
 
-- 
gitgitgadget

