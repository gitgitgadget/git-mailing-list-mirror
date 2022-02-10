Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B0C433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiBJJ3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiBJJ3D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:03 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724A510F4
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:03 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id hi22-20020a17090b30d600b001b8b33cf0efso3896556pjb.1
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=puu5AcCYsaaMCyP0Miw6o/BQAKwD83xVxXobDV0qE4M=;
        b=ae7YbC3m88t3k0G55nIaWnGfebWPCzor2XmEqpBlibQnUZz+dPZ6mMMXOkA4ih0g8y
         0BgsWf6qCw5IMivXg3Prs9FJewDA+dF9vwvOE7qK+bHBmH95TVS40tIFtciuJy4c9Js8
         UUSrKZcjxj5Xt1eo3qdrj68nsPJXPnZy1N/A56s8M7o5iCevJ4wse++gGtvygXxQtzVP
         1oB/Bt4LY2wbLIsNCATW3TPqH9y2Nsue53OIYrdlIMQucfS5BxOyQTP4oBPv09r1DaC7
         KGgMSUhIelYccaSMfoA7itG9pxI2tUKvuwE0zSX2Izj9Vrg4sjBhmeFNoRmqh5cxncOv
         Ecgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=puu5AcCYsaaMCyP0Miw6o/BQAKwD83xVxXobDV0qE4M=;
        b=coCEbUPYWRT0XYgKW+MO7WkgjYn/tp2AYiYuk/R8iiOqXxZVv2ulpZQIjWbuYpuZI/
         2pyFYLiS/Bq0j3zD599B+jrqqtdbtU3TGH25MQF050b7+v/grvYjJnEmSBM5sm/hwE4S
         T31FCW7bplzKbiUJzwG+tLf1BFBIaEsuv/059J3BiNDi4YcIVKvlTU/CWH05/YlSpnJO
         5SfvUbjosYpcPF9iU1NCOXAKMf4BQ/T+N9AOzcFxdOu2HX0itLd7i8+qq9IY+F7hP/ZP
         qW0th6tdKxC7ucAuDP3QZzDa28J2KQNQySlJSGTsI0qaQzi3xaH9qJV7Vl+27BZSCTvi
         SpTA==
X-Gm-Message-State: AOAM531fyiupUY29jt8Qm6L6kqzpGnQJ+2GAW67hLW8ZZtbwtHxc8bcv
        4uZGyO3ln4aDUvoKpJHT3dArAyLvMMIfiSg7RAXUEOiNWnhwRX9eFIdnM9L0f+daPjDJdIneHI8
        nZH2p3lqzGUlNGx+RgaKLHovB4K/bCbWuP58NToLo6ZW7pAO8KOL3bsW93O4JmMY=
X-Google-Smtp-Source: ABdhPJzBcmigvrQG5c0i/f5vLjwk/sqVjNFC0vRhKCagI/Vg77BkoKHn0qzj9BJJB+gKGYlefHCPhI08P7qO7A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:15d5:: with SMTP id
 o21mr6725653pfu.9.1644485342844; Thu, 10 Feb 2022 01:29:02 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:20 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 07/20] submodule--helper: don't use bitfield indirection
 for parse_options()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
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

This will also make a subsequent large commit's diff smaller.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c2d4fd0347..4a0890954e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2045,10 +2045,10 @@ struct update_data {
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
 #define UPDATE_DATA_INIT { \
 	.update_strategy =3D SUBMODULE_UPDATE_STRATEGY_INIT, \
@@ -2578,16 +2578,17 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
=20
 static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
 {
-	int force =3D 0, quiet =3D 0, nofetch =3D 0, just_cloned =3D 0;
 	char *prefixed_path, *update =3D NULL;
 	struct update_data opt =3D UPDATE_DATA_INIT;
=20
 	struct option options[] =3D {
-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&force, N_("force checkout updates"), 0),
-		OPT_BOOL('N', "no-fetch", &nofetch,
+		OPT__QUIET(&opt.quiet,
+			   N_("suppress output for update by rebase or merge")),
+		OPT__FORCE(&opt.force, N_("force checkout updates"),
+			   0),
+		OPT_BOOL('N', "no-fetch", &opt.nofetch,
 			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &just_cloned,
+		OPT_BOOL(0, "just-cloned", &opt.just_cloned,
 			 N_("overrides update mode in case the repository is a fresh clone")),
 		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
 		OPT_STRING(0, "prefix", &prefix,
@@ -2618,10 +2619,6 @@ static int run_update_procedure(int argc, const char=
 **argv, const char *prefix)
 	if (argc !=3D 1)
 		usage_with_options(usage, options);
=20
-	opt.force =3D !!force;
-	opt.quiet =3D !!quiet;
-	opt.nofetch =3D !!nofetch;
-	opt.just_cloned =3D !!just_cloned;
 	opt.sm_path =3D argv[0];
=20
 	if (opt.recursive_prefix)
--=20
2.33.GIT

