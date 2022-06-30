Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F131EC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 22:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiF3WMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiF3WMD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 18:12:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983535721E
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:12:02 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id a19-20020a17090abe1300b001ecae1011fcso2009718pjs.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7FPH+Z1TPp843C1JN+zunsLTn/GaqmHSFrL8aHYJeQU=;
        b=iWPIiztB/yN9gbEIozx1hy2OKNUVAKAu6Zry0TBxfNxH6X3KCKCfGtjN3jBQ9jmynR
         +Z0BfdNy1ViBY+38o6h5SygRTqg9yCAIIb2OS4sw9Po8SRphs0gkylyvIH/7Cx8WlD5o
         zJ8QqBozSSsC/xRiOsWPax6mCrVcp79XKPev5UE9creqxRGdlmLvwiROiZGcnyqEai4w
         78TkQb73Fb/ZQFGj3IRbYt6442Z6D/3JnE2dBuxtfrFseE7aK3Bz+Udh7WhLld5n+Aji
         wEmapyI5Hxih9DlJq8N5nuEhpbbc5trpaJoqZDRh7wB/StU36t7vHuMN6HgN50jDJCa3
         fEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7FPH+Z1TPp843C1JN+zunsLTn/GaqmHSFrL8aHYJeQU=;
        b=tw691pPD2g64v0nTZcZXRfiSvGUU7Nuysgv1TwK987GWVoyPnNzxtztbTpL6ts/rBU
         Mrq4Yzaxmu+0UA36o+3+3t7Pi488LpiU9YhXZ80X7IjGWnnljFCfgazsztgMTDKgFX1i
         NPoeSo+I8uFxM5IDg2ALppZ4+aPgi0CLRd2VfmlCOu0COGUuvL7qtBQzVbardM+TpVld
         Ks3CrLbBAc2af6S2d02a8te/6srmc/ebzrA9Y0uU6zdkyAodZcGM+YSp5kvlIeRH67jU
         0S2fWP8x5sYn6Q+r1pIfsr9qtT9fgeL4J2lZ05GpBgQuPzIgTczn/kCRINMoNTXjL01F
         KPRw==
X-Gm-Message-State: AJIora9ikGAl6dRgQzlu15Kspj0FgCqWsasEAXKlcEM7n+nFKuDazezL
        yZtWFT82xmcxVexP1xz7yu9MWH1lGXdEBwTQCShrN6Ecuf+6uZDcK96NDo/ZZiIoKcF4mvVdUHY
        WuV5bZ7dXOzXc9YDkNSs2IQUEnsjp5NSD7GauOB3g7bQu66FY6+eS2Nep0ldO20g=
X-Google-Smtp-Source: AGRyM1ugp8mTInRzTn89dTmLuO+3dPEEn+uE7zkBAuNm8DMHT06IPtyxIoA4yDNP1Fo9A1AagYYnKk13NH5T+g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:4462:0:b0:40d:fb07:ec27 with SMTP id
 t34-20020a634462000000b0040dfb07ec27mr9160634pgk.346.1656627121643; Thu, 30
 Jun 2022 15:12:01 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:11:44 -0700
In-Reply-To: <20220630221147.45689-1-chooglen@google.com>
Message-Id: <20220630221147.45689-4-chooglen@google.com>
Mime-Version: 1.0
References: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com> <20220630221147.45689-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 3/6] submodule--helper: use correct display path helper
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace a chunk of code in update_submodule() with an equivalent
do_get_submodule_displaypath() invocation. This is already tested by
t/t7406-submodule-update.sh:'submodule update --init --recursive from
subdirectory', so no tests are added.

The two are equivalent because:

- Exactly one of recursive_prefix|prefix is non-NULL at a time; prefix
  is set at the superproject level, and recursive_prefix is set when
  recursing into submodules. There is also a BUG() statement in
  get_submodule_displaypath() that asserts that both cannot be non-NULL.

- In get_submodule_displaypath(), get_super_prefix() always returns NULL
  because "--super-prefix" is never passed. Thus calling it is
  equivalent to calling do_get_submodule_displaypath() with super_prefix
  = NULL.

Therefore:

- When recursive_prefix is non-NULL, prefix is NULL, and thus
  get_submodule_displaypath() just returns prefixed_path. This is
  identical to calling do_get_submodule_displaypath() with super_prefix
  = recursive_prefix because the return value is still the concatenation
  of recursive_prefix + update_data->sm_path.

- When prefix is non-NULL, prefixed_path = update_data->sm_path. Thus
  calling get_submodule_displaypath() with prefixed_path is equivalent
  to calling do_get_submodule_displaypath() with update_data->sm_path

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c104b1a023..aad431f898 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2464,19 +2464,11 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
 static int update_submodule(struct update_data *update_data)
 {
-	char *prefixed_path;
-
 	ensure_core_worktree(update_data->sm_path);
 
-	if (update_data->recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
-					update_data->sm_path);
-	else
-		prefixed_path = xstrdup(update_data->sm_path);
-
-	update_data->displaypath = get_submodule_displaypath(prefixed_path,
-							     update_data->prefix);
-	free(prefixed_path);
+	update_data->displaypath = do_get_submodule_displaypath(update_data->sm_path,
+								update_data->prefix,
+								update_data->recursive_prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
 					    update_data->sm_path, update_data->update_default,
-- 
2.37.0.rc0.161.g10f37bed90-goog

