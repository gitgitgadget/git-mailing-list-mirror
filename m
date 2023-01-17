Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B238FC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjAQRLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjAQRLd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:11:33 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA23C3457D
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:31 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y19so12432671edc.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRTnwPrbrV7ma7a3OZWCZwFiOWUu4067NVK87XmGZ6E=;
        b=eDUMPKolei62UAmiye8uJHPeGIReK4w3qDlUClS5lhyqHhXtO+h3eQBTQRX7MdJePA
         5ADvfp9AIdUKpRc0f7zrjQOp8nf54l3hSTPgL5hBME+r3w89WEsMKHNR921OAeT8u8Qu
         Qz2LPVLBBO8xv5x5DjhJAWwUukKzxNFp76TzzkeiLrehEhHERi+vc5rZyFPgAt27gBcU
         6ydLPFZlHWy+UeU3o7iv+nZqd4jh612Ze+0yCgD2RN8UqS21RJPz0VUS7tbpqBuVeBEB
         Nq7nvcaXvOP3ITmkZVvT9kVzfwyA6O0KLrJqKWdjjllj/e5t0YMNNO9uvPBcYeqQA4EE
         LMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRTnwPrbrV7ma7a3OZWCZwFiOWUu4067NVK87XmGZ6E=;
        b=RWYn97NhasWkIT0niAlqrqZP44WHvUQWOPTnp7k5cZw0huWhcgO8GY5oP2zr4GoGgS
         0yeqGNppxW6XIGeTeqnZg5qRhNRYzj0IQwBfdTy2FwVly0dyOY0/sW8Q0JI38voq4vhD
         JebQEjGLFq0MPWBgRBgWrviM/Md21gwfVThuwcR5+FtdtgB6A4JDwGxovA/nik+i3J+a
         iWaBUThoR1rskFj0wE5qq3ZR/lam1TFYknegzfE1arVeYl+fP85OxsBEkcEKWXWuGCSw
         +ar+YIkTgnAmr4gCHE+s4WiM0B8IvoP/Ic4Db3EhdIuB2eY7HneQkOuGjL/hoEw3eZml
         tpPA==
X-Gm-Message-State: AFqh2ko2HEqTlcPGKlzxf18B1CQ4lsBHOk0Lu9UU4L9Gv+DJ3f7Wkd75
        3jfGxJ0plnTzpWiRIA6n3wEWjPDqCgp2jQ==
X-Google-Smtp-Source: AMrXdXv0I9fIrtSQJti5pde+gE1Oil8pN+K6rHnWH+JeGWTG5fzVyThMkaS8+gvbaC8Y+rWS6bfw+Q==
X-Received: by 2002:a05:6402:159:b0:49d:a87f:ba7b with SMTP id s25-20020a056402015900b0049da87fba7bmr3793320edu.39.1673975490033;
        Tue, 17 Jan 2023 09:11:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/19] clone: use free() instead of UNLEAK()
Date:   Tue, 17 Jan 2023 18:11:09 +0100
Message-Id: <patch-v4-04.19-966d7657d54-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an UNLEAK() added in 0c4542738e6 (clone: free or UNLEAK further
pointers when finished, 2021-03-14) to use a "to_free" pattern
instead. In this case the "repo" can be either this absolute_pathdup()
value, or in the "else if" branch seen in the context the the
"argv[0]" argument to "main()".

We can only free() the value in the former case, hence the "to_free"
pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5453ba5277f..ba82f5e4108 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -892,6 +892,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int is_bundle = 0, is_local;
 	int reject_shallow = 0;
 	const char *repo_name, *repo, *work_tree, *git_dir;
+	char *repo_to_free = NULL;
 	char *path = NULL, *dir, *display_repo = NULL;
 	int dest_exists, real_dest_exists = 0;
 	const struct ref *refs, *remote_head;
@@ -949,7 +950,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	path = get_repo_path(repo_name, &is_bundle);
 	if (path) {
 		FREE_AND_NULL(path);
-		repo = absolute_pathdup(repo_name);
+		repo = repo_to_free = absolute_pathdup(repo_name);
 	} else if (strchr(repo_name, ':')) {
 		repo = repo_name;
 		display_repo = transport_anonymize_url(repo);
@@ -1413,7 +1414,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	free(unborn_head);
 	free(dir);
 	free(path);
-	UNLEAK(repo);
+	free(repo_to_free);
 	junk_mode = JUNK_LEAVE_ALL;
 
 	transport_ls_refs_options_release(&transport_ls_refs_options);
-- 
2.39.0.1225.g30a3d88132d

