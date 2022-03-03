Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C09C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiCCA6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiCCA6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:49 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F15154708
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:58:02 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a200-20020a621ad1000000b004e191fdcb4dso2204579pfa.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=SASj7Pwi9GGVLI3+2BvvPv3frQbbas3/rP7hoCwAk+E=;
        b=SyM7jNKstKnIwM9Tut7uJrc2vuZu5CnjPzDFePZ5mM6NULVEb5TEGg6FAFsIw8Ukl6
         TqQsJF0gkI1MW6ePvv0olSfH643aJmHTUgy9f1VM8WgACF7/Ce5UihiMBw58/3vx9tyh
         3eZglBh//LgUAuRhNEmYsUi1QsaC66H47AU3HubEMxyJrOQdoptEz2lJvXC2bx0SMyHC
         QwFAyJLraJMJ8Amf49OG+NQUxKLjHE2dYXP7DVch4W2cvnYwnE84mm4KmRrUDdrg8D2m
         18A9gY5efw8qh0Zb1MH/0POA57vfH2qlhAVSgC00aikiKCnndIscvFRRdYIeafZyYEQv
         IDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=SASj7Pwi9GGVLI3+2BvvPv3frQbbas3/rP7hoCwAk+E=;
        b=ORT/8XHo4H38/fhFovVFQSAVpsulPUFcvRisczTVN8PL00atZJySObI7y0EydOD580
         1YxVrEYjvLwAQnUadRxaoU+5w5WDzWiwdSWLfjG4GPztJdHOrP1NH/GtxjxGL27uB2J4
         stmt8XDmzsPeOMT+Rr3jcKNkB5/bYSnchDEo7Z6+SUGose+tGhyY9JXmaIvtNdHDj2gA
         /uRt85dmT3P/aHJSgwMa3KLPNhouPfvMMHNXFrHfj71lAxdZ1zBOdfHKziSSjK5yYuCG
         CLVVN6KLNfc8B7lPO+sH+nc6Kgy4HMevw8YBWl+oByj6CnEVmkX8uF8Rs95QGTndfWuE
         kZuQ==
X-Gm-Message-State: AOAM532hJTiphTI6BrsHBzlGhDx4WFaQEXgC56d7W9iOk+Ai+JxqyNEa
        Tu/AslCohxMXIQqc5bgPnqppPJgixFReLhpii5GW4iWeHjaBquPCw3jXmLqkrmjfS9qxoacIX4L
        ZltWpdEuUjHdOIZ3BCHVGi4bqN9VxEVjVF6a0RoKKB/YmhaDW+pXiU3VC6Bp4iQk=
X-Google-Smtp-Source: ABdhPJx/bL/uJGZHydfr0Y0q1BBeMcfVRBsenToQdWs5l3VL8nIBv4OVu8l9wG1BE0cSEDY+2fUjlPRAmy8WAg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:945:b0:1bd:561e:b24d with SMTP id
 dw5-20020a17090b094500b001bd561eb24dmr2595795pjb.202.1646269082046; Wed, 02
 Mar 2022 16:58:02 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:24 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-11-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 10/13] submodule--helper: allow setting superprefix for init_submodule()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We allow callers of the `init_submodule()` function to optionally
override the superprefix from the environment.

We need to enable this option because in our conversion of the update
command that will follow, the '--init' option will be handled through
this API. We will need to change the superprefix at that time to ensure
the display paths show correctly in the output messages.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e6df99a884..69ada7f914 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -594,18 +594,22 @@ static int module_foreach(int argc, const char **argv=
, const char *prefix)
=20
 struct init_cb {
 	const char *prefix;
+	const char *superprefix;
 	unsigned int flags;
 };
 #define INIT_CB_INIT { 0 }
=20
 static void init_submodule(const char *path, const char *prefix,
-			   unsigned int flags)
+			   const char *superprefix, unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb =3D STRBUF_INIT;
 	char *upd =3D NULL, *url =3D NULL, *displaypath;
=20
-	displaypath =3D get_submodule_displaypath(path, prefix);
+	/* try superprefix from the environment, if it is not passed explicitly *=
/
+	if (!superprefix)
+		superprefix =3D get_super_prefix();
+	displaypath =3D do_get_submodule_displaypath(path, prefix, superprefix);
=20
 	sub =3D submodule_from_path(the_repository, null_oid(), path);
=20
@@ -679,7 +683,7 @@ static void init_submodule(const char *path, const char=
 *prefix,
 static void init_submodule_cb(const struct cache_entry *list_item, void *c=
b_data)
 {
 	struct init_cb *info =3D cb_data;
-	init_submodule(list_item->name, info->prefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->superprefix, info->fl=
ags);
 }
=20
 static int module_init(int argc, const char **argv, const char *prefix)
--=20
2.33.GIT

