Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70539C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiCEAQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiCEAP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:57 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BFB246355
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:08 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id j19-20020a17090a841300b001bedbb1a120so7967308pjn.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=M1aokkmgyUv58OLH+XTfzmmBZ9zFIbZIpt2C/IJDq+Y=;
        b=lRoRQZ6BCcWQpvYh9pAxux/AknILpo6dMigaehmGL/8bfvr9QseBd8Vt/mKrGEmRaZ
         luJgO+nOGPIYdIix9H2J2f2Nv0nRCdTI33kLxKfzsdXg9Jb3bnzxUUNSjj0QpjY4YLEb
         CyuSj+WnkdtDjb3c43YeCY9O/DSbtUJ91zTJBNQFXFJryoMMVa1W9NF38XdO+NX93aC9
         VgKAGQY/xyRwjYG0p5g7rNMe9BNw8h7kt0t+Nn0EPzV+ZP89ii5/6Q9e9+Nazs6nXQ2L
         jzwJRV1mUsf3S0gdl1GVbZflUr1UEd3KV47Z0QF1RMvNGkM64TF1wC3/YIYB7CisBYB6
         QGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=M1aokkmgyUv58OLH+XTfzmmBZ9zFIbZIpt2C/IJDq+Y=;
        b=SCAzlxrDE+dOezdI4zuVOlRJnqIX/U+FCbGZgcXIh62Ja9Rdd3wsh8zFehogGqE8hq
         aOnPiBUar2IYaZrMpr5OEdyRTBwFVDf7oGCNiuScwXfuB5tJu74gFl64Oug9a+UJRq5E
         azKQXQAnUQJgJSnXAPNTZ7yBOKAuy/7RMdV5iWnr8jh3kX8HHRwdWt5z64ngBrgpanO0
         dPsbaaI9ETsOrOEsAfgSuYsx3p0sRlFncjYN9ntxHZSXQbo+m8tHxKiLJ/fQC/lxCI6z
         IgWnp/GAUVG7Imyr702RG5MkdyDDwXji6lay/rtB3f88v7VlOejBpineZAxXt2MUjYKS
         wSZw==
X-Gm-Message-State: AOAM5315rXHwbiBpjqh5/HhhuIrxYFZmdH+kP74rFJmMdR2wTuDbfL8V
        qLFvdogu3jF0bPcBUWhFkAWoaszWGH/TJPVodL6Rxbcz2EijHlE0AOIznpqYjTDjhZZbLI0FSYR
        qwNXrLuyAEUzg3buT1YzVdovmnX9oGlKMQUOKVc1pyQM1DMcgbmj5S8D45s2N2xA=
X-Google-Smtp-Source: ABdhPJxkzHa4ctwVy8+pDXOq+rOmsxVEw/ACMlmpMEwgIpHAI/bSxkH7NbzCLpbSe9xrv4Y42zJ21+qBXWlJdA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e54b:b0:150:241d:c564 with SMTP
 id n11-20020a170902e54b00b00150241dc564mr873781plf.61.1646439307938; Fri, 04
 Mar 2022 16:15:07 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:56 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-9-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 08/13] submodule--helper: refactor get_submodule_displaypath()
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

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f673f7ebbf..52d4f47ffc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -247,11 +247,10 @@ static int resolve_relative_url_test(int argc, const =
char **argv, const char *pr
 	return 0;
 }
=20
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+static char *do_get_submodule_displaypath(const char *path,
+					  const char *prefix,
+					  const char *super_prefix)
 {
-	const char *super_prefix =3D get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -267,6 +266,13 @@ static char *get_submodule_displaypath(const char *pat=
h, const char *prefix)
 	}
 }
=20
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+{
+	const char *super_prefix =3D get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb =3D STRBUF_INIT;
--=20
2.33.GIT

