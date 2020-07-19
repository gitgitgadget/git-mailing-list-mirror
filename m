Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACBDC433E1
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8515A21775
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 12:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hogQlKtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgGSMj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSMj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 08:39:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F28EC0619D2
        for <git@vger.kernel.org>; Sun, 19 Jul 2020 05:39:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d17so17396968ljl.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2020 05:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VB/sSlvQEFMObqB3kwrj3aOOLaZY3Et9LU/5E3ckbYc=;
        b=hogQlKtxzDgPTgs9mhMljjvKG22g6QURVbFJsbyOsKCqLY+KwtFrvD6DdvBwlJ93sM
         jue5Mngl9FYiJafDwvXlR2PtTXQBgTOujdcBBQOydDaGR44TYwKYPfHX7Ga0st1aCvkb
         3bM5zBOW6jv3meWU6dLEZEBleyr62HEtpAO9glCpSC2i5Urag9quIAwpLLkg23iiM2Ro
         7Mwa4P5XJfgwE9N7Bd7ww3eBURGlDuLbQDsiOcKjaa5UBLp9MFsW6Z07Sdd9kDhCTfZe
         zLYc5eUhDIIF01+t/QbvkCIHm77lbhSPXLLJDN1YL2xhazrFXBE8YXCE4E65Q//bC3oH
         fhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VB/sSlvQEFMObqB3kwrj3aOOLaZY3Et9LU/5E3ckbYc=;
        b=ZRBa1BLKY0vmuAMf2uuOxvZcI9Sh+mZ5UhBT0Cf4LQYBksirmT/aNWKk4JJ1lVwAFA
         jP/tU2lJt5E3e/u4S5Ocv5b2q/lSo/b89CQHtQWk0yvEmGoFdbv1RSc0eGLHFlZxQu0/
         d3CZ+a8aF+ERg1klUB5/DNvC+h24WhpOmoxrD38Ey/tFx5eP3pPVZBqjdN96nnt1iDBM
         4ltzCT3EJW1Iff9765FZPo34cw55zXeZq0Kof71EYKK6Zb2Y/zeftjs0xBKWDCWyIGS9
         Q4HMdarkiThU7BbxcFw8RVqmLPJR345ehlCCfnAh1aXtZjouDpImOWP3rVLLEsS6olM1
         AS8A==
X-Gm-Message-State: AOAM530vhyxiJosOtEmeQx3DXZjNplM5mNaIjDAcvy32cUuIe3vnschd
        EHECg6fyMxKQfvqhlMPzsDw=
X-Google-Smtp-Source: ABdhPJwQcxi5EH/+aASGcAMNsHBalRti8ASQZQClxkr1ls/uaSWXFd3+a82d5bxoi/0vDGOO41F/Wg==
X-Received: by 2002:a05:651c:1a7:: with SMTP id c7mr8689173ljn.345.1595162396771;
        Sun, 19 Jul 2020 05:39:56 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id y2sm3139106lfh.1.2020.07.19.05.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 05:39:56 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Martin Melka <martin.melka@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 11/12] Fix error-prone fill_directory() API; make it only return matches
Date:   Sun, 19 Jul 2020 14:39:19 +0200
Message-Id: <20200719123919.1802-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.rc1
In-Reply-To: <87lfjg6mkn.fsf@linux-m68k.org>
References: <87lfjg6mkn.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, 19 Jul 2020 at 08:37, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> This breaks git status --ignored.
>
> $ ./git status --porcelain --ignored -- a
> !! abspath.o
> !! add-interactive.o
...
> !! attr.o

Thanks for bisecting. This is 95c11ecc73 ("Fix error-prone
fill_directory() API; make it only return matches", 2020-04-01).

I wonder if the below makes any sense. It seems to fix this usage and
the tests pass, but I have no idea what else this might be breaking...

Maybe Elijah has an idea whether this is roughly the right approach?
Looking at the commit in question (95c11ecc73), there must have been
some reason that it injected the pathspec check between the
"path_excluded" and the "path_untracked" cases.  The diff below
basically undoes that split, so I have a feeling I'm missing something.

Martin

diff --git a/dir.c b/dir.c
index 1045cc9c6f..fe64be30ed 100644
--- a/dir.c
+++ b/dir.c
@@ -2209,13 +2209,13 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				       baselen, excluded, pathspec);
 	case DT_REG:
 	case DT_LNK:
-		if (excluded)
-			return path_excluded;
 		if (pathspec &&
 		    !match_pathspec(istate, pathspec, path->buf, path->len,
 				    0 /* prefix */, NULL /* seen */,
 				    0 /* is_dir */))
 			return path_none;
+		if (excluded)
+			return path_excluded;
 		return path_untracked;
 	}
 }
diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index e4cf5484f9..2f9bea9793 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -30,6 +30,31 @@ test_expect_success 'same with gitignore starting with BOM' '
 	test_cmp expected actual
 '
 
+test_expect_success 'status untracked files --ignored with pathspec (no match)' '
+	git status --porcelain --ignored -- untracked/i >actual &&
+	test_must_be_empty actual &&
+	git status --porcelain --ignored -- untracked/u >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'status untracked files --ignored with pathspec (literal match)' '
+	git status --porcelain --ignored -- untracked/ignored >actual &&
+	echo "!! untracked/ignored" >expected &&
+	test_cmp expected actual &&
+	git status --porcelain --ignored -- untracked/uncommitted >actual &&
+	echo "?? untracked/uncommitted" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'status untracked files --ignored with pathspec (glob match)' '
+	git status --porcelain --ignored -- untracked/i\* >actual &&
+	echo "!! untracked/ignored" >expected &&
+	test_cmp expected actual &&
+	git status --porcelain --ignored -- untracked/u\* >actual &&
+	echo "?? untracked/uncommitted" >expected &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 ?? .gitignore
 ?? actual
-- 
2.28.0.rc1.7.g31f2d237fa

