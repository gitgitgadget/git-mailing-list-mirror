Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C07C433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbhKZWse (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 17:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245071AbhKZWqV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:46:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38A7C0613E1
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so7710405wmb.0
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 14:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gRaNdmvDEr6H46nnqwVcMKdS41AmthpmKs+geDt0D6A=;
        b=MB/PcpAQy9lXGArFmXni0/nXyXNuv6DQR8g5Ao7mc7xUiaO/sQnhKvXrsqO8+2xI05
         MSQCIkzhTyhZ8+PMrNFvNHHFo4eA5j83Pq7bjflAJHzIU5O5gpfLjVCrnnXq8Is1Sr8f
         rLPj1Irz3CYfb8sjgPk5/WD1uX0GSD52V+1uMG0yUKdZQJxBqKMHkWPomWJiTNTS3ICg
         VGNuBir6Bl/N1yP/zCh709DFaM+CIBCYmRnPE+ltXhV/qkZ1tlCfrVPyoIVJov2R3urY
         /HM5GJftHmCuL3ipML2o2l9B6tpZ2AE33jG/+uUqViknfo/pwnEoORA4DIFyneUk4jYI
         DK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gRaNdmvDEr6H46nnqwVcMKdS41AmthpmKs+geDt0D6A=;
        b=l/QbpiWGR+U1IMfruWk6cAUxvcukQORm99A0CHYoykWwFpHWupgUXpR5BLRRCbzYCF
         tbeKwLSWQ6QXVlPg636ObX42mpPsSwD0ucsLZ26azGF509LX0z9VJMGyWqZ7tXOjlKGf
         E0iHtWlraygYc5TIcWLRDaVZRPYsuvAak5h/7EzWYA/G7NUtPtAqbh4phQb8O0+wY3LE
         9W2hNVFMpEwXQlGiv71abbDQ8ZEES6rYj7kl+Rtj051isQnv3qH29iZ+t559Iq0XswOa
         VeET9lO8EB20wDeArBgak7jYvl2ZW6EIMukfSTKaF2rSbLn5ECrHQQin3WKWmhulhlOU
         lJ1g==
X-Gm-Message-State: AOAM5300IDPvLVVoYZHfcn2VVRhQa8Sb2ImZwjQfJDzUiqNEKYfbmEaW
        MrQNUfrnmm03bdsO/pt/FYlAMvQ4qgo=
X-Google-Smtp-Source: ABdhPJzaeX9aD2L2qmj5aWA5ys6DUVsTvg2hPaZDIjvTT8BBKgNFXlCiYfI8jogTDCideU6iOqislA==
X-Received: by 2002:a7b:c763:: with SMTP id x3mr19066789wmk.31.1637966470205;
        Fri, 26 Nov 2021 14:41:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm6606163wrw.5.2021.11.26.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:41:09 -0800 (PST)
Message-Id: <0110462a19c0ad1f11bbb6449f2ec84fe14c1442.1637966463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
References: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
        <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 22:40:59 +0000
Subject: [PATCH v3 08/11] stash: do not attempt to remove
 startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since stash spawns a `clean` subprocess, make sure we run that from the
startup_info->original_cwd directory, so that the `clean` processs knows
to protect that directory.  Also, since the `clean` command might no
longer run from the toplevel, pass the ':/' magic pathspec to ensure we
still clean from the toplevel.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c      | 5 ++++-
 t/t2501-cwd-empty.sh | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654df..4d89cc7f969 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1485,8 +1485,11 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
+			if (startup_info->original_cwd &&
+			    !is_absolute_path(startup_info->original_cwd))
+				cp.dir = startup_info->original_cwd;
 			strvec_pushl(&cp.args, "clean", "--force",
-				     "--quiet", "-d", NULL);
+				     "--quiet", "-d", ":/", NULL);
 			if (include_untracked == INCLUDE_ALL_FILES)
 				strvec_push(&cp.args, "-x");
 			if (run_command(&cp)) {
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index acf9646ec6e..6788a0d267f 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -227,7 +227,7 @@ test_expect_success 'clean does not remove cwd incidentally' '
 '
 
 test_expect_success 'stash does not remove cwd incidentally' '
-	test_incidental_untracked_dir_removal failure \
+	test_incidental_untracked_dir_removal success \
 		git stash --include-untracked
 '
 
-- 
gitgitgadget

