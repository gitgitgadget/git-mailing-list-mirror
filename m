Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2F5C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBFXIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBFXIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:17 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5040F6
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mf7so38748220ejc.6
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r32YOUi3/hD2J2xHGNU5MLe3BaAzvTq1alLQHZ/oi+0=;
        b=Y1MiG/2bTbQCXufFAyF08qjUFh/0rSuiNUbWgSY1Z9PbWrASepXIMMZTUtW3SO7UKJ
         9LXXX0aJaXgNgbh3uM43v9Y6JZcjQrKqrciMNXuqJtD/Sr2VEOFSU5sDvCwpXELxGKSZ
         MKRq/tWhIKXrcEVeScIKmKojpr0u0WvY5T5m8x04m6o5VdDdAk0a45Gh8vN3si3dNWz8
         e15a3a5xfM17U3P82vlWipDvvvLSYUzSbHNaC2PgfB3bNTjV12DiuGMIDa6dLQaZzQjo
         T4yc2spqauCBqAKpE6+VARUXxG2A1RAaNxntKo+1Qs0o37AYzfMRQtPa5GwkcA/4EsOG
         RD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r32YOUi3/hD2J2xHGNU5MLe3BaAzvTq1alLQHZ/oi+0=;
        b=QfGDda3+f6/ymj5yUD+/vZJuiZL9r5V9E8Y1iB2GKgvf1P6Xap1YuwThj/TxiPFWwu
         C1VMgBbjG050L2vm67oXboA63jS+wuQyZDaQZQ/3Eim9wNokKq4dlElnoqNpuxJ7YxSS
         UfR+XYx1UTRP93+2gq8O81MAy6sz21Qky2Z9N124MnzAdBBwAh4yLVRoE/uBhpFpU1VL
         2bOE921QbN2pbUwqsPYGkzAaduR9v6J0HWGZIZqyLrtCVXpIVaHpqP7n0eeyQN5XJI0v
         cIu7lufnPy6vUBNBbtgjm2dwP4WMY40+Hl7xf2KdInNs0hKUo8FKo+rdesjyyBmmmBe3
         Bjpw==
X-Gm-Message-State: AO0yUKV3jQXEY/mgXhyF8KmrmWqu3z1XHQtGzVwiWdf6O2Rr3gLL/lVc
        YcH/EwKkEWJn7Vl54CPCXH5YnwWVq/fdkaKR
X-Google-Smtp-Source: AK7set+GbmWA8ab4AB4i5GAslFJMKrJFatH1MwKt19HQe+JPsie32HvfyfOA+3erwC96ucRyCeNo5w==
X-Received: by 2002:a17:906:a255:b0:7c4:f8fb:6a27 with SMTP id bi21-20020a170906a25500b007c4f8fb6a27mr1446193ejb.0.1675724895220;
        Mon, 06 Feb 2023 15:08:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 06/19] name-rev: don't xstrdup() an already dup'd string
Date:   Tue,  7 Feb 2023 00:07:41 +0100
Message-Id: <patch-v7-06.19-67b8606c529-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

