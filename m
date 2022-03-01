Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA27C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiCAAJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiCAAJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:19 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB599A9AF
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:39 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id t12-20020a17090a448c00b001b9cbac9c43so421786pjg.2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=DgUdkc0m+74oW8xklSVkGtmzI1w7EDX7zp1aA4QbA1A=;
        b=FJHQFfVKDCJgeCZXyV6rTgI9xhVLgilLyFzuNPv3vhly73/CuDU6+UgRwGDusyF7+U
         KAhdehPcaM5Ae3qSppFMmWO3e45i0KZsNzk9Hi6SSnYusg5k/wXjjlnhqIbRO6AmWZM4
         RGMFXBaGnvLzrDjs/mR6sOGEZ5Y6CJKqfCvlcxK4ArK4eIKM1vuFdoWZXQ/rT0eC8UBi
         eoXmcGrEQC90hNc8lF8rTqDC0BUQBg6Wx+5ev+7q62XG1hG2DFTM/PZk0j3dhGPVKtjq
         QZOpwqrE9kh53pXBBIIqB7mWRt51FPrpBL4uLALXO/ipYggI5rxmzLDAuOgMqwlKuzAP
         bUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=DgUdkc0m+74oW8xklSVkGtmzI1w7EDX7zp1aA4QbA1A=;
        b=ttLljrrpBl0T3cKV24GR6syZ00pZqkzHiSZox/A9DNQzOwR04KFHOgTrvNAmb7yZyi
         6PpObRHay0cUn5S9XoSf9GoApggILSUI13iEv6z9uQdVY1dlAtL2BKfLR1won1haTPFl
         P7M6JtQuaZfXKUeEV2K4Goo/Ee6WHN87nBt06+FOV24IUX9KVC9tv2VhMY4VFJM2YuMU
         Fb4lsU3Q2SPyOm75jv3N2wUBAsBBozcYbDgHRaIYYuJSVZdwZzl0BdU277BilH1liQ/Q
         Dzu0b+mS8CcJCKw2NJM6grlif3NA/JgQmw1xeULFcHFROsA85NjOLqpB2cL02my9QtEt
         bboA==
X-Gm-Message-State: AOAM5328jeJ26kEcWk4Tnf/LzJd0mNhAiLntjRmgpqqLgkEirdBunAo4
        Ghvc3qwRAU029zVKtByltmD3F6Sj0+rZGdQaQLAoTL0ciZoUXt+FNvs5ZLhM4V2HAUhI20t3lX6
        FmUtGOJkEMqfDV6a093JTmGIQMZFWCJdKGguXVE10GFeTVb/i6jkZT+74xsb2tfY=
X-Google-Smtp-Source: ABdhPJzjMHx8tImnmAtxOR3rnO3BBqxvfBKpt5KguT5AaayQVmTBKoEguUhGMoKcrXDOx5CJPemNl9JGDCkaow==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:7352:0:b0:375:5942:661 with SMTP id
 d18-20020a637352000000b0037559420661mr19361152pgn.471.1646093318931; Mon, 28
 Feb 2022 16:08:38 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:12 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-10-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 09/13] submodule--helper: refactor get_submodule_displaypath()
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
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1d4d9231ac..3598069de5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -248,11 +248,8 @@ static int resolve_relative_url_test(int argc, const c=
har **argv, const char *pr
 	return 0;
 }
=20
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+static char *do_get_submodule_displaypath(const char *path, const char *pr=
efix, const char *super_prefix)
 {
-	const char *super_prefix =3D get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -268,6 +265,13 @@ static char *get_submodule_displaypath(const char *pat=
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

