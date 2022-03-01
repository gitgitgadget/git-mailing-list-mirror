Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D95AC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiCAAJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbiCAAJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:09 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2FD9AE75
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:29 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t18-20020a63dd12000000b00342725203b5so7417833pgg.16
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6b3Koiu50iGgu4+CvsJvU3gtyLeMDqKt6mcoMXU061M=;
        b=X2X1gruFX/PVXzvJI0HOZAXPDf00yApcAm1DzU1GOIzZAeIOFLVyLonHbNnCIT6qP6
         bhxSXx1SAU9VNT7CCvIwttEoHrrd4hsieSWiRoDmqn6j85LwWkEkpxZlRDSutelU2+Sw
         A/QdrFKhKG0kkErzVpu24oaW3GFRkuPgJE/YIu6kxUXg1mPIRBtmXCSIs9ClhPb1ZuYp
         h88aGhEY6YxvAKucROp7fTN7qB1D4xZo9DRe59+SC57JR5rRd17Oc7FEwvLTZUlEQVQN
         /IrI+TxJoi5BN8fN50ZEUN9QdTTGSotSJyV0iWmBuYQScdKlmCWPbSnCxuZ4uZWovMJV
         O8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6b3Koiu50iGgu4+CvsJvU3gtyLeMDqKt6mcoMXU061M=;
        b=oN+F/1Hr7lAQ+k8Dhv0QH4vo8Q3ueQvHgfExQBjxE+3aUGGTjn/LfHPIDPsmC1txNj
         /vLoyoOoBED7SOZxWoAJZcGRb+GT9RuNFypXaxyRjlNwico1kQ9+su4sg9i4z1/heTgc
         WPUHN17s5fMRAZ1nShgCTDVccJ3fokaPDdR9K8wo/f6kd5D2YFoUNDGdQsGCT1mr1QVi
         cmvvbEzJP6bEpin3L9+scQF7X24oRbpIa+Xu6ABnBaYyUqZExaDQNowZyfGiRW6EzibF
         WFMTxqZPZ1TSS3YbkKf4kdJ98ExITFCb2hQ233CT3maMYppuvw5zxX1RNyuuHF/TeEEm
         ae0g==
X-Gm-Message-State: AOAM532op/69Hws9bSsufs+n+LCay9WZ9q2b65vCTWXReTzFH9ifaBfp
        tO4KWwS1TVgy2CPEBXxjl9RQd8z/W0PRrYwCI219Yu/BSW0gfOpX+dGQmz3MU1sjn4kUuDnWGT4
        88sQB7VhiDyNfnPEuIJIqr9DnWTnxblng9G2ZIrbRTfcVVQBz9Gf/qj+GQs6ZHHU=
X-Google-Smtp-Source: ABdhPJwVoXppr973pyVI3Z/mR6/2aSd2DdbCOD0vN2hvN5ZC95KkDaHWa2MeujuZxmlDzBsS88+CfwbL/ia+aQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:d5b:b0:4e1:2007:87fb with SMTP
 id n27-20020a056a000d5b00b004e1200787fbmr24706393pfv.38.1646093308880; Mon,
 28 Feb 2022 16:08:28 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:07 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 04/13] submodule--helper run-update-procedure: remove --suboid
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
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

