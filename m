Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A1C32793
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjARMqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjARMqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:00 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24637B7F
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:41 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mp20so36115907ejc.7
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJsc2mByCTaVzvS4IrvPa5rvQz9EYF3b31Yl3yAfz8k=;
        b=MUCOjqvwsgYxdhrutFq4+jmA7TLR9L5p9DF/EwpHp+c0oKZyphXDlkvicH0jUfpmed
         6pR28aaJOWxpRNQtAWMaUU3+HbqV9dwIwC3KewWGxqaObdZwwawjWG2wZt4yDSHyAB0C
         fYEhj6tB57Z1AhALdW2jqgNYP9UD8B4iqY9hfB+s32j8gbFcIs/sVeOe2vtCvc4xmd32
         cldXuTgn0rI/siF1KtJ6xcRy2TI99Y+syxxiJhzujVhu96ZdiOP9BYUoAXv2TYkiMttm
         cobMma7+L43SnOl5qLcQZTBeY3PWXp5zF2uOo7l8bkzEfgRLDA4XPat3v0fhfcoDfqi7
         uMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJsc2mByCTaVzvS4IrvPa5rvQz9EYF3b31Yl3yAfz8k=;
        b=3qvFhPiV97F7qsY1+FUbJ48cytKlmC3QsvYNKv2uODtX9KHXLNtC6u3PmNhSHkZeQO
         O6N/f2bUHtEMX5CRWbdd82IDnnIEKJkbSjBvQFdH8F1VlbkFbES4xiA4YDjQL9Xl/YwG
         wuCiHdbyWOYxHSy8ed2rKieGulxjtkviyRAr68cISiq77jAZi5Np2sWw2F3urTql0Zo+
         qSVZ83m8UUBwx8wNCU14+1BoKrDcuVf9SRl6ladUUgJ5jVzwblCPgvqa/BNZoyJS1alq
         zWJZmh0l8isLX3XOA0tjmI4xj9FdbfDxMV8A/5no88r7tTgzBhRCU+dESoMTypWqxKJx
         dQaw==
X-Gm-Message-State: AFqh2kob3UN1+ik5yhXd1uJ7ctX7GqSrReOUVfixeL1Tqh2lOoO8/wKy
        D9N3PfUNjGDB5vPubiLJrilwzNiO60XVag==
X-Google-Smtp-Source: AMrXdXtExrHq7/u6kfeKbnsp7d067HJ29vL5r0uaCoQyrofYUVTPeK0Z3CTILjp9s+Jc+GkENqmxMQ==
X-Received: by 2002:a17:906:4f07:b0:864:223:40b with SMTP id t7-20020a1709064f0700b008640223040bmr7245184eju.33.1674043719484;
        Wed, 18 Jan 2023 04:08:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 06/19] name-rev: don't xstrdup() an already dup'd string
Date:   Wed, 18 Jan 2023 13:08:19 +0100
Message-Id: <patch-v5-06.19-eb5dc3ac192-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
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
2.39.0.1225.g30a3d88132d

