Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD84C433F5
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350546AbiBHIke (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350684AbiBHIkW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:22 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BEEC03FED0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:21 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id b11-20020aa7950b000000b004df185959c4so7015016pfp.8
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9tSCNhbr0674my1WC8Aj0WZhf1LgKShpcEo/fODt+ps=;
        b=WZiXn7lsc5MQshFKwIPo8/tsOD/vfoVKF0yGk65XapIh0t8S4BiuKfYoAKNCF49AhW
         Ydj4aMDAWc4hq4CouiE76D6YlTm28j8i8NdnrSR5ULmcdKzx88fyk3OI7y8o8lN4UndB
         pJjJ5+kKhUSjMhFd9yJELE0Lr9wTgvgfRNDjIRhwVYjfd7urAwzNTJ9nu5t+lNChXw1t
         ICPsYdZOdxlzVSVIpdbjo3Tye877wbQ4QgxURBH9sQ8xbxkI0+UOz6H03BlBhCkBW0KY
         NdIPOdszG6mCdZMoidmZjwGH+CgDTbLCsXM5BmLsh5nJSytmfjKUxGgwkMPW1uZsdmW+
         uGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9tSCNhbr0674my1WC8Aj0WZhf1LgKShpcEo/fODt+ps=;
        b=U6upOpNGtge7ABLKeymjVRSu+a0m3Dnd8ipRbw5/5OufjwKfjW++HYNHf3q95hdF7h
         FEaOuKOcfXuyz6KNI8S/hqyXDuM+nQjImy35IcHL6V96TnirVLra44Ny+GomBmQcgIjK
         A78h6SuV8cCiX3BmBDh9fq+5gRcsrtoDkVh1wbeavgAYi9lvV40eCCoZ8gAPHWV0E3+U
         3vmYvwRLFnKwbWV3hM7XsHHJarDb/rbfeEtC0jBCoDPWYKCGs5BCyjHjjuyv4UoXlU81
         1GmHpohmnDOUzXhctzP75Qy6xKBt1Vsn5HcUzR7TLODR/wCmj2iW2YWLs+vPHa7J8RN3
         oqtg==
X-Gm-Message-State: AOAM530BEyzxJ1hOHPLJWiFl9pGxpoAJ4CXhKh4K6MlqoaqBIn2njL0b
        UUryWEOQF0sNUFW9MBPk+ligKiQmKkHkZ5bMdgsb70cksD9TE67yehPwfira1CseA0N6SHQ9Zpw
        GnLKksSYtsgVdsqCvAil+lGq77ts9HG+RvwHZAo3Q1X0GHxmF0l5DRRzTQlrYqEg=
X-Google-Smtp-Source: ABdhPJyU6MdB8KCr1P06xuyfP/ngjxLY+XzXnIKIK6IxEtNfeBYQgsaY/eSCqdRusO35xdDVwpKBfDt3RXs3Nw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:cc8:: with SMTP id
 b8mr3439831pfv.5.1644309621047; Tue, 08 Feb 2022 00:40:21 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:46 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-11-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 10/16] submodule--helper: reorganize code for sh to C conversion
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

