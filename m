Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154DCC433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiCAAJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiCAAJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:18 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5F99BB95
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:35 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id bm16-20020a656e90000000b00372932b1d83so7431149pgb.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=U3sHN7GCQX5KRbfYGK/0HSN2pSBikSSsMMhQoPIvv28=;
        b=BwzWpUQ4xwT0TLmFblbIgpAyOD6yuqiNDrqt19BIem3A3njHxsyCN8V2+121BdMe39
         TQ1EnYliDYWuuqh/ys+OorCxhnR1F0mZvEh/U81ZzIGFPQ9Ed+xbPVc9QiSPXH5EtWRp
         Yz1jpLc2oYpEA8QSxsS0KrMjTXK3x02Xrtj2eHpw/Yx4jVUCL++pcP98PeCTCfB1818q
         iTg0drJnwMNYHBa8llsi4qm5BPekI2OTjt1cCkoS0g34FouWvJ6+GXKsMjXXgf5SW+sv
         dl9enRyX4V7FoTOD0pVsc3S0svpv+LP8rBIv8c4j0bgXWiXXgpHELVV65hqq9+YP5St/
         VJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=U3sHN7GCQX5KRbfYGK/0HSN2pSBikSSsMMhQoPIvv28=;
        b=MMC6+Frh2Fth5hTsvFNQ0AWkdfHBELHmNPNKpKmoRHoY0ugJ7lZOkPEwzGm+Kv1K76
         v1DWyNCj5d7t1qLSL+hjiZBrL9Vbu+LHbm2lRvFerO2+la05m7Vju5Z0ej97jZFda6+Z
         wesM0um3u0zQgc9bCKY6e6HF/LD/1Q5M/Jhkp36xtBhuJ5IaRbbsguRoxmZzyWv3Yws5
         lZtojedQQ28Y7lhWykenwShgtnkcvshb4L843lJ4UiicGEZD08mPkK0nH704fT/7B2eo
         Yg0mHaAD0Z490qTXQbVdf9yVjA3zl2ZlMZPUyulS4l6FH/IuY+otX7z30rxjHVz08S+g
         FiXw==
X-Gm-Message-State: AOAM531iMpuxg4duqk+a81XqSd/t58YCkrxJuS9c5NRPAj820tIsOLnm
        6IQzEwZb8W2LNZE2xVWfTLg0QQGKUzWBp1Bl9u0hCWxr3aYMH+ITBy+q+m7XEwDJbndp0fCKR9c
        qYNRAn4kkB0cmF9fohoTHQjIgisp10XGIdxJhuwgVmMdblb9qzDkwI+qkG8YJ6uw=
X-Google-Smtp-Source: ABdhPJxH4reTSVqoOJJcdhesXEv+pkT192ZOj5IOUlh1pY6MfR6w1FbC8LHIQeCxeAa1tVbOVNnBrIdutdIdwg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:7a16:0:b0:374:90d4:b31 with SMTP id
 v22-20020a637a16000000b0037490d40b31mr19558361pgc.273.1646093314865; Mon, 28
 Feb 2022 16:08:34 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:10 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 07/13] submodule--helper: don't use bitfield indirection for parse_options()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Do away with the indirection of local variables added in
c51f8f94e5b (submodule--helper: run update procedures from C,
2021-08-24).

These were only needed because in C you can't get a pointer to a
single bit, so we were using intermediate variables instead.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f934e33c7e..5fbf8713db 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2024,10 +2024,10 @@ struct update_data {
 	struct object_id suboid;
 	struct submodule_update_strategy update_strategy;
 	int depth;
-	unsigned int force: 1;
-	unsigned int quiet: 1;
-	unsigned int nofetch: 1;
-	unsigned int just_cloned: 1;
+	unsigned int force;
+	unsigned int quiet;
+	unsigned int nofetch;
+	unsigned int just_cloned;
 };
 #define UPDATE_DATA_INIT { .update_strategy =3D SUBMODULE_UPDATE_STRATEGY_=
INIT }
=20
@@ -2579,16 +2579,17 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
=20
 static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
 {
-	int force =3D 0, quiet =3D 0, nofetch =3D 0, just_cloned =3D 0;
 	char *prefixed_path, *update =3D NULL;
 	struct update_data update_data =3D UPDATE_DATA_INIT;
=20
 	struct option options[] =3D {
-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&force, N_("force checkout updates"), 0),
-		OPT_BOOL('N', "no-fetch", &nofetch,
+		OPT__QUIET(&update_data.quiet,
+			   N_("suppress output for update by rebase or merge")),
+		OPT__FORCE(&update_data.force, N_("force checkout updates"),
+			   0),
+		OPT_BOOL('N', "no-fetch", &update_data.nofetch,
 			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &just_cloned,
+		OPT_BOOL(0, "just-cloned", &update_data.just_cloned,
 			 N_("overrides update mode in case the repository is a fresh clone")),
 		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch"=
)),
 		OPT_STRING(0, "prefix", &prefix,
@@ -2616,10 +2617,6 @@ static int run_update_procedure(int argc, const char=
 **argv, const char *prefix)
 	if (argc !=3D 1)
 		usage_with_options(usage, options);
=20
-	update_data.force =3D !!force;
-	update_data.quiet =3D !!quiet;
-	update_data.nofetch =3D !!nofetch;
-	update_data.just_cloned =3D !!just_cloned;
 	update_data.sm_path =3D argv[0];
=20
 	if (update_data.recursive_prefix)
--=20
2.33.GIT

