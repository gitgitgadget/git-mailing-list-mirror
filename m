Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D528C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbiBJJaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:30:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiBJJ3c (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:32 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F313E1145
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:31 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id s207-20020a6277d8000000b004e0300e14f7so3933016pfc.23
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lNK+oYAT8iCrh3nj/FdHLjMJncmuBYs5ti04rusFEQU=;
        b=I29doCT12nyHufckfJQR0QKYVDsmBa7Msp74xknm1FBYPMwEGZzB8KuK76VW6yaT9B
         G3DMXyqejsw1yyBMzrZwbwSaXln2NI9wwS1TfCHEuNQdisSRs38bHFWCu3dKgl7ZWZWS
         myi2jXLMxZn1tHN6t0bptqCmjSj/1LZMige9+0xvzcSP6qRVhonx3Miv+MPsFRcidIjN
         h5sM8kO0Z45x18ihRKxtY1tBmDEKX4q1zmKYjC7q3KA7UVbe1GmE07dWUmEH5MvxyzSo
         WBKRTpma6HlV4GFXzqhQKmzhEGRTNa6aaP2jq9dXZ8MkaC0nulMOvj2XaHLbzJ4jl/qs
         /1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lNK+oYAT8iCrh3nj/FdHLjMJncmuBYs5ti04rusFEQU=;
        b=bTZCbS3BYfHCaoh8OUbLAxe+lO+QVc5/BRTxCDmbCqqdtcKRqV7Vi1T+fE0zMC+jdN
         AJ7vlr8Tqax/MECV4HtfeiDC4WPkGN69oItW0C7jeVSXtNtHkfh6ChuXen61//5yekrl
         BgBJnZOJZ9q6Ae3v8VsKg6IS+PS+F8hlXlvam/QBzSu6y8UbM81wrIuB871sdt7m8eWi
         XFlCoH3K8phTHNnUtpRVmtbu/zhceBn5NugX7hMQieGETQML12kvLKKnmeTUm9WYoqqw
         O2MPm0NLJ/hh21GL6YUOdTbuE7G7TYOpEsM4+RsEJ1ajPEraCID5avAJalSyTSJp2Pw+
         MSGg==
X-Gm-Message-State: AOAM532ITJit6gTupcGMt72a11909pNS9llob5rzNp1JDXOTxf+28FIR
        pW4VppaEWMDRl5YGfxYCGC8VgP5U6u9xD1977wiau5sdqisrVAUwH9uhTw0SgxqqZCdTgJX38ZU
        VGVRYcRpuUtFnfc26n/9pNs8GGk3BgeALCB4XZcM4xBdLulgWBpzFPPL+p60vaok=
X-Google-Smtp-Source: ABdhPJzIf6xi0LuUPdJkkLfD5nhyUdeOZukP7yvWn2M8jp8cESD/UfWIgw4HNqjg7yNCNjxznOSgKhlNYqXNLA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:ab53:: with SMTP id
 ij19mr6690409plb.45.1644485371336; Thu, 10 Feb 2022 01:29:31 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:33 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-21-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 20/20] fixup! submodule: move core cmd_update() logic to C
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

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 13 +++----------
 git-submodule.sh            | 13 +------------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5d5302b50b..3367997973 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2807,12 +2807,6 @@ static void update_data_to_args(struct update_data *update_data, struct strvec *
 {
 	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL);
 	strvec_pushf(args, "--jobs=%d", update_data->max_jobs);
-	/*
-	 * NEEDSWORK: the equivalent code in git-submodule.sh does not
-	 * pass --prefix, so this shouldn't either
-	*/
-	if (update_data->prefix)
-		strvec_pushl(args, "--prefix", update_data->prefix, NULL);
 	if (update_data->recursive_prefix)
 		strvec_pushl(args, "--recursive-prefix",
 			     update_data->recursive_prefix, NULL);
@@ -2980,8 +2974,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec;
 	struct update_data opt = UPDATE_DATA_INIT;
 
-	/* NEEDSWORK: update names and strings */
-	struct option module_update_clone_options[] = {
+	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
 		OPT_BOOL(0, "init", &opt.init,
 			 N_("initialize uninitialized submodules before update")),
@@ -3023,14 +3016,14 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
+		N_("git submodule--helper update [--prefix=<path>] [<path>...]"),
 		NULL
 	};
 
 	update_clone_config_from_gitmodules(&opt.max_jobs);
 	git_config(git_update_clone_config, &opt.max_jobs);
 
-	argc = parse_options(argc, argv, prefix, module_update_clone_options,
+	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 	oidcpy(&opt.oid, null_oid());
 	oidcpy(&opt.suboid, null_oid());
diff --git a/git-submodule.sh b/git-submodule.sh
index d176469fb1..89f5cf393e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -50,15 +50,6 @@ single_branch=
 jobs=
 recommend_shallow=
 
-# NEEDSWORK this is now unused
-die_if_unmatched ()
-{
-	if test "$1" = "#unmatched"
-	then
-		exit ${2:-1}
-	fi
-}
-
 isnumber()
 {
 	n=$(($1 + 0)) 2>/dev/null && test "$n" = "$1"
@@ -348,9 +339,7 @@ cmd_update()
 		shift
 	done
 
-	# NEEDSWORK --super-prefix isn't actually supported by this
-	# command - we just pass the $prefix to --recursive-prefix.
-	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper update \
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
 		${GIT_QUIET:+--quiet} \
 		${force:+--force} \
 		${progress:+--progress} \
-- 
2.33.GIT

