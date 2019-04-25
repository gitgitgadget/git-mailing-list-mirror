Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D8E1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfDYJqp (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35551 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfDYJqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so10895948pfh.2
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYcc2w0Q0ZJn0ZnuqjwgIHi9CaHUcQWqXBddKTP71r8=;
        b=K/wzaNw39hjUX9+cSxc9EoiuKAZdNq+aIje3y7iYMzqfpR0UvoN0IJZA/P95LX/eN8
         el5snCQd6dnt/IW56xKPP50wetxzF7bHDBzSFV7K5PhXIMS3HjkaOO6PY87sIlgR1Fsn
         Lv0jeirGhqV6bt1ajP+sXLKvT5aa4M+3ySv8/5JINiPdqtahuewYNlO+GB+H2ie0RUCU
         vPWy8xBYSbwg6rCw1aw4E5gcrLO30YN1mHYsxltkX2o0F7EY/X2jU2FsBCdSFVEnDJq0
         BQrAMSSv9zd7hsiz0NBtHjJ/EiX8woS18dR7fTUwN3ZSx+OsaBJloDweStkWx0+WaNrc
         uibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYcc2w0Q0ZJn0ZnuqjwgIHi9CaHUcQWqXBddKTP71r8=;
        b=QtbiHpJeCYhVCwJCHt1UMJlyeCv4HKtCOK6ZMg5hg0ZWSXaGdZoQp50bJM3I+uQk53
         qS42V5nmCgA0QmeqSHNCV2DiucCxUaXvrdF9tCK+jCX4Yuh5Bw42sH5UouWH7/oasCin
         Qh/M1bUx6H/TmrZ447tnNPC5d/Yo608CvcXD2Ui8O3T5LhBfPncbYQypxSkQKc5C5PBA
         wxMZ6LhLGV/zX8sRPVL2uHOqdp/N+q7wokKE0UowuGtDDMjk3xM7ISFPH4UqHoSAQE8q
         RSMzMHt42gpppDm8eolmn9lv25mKAanrnGU59S/LjE6VcpRc4kt8jGykDUBPafgR7xG2
         vtKA==
X-Gm-Message-State: APjAAAVVsaKk5NkJjFM30lL8glEsOs3Vj0d2gBVs3pjF/LUI6Wn5s8gL
        Xm0iUuUaicjk7DMMnJVLt3o=
X-Google-Smtp-Source: APXvYqxC25uhD/5RVP5Q3KT2C74wS9NqatHagFCYGocMMbGG+u6cwTODTIvfmF9LKcWzLisl/npxQg==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr36738053pgi.345.1556185604623;
        Thu, 25 Apr 2019 02:46:44 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id j32sm10844883pgi.73.2019.04.25.02.46.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:44 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 07/16] restore: reject invalid combinations with --staged
Date:   Thu, 25 Apr 2019 16:45:51 +0700
Message-Id: <20190425094600.15673-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.854.ge34a79f761
In-Reply-To: <20190425094600.15673-1-pclouds@gmail.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-checkout rejects plenty of invalid option combinations. Since
git-checkout is equivalent of either

    git restore --source --staged --worktree

or

    git restore --worktree

that still leaves the new mode 'git restore --index' unprotected. Reject
some more invalid option combinations.

The other new mode 'restore --source --worktree' does not need anything
else.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e855c64cfe..71e2589340 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -433,6 +433,16 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("'%s' must be used when '%s' is not specified"),
 		    "--worktree", "--source");
 
+	if (opts->checkout_index && !opts->checkout_worktree &&
+	    opts->writeout_stage)
+		die(_("'%s' or '%s' cannot be used with %s"),
+		    "--ours", "--theirs", "--staged");
+
+	if (opts->checkout_index && !opts->checkout_worktree &&
+	    opts->merge)
+		die(_("'%s' or '%s' cannot be used with %s"),
+		    "--merge", "--conflict", "--staged");
+
 	if (opts->patch_mode) {
 		const char *patch_mode;
 
-- 
2.21.0.854.ge34a79f761

