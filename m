Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACB6C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiL3CTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiL3CSq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:18:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E91704D
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s5so28867846edc.12
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoBbEH2ijIuLF2v+LEPT44edGXSS+hZN9201U3uowYk=;
        b=Mk3VWJ4Aq5jZ45xkxCQxnXhZ2ye7i+pvnoWxIvWwxWcb4bxgWKcrQbqzgtkhfe9z+r
         lJqW1v1gzLlsAuLTGDILb0CaZ+6boG6+M+u0fokX82NKtYDLEGDGXayZtS9AbE0Dfbv1
         sBgya2wWHypu8wygtQXC9Yl8ODPKQ3dGxfeF609rP0Sh4V9IBT7OfwpXUMasdaDGW5yZ
         PXhb1Zl5cYMPjWyFITuRtN5u1qQyYaAH4Mquubd+/H/FWZpVp4BPECtXry/V67WsXzl5
         IL9SC2lyb5FHepkOj9MEUYc8KfuTJu446NGNc0VbNxaJIMhj4iFIQZejS24QHCu0s8ms
         dEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoBbEH2ijIuLF2v+LEPT44edGXSS+hZN9201U3uowYk=;
        b=WW9nUlKMXKsvwFr9LEsqNz8eVpwXqKdAfzJC28a2H0QtOtlXgGpDm5JJc9d3b1oGhF
         sT23qrToSFSJ2uaDqG98VB01+7+tk5hnf4ic4G6esHCbItWMCaW0HVX/hUzjBZnG6sbe
         rpCZvUkYOE78Nm/BAJURGgUIDRU+5WwkhZmkH46IpRpk3l33Wvj4XXFz/go1GyF1cnIY
         zkqUWlctuUnqNzX6oHJZnmfRQ6qgtaCb773/2fTfVe+lUALhbCa9r/epPCkKEFLBAjc4
         4pFwkqPWnjPdySunaVPg4f8CEWXIPZ/3gxC8h7z7M/ytO+eBNuko9z9JGcljevnPHSRO
         yBJA==
X-Gm-Message-State: AFqh2kp4f8Gzzkr8iYMKGfYWo0czYYEO/S1vOGJkkP4hhhhBoA0fRYw9
        LG46FzYFOgeepgGmqxw0BLxgcsYiItkotg==
X-Google-Smtp-Source: AMrXdXul18e/cxjrLwpq5nbTv18h2up5F/OT1zTTqq40pnu+77CENKzpyurA8mjMKISR7nEyLwdsAw==
X-Received: by 2002:a05:6402:528f:b0:47e:eaae:9a69 with SMTP id en15-20020a056402528f00b0047eeaae9a69mr24878779edb.41.1672366725092;
        Thu, 29 Dec 2022 18:18:45 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:44 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/20] name-rev: don't xstrdup() an already dup'd string
Date:   Fri, 30 Dec 2022 03:18:21 +0100
Message-Id: <patch-v2-06.20-7cea3da9fae-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
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
2.39.0.1153.g589e4efe9dc

