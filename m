Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D501C61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjBFXIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFXIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF743AA9
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:14 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p26so38646166ejx.13
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvmZTFgi8UGwvl/FXYtEpG1oyYexMCgMKhW+C8nm/F8=;
        b=d27p7j4hp2A+Moo4/ZrbUnjKWUOzPp7TTbSrpn7u+oniFUC65pWAR1f1yS5fZxnjAr
         6cWkYnAv+/rYGRcMCE0nAob9QdkTUD3eT7XvT+WVp1dHFsJQ1Z6pI45d7bzKXPj64KEh
         Syjqr0EAaXv4xu42Md/IvG/JLX+L1gm+Szg7IF16kTBxJz9UtMrQGKXxWyDUpladoM9i
         bvQzdCyLUTWf5nkycxx+yhN/CvOxkQxUEkCILd9Gm/q0ad0TtDULheBtU30tZ15ySERc
         v/F2Y23Iqbykhd9mzkNsfk9d2Z9GRAx+3Kq5TY4BkiN+yuPrkjRzeH1ODnBaUlFU80ur
         0FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvmZTFgi8UGwvl/FXYtEpG1oyYexMCgMKhW+C8nm/F8=;
        b=fo87tQ1/jSCD0FcQZiL0QEoZHJksgMzneM1iOz0jGkUfEqhStjVipDHdYhfCCMpi99
         0x7calLms3EHI/8hJFr5RmEv0lUJLRvzP/sjYU0XGYvCK74qMmQxxkxSyyfuVHoNSeFY
         Xc12UqhpbvqaOrlT9QT2Y6fJKRbvl4pY8czpdlmSIn6/pSN24LW1pNqf2Oo2hRBKsblK
         9PvnIZzv6esT8603WO/ZrL5ivbHwPzfTdKrO9w24gQ7Vc02UO9MKv3+Gwu7mRg+5WbWU
         geEnX7VI/Ip1qCOhHe+y6Z22ejyPYm5Arz4k6xY9sKB0t3tKzLOdwcIU7/wyqTUjlQZc
         4r+g==
X-Gm-Message-State: AO0yUKUoBFwzPvlqU/1WdB4RuE/kWAikAoG3UGiTKiP2s+DoezdylVpn
        pBOXO16rS3G8wMid4hYW2FI5sbY8Z9De7Yrg
X-Google-Smtp-Source: AK7set9jfn+mW5T+j5pnVg2Az7Fhoialqh5WRZhr/hlcsN9XzggsgYqVFEZfaVvxs1aUSl69PtqFcQ==
X-Received: by 2002:a17:907:9484:b0:878:509f:798c with SMTP id dm4-20020a170907948400b00878509f798cmr1370015ejc.4.1675724893003;
        Mon, 06 Feb 2023 15:08:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 04/19] clone: use free() instead of UNLEAK()
Date:   Tue,  7 Feb 2023 00:07:39 +0100
Message-Id: <patch-v7-04.19-56f9227c552-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

