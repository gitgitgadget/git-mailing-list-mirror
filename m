Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA00C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D3360ED4
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhGWLeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbhGWLeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 07:34:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CDCC061757
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z7so2081777wrn.11
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nmWVsTNt0irPKVLpD1ZQVBWsgSV971zvgmZmx6gv6Pg=;
        b=UVvXoLOnQ+4JMcYMjj4YYslD0dbhPUUgDGRD808R7MKjzLZq8y649diD7i7uPjzojx
         T7xw5z+p1B07zFXWV1JbTlLZAb44t5CsS6EZfZGGIvzsb3PGkLqBmjbzYva4wYp9n2B8
         kE69E/dIkIf6TNTlr2vohJHL8hlBlD/ZtG6qVdFTbHVwzfLvBDKxO6N/38/4wqSEXjwT
         dkKuVgwrP/D9DsRAEfK4qYka6pcb3r2vapFSIGQosEcoLT6KW8QvDip6KfMiHf/6YDc5
         uRQ0a2RWJY9FnsmeQln9dML+cocJ7Hqw9rS9w9RftEhAgevZJ0ySVoBC83Xzi5gOqlTx
         /ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nmWVsTNt0irPKVLpD1ZQVBWsgSV971zvgmZmx6gv6Pg=;
        b=bOSo3+JL4Xy22h0KmXAJJJnm5Tfv+YKagB7bJPawkonBO+zRr0QH3/44HLFb7cpsD4
         4FNGhQtJ0QpjWz5Wolc4qdZvolsZ9egBecCRHZulpHSLFuXZ3/CzRa3QUArF9Q8nfgKw
         OcEiVKRhWzgkj3ecuatSMU+uTH3RousAUz3Rq0XbCbAZNeJzYwk5BaRtjKto0n+NRFYO
         7MuYA68MvC1cQPLpxSfTpPiXqpjFL0tpZsWWdKVc57PtGDeXgiAPCnByK3seymE7OmWM
         DWMVQlTjP+pIlWe3PRrYnQ+qOFm/jmbGcOFIkUDi+Ntmosu3dQXoNwj/g1kBLvIFpvNk
         0+og==
X-Gm-Message-State: AOAM530IgttIif6jtc3wr7x88Evdy7IntHVjgYepIR83KuoqWFP4FRRo
        IhIdnrB9uW3lWFNLjyUPLLTLX1qMv80=
X-Google-Smtp-Source: ABdhPJwrU5Nm4HPcdLQY/ipkvobHNFEdXVcWtjmwyz04ctqBwioiP6gHzvpoYq6S7GmRXSNuHiidZg==
X-Received: by 2002:a5d:4527:: with SMTP id j7mr5021201wra.137.1627042473616;
        Fri, 23 Jul 2021 05:14:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm8851658wmq.7.2021.07.23.05.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:14:33 -0700 (PDT)
Message-Id: <86becf764243f129c980f073127ec3f08fd4477c.1627042470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:14:29 +0000
Subject: [PATCH 3/4] merge: apply autostash if fast-forward fails
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Since 'git merge' learned '--autostash' in a03b55530a (merge: teach
--autostash option, 2020-04-07), 'cmd_merge', in the fast-forward case,
calls 'create_autostash' before calling 'checkout_fast_forward' if
'--autostash' is given.

However, if 'checkout_fast_forward' fails, the autostash is not applied
to the working tree, nor saved in the stash list, since the code simply
calls 'goto done'.

Be more helpful to the user by applying the autostash in that case.

An easy way to test a failing fast-forward is when we are merging a
branch that has a tracked file that conflicts with an untracked file in
the working tree.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 builtin/merge.c  |  1 +
 t/t7600-merge.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 74797b6c7a6..788a6b0cd55 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1560,6 +1560,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 					  &head_commit->object.oid,
 					  &commit->object.oid,
 					  overwrite_ignore)) {
+			apply_autostash(git_path_merge_autostash(the_repository));
 			ret = 1;
 			goto done;
 		}
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 1cbc9715a81..216113d3537 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -122,6 +122,8 @@ test_expect_success 'setup' '
 	c0=$(git rev-parse HEAD) &&
 	cp file.1 file &&
 	git add file &&
+	cp file.1 other &&
+	git add other &&
 	test_tick &&
 	git commit -m "commit 1" &&
 	git tag c1 &&
@@ -711,6 +713,15 @@ test_expect_success 'fast-forward merge with --autostash' '
 	test_cmp result.1-5 file
 '
 
+test_expect_success 'failed fast-forward merge with --autostash' '
+	git reset --hard c0 &&
+	git merge-file file file.orig file.5 &&
+	cp file.5 other &&
+	test_must_fail git merge --autostash c1 2>err &&
+	test_i18ngrep "Applied autostash." err &&
+	test_cmp file.5 file
+'
+
 test_expect_success 'octopus merge with --autostash' '
 	git reset --hard c1 &&
 	git merge-file file file.orig file.3 &&
-- 
gitgitgadget

