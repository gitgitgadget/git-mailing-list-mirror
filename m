Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98205C54EBE
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjAJFoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjAJFoC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:02 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840B141A74
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:43:55 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so25731686ejm.8
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKhtK2c5/tdNHpixWjcaMzOzyk29rV3lIHqroZpbqOw=;
        b=FFHUPbvWfkGmE3tQ3Dyf1DMSTAJEl1K0TANZ1zDcPeNe0qD6PQGz+vbyFDeaYBj0uB
         4cikkX7jimHUxT13Ga4Pxh7IRBgPVEiqlVcBFuWiytm6m2ya3XkNerIa+fYrtrs0bA7H
         WYCoZIYnp2lqFLKvJc38f5VVIOMRo450v7Q/6Pk5DzEn3dxl6UmkNg3ne+iujQ7FfPkP
         /eZXb8G1t1Z2vdKQDnRtF/scPjPiWXdB6vCpfGkVOeIKgjOOObjMq/0/9rTGM3392ObY
         RDR2DfhayXPeu4ldmz43IdGDyx4S8WAunsUwkv6sjMACglCbQWWTq18NFUSVQorUSi/0
         lang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKhtK2c5/tdNHpixWjcaMzOzyk29rV3lIHqroZpbqOw=;
        b=dG6utfGHmVbJuigGZGGNIl9Uz1Dv5ja+r7gqx4Pv9Ss7yDKmwSisoxB6XmAlOQ5I4x
         9B92ANNHN3pIdv8Q3CgPTbyCkkBlszrcSQHoRMfMvYOQz6CK9BQbkAvU7eWTtwfsHdaf
         mfAQvT6lZT0YtKDfJiPjcgQjpCXuFvdghqQLBDpHszB7ZY255h6Md0JoewOlQrfD7YDH
         +xdtxKK4efNMNidP6m4SWtVmEDFXGN0biqk4odIsiLiifKwDZogbBJ/moCTcyFs6viu9
         T6kmhOO4IeCosk5kPGckE99/yq5Dy645OIVdXMuPhuab4hkM+ZsrYEpuEnUU/XatPMFJ
         g1Uw==
X-Gm-Message-State: AFqh2koVji3a0uauCNi92QX8oqz28ING3yA+Xg/NeVdNeYrP0kE4Vv9a
        Hl73/0uy8GWBtiQiA67KYz1UCcY5f+9iCQ==
X-Google-Smtp-Source: AMrXdXsmUSQieiRljBjEiSRCtjcuxV5WneRcncBpq1GAyZc9sIYRseALLDzaMn8DpyJNGp7mY4OaRQ==
X-Received: by 2002:a17:906:af17:b0:854:6b5f:4ffc with SMTP id lx23-20020a170906af1700b008546b5f4ffcmr1751360ejb.70.1673329434203;
        Mon, 09 Jan 2023 21:43:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:43:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/19] clone: use free() instead of UNLEAK()
Date:   Tue, 10 Jan 2023 06:43:24 +0100
Message-Id: <patch-v3-04.19-765d5cbcf81-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
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
2.39.0.1195.gabc92c078c4

