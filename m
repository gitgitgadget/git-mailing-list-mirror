Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91A61F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 23:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408054AbfJWXcm (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 19:32:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41465 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408036AbfJWXcm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 19:32:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id q7so13874523pfh.8
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mbjj1m20QOj4nkFUOudnTseLtoXjcUB6i8SafQ1KKXM=;
        b=CYQXNeAtEPGHljoMZwCYJWoM1r1AW3//r4mhw7j8dXYs9QvELJ4EP1Uta6dZGf1RQx
         a+8+L0aG71zKAAGz8EJo0f8i4/37Ls0yMQPqfEVSc0BUbEpi4IU8tFCzYbCqpGu0g0UH
         P4jAlcI37907u/Zv+oCRVJ1LpTTdb3iH49mporUrQdbs63sqX+RayopYeoK0hPB0Kl+H
         rqgTKVGLVo4CEhdleASw00FAjqH2FwyVAbHoiYGkLKHsLt5U68XZGmkWs89sBqpRYmGm
         62nAfXQRRdq3gtxQU6VI6duQCrUjqLt9F6/GhyJfEBbqY2YpIvKv1G4pSuKAn7qxnsXY
         h/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mbjj1m20QOj4nkFUOudnTseLtoXjcUB6i8SafQ1KKXM=;
        b=beQd6yhuzq+SvZw5LKCbJU8lG2e6P+I8lBgT1j2NBwM+SvoRgyjmu62XO8T/QafPH2
         baz50DRmYt/K1ovfPFkwGOYIrRrw/fk6azG5bz7IdfSLutvYclt/V04Ynz6fWuB2Waxw
         tUCSny2kctXqJijxrLKKdnS68FfozaBXyDCKuAYZNPyATnU9eT289eXM35zXFlRxObLw
         Re1CJssv1mBMJCmTqKU4Xe85DwMLawprPinFIraIQR2hKbIf7ta/UbKUC90qyZW+teI+
         vy+N5ir1zXh9dAfFHxfF3YIrvuQnsKNSE/IMdAOQj7zVqAbea0Bnv5KT+qsZAPOp8UrN
         ji4w==
X-Gm-Message-State: APjAAAWrFhcPY7Y2Inw3aXyfO0qcSqMj7oOdrHbF3HkqrNRfHOUUAuwj
        9Gt/czHvhDsX9eHb79rFP3RBomv1
X-Google-Smtp-Source: APXvYqwptUeEM2eyigFi2I94tl9Y+aEIFqZq5bgDWRrmTvSwZacW8FWwAJDtXXXZp30Nux1Q2Ob0Fw==
X-Received: by 2002:a62:7c4d:: with SMTP id x74mr13624366pfc.259.1571873560987;
        Wed, 23 Oct 2019 16:32:40 -0700 (PDT)
Received: from generichostname ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id a11sm23393889pgw.64.2019.10.23.16.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 16:32:40 -0700 (PDT)
Date:   Wed, 23 Oct 2019 16:32:38 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 5/5] apply: respect merge.conflictStyle in --3way
Message-ID: <5412dc9153d10c4f7769b24433b05c6809904655.1571873435.git.liu.denton@gmail.com>
References: <cover.1571832176.git.liu.denton@gmail.com>
 <cover.1571873435.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571873435.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, when doing a 3-way merge, the merge.conflictStyle option was not
respected and the "merge" style was always used, even if "diff3" was
specified.

Call git_xmerge_config() at the end of git_apply_config() so that the
merge.conflictStyle config is read.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 apply.c                   | 2 +-
 t/t4108-apply-threeway.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index f8a046a6a5..b9291f5f7b 100644
--- a/apply.c
+++ b/apply.c
@@ -32,7 +32,7 @@ static void git_apply_config(void)
 {
 	git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
 	git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
-	git_config(git_default_config, NULL);
+	git_config(git_xmerge_config, NULL);
 }
 
 static int parse_whitespace_option(struct apply_state *state, const char *option)
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index bffe37f1ba..d7349ced6b 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -73,7 +73,7 @@ test_expect_success 'apply with --3way' '
 	test_apply_with_3way
 '
 
-test_expect_failure 'apply with --3way with merge.conflictStyle = diff3' '
+test_expect_success 'apply with --3way with merge.conflictStyle = diff3' '
 	test_config merge.conflictStyle diff3 &&
 	test_apply_with_3way
 '
-- 
2.24.0.rc0.197.g0926ab8072

