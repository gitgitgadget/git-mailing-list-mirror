Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177D9C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351866AbiCOVLG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351876AbiCOVLE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:11:04 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884335676D
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:48 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w68-20020a62dd47000000b004f6aa5e4824so344689pff.4
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TMDfdGOO6nQ5NK9WDPYQfvtNlrDxhX9InuRqhajRLfU=;
        b=hMUQ/VnoZh34vOE4Y1oeYH7PJ/KAvQAm+CRMDF0ic3ux9k1zpYy+47A2nex5DgoKLE
         oGxfTwpCdnIPS+e/ot6hw9MTRhFA4ecxsWzT7J3PgVFzoW9/Ws163dHRZkJ1BExTxL0F
         QT1xTKNr9y8WOvjpANeC+h61BmKL2id8VdbtHcDYWUCPDEV7n+pfFxyOO+ECH84toelB
         ryOSZrWoGkwjhlyXKKMz3NP+38aLUKrBDZAyAVrYtKebS+7OUx6BeNHGmRlUxzgx3IZX
         qiv1zP0CtDImsYrmILneTa3qTlQTnYHoQsAz539mIAUXtwFJwX6R47D4h1sZZbw2GvX8
         0P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TMDfdGOO6nQ5NK9WDPYQfvtNlrDxhX9InuRqhajRLfU=;
        b=yQg7oeqA9WmoyFeT6rSYMslkF95mL9kmM8KtWblu3D4iZIPVrKDvwCDTprLvpxecSQ
         jpdG52qLyFYKIkz02MRlpftVilQgHUTnMzffeIAeduZo4tZhlX7JoZshsSRFZ++D8EGw
         l92cUaa3ufhNrCSgNB3ESf1mzhprZ+7ssKjrjhpFKozgbKAYGSNJBgPeC4L4T4O9KXDa
         gaCE1u2ntvAlcwHlTzL/YTjS9ipmOlPKM9kn7IKb2k0zmvDoULyXp8QeAHanXHJTqa+M
         IgaJdrSGYHmJ7lJyoXKRydA2jkorcN2xexWaJkHcJ8jiycMNAF8iMPAxZBBEkMIytP9H
         uxcw==
X-Gm-Message-State: AOAM531UTXMyRQyHuzrUHBLW38I3JfQnwgvE8P7xh0ku+jNKHYAan033
        PGtTrtdJA3QPB5t6jfdzCuU7943vYV2ccjxG+fTKJgJslzes7MGGH4BLpQTSIwQlWnyomAqbvQj
        rv2GCMkH27BZBWLWSG61/aN2x405ao303qf8cF+mqy23lXWjbfWFBDavoVnen8t0=
X-Google-Smtp-Source: ABdhPJyePsfrK+g+tDuSW4HtOGJNcXYjUQSsJswZVLHoa13jXKBtY8P3gE+qBAotLjN2hZYCDrw7pzKIU5tSgQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:319e:b0:4f6:dedb:6c52 with SMTP
 id bj30-20020a056a00319e00b004f6dedb6c52mr30602348pfb.31.1647378587979; Tue,
 15 Mar 2022 14:09:47 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:09:23 -0700
In-Reply-To: <20220315210925.79289-1-chooglen@google.com>
Message-Id: <20220315210925.79289-6-chooglen@google.com>
Mime-Version: 1.0
References: <20220315210925.79289-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 5/7] submodule--helper: reduce logic in run_update_procedure()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A later commit will combine the "update-clone" and
"run-update-procedure" commands, so run_update_procedure() will be
removed. Prepare for this by moving as much logic as possible out of
run_update_procedure() and into update_submodule2().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 04874ce111..85f37c4458 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2611,7 +2611,6 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
 {
-	char *prefixed_path;
 	struct update_data update_data = UPDATE_DATA_INIT;
 
 	struct option options[] = {
@@ -2653,18 +2652,6 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 
 	update_data.sm_path = argv[0];
 
-	if (update_data.recursive_prefix)
-		prefixed_path = xstrfmt("%s%s", update_data.recursive_prefix, update_data.sm_path);
-	else
-		prefixed_path = xstrdup(update_data.sm_path);
-
-	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
-
-	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
-					    update_data.sm_path, update_data.update_default,
-					    &update_data.update_strategy);
-
-	free(prefixed_path);
 	return update_submodule2(&update_data);
 }
 
@@ -3044,7 +3031,24 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	char *prefixed_path;
+
 	ensure_core_worktree(update_data->sm_path);
+
+	if (update_data->recursive_prefix)
+		prefixed_path = xstrfmt("%s%s", update_data->recursive_prefix,
+					update_data->sm_path);
+	else
+		prefixed_path = xstrdup(update_data->sm_path);
+
+	update_data->displaypath = get_submodule_displaypath(prefixed_path,
+							     update_data->prefix);
+	free(prefixed_path);
+
+	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
+					    update_data->sm_path, update_data->update_default,
+					    &update_data->update_strategy);
+
 	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
 	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
-- 
2.33.GIT

