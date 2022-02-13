Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8BAC433FE
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 00:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiBMAkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 19:40:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiBMAkI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 19:40:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D69460056
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:03 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v129so7583038wme.2
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Lf81j0EfViiw5yQag7tu+GvRr1Mg3cI/hhwGiCBZiqo=;
        b=oVuV5N552m8O87pICXxug0aRTzR5oA0QtDEW44AIkpTYu5PyoQepzHt7QU/WxxUZtq
         ZNd7sio9jxLg1UaEv4dOQH0gA8OjHOq2THdIxF/qQQbc4f7MgjQDtHtOntsVtrSqx2sP
         BFzx+Og+PsGEYVsDRhbI8F4XY0GL0b6nuVfiiwPdm0r0kpCXX/Sr679pVjpKPTW/CvDW
         95zut+tOc1aC0eR65x56FyMEGrEnax5pvLU+whFPWqYE9i6c8e0hXwdzdayoOZJagWur
         g8comxG+HotWX3iCPqKVYPwRGV5yGqQiZIfwMfjkLmajCF1ZWmsinHC2b0+Bi4H0QFOR
         65PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Lf81j0EfViiw5yQag7tu+GvRr1Mg3cI/hhwGiCBZiqo=;
        b=Jxph9YbohhRZoKpsAOLqsuNyy1S5G5NDuU3zF4J9Nud4ZTopqTU7uL0CKZTj6EXAzf
         5TSlFaAXRItW1JM2pbCc861UkuWsUWXvtMQojhWkphIps3aMJQmBJfCMEGRWzaAG9eXk
         s2F7DDvL4xr8978Q8TSmabmDi8s2u4W1YwLCa3oUPA3oIrzg7W0wLDDBYAybZjeeWuDM
         +0rqG2bv51g39HS6fmjbXt0S1RlNBA7DN+uQkMYL9uPp8lLMTHtIPR4oyRFm9qE4ppbw
         IYltJ0tfDiF1jIstBC9BKIOwDd53wK75nBkZCcunRGZxzjs987JQWfcDbQ29diu6lNDP
         gieg==
X-Gm-Message-State: AOAM5309AJnUNucJ+MaV26tSQZJHgEdaI5djZY7tUn4FMwP7yJn2cHuu
        oJlx2/GMjUtf2opHSIhoGsFt6g25X8A=
X-Google-Smtp-Source: ABdhPJzJVhjGmw5OLwcODbqWUCouJ0lPLJd8szzU4+i2/K8sX/JzppvIrf7YtwP9y0gX8vfWlN664w==
X-Received: by 2002:a1c:4b11:: with SMTP id y17mr5575941wma.46.1644712801838;
        Sat, 12 Feb 2022 16:40:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm25898101wrd.8.2022.02.12.16.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:40:01 -0800 (PST)
Message-Id: <679f869ff11b5c3e61081018f7eafa81c334f3d1.1644712798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Feb 2022 00:39:53 +0000
Subject: [PATCH 3/7] sparse-checkout: pay attention to prefix for {set, add}
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In cone mode, non-option arguments to set & add are clearly paths, and
as such, we should pay attention to prefix.

In non-cone mode, it is not clear that folks intend to provide paths
since the inputs are gitignore-style patterns.  Paying attention to
prefix would prevent folks from doing things like
   git sparse-checkout add /.gitattributes
   git sparse-checkout add '/toplevel-dir/*'
In fact, the former will result in
   fatal: '/.gitattributes' is outside repository...
while the later will result in
   fatal: Invalid path '/toplevel-dir': No such file or directory
despite the fact that both are valid gitignore-style patterns that would
select real files if added to the sparse-checkout file.  However, these
commands can be run successfully from the toplevel directory, and many
gitignore-style patterns ARE paths, and bash completion seems to be
suggesting directories and files, so perhaps for consistency we pay
attention to the prefix?  It's not clear what is okay here, but maybe
that's yet another reason to deprecate non-cone mode as we will do later
in this series.

For now, incorporate prefix into the positional arguments for either
cone or non-cone mode.  For additional discussion of this issue, see
https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/

Helped-by: Junio Hamano <gitster@pobox.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          | 22 ++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8d595189ea3..bec423d5af9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -681,6 +681,24 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
+static void sanitize_paths(int argc, const char **argv, const char *prefix)
+{
+	if (!argc)
+		return;
+
+	if (prefix && *prefix) {
+		/*
+		 * The args are not pathspecs, so unfortunately we
+		 * cannot imitate how cmd_add() uses parse_pathspec().
+		 */
+		int i;
+		int prefix_len = strlen(prefix);
+
+		for (i = 0; i < argc; i++)
+			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
+	}
+}
+
 static char const * const builtin_sparse_checkout_add_usage[] = {
 	N_("git sparse-checkout add (--stdin | <patterns>)"),
 	NULL
@@ -708,6 +726,8 @@ static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
 			     builtin_sparse_checkout_add_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
+	sanitize_paths(argc, argv, prefix);
+
 	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
 }
 
@@ -759,6 +779,8 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	if (!core_sparse_checkout_cone && argc == 0) {
 		argv = default_patterns;
 		argc = default_patterns_nr;
+	} else {
+		sanitize_paths(argc, argv, prefix);
 	}
 
 	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 4a7394f7a58..b9e6987f5a6 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -816,4 +816,31 @@ test_expect_success 'malformed cone-mode patterns' '
 	grep "warning: disabling cone pattern matching" err
 '
 
+test_expect_success 'set from subdir pays attention to prefix' '
+	git -C repo sparse-checkout disable &&
+	git -C repo/deep sparse-checkout set --cone deeper2 ../folder1 &&
+
+	git -C repo sparse-checkout list >actual &&
+
+	cat >expect <<-\EOF &&
+	deep/deeper2
+	folder1
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'add from subdir pays attention to prefix' '
+	git -C repo sparse-checkout set --cone deep/deeper2 &&
+	git -C repo/deep sparse-checkout add deeper1/deepest ../folder1 &&
+
+	git -C repo sparse-checkout list >actual &&
+
+	cat >expect <<-\EOF &&
+	deep/deeper1/deepest
+	deep/deeper2
+	folder1
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

