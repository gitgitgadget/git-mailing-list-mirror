Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C14C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 12:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjARMqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 07:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjARMqD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 07:46:03 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A5D23656
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:39 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ss4so75424813ejb.11
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 04:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRTnwPrbrV7ma7a3OZWCZwFiOWUu4067NVK87XmGZ6E=;
        b=oCPiRRM4KHkfVW+az5rBB+JMSBUuM/HlHlJuFAPyce6Pqy2xkBLAUsZTGS4kjp34zn
         EVUBkg0z/ZVgFnwTizkxWWjMtH6VbvC6vhfWlwzaiE2VtKNrB4CwV9Dh/HIrW9zmhZaV
         yPsAd/El1XEedMXJJ6kQ58hc+EJwAIyTWrbsElT5WkbHxPcNpJnpehWjKqo0YN8J6lIL
         28V2yqI5kpg4uQ9gbCH76/AeX/Pj0avrAqJLe5hpHtYKW0iMbDTJkq4BEcL24Vu/9qWj
         Wd0OzpmHKfuHNs/W+bealvLqcX38jnHqJHXJ4R/iw+T6/2c9xlLyQR6EqGYG4vPzn+xg
         2+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRTnwPrbrV7ma7a3OZWCZwFiOWUu4067NVK87XmGZ6E=;
        b=GnjG5EO+JesELdMOuQ/WutLg5F8CyWDE3LEWLcJD68OceuIC1qUhgYGFppxDrCd+r5
         jBRJqAlPwklxs1Bcq33iQSpEbnCSkg+GVX3HMCt5OJ9UCIkF0PfPeLYNJb9CaqM+FyZ1
         21kCfdzFyTcdBkhqX+0lEpTkzdH4b6MxVJIyE/YDDdfWF2OxjvjEaZmXm+xHcaUQCr1W
         3mi1+Fmg7wCsk1gn8QqLYZZ5Zm2blb1PuVy5Q+RHSKOuMUW89QGOn+2OpmVRSQOm3Wz6
         hEqZujFqvCjHqPLuYJTiBjhxoYUs26p4lB4tiD61Bw0ZMfmqseLB4Vm17pMl0Ida60Sp
         kgXg==
X-Gm-Message-State: AFqh2krzwsuuxql18aPfFzvhp7NuSG73Svtg1o6lAGufAxW5vk7v+WPA
        E7Jz8OoRdGWcZZI9YyWGtD2S+RZQtP/eWA==
X-Google-Smtp-Source: AMrXdXsVgl0mFw//S1zBmkbGkId/d1qHG5umxRpYOmxlgDKEpD5XYDTlvvJKGEDtUfoTISX6wmxytQ==
X-Received: by 2002:a17:907:a506:b0:873:901:4f23 with SMTP id vr6-20020a170907a50600b0087309014f23mr6824380ejc.24.1674043717766;
        Wed, 18 Jan 2023 04:08:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020aa7c90f000000b004615f7495e0sm14120053edt.8.2023.01.18.04.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 04:08:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/19] clone: use free() instead of UNLEAK()
Date:   Wed, 18 Jan 2023 13:08:17 +0100
Message-Id: <patch-v5-04.19-f4f3aef2861-20230118T120334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
References: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com> <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com>
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

