Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE33C433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiCAEml (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiCAEmh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:37 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC54E6E36A
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:44 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id lp2-20020a17090b4a8200b001bc449ecbceso733435pjb.8
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6b3Koiu50iGgu4+CvsJvU3gtyLeMDqKt6mcoMXU061M=;
        b=QfHhP27et4NC9MlyCN/Rf/Gli1NoSW+oUphaB7pJNH0EOIt5HI0kUXlinE5k7pJwVM
         RxgVYfNQ7+j+eBQ5OvQtJx7lqh3nf5y47PGi1Sc9Nq9eWrx0AIP5ng7b0oG+hDejd+RB
         7tGVCkcIeMGoqLZsgDLYoJGKP6aKxc+r/+TI8javHmo9PnzAQ/DYvLtyaK/w/PdWZXUz
         jmBi4w0ImGsZ592k2fNKNuCthpA0d+7Don/7mwq7chBWwu2yQewbcVhu/SnjC6PfPujJ
         4X0NABmNbRjuRe57g/ACU07fQvmt6IB872zSI0QvBIYJ9Wq0KmnYcm4ILrfe3rDT1DvL
         jUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6b3Koiu50iGgu4+CvsJvU3gtyLeMDqKt6mcoMXU061M=;
        b=N6XBOF2bFEq/iGVT+K9cV6dQ6Gn1xoDGKfmMBC33BGfZ8IE1SjL+1KBDNHL/UX6Mob
         QvjZAtPiS67kstc18+s0zeo7+kZOpeNuCjMGEIyvDjSRJu2MHt9q8i9Fl48cTP+UEm7m
         KobuzOx2WPE2VA4ZTcXE16KD69H6AG4ovNWEPP6qpctHYGnHpCK0VaqppocUCVVQLorv
         lhZRY2e5XlHlkhTbXwW10IU+IMia+kBrSRxMRLd+25KtnDFC6ufbtg0AnD0/4oaE67yN
         b7g96DDMO9UbhRtSohm0V7FVQ6MjBLDrHTf4dxTPoAKv41mCPhtUrsCKzDgZ11e9255R
         HmHg==
X-Gm-Message-State: AOAM530x8nvvX1B3e2expzxbUJ+EnACm82EXXCefmgYNsLG9u7a6cYRd
        K+LZyXUhs+yVetNqwXHewb7E/NDeSpT/jEQUv4cOMaOVwaABZzVcaThoo91Zu1FN7zSKOja7MqY
        lBSx48lCc2E0vOEBeONVDJVRhegZvbopJEtlgGgPGzbpRQtnfyRSmkW8A3/A9EEQ=
X-Google-Smtp-Source: ABdhPJzRRlN3DB/7qctrj3Vtx9sxZ1Oef4pNpFNR3PJrBdVKkiaezjuQQyaLF3AgIgdY4RtXqQLAyxf3skxt8A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:a508:b0:14d:bfd8:58be with SMTP
 id s8-20020a170902a50800b0014dbfd858bemr24391079plq.10.1646109704143; Mon, 28
 Feb 2022 20:41:44 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:23 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 04/13] submodule--helper run-update-procedure: remove --suboid
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach run-update-procedure to determine the oid of the submodule's HEAD
instead of doing it in git-subomdule.sh.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 9 ++++++---
 git-submodule.sh            | 8 +-------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1b67a3887c..77ca4270f4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2594,9 +2594,6 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "oid", &update_data.oid, N_("sha1"),
 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
-		OPT_CALLBACK_F(0, "suboid", &update_data.suboid, N_("subsha1"),
-			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
 		OPT_END()
 	};
 
@@ -3032,6 +3029,12 @@ static int module_create_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	if (update_data->just_cloned)
+		oidcpy(&update_data->suboid, null_oid());
+	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
+		die(_("Unable to find current revision in submodule path '%s'"),
+			update_data->displaypath);
+
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
 		return do_run_update_procedure(update_data);
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 87772ac891..32a09302ab 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -406,14 +406,9 @@ cmd_update()
 
 		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
 
-		if test $just_cloned -eq 1
+		if test $just_cloned -eq 0
 		then
-			subsha1=
-		else
 			just_cloned=
-			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
-				git rev-parse --verify HEAD) ||
-			die "fatal: $(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
 		fi
 
 		if test -n "$remote"
@@ -441,7 +436,6 @@ cmd_update()
 			  ${update:+--update "$update"} \
 			  ${prefix:+--recursive-prefix "$prefix"} \
 			  ${sha1:+--oid "$sha1"} \
-			  ${subsha1:+--suboid "$subsha1"} \
 			  "--" \
 			  "$sm_path")
 
-- 
2.33.GIT

