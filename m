Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64053C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiCEAQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiCEAP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:59 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63415244A05
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:10 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m3-20020a17090a3f8300b001bd33af55f2so5544181pjc.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=KjG9drFUSjVnAJXDX3J5ZcaU+aLEydMBrQXjn+fFjOs=;
        b=bl9CkeuxEdKR7XOOLIxGro3Ci9007TYfEmbfK9TVPsG6d23g9WfiY4C8JhCT2I8F6G
         SikEjFNp2x8viOnSQfisWmJZzaFOKrfqRILabuxiry3MNOwkj/iBP7gdFeg/DCIHAF6Y
         J/JYO+ir1vdNI08SWuuVkJ+WYw/i+1LbUPGA8R7Am0vONgPUK35SXsoiyL9uktta3hGv
         87GbVZd/IEZLIFLpOT+RCehFIb8kGXA/PnXn7VYmVkhPRBPygzXUsCzHpGLk/BgrypoJ
         aR3VswC90hbCFiNf0/KYLpAg6FFJxgpQ4bPnXK8BvVXL+3wFTqqv0DUKeF0bX1ctDA5m
         Mhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=KjG9drFUSjVnAJXDX3J5ZcaU+aLEydMBrQXjn+fFjOs=;
        b=MtAX09Yj+1uARIpCNKGzKZQLfZnSzGObtJgsciexoR7VKwAmInSAzVSG1/aEcFlLTv
         MB0ierX7zr62rj6PAfNl5FmwdJ3+tAfy0fop+/K1K2TpA+ud0Zx1s513t76KfEqzditH
         gvcINNJx5p9xf+ypJeO3f8/G/RT1bba66dkLR7s4DEDzQrlNKs6KqAdowu9mDy5qHu5e
         JILjBo8iZ+GTk43oUL0zmg/SHk6s51WyPkgAMRg09f+jBfCujkx98cMOIytmdXbuTtio
         QKT1Fs0TWiaU96Yf6AH1vVPpQyncaOTIzf/ZcnCQMLeGxW4oZBXqgiuV7Ax3B+vT/MkI
         fNxw==
X-Gm-Message-State: AOAM533871nehBbJUtGjjD8PTDq5Snv3l44pT5kfJQ8dLcdGC6vFZYkR
        q+fvu+3XJFEXjVCK0Gz37IMIzFsmeeWpgWYnvHQIoE2eAYFUFqACL7XD6WDTBTnLl+7XfdMX3ON
        U5oQDpxVJjlqj42RBe2JeL4w7iW6tKuMcUqGswie906kRMjbfJesXAxs25ttUDgk=
X-Google-Smtp-Source: ABdhPJxtInt3SbXgm3hVwK/KbxsnJkailxdIvqeaxCaIy7teXU1ElivgyRM1YRXIguiPVvv8V7x4ZDQKbnmflQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:a1d:b0:4f6:d122:cd08 with SMTP
 id p29-20020a056a000a1d00b004f6d122cd08mr1189915pfh.68.1646439309816; Fri, 04
 Mar 2022 16:15:09 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:57 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-10-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 09/13] submodule--helper: allow setting superprefix for init_submodule()
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
index 52d4f47ffc..c6df64bf6a 100644
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

