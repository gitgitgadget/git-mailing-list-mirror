Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39401F453
	for <e@80x24.org>; Thu, 25 Apr 2019 09:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfDYJqv (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 05:46:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46201 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbfDYJqu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 05:46:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so1789415pgg.13
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qyOxQMmAWW6a/P4whzPoCFz6gbfVVSDMyxDdQ4+isj4=;
        b=syAZyF1zCZSp/5gN5ko0Nb1Vca5avwoAEifxn8C2v7OBLVMF+tKJpsK6A6rByoOAME
         tCG7xsqMi6nMWC5WB2n0pxSzh6YwovMDlR95CO8hiLOZC6mc/7tgSUF7DVyQLnmqqh20
         u9Jtro/WMvnj3dNuvvdz1ElRxxmSA/G2pZXKmuzKru5AER1tSZK5y7rFL1hJNsZTa+rT
         nKRjW3R1ByHftyUcjEiuT/cf0HYSz70OdR2iED+b/mexclCMjKVhlEkL7f+B2lEb666C
         UUFc49QzV5ajRLm326Q8dhoHDJEUPV8cu50YPT5Xhca3bwaUIixYrSGREa/KF/DWUyQF
         yonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qyOxQMmAWW6a/P4whzPoCFz6gbfVVSDMyxDdQ4+isj4=;
        b=BCk/+QGwBXK2AClEam++GlQp6LaqdKDN9itQUTIN/llnYP9Ma74D2E2rkLuo7zdcPJ
         jJqWS+fzxPvkxHetWxsb97ALhcC+Ja1dKYHnT9Lmbd4LzuyOJIV5GE8o2Sa8jCxrSXpZ
         WNP1YoPOIfNVtWkHaSNBmL7n+d/WyDGPrF9LNEz+KsJ4P0lL0+UHoR6OYMhY5JMgkYTz
         l6nPwhfZw/UcdFqMPzFCUn3csfAo7R97hSKMPHz0V1v37okWI9RaU04UkzXB5oVz/CxF
         VA5e3ICCvEcrh3lJIKi6tL72rl09TmwPIFbMoSAK/rsErXEeh2HJNdMczKZDsVMIq/GZ
         xAtQ==
X-Gm-Message-State: APjAAAWQwXYLMahzjBjPUMQh2wIH2ue77y8XD1sY0QHm95c576OXyJAN
        jpiNYOSkHcxMRS64jsey9e4=
X-Google-Smtp-Source: APXvYqzs1FWiz1fN0aZnZG5Jh6pxfOzR4ucXQESeQ57AYq0Sj7+1GiirIYaS2kSZ8lYmnKAHp7CjzA==
X-Received: by 2002:a62:2fc7:: with SMTP id v190mr37988194pfv.10.1556185610005;
        Thu, 25 Apr 2019 02:46:50 -0700 (PDT)
Received: from ash ([115.73.128.9])
        by smtp.gmail.com with ESMTPSA id f22sm29675508pgv.45.2019.04.25.02.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 02:46:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 25 Apr 2019 16:46:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 08/16] restore: default to --source=HEAD when only --staged is specified
Date:   Thu, 25 Apr 2019 16:45:52 +0700
Message-Id: <20190425094600.15673-9-pclouds@gmail.com>
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

"git restore --staged" without --source does not make much sense since
by default we restore from the index.  Instead of copying the index to
itself, set the default source to HEAD in this case, yielding behavior
that matches "git reset -- <paths>".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 71e2589340..09a03f1ff8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1524,6 +1524,12 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 	if (opts->checkout_index < 0 || opts->checkout_worktree < 0)
 		BUG("these flags should be non-negative by now");
+	/*
+	 * convenient shortcut: "git restore --staged" equals
+	 * "git restore --staged --source HEAD"
+	 */
+	if (!opts->from_treeish && opts->checkout_index && !opts->checkout_worktree)
+		opts->from_treeish = "HEAD";
 
 	/*
 	 * From here on, new_branch will contain the branch to be checked out,
-- 
2.21.0.854.ge34a79f761

