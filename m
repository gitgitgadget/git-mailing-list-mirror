Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C422C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiGACMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiGACM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:12:26 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7293060508
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:22 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id jg5-20020a17090326c500b0016a020648bcso591653plb.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l4pUsrUEx/+7EPda9I7NMpbfcYywsaWP95UMb/3whBI=;
        b=mYlTmUM00VNHT8MACWMlQaWtPx0SgZBfWW7O7S5YpgWHqFxAdAIj9lxDfXj+3hFKVU
         5mV5a7zSUdPYQ2fQ/ZczyG7ajRacOCK4/WxVJ0XMpg7OzWJw4Wx+w9XewjGeF07HY267
         ulzugWxPQ0eWIC9gtRHve7Y91di7FCED5VYN/boVCD30tGj7egoXqnD55Zk3WiYUTujF
         gDm6y2HuXVIuXTSTawA6Po09dobHPggVQ6ke60Q4uy1bv8Yqm5nEbDQ8TXFFW2AeJBgq
         n+VeDZZeh+2mKkbzbr1jFY7WySpOBr+BMwv9Qji4+OKYek9xW5S9fFgiaBGxS532NG0i
         xpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l4pUsrUEx/+7EPda9I7NMpbfcYywsaWP95UMb/3whBI=;
        b=xNYn9n7frkSEBhra1nHlbvdTzKkpDvU2leOK8a9IQ9WwsVmleRt1e/M31+qjukAip6
         9ITC4cvXu7eeKhqfdz5NcY4t9LFCysdTmsEZe8swWsNwBTZXxHUOhYJtEwPIAX5DKSFe
         zI/gTt1lFx9AdbtJWIFsIW3HlwWqezzVxBkALyUNQT9R5CesDsFwHIE8cPeMhKGyEGkC
         ZEOjebd6L7syKG2rM85ai5EUUEl31xxTPo5e7VEV33Wd927IAWRVLA4ONhaFV2HUnT74
         PurYqDAqpLBe/zOHYCCQN5wUAHFkeQxSTtMS+xyjFuP5aV1Tz7WNVX9N51cGGMaFB5Sy
         KJyQ==
X-Gm-Message-State: AJIora+GRcSUucpFUFLlkTp4Rr8jhe+CnFqFPJeMmOyJ99Q8wAlVuPkS
        u50EFdPr/5aOYcN74vYFFgS6sYzzwCMunfDDiIEfSif7uZ91uzQgYrPwLvNkhagcVu7mGILqBlE
        OiPy5arR8geR7O4hTcXPS6rPWRhGyswb4CbXVqJ4NT3xF2qsKxp/H3whs9HADGfQ=
X-Google-Smtp-Source: AGRyM1sFgg/qQqkhkoOrKQMPANUkaNongP0D8CmEa2I/VKUTuVu+ihG8nR35/DR/Lomu3LPfhZohl7AATBWAtg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:c948:b0:16a:58f4:c142 with SMTP
 id i8-20020a170902c94800b0016a58f4c142mr17859292pla.103.1656641542137; Thu,
 30 Jun 2022 19:12:22 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:11:57 -0700
In-Reply-To: <20220701021157.88858-1-chooglen@google.com>
Message-Id: <20220701021157.88858-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220630221147.45689-1-chooglen@google.com> <20220701021157.88858-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 7/7] submodule--helper: remove display path helper
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

All invocations of do_get_submodule_displaypath() pass
get_super_prefix() as the super_prefix arg, which is exactly the same
as get_submodule_displaypath().

Replace all calls to do_get_submodule_displaypath() with
get_submodule_displaypath(), and since it has no more callers, remove
it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index eb84e3a98b..405a4224c5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -118,10 +118,11 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-static char *do_get_submodule_displaypath(const char *path,
-					  const char *prefix,
-					  const char *super_prefix)
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefix)
 {
+	const char *super_prefix = get_super_prefix();
+
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -137,13 +138,6 @@ static char *do_get_submodule_displaypath(const char *path,
 	}
 }
 
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
-{
-	const char *super_prefix = get_super_prefix();
-	return do_get_submodule_displaypath(path, prefix, super_prefix);
-}
-
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -488,7 +482,7 @@ static void init_submodule(const char *path, const char *prefix,
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	displaypath = do_get_submodule_displaypath(path, prefix, get_super_prefix());
+	displaypath = get_submodule_displaypath(path, prefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -1943,8 +1937,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	enum submodule_update_type update_type;
 	char *key;
 	struct update_data *ud = suc->update_data;
-	char *displaypath = do_get_submodule_displaypath(ce->name, ud->prefix,
-							 get_super_prefix());
+	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
 	int need_free_url = 0;
@@ -2460,9 +2453,8 @@ static int update_submodule(struct update_data *update_data)
 {
 	ensure_core_worktree(update_data->sm_path);
 
-	update_data->displaypath = do_get_submodule_displaypath(update_data->sm_path,
-								update_data->prefix,
-								get_super_prefix());
+	update_data->displaypath = get_submodule_displaypath(
+		update_data->sm_path, update_data->prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
 					    update_data->sm_path, update_data->update_default,
-- 
2.37.0.rc0.161.g10f37bed90-goog

