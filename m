Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0B8C433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 00:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJHAju (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 20:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHAjs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 20:39:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376A13DCF
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 17:39:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so3427068wmb.0
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmNk+xpbmlAzrxDPj28G+vHDQzbK106pW/fctijDXMc=;
        b=gWlrzysHmBWe46cT5mZ0V21OTeDRX9XqrA1YK+gFGzzUvujL7yVf3IcndZ0BBDkFJq
         GNL4kKXsyxvvXp0W3fZPDYDVKjphZxcC9qWM8Qm1DTs2Sq7S8wOMKoKEW+Qpzqse1eh0
         U8yO8hwDiIi59FnqgcbAgrTcbhrfg2tvJBYCOz0qcWtbOU587Y/XVDvAcStDIYQt2QBP
         ufJXrOLT8FIYaLyuVCjOkr3AeJbIQ/NOKSaL/l5XsaNMHqInKYUJk4CYbvDNq9tFEUIo
         /8mBPcI4a8I91E1INXl/Sd6lE2rAx+lVFRj+W8tIwIVEB13E+oEZquOppnwuEJScDjud
         R1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmNk+xpbmlAzrxDPj28G+vHDQzbK106pW/fctijDXMc=;
        b=WRl/rHaWIcwFRNQkwpYEVu1zQDReV8CEhkca2H0Y3c8Wun6EJ5S0/XeZkaKV6F91IE
         SnNXjn/KGKijzgGbx8sCYBMTUqwlWjzdJZfANBOlxnJEZXqxokcQ5NQSEfkYic2G7B9o
         j6Va209spHfsPpHW15NiDkulDrQXsJ4Dq0xTYXXOuIJg7waNz617T5y4IqyX2M5xbgV8
         HvZoFZohGeTJXAl9vkgLYnSVHCHzVQ89/IuhSiBHqyOMnW1dfOVG6KGMToVlIsdpd4Ky
         uE/8GGG3FCLyYhO/LKqCPM+TbQirKr5SfwF3IyXFAzxstvgEIUDunnKfSuyGo9aLTHc3
         DCRQ==
X-Gm-Message-State: ACrzQf3ox6ZvbYP4sb2aWiW/+IWDPiIrnsU0yTg325D/MEg2aI32GjOE
        2ay+Fr5kg04+twuAJbscjk8=
X-Google-Smtp-Source: AMsMyM55k9WQ4rii6d2MZRXrIXDOM76QjEDqcstqmFVddjqPtlHpDT/CB+ewC0mgPUW5sqj0MDBxFQ==
X-Received: by 2002:a05:600c:1909:b0:3b4:aa30:40df with SMTP id j9-20020a05600c190900b003b4aa3040dfmr12045138wmq.205.1665189584765;
        Fri, 07 Oct 2022 17:39:44 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b0022af865810esm3179814wri.75.2022.10.07.17.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 17:39:44 -0700 (PDT)
Subject: [PATCH v3] branch: description for non-existent branch errors
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
 <930ff836-a5c4-0e85-517d-39645f00cd31@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <8d627a2c-923f-181f-a03b-15f370c4dd0f@gmail.com>
Date:   Sat, 8 Oct 2022 02:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <930ff836-a5c4-0e85-517d-39645f00cd31@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the repository does not yet have commits, some errors describe that
there is no branch:

    $ git init -b first

    $ git branch --edit-description first
    error: No branch named 'first'.

    $ git branch --set-upstream-to=upstream
    fatal: branch 'first' does not exist

    $ git branch -c second
    error: refname refs/heads/first not found
    fatal: Branch copy failed

That "first" branch is unborn but to say it doesn't exists is confusing.

Options "-c" (copy) and "-m" (rename) show the same error when the
origin branch doesn't exists:

    $ git branch -c non-existent-branch second
    error: refname refs/heads/non-existent-branch not found
    fatal: Branch copy failed

    $ git branch -m non-existent-branch second
    error: refname refs/heads/non-existent-branch not found
    fatal: Branch rename failed

Note that "--edit-description" without an explicit argument is already
considering the _empty repository_ circumstance in its error.  Also note
that "-m" on the initial branch it is an allowed operation.

Make the error descriptions for those branch operations with unborn or
non-existent branches, more informative.

This is the result of the change:

    $ git init -b first

    $ git branch --edit-description first
    error: No commit on branch 'first' yet.

    $ git branch --set-upstream-to=upstream
    fatal: No commit on branch 'first' yet.

    $ git branch -c second
    fatal: No commit on branch 'first' yet.

    $ git branch [-c/-m] non-existent-branch second
    fatal: No branch named 'non-existent-branch'.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
Range-diff:
1:  d8c3242b31 ! 1:  180435ff15 branch: description for non-existent branch errors
    @@ Commit message
         considering the _empty repository_ circumstance in its error.  Also note
         that "-m" on the initial branch it is an allowed operation.
     
    -    This commit makes the error descriptions for those branch operations
    -    with unborn or non-existent branches, more informative.
    +    Make the error descriptions for those branch operations with unborn or
    +    non-existent branches, more informative.
     
         This is the result of the change:
     

 builtin/branch.c       | 14 +++++++++++--
 t/t3202-show-branch.sh | 46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..499ebec99e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -538,6 +538,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
+	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
+		if (copy && !strcmp(head, oldname))
+			die(_("No commit on branch '%s' yet."), oldname);
+		else
+			die(_("No branch named '%s'."), oldname);
+	}
+
 	/*
 	 * A command like "git branch -M currentbranch currentbranch" cannot
 	 * cause the worktree to become inconsistent with HEAD, so allow it.
@@ -805,7 +812,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!ref_exists(branch_ref.buf)) {
 			strbuf_release(&branch_ref);
 
-			if (!argc)
+			if (!argc || !strcmp(head, branch_name))
 				return error(_("No commit on branch '%s' yet."),
 					     branch_name);
 			else
@@ -848,8 +855,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("no such branch '%s'"), argv[0]);
 		}
 
-		if (!ref_exists(branch->refname))
+		if (!ref_exists(branch->refname)) {
+			if (!argc || !strcmp(head, branch->name))
+				die(_("No commit on branch '%s' yet."), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
+		}
 
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index f2b9199007..ea7cfd1951 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -7,6 +7,28 @@ test_description='test show-branch'
 # arbitrary reference time: 2009-08-30 19:20:00
 GIT_TEST_DATE_NOW=1251660000; export GIT_TEST_DATE_NOW
 
+test_expect_success 'error descriptions on empty repository' '
+	current=$(git branch --show-current) &&
+	cat >expect <<-EOF &&
+	error: No commit on branch '\''$current'\'' yet.
+	EOF
+	test_must_fail git branch --edit-description 2>actual &&
+	test_cmp expect actual &&
+	test_must_fail git branch --edit-description $current 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fatal descriptions on empty repository' '
+	current=$(git branch --show-current) &&
+	cat >expect <<-EOF &&
+	fatal: No commit on branch '\''$current'\'' yet.
+	EOF
+	test_must_fail git branch --set-upstream-to=non-existent 2>actual &&
+	test_cmp expect actual &&
+	test_must_fail git branch -c new-branch 2>actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'setup' '
 	test_commit initial &&
 	for i in $(test_seq 1 10)
@@ -175,4 +197,28 @@ done <<\EOF
 --reflog --current
 EOF
 
+test_expect_success 'error descriptions on non-existent branch' '
+	cat >expect <<-EOF &&
+	error: No branch named '\''non-existent'\'.'
+	EOF
+	test_must_fail git branch --edit-description non-existent 2>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'fatal descriptions on non-existent branch' '
+	cat >expect <<-EOF &&
+	fatal: branch '\''non-existent'\'' does not exist
+	EOF
+	test_must_fail git branch --set-upstream-to=non-existent non-existent 2>actual &&
+	test_cmp expect actual &&
+
+	cat >expect <<-EOF &&
+	fatal: No branch named '\''non-existent'\''.
+	EOF
+	test_must_fail git branch -c non-existent new-branch 2>actual &&
+	test_cmp expect actual &&
+	test_must_fail git branch -m non-existent new-branch 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.32.0
