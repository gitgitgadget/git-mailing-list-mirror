Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF3BC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 02:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiGACMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 22:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbiGACMO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 22:12:14 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0B5C9D5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:12 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id z35-20020a9d24a6000000b006169679be60so523782ota.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 19:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5rKBXAkepuPmAcAwO6HKgUAqFe1oVJv4K7pGXgqHBx8=;
        b=OcR51Ey3Xd9S3pMqFpoRRfBaZqnBzr/VqwXUP1wHa2Nty/f8IwAGgRXueqh1nR73g5
         7zvoNx1+gkz5I1Bp+4ruTT7kD+cqjEvxBbypZqndvYDIegNO4997zdTxiviZEoYrNuJL
         Cb9GOIIui040iOzs0kSSZk8jL3O5lMFYqdomBnRY89G7LD3I5JBK0z403yEoDKiZovmA
         WLu7PP18vS47DYhmCXdLNiNDF9XeIUgx9hvA+HXlxP2z6snFVOYCmvf1fIE+cuqpi5od
         vk6YYu97jnow568HcvMpdSQwEGFm3R9Ft9RKI3Mhx2FKPS2W20mTzqkBpy1GsNF2tsF/
         kqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5rKBXAkepuPmAcAwO6HKgUAqFe1oVJv4K7pGXgqHBx8=;
        b=Dnr8PihHFlDmW6yREkC9vwL55Ekmoa3JR5WQ+rcIg95Dd+D34eTbQBPDFMKkQh/mR9
         C0dMutLsVNyoDw1/kJZ3txIipFApBMqruGAvBVEpMzothgB8w4AFJKBpLgv66Qbfc9ea
         CWmE1Zzbx1V2JKOcHonsorEAnqpE/qCv6HCUJdbT4MPQwFgeqKrT4HGNc50y51EiO6H5
         Np0WwuRSSS2noY78/mtFeyepmlRfFqKqo/q1rqTOoh3pJ9vySOBIw6N2KfaymfSKWB/u
         0Mh25S4foxcAJwp5gqQg2enrVc0SB7zjhE1xk6gceHrpC0fTu471FEWXwbla7Gzbnb5g
         qPGQ==
X-Gm-Message-State: AJIora9yO4NYXTN7sm9gECCU0VBLqlcojem22Tfzc9u+MAm1J1BK5YWI
        fd7b8lIOcJ9fYHNkwWCDSDTG2fibMtPbpB14WwK6Blz+zfLdxr2jo3A9ToQTI6Uk25ZfMwKqYVL
        M3mt5Z+g3kwzYjX1MFlNDsjkHPD95GB+NM27y5tWsTTGg5MGSFeFGR4QkdIj5bPw=
X-Google-Smtp-Source: AGRyM1t30R6HbfdviTWODJJhxZiSx4UvmQYfXBKxX3OKW4mLFxzJLwJg4CmQGegSvzFYki0nXBFQZe5eDoqJfw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6870:1e8c:b0:106:a0ac:9f73 with SMTP
 id pb12-20020a0568701e8c00b00106a0ac9f73mr7046050oab.163.1656641532122; Thu,
 30 Jun 2022 19:12:12 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:11:52 -0700
In-Reply-To: <20220701021157.88858-1-chooglen@google.com>
Message-Id: <20220701021157.88858-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220630221147.45689-1-chooglen@google.com> <20220701021157.88858-1-chooglen@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 2/7] submodule--helper update: use display path helper
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

There are two locations in prepare_to_clone_next_submodule() that
manually calculate the submodule display path, but should just use
do_get_submodule_displaypath() for consistency.

Do this replacement and reorder the code slightly to avoid computing
the display path twice.

Until the preceding commit this code had never been tested, with our
newly added tests we can see that both these sites have been computing
the display path incorrectly ever since they were introduced in
48308681b0 (git submodule update: have a dedicated helper for cloning,
2016-02-29) [1]:

- The first hunk puts a "/" between recursive_prefix and ce->name, but
  recursive_prefix already ends with "/".
- The second hunk calls relative_path() on recursive_prefix and
  ce->name, but relative_path() only makes sense when both paths share
  the same base directory. This is never the case here:
  - recursive_prefix is the path from the topmost superproject to the
    current submodule
  - ce->name is the path from the root of the current submodule to its
    submodule.
  so, e.g. recursive_prefix="super" and ce->name="submodule" produces
  displayname="../super" instead of "super/submodule".

[1] I verified this by applying the tests to 48308681b0.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 19 +++++--------------
 t/t7406-submodule-update.sh |  4 ++--
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 389b900602..9381127d56 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1947,30 +1947,21 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct strbuf displaypath_sb = STRBUF_INIT;
+	struct update_data *ud = suc->update_data;
+	char *displaypath = do_get_submodule_displaypath(ce->name, ud->prefix,
+							 ud->recursive_prefix);
 	struct strbuf sb = STRBUF_INIT;
-	const char *displaypath = NULL;
 	int needs_cloning = 0;
 	int need_free_url = 0;
 
 	if (ce_stage(ce)) {
-		if (suc->update_data->recursive_prefix)
-			strbuf_addf(&sb, "%s/%s", suc->update_data->recursive_prefix, ce->name);
-		else
-			strbuf_addstr(&sb, ce->name);
-		strbuf_addf(out, _("Skipping unmerged submodule %s"), sb.buf);
+		strbuf_addf(out, _("Skipping unmerged submodule %s"), displaypath);
 		strbuf_addch(out, '\n');
 		goto cleanup;
 	}
 
 	sub = submodule_from_path(the_repository, null_oid(), ce->name);
 
-	if (suc->update_data->recursive_prefix)
-		displaypath = relative_path(suc->update_data->recursive_prefix,
-					    ce->name, &displaypath_sb);
-	else
-		displaypath = ce->name;
-
 	if (!sub) {
 		next_submodule_warn_missing(suc, out, displaypath);
 		goto cleanup;
@@ -2060,7 +2051,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 					      "--no-single-branch");
 
 cleanup:
-	strbuf_release(&displaypath_sb);
+	free(displaypath);
 	strbuf_release(&sb);
 	if (need_free_url)
 		free((void*)url);
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 9a076e025f..6cc07460dd 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1160,7 +1160,7 @@ test_expect_success 'submodule update should skip unmerged submodules' '
 	test_config -C top-cloned submodule.middle.update !true &&
 	git -C top-cloned submodule update --recursive 2>actual.err &&
 	cat >expect.err <<-\EOF &&
-	Skipping unmerged submodule middle//bottom
+	Skipping unmerged submodule middle/bottom
 	EOF
 	test_cmp expect.err actual.err
 '
@@ -1173,7 +1173,7 @@ test_expect_success 'submodule update --recursive skip submodules with strategy=
 	git -C top-cloned/middle config submodule.bottom.update none &&
 	git -C top-cloned submodule update --recursive 2>actual.err &&
 	cat >expect.err <<-\EOF &&
-	Skipping submodule '\''../middle/'\''
+	Skipping submodule '\''middle/bottom'\''
 	EOF
 	test_cmp expect.err actual.err
 '
-- 
2.37.0.rc0.161.g10f37bed90-goog

