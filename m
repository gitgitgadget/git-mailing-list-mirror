Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35A4E1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 21:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbfDYVKl (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 17:10:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39944 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731106AbfDYVKk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 17:10:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so453086pgl.7
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAfVTcg9qRRfX7MOW9Ezg6H3UYlLOOMajqSnr5dfvaQ=;
        b=jm/F9NKlyj7U3YfLMXamZavdpFlYZyG6fi0t67YaPYdcV28r6Sr8KShStUT3BquOeC
         vzS2nVBeoSskN5eYJUXjsp+pnCHlw/ZswM4mnIWnyA+YwV3zbahckMvx9euUZ/xO0iOh
         ydrn0FLkSroz7WXC+qy/IOGPIz7sys5C+OG//SzOcPy9xeL7zZsirG0luZ2S15/lAE38
         ja7fd70hbO+pI2Pfu9pHcvzy3nqn9BzS0vLGTQREgK4MD7sapTxY8Rq4qrMabyxGUM7j
         8D694capsk60/nevnKUp2tJsTnJ5C3qgGd+dcxqpMiCygUU2yyUUPz1p1WiR3+MgdWJZ
         Nhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAfVTcg9qRRfX7MOW9Ezg6H3UYlLOOMajqSnr5dfvaQ=;
        b=aLw26P7exHHoshMP0c9gqseQSnMTUygUJp0X263l5iYoUQgnmnSwNV6+Z0qFW2sFIe
         TzWuiBOR+dhjD9OYEf4C9a2Gz3lxPQpxxPcKv5Dx2jEi+WQlx9lPxj6zZGyLkye+zY6n
         5s/cjFlayR51VJglY5z8vE1PqOfYKVUc9l1rQ6MWStXbdPf9LGMeygSflEk/UJMC4dxL
         1OZedKLatQ4d61KdHoDpwIPuYq9lK3TJ847C8KZmbwuiydZDu6Q0IUMZApmj+lD342pa
         epiPkotg02nNZhYv5pdN0qJj8tfjfeXVpemvJ6p9FOCFFeYxqi7t/DDJ77YYWge8DQpN
         IQ4g==
X-Gm-Message-State: APjAAAVdIkpB3wV8SeRqxkMaAt4RPk48DWElmMMP6+J8tx6NCrWB6M1p
        mseV2ujUGx8HmtZ9MFLiz7jP73IK
X-Google-Smtp-Source: APXvYqwowKHXs2HucxY1Uibynb2KFDF5VjPGK6WT8Yd9bTD3/CcVxFS+fPO96raXzCK/iFVehsD0Rg==
X-Received: by 2002:a62:604:: with SMTP id 4mr42644527pfg.38.1556226639441;
        Thu, 25 Apr 2019 14:10:39 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id a6sm34521551pfn.181.2019.04.25.14.10.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:10:38 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:10:38 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] checkout: allow -b/-B to work on a merge base
Message-ID: <031780431d790c16b3862d6f155693e197bb74ed.1556226502.git.liu.denton@gmail.com>
References: <cover.1556226502.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1556226502.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we ran something like

    $ git checkout -b test master...

it would fail with the message

    fatal: Not a valid object name: 'master...'.

This was caused by the call to `create_branch` where `start_name` is
expected to be a valid rev. However, git-checkout allows the branch to
not be a valid rev in the case where we have "..." to specify getting
the merge base.

In the case where a branch with "..." is specified, use the oid instead
so that `start_name` is a valid rev.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/checkout.c         | 4 +++-
 t/t2018-checkout-branch.sh | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ffa776c6e1..d99b3f3925 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1229,7 +1229,9 @@ static int parse_branchname_arg(int argc, const char **argv,
 	argv++;
 	argc--;
 
-	new_branch_info->name = arg;
+	new_branch_info->name = strstr(arg, "...") ?
+		xstrdup(oid_to_hex(rev)) :
+		arg;
 	setup_branch_path(new_branch_info);
 
 	if (!check_refname_format(new_branch_info->path, 0) &&
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index a3fa520d2e..d6ea556d84 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -65,7 +65,7 @@ test_expect_success 'checkout -b to a new branch, set to HEAD' '
 	do_checkout branch2
 '
 
-test_expect_failure 'checkout -b to a merge base' '
+test_expect_success 'checkout -b to a merge base' '
 	test_when_finished test_might_fail git branch -D branch2 &&
 	test_when_finished git checkout branch1 &&
 	git checkout -b branch2 branch1...
@@ -128,7 +128,7 @@ test_expect_success 'checkout -B to an existing branch resets branch to HEAD' '
 	do_checkout branch2 "" -B
 '
 
-test_expect_failure 'checkout -B to a merge base' '
+test_expect_success 'checkout -B to a merge base' '
 	git checkout branch1 &&
 	git branch -D branch2 &&
 
-- 
2.21.0.1033.g0e8cc1100c

