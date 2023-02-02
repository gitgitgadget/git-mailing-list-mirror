Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA15C636D4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjBBJxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjBBJx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3546B144B3
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so927952wmq.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDKL2c4jS4+lyhZLRjZx+DSWhTIiOWwZzSEkYPeD5ic=;
        b=ih0n7sfVOLaOyYANiFtFAC7LSlpCEGXs7bsEChBjd4MCcz3fdOIWTVs87Zk2w4S3rX
         LY+jKbBJ/v/iZrj2pn4OqjDhogqDnoDTl/oyLtbEjkEis9WNkgnpodbpIVt331ZqaYQ3
         7657bzY/cmQ6zRMSyYMRjsuVglQ6PC5kKNKNgJDz7Jn/RfS8kEwgSUH4nPW98lceyn3d
         g1sOCFJM5LS+vD/LZZ0Qab1oidbuddd1aZmzaOlXmz1R9aT3zdcVa6ysa4Dt/Bzi1z5O
         sDLZFRuax5Es2e98+uPMRObYam6FtRuAORm9Y32l5Un+PE6G66yacEkfBh/3mRU3Hbqg
         UKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDKL2c4jS4+lyhZLRjZx+DSWhTIiOWwZzSEkYPeD5ic=;
        b=Tdtpl/g9NvS1L4WGwK/nuCRdwhAgp0Pyn/+5SSqlTZfPGUEx+jiBF8yxWcNTLcQ7cl
         +vzhC+FTZjPXumdcOMIyyIspePqJrsPG1Un2vyGmB3mszxoTD31ExPMHg6LLV7aq+uc0
         4qroC0TO7/fB7DEhrOdiQ2F9O/FZqS5lpJkGgKOR6beNvHFshbDvYFtVwE2g1NQEnmO2
         1eX40Zf4ZXgEqiWOsf81vIARaqiFGGK3h2mcXQLcZQhKBySiBF0OGMZH47hEYPhYksBD
         4yk11iKPaFi2QYIKeTO7g13x6/5+arY4noaGRqAbF5dc9qLKGqf2pu2sSyForqr0s2rD
         PHoQ==
X-Gm-Message-State: AO0yUKUlO/+cbShJoN1AOJTcOYfTBtOfAR8QWpeYXJY9qGTq68hwktwq
        K27h+8y1IoUPtpCl3+0/oa3YSvtNW+tRQnCC
X-Google-Smtp-Source: AK7set9N8dor4g+/9JcC9msh+xRRl7zMZhxrXuk03gsYIHt6KPDxLo13nSZW78LP22mLpIFmL8QxWQ==
X-Received: by 2002:a05:600c:35d6:b0:3db:a3a:4594 with SMTP id r22-20020a05600c35d600b003db0a3a4594mr5824239wmq.28.1675331582147;
        Thu, 02 Feb 2023 01:53:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 06/19] name-rev: don't xstrdup() an already dup'd string
Date:   Thu,  2 Feb 2023 10:52:37 +0100
Message-Id: <patch-v6-06.19-bca659788de-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "add_to_tip_table()" is called with a non-zero
"shorten_unambiguous" we always return an xstrdup()'d string, which
we'd then xstrdup() again, leaking memory. See [1] and [2] for how
this leak came about.

We could xstrdup() only if "shorten_unambiguous" wasn't true, but
let's instead inline this code, so that information on whether we need
to xstrdup() is contained within add_to_tip_table().

1. 98c5c4ad015 (name-rev: allow to specify a subpath for --refs
   option, 2013-06-18)
2. b23e0b9353e (name-rev: allow converting the exact object name at
   the tip of a ref, 2013-07-07)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/name-rev.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 15535e914a6..49fae523694 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -273,17 +273,6 @@ static int subpath_matches(const char *path, const char *filter)
 	return -1;
 }
 
-static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
-{
-	if (shorten_unambiguous)
-		refname = shorten_unambiguous_ref(refname, 0);
-	else if (skip_prefix(refname, "refs/heads/", &refname))
-		; /* refname already advanced */
-	else
-		skip_prefix(refname, "refs/", &refname);
-	return refname;
-}
-
 struct name_ref_data {
 	int tags_only;
 	int name_only;
@@ -309,11 +298,19 @@ static void add_to_tip_table(const struct object_id *oid, const char *refname,
 			     int shorten_unambiguous, struct commit *commit,
 			     timestamp_t taggerdate, int from_tag, int deref)
 {
-	refname = name_ref_abbrev(refname, shorten_unambiguous);
+	char *short_refname = NULL;
+
+	if (shorten_unambiguous)
+		short_refname = shorten_unambiguous_ref(refname, 0);
+	else if (skip_prefix(refname, "refs/heads/", &refname))
+		; /* refname already advanced */
+	else
+		skip_prefix(refname, "refs/", &refname);
 
 	ALLOC_GROW(tip_table.table, tip_table.nr + 1, tip_table.alloc);
 	oidcpy(&tip_table.table[tip_table.nr].oid, oid);
-	tip_table.table[tip_table.nr].refname = xstrdup(refname);
+	tip_table.table[tip_table.nr].refname = short_refname ?
+		short_refname : xstrdup(refname);
 	tip_table.table[tip_table.nr].commit = commit;
 	tip_table.table[tip_table.nr].taggerdate = taggerdate;
 	tip_table.table[tip_table.nr].from_tag = from_tag;
-- 
2.39.1.1392.g63e6d408230

