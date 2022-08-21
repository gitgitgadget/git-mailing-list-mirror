Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38478C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiHUOCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiHUOBw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A9224971
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso4734886wmb.2
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Nqpn/W2fql1U3XgSzMMvl85uIHHV/JGACe+z/A9Zy9c=;
        b=WJ35Gj4dzKlmm5kqKgqilRC9pf2sL16FT/abItCQzzuzXxuUDk1Su8OJ6qNkNFZuGV
         1zLNM7fz+9G7jVT8+h4rKAebxMgXNDvOplE2T4hX4t2Mp3/MhF3RF3wd9MaB0IgKmpEZ
         inKsQzjFLJreUvICDBH005FGNNTwi6b9ujS9XSHehelf75P8RQehIERLundnXzOtu0P5
         VTQ3NUoyUN5okrRvXLmBAxm8OLgyydDU8E4hddPoUA/1QlOcOUMSnVGSAQ7CDEjEIU1n
         7uk3m/q7JzXpZ2FQeXgObpsQWTAsgDHp7bThDSGfnzexXClLSFLquc1XrndRRfX+Txwv
         a0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Nqpn/W2fql1U3XgSzMMvl85uIHHV/JGACe+z/A9Zy9c=;
        b=IKD2YdCsS30QRKjqcmm1gEsou82fTizf082jOsTgoD0q8KAggsDVqoc91uzbPfL/5N
         U7PLt0ZdCq51zyo6+QFVoyqNdHseUuWl6ZPFnuf1XtV0hseuMsWQk7ekUh46q1eMwrog
         aspwb/LwvYyIDogO1mONX90V8mEAUiyrsA5RpI2NIe3wPo2akAz3ZKz3EDTDdMzvlKGt
         dIDArx5/WO/t5SE3JZj/GA3/PxnnIlO92iX05JlZxQlMuTn3Pt5OZCKkYXdqJ1BqhCiW
         8q24VXKPsrtR1EQgYJMsnD8yhmho0Yk3gxie3e9ltpgyMCE6+CXU1a4rW69oyMl7GMVx
         nLdg==
X-Gm-Message-State: ACgBeo2hGuVUcZ5KL5I4ZvOMsXt2R8j65HdYR4AJUfIwkuKbrhVV+EOk
        PzraLZJO/UsNHsFa0P4yEGR2WezkaVscsf7q
X-Google-Smtp-Source: AA6agR4+tGRleNykccY+MLta5fx5NsyOc4R+y0kVzRXByR+JXvOfUjto/323yFA46hFZxavAsToCYA==
X-Received: by 2002:a05:600c:a0a:b0:3a6:69c0:5799 with SMTP id z10-20020a05600c0a0a00b003a669c05799mr148068wmp.141.1661090467191;
        Sun, 21 Aug 2022 07:01:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 05/17] submodule--helper: don't leak {run,capture}_command() cp.dir argument
Date:   Sun, 21 Aug 2022 15:59:29 +0200
Message-Id: <patch-v6-05.17-a3886d36366-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in c51f8f94e5b (submodule--helper: run update
procedures from C, 2021-08-24) and 3c3558f0953 (submodule--helper: run
update using child process struct, 2022-03-15) by not allocating
memory in the first place.

The "dir" member of "struct child_process" will not be modified by
that API, and it's declared to be "const char *". So let's not
needlessly duplicate these strings.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 64dc906b5e6..5eb6bec4c63 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2129,7 +2129,7 @@ static int is_tip_reachable(const char *path, struct object_id *oid)
 	char *hex = oid_to_hex(oid);
 
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(path);
+	cp.dir = path;
 	cp.no_stderr = 1;
 	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
 
@@ -2147,7 +2147,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 
 	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
-	cp.dir = xstrdup(module_path);
+	cp.dir = module_path;
 
 	strvec_push(&cp.args, "fetch");
 	if (quiet)
@@ -2200,7 +2200,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 	}
 	strvec_push(&cp.args, oid);
 
-	cp.dir = xstrdup(ud->sm_path);
+	cp.dir = ud->sm_path;
 	prepare_submodule_repo_env(&cp.env);
 	if ((ret = run_command(&cp))) {
 		switch (ud->update_strategy.type) {
-- 
2.37.2.1279.g64dec4e13cf

