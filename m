Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0ADC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiCAAJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiCAAJW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:22 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDD59BADD
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:41 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id l6-20020a170903120600b0014f43ba55f3so5317631plh.11
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=q7VO7+zHWCqV3qOjSOPfDL0x1ypvI3q6h4rDySLILpA=;
        b=pZE9sQsJmbXO5EbMgPrA7qVBIa2eNoXPW9aG/FgHG0Vju9CwbJ2oLCOiquuG1y3kyh
         tBa59RXcBYzmSJB8sDaLLsmWEyDkBQCh98AAqmm4PxWamWMJngncES84ME4DoEYV2uoL
         Ggj3IQimVMgnInjeiMNGN8DeZoIYC3Z7XPFaCAq402xyUN4yZrOS3/+aJJ8eeCIvUl54
         y9pWaUfvQkyTm7SMGYvPFw+KZndRM3juZEKjYfyUFE0Slnc4ujaCIk6TzcrLal+6nN5s
         T/o7CMey8o+efS8XE4Leec5NWFB9/FRLPSJKU6ZOgby1s2zvXBGLlgyaEFawDRQ+F+UB
         BIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=q7VO7+zHWCqV3qOjSOPfDL0x1ypvI3q6h4rDySLILpA=;
        b=VEXAIXF99RFvkzDi+kwdD1ZE3b3tbjm39uOCaf5fkrbAgJKvAX1bPKoo/tnn2Ibd+J
         fak7kNV2W4pc73EEQkGim8tVnQHcsWgqgKQd5UgV49kx03lgEApP14tOdLFnC0cSRaf4
         BZj4xRVpzHWm9KeB+OI5+lv5dAYW8uLu6qGd2fMGXln7g7SMQOHDwfROJH+WyZjH3/Tt
         zwdBC0aGilVj+vjeNPgh6mHhYYsKkQiIRVOmZ5ULEvvUbWClh5JZyuyz4bEFQ6EE1/Ve
         dUPr9KX+leMf9J57v15xfgbwbxNKxAYGBcXmH8F6izH4Q8nildZSi05XnIQZeOUhqKBG
         srdw==
X-Gm-Message-State: AOAM531ni7FbNYcalcH8QxigPMSrWMfy8FFKVp3ESVjlgwo8KJVBN2sk
        fSwIAxygDk/Op2FcZQsZ8uuYF2KURK9fOda6VpM44we5v1AUzAYwVcDcvvAsT0da2hcgvvrrQ+A
        2we3AoxkNJh+BdiCeyHwIZklil2uY3v2jGeavgVObAJPNGOF78Bj+L3BonqGOH5c=
X-Google-Smtp-Source: ABdhPJz729mRQtsPs7UzfLLNLSVK3NW2WUak1No/JlbQmn7UV7voJRQ6xgxv5hVtwK58Ps7G720txCOfE+BppQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with SMTP
 id pj3-20020a17090b4f4300b001bc7e5ce024mr324849pjb.0.1646093320955; Mon, 28
 Feb 2022 16:08:40 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:13 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-11-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 10/13] submodule--helper: allow setting superprefix for init_submodule()
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
index 3598069de5..c3760f511d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -593,18 +593,22 @@ static int module_foreach(int argc, const char **argv=
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
@@ -678,7 +682,7 @@ static void init_submodule(const char *path, const char=
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

