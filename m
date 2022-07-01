Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F399DC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiGACMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbiGACMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:12:17 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BF25C9E4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:16 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id u6-20020a17090a1d4600b001ec8200fe70so670310pju.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OhxB8Ha20RvzutIxfZ24TgLwnYOTpOhJl8faME5W5zg=;
        b=BMPxlux/Pjj0IlgFgr8RrzQvLGuyHYk1RHG4Z7D2aJR2Shi1rmFtlEXD4d1LUy3JZ6
         Qi2seyvp5KqXY3FQFgTgfLr7qjqshK337Le2h66hrg3gOsLkdUWhQ0wmZqUn/nnnZw10
         cqcPn5jEMGgnFsMFnTZZipMWLMPsFH9NzaRel/++y88FiQSI1+2ghONDSG4gLS8OghoJ
         tPbZI63CvaAEZfIt7w85WDU75KLnKGjI491bK5ghRoBmB7j84OwI0KWImvUe8msKogqV
         IzlKlpACYGUUYC57G+aE4TbkD1GYwzRhFijXeFmjGzfglM17xnnbTXtUw3cltbsFDROB
         LSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OhxB8Ha20RvzutIxfZ24TgLwnYOTpOhJl8faME5W5zg=;
        b=iGuoLERNGQiKmvuxiHSTJ/ahmDgwjf7vP2rIgWaGmLRYK0cucd8wdC4zBJmZNItSgw
         YHB58mzoss2x5idOublVMPRwYD3SFq3AYZtENa/CioceJtf5huckmIfTqvGhK72XRdH+
         VxjlrMz6KFra8sBsopH6feu+DkA/U9WDmPcjC9yE0wGkpfqKinBo5/qhPfLdjGy3pKg6
         32SztpBuZBy2DATEn0xMMR6MfvnAkJJ3QlxKe5AzEIqIlWljOZ23zba9CczLkSJ1ZrHw
         Tl4oVpSdoKjc6uszvHoiTA7N4dHZkZn88SVgX0yM/T8xlFx5N1nPikiJYbcnvNm5uhcG
         en/g==
X-Gm-Message-State: AJIora8ocq8hxTqCeXtFG9Qae/9qpK3HIxW6nnB4t3lb8HMzTK79y6Qn
        3iExccRVmLlyJ4rxROdPHeMsLcIwn2L+GM6k8UQswzBTdM+si5shg5f9xHjNbBKSsT6H4lzzjak
        lVZpQ97Lzc8yoOmGuak23VmFjOl3YA6xIuZvyzlBgQz6KW4IrlI1jXwGobmPCV2c=
X-Google-Smtp-Source: AGRyM1saIhBHscNTHyVNpap22Op4M5Si8ypOrofUGH9MC+Tgf/vpTA5eJojAwC4rR0+exmfrcOJtZzs2dYV79w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d50b:b0:16a:2cb3:750d with SMTP
 id b11-20020a170902d50b00b0016a2cb3750dmr18897762plg.17.1656641536279; Thu,
 30 Jun 2022 19:12:16 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:11:54 -0700
In-Reply-To: <20220701021157.88858-1-chooglen@google.com>
Message-Id: <20220701021157.88858-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220630221147.45689-1-chooglen@google.com> <20220701021157.88858-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 4/7] submodule--helper: use correct display path helper
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
index 4a0eb05ba2..65350bde4b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2463,19 +2463,11 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 
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

