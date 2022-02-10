Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E751C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiBJJ3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiBJJ3R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:17 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB1710F7
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:12 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so1174284plp.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C4m91dacx6CAhzX4YyT26sMDoIhe7B1orAVRP6TgaLI=;
        b=Yi+2Wa25Qibj0JXSuPlxjGpIcbxlj9ouU6mwYmVglMmXO6H5OSB/9kPlr5TZRZLKPd
         EfN62VCh2nNNcy3U6R8ARrTAaAIMqdXbkekZ9jlzY3OwFw0Nt9VBXvE4Pn03wllntmXN
         Absqw8CfGcJinRCXBNr4RlWf7v/xZR7EAPQiAYE6BY9+rhW5/THuIIRyN9F/D2FDGqa9
         Q8t5Ue83pjYDVcR2tVqTJPnakapMopk9kpDW9HQHsVnZ3/Iz2LZmcObWbeDCVLq74kq3
         X5WezFeZxxpXThukOUrr/TDH3MDfkOYtBKuhmfNal/GRiM+C9l8jqaLd6XaZThgX+/dv
         8KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C4m91dacx6CAhzX4YyT26sMDoIhe7B1orAVRP6TgaLI=;
        b=Zk7O0I9nCikn991ejHA25U9inOCnsZ6fpTmCeiZW/H0IWPuNDhFR9hcuYYY6y8+T6a
         GW1ulA/V+RUj0OrW4DQfcoy7+SQRfMTwmgBOoLnTzVAaMvsPy6NwVCip5AkOj6VfT5kl
         Q4LKERsONzryArqmJkj8m4NRc+SQgEdOSYSqy5vK35Eo4zKV8UAEuoyV/dutGzcvG4dQ
         JM8bws/aCRPE64qP5meYRJRnzHM4Jo4FqqB+eJ//jUfNu1l8KkWwuYGXvCrNKdOztuvb
         QAgLemFj6Hix4et3Uw7iOJvm2DKuqOm+tzBoEy/50xeBzEhZU+Gl/z6IyOyCBbQLA7mc
         ngfQ==
X-Gm-Message-State: AOAM531/3up3JJ8S3vr6xgSz0yuxPBXzwte7WKfdUWujHthaB0T3gIX3
        yxARlvPn6fhMC2FRSCjKlJp2ITbA37Xn9DhBDTKpNDnzaqIwKsKD2fxlJ/7KUk18PfpwkDBHWki
        BPEXG7XOOtu44phA7IZHITC8rlCDfns+cfX/QUAjvzWJFLcvrYy89xC6x/EDwVac=
X-Google-Smtp-Source: ABdhPJyNrMQP/w/PPwknhh7wRxIQ3pDEHGTI8ndyHQEof/wON8vuDVI+vaRft/35N7LYHovkF8XPjhIVriy0QQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:3197:: with SMTP id
 x145mr976218pgx.618.1644485351490; Thu, 10 Feb 2022 01:29:11 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:24 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-12-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 11/20] submodule--helper run-update-procedure: remove --suboid
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
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach run-update-procedure to determine the oid of the submodule's HEAD
instead of doing it in git-subomdule.sh.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 12 +++++++++---
 git-submodule.sh            |  8 +-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b5120734a..a26477ce04 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2585,9 +2585,6 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "oid", &opt.oid, N_("sha1"),
 			       N_("SHA1 expected by superproject"), PARSE_OPT_NONEG,
 			       parse_opt_object_id),
-		OPT_CALLBACK_F(0, "suboid", &opt.suboid, N_("subsha1"),
-			       N_("SHA1 of submodule's HEAD"), PARSE_OPT_NONEG,
-			       parse_opt_object_id),
 		OPT_END()
 	};
 
@@ -2982,6 +2979,15 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 /* NEEDSWORK: this is a temporary name until we delete update_submodule() */
 static int update_submodule2(struct update_data *update_data)
 {
+	/* NEEDSWORK: fix the style issues e.g. braces */
+	if (update_data->just_cloned) {
+		oidcpy(&update_data->suboid, null_oid());
+	} else {
+		if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
+			die(_("Unable to find current revision in submodule path '%s'"),
+			    update_data->displaypath);
+	}
+
 	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
 		return do_run_update_procedure(update_data);
 
diff --git a/git-submodule.sh b/git-submodule.sh
index 652861aa66..d48c314f01 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -391,14 +391,9 @@ cmd_update()
 
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
@@ -426,7 +421,6 @@ cmd_update()
 			  ${update:+--update "$update"} \
 			  ${prefix:+--recursive-prefix "$prefix"} \
 			  ${sha1:+--oid "$sha1"} \
-			  ${subsha1:+--suboid "$subsha1"} \
 			  "--" \
 			  "$sm_path")
 
-- 
2.33.GIT

