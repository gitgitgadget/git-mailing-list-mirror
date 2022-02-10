Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5ECC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbiBJJ3Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238583AbiBJJ3I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:08 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29E010E3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:09 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id z12-20020a17090a1fcc00b001b63e477f9fso3562461pjz.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9tSCNhbr0674my1WC8Aj0WZhf1LgKShpcEo/fODt+ps=;
        b=hDCtHZj+1PvZHPlvP5Onnxyotv2cJuNsgXGUocNcXkBDr04gOa9A++Ce4bLqZZPK6s
         suUdk4VNon44RXYsibQXS1ZNoEyIR3DHt48JEfbvKnoJoE5dyO7tJRIH31Ut8687fd3g
         NsihRaGpFWYZIYrexA/66BK5hvhck6P95DSHxbERcgbrKFfvjj+c4TI722V5wIZh3AxI
         bNjfgBXCN7ICv2JuUCkYoU+9X+fYvQQUEaG7gLrAxJ4DONOxnub7douRPk7sO++ZxXh4
         wsaTLoABE4Tq7v7gYKht5wjh044JmigSrRS9L3k+MMago/eOpc87rzty/d5v2GISjamq
         vhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9tSCNhbr0674my1WC8Aj0WZhf1LgKShpcEo/fODt+ps=;
        b=PoBPhOgdo/1oLvEUhZYvroNdB5kqMz4O7sm8WbNF46Noq3SQp8GZuMai1WL82lpikO
         TWWUbSv7eC1cVzUS6nPA+U9S6udLpjuZN7Qef9cjDNpVNunbolfQAbwOKkigWrYGG7lb
         WxtDFESg1vAk2jY6QwbJYVi1rukAx3laSd88FUqY2qcWYDpWpQSVBLlJ4dbdHxQkDHgR
         u7fMvRuXIripDpGzViBvqRn92UnFy/ekmuH6zp62iHA29KfJwEmdKuTL40aeUN0uTwPR
         2syJVvi+0ISYeD/2dHi4zb7zHSjBUUwR7qwSd2FL8du9kqUdLxmA4QjHj3yASNqJ0ngN
         LJSA==
X-Gm-Message-State: AOAM532ceuqD+180sVGvM3IML6adcchL+//d3hETnhq7aabPl/h4DoAw
        +SqbCXULCN41Rt9GwF6U4ZGiw0xIersKYLltupNmbvmgL8SJjlDTjiUztP0EpHu0Zam/+vlz5b2
        aPd1UjUD5tu03myiVlRFaxqYXeB+jhRTgKxvYKStv3i/Up7hD8yTNNnD7NY0DRTw=
X-Google-Smtp-Source: ABdhPJz5XszzSiKI5+MoDiXrJM6vQ+rah2vRpZrYAq/f8+RSuIwbUV1lLDxBG9UlFcdJyQI52PFHhnjP4LYCzA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4c8e:: with SMTP id
 my14mr318568pjb.0.1644485349049; Thu, 10 Feb 2022 01:29:09 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:23 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-11-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 10/20] submodule--helper: reorganize code for sh to C conversion
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

Introduce a function, update_submodule2(), that performs an update for
one submodule. This function will implement the functionality of
run-update-procedure and its surrounding shell code in submodule.sh.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e0cc1c1b79..0b5120734a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2553,6 +2553,11 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	return update_submodules(&opt);
 }
 
+/*
+ * NEEDSWORK: Use a forward declaration to avoid moving
+ * run_update_procedure() (which will be removed soon).
+ */
+static int update_submodule2(struct update_data *update_data);
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
 {
 	char *prefixed_path, *update = NULL;
@@ -2610,11 +2615,7 @@ static int run_update_procedure(int argc, const char **argv, const char *prefix)
 					    &opt.update_strategy);
 
 	free(prefixed_path);
-
-	if (!oideq(&opt.oid, &opt.suboid) || opt.force)
-		return do_run_update_procedure(&opt);
-
-	return 3;
+	return update_submodule2(&opt);
 }
 
 static int resolve_relative_path(int argc, const char **argv, const char *prefix)
@@ -2978,6 +2979,15 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 	return !!ret;
 }
 
+/* NEEDSWORK: this is a temporary name until we delete update_submodule() */
+static int update_submodule2(struct update_data *update_data)
+{
+	if (!oideq(&update_data->oid, &update_data->suboid) || update_data->force)
+		return do_run_update_procedure(update_data);
+
+	return 3;
+}
+
 struct add_data {
 	const char *prefix;
 	const char *branch;
-- 
2.33.GIT

