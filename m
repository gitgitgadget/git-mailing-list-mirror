Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E99C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiBJJ2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:28:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238516AbiBJJ2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:28:53 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1440BD95
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:55 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id z12-20020a17090a1fcc00b001b63e477f9fso3562096pjz.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=d5OdSxOJpSIJ8Imz8Plwa6pJa7oLeJV7xRwU926Etao=;
        b=V1tyAzdPkHIDoMqtjfESXGklX4nmMlnKZilnXmirRRT1m6fWpEEF2IeWw74FZeVdon
         +ySsmrDcxRsdJSgMG5dFesn5cnGxTTWylweMY6r4zHrybMUErBaYodu2j/9oTab0VT/+
         AZvDdRs/MqF4hdZ1LD6aouWO+SEU0nGcMsd/j1rwmQaACIa7MLT0UwPtx3lGOfUVPq3/
         QSOZymB6AByR27yBAXzzsOxOI0fk62bnGHcBHNgs97S4Eg9RXaHCWlgLXq4qlLiabax0
         4g9iYD40ppsQhFe+UQ/PJax88ERscufRlnCCftCfo3wAdpxrNiKLnc4UUCSMDGDwJGYw
         AjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=d5OdSxOJpSIJ8Imz8Plwa6pJa7oLeJV7xRwU926Etao=;
        b=CNxsbh1P+pBukl4dD4/Ti66vnaFmena/mXKYBmX9bJNT3PSvF5QCROn/PtdQqLFVYs
         ErHcqwz2TBg4agfWKMb+Z2Itm/X/Ypei8o50klX50s7K/0f/+iLSpC2UnI9Nz8APdhxE
         IxciXmnhTds+xr5GJV/+2yGWjsDKgpxOy7L3G1ojKO86Ugz0bNQDva3hs7kK+bVn+J4N
         YdAXNCtHVEA4bB+kFydjf5fJ6YM1nwgfY3JAE6wOUyesZ43OcQqRlrzi9jRYJ1T9Ivnj
         T25OCdFXxuv5Ua+ZZPQlZKB6S7KzDofZb4xxQy7C7qNIAkGsNTObmMV7YeYEPl7XO3yp
         JaaA==
X-Gm-Message-State: AOAM533k2OSOM7iDyHCUfEYoLvRC3lG2VSr/Bw52gruuJ0nMk2juMqnY
        tPCUaEVhtPMZ+etOTalcFplhf0LGMjQX8JkDO8AfOo+rfwGbkzeqKG8kPz4kx/LNBxhGB+rOz5t
        +O4HhkG7Gl4cJ/2O2fPeXdZYE/vn15OuCvTGINEiIqtVQ2p4ZjGr/XVxn+8Mcav0=
X-Google-Smtp-Source: ABdhPJwsQWl26Xaf0eoRg43T22iSSnycrFIqyp3D+ycEnoq31YSMI1J+zID9baT1LPz1oNI6ytfi4IoDaZM97w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1d9f:: with SMTP id
 z31mr6433395pfw.38.1644485334390; Thu, 10 Feb 2022 01:28:54 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:16 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-4-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 03/20] submodule--helper: allow setting superprefix for init_submodule()
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
index 5efceb9d46..09cda67c1e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -606,18 +606,22 @@ static int module_foreach(int argc, const char **argv=
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
@@ -691,7 +695,7 @@ static void init_submodule(const char *path, const char=
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

