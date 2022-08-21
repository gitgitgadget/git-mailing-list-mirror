Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC43CC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbiHUOAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiHUN7X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:59:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992DD237FB
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k9so10321222wri.0
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qdHYxlsjiofcCgSdh9GvzOFpbdNNXH6ayj/L2iAD/9c=;
        b=QNfOu4sYc32cK+iKnYAXlRX9IjKYsHkQusJ8tBDrhR5aytHkap9O0b0zsNOaP+pdnl
         HrvRvX40Y+IhZwoUQySUQcgGp9xWRgkoCeisTqe/49YgKglYzBvJDv0WuP3uaJRHvqNU
         XWRjoojf8MrdzMCsHsZ6OAe9TzGFsPO/NY9yxDwsO6s0D2HtCFidOjQwLRtd49NhamGt
         5FxuTcyQ4yDB50rkAOK1owksnN6uKopyqnGN7cOVbp6oHytpIHKsmcJqbvl+CDlzVg/2
         lJCDnpLjPnQytju00+3c9l/zU1FTv0KYlOZGsAZ5TUYFVP8RG7VYyIx2QSMRX2/lt26u
         jZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qdHYxlsjiofcCgSdh9GvzOFpbdNNXH6ayj/L2iAD/9c=;
        b=f+wyHh7Lo3pQO8kS/nB4HCXK1YZnBGs3XGvnZwU1pOrwf+olsa1kRiUiuJgXokHntL
         qB77gC5yiv2tKy9TB7oemQV0eJwBwt8fKH4/GhqsiwXzr7yPOfd2Yho6fYgqoBRsblr0
         jAlB9b6k+nNh7VSxOeUCTGF/pDH6RWCQpJmYXxmXfJMLz3vYK0o0ZEoU0HFzvTDkyVJT
         7zyJswp9DlEZ/s3ngyDErhVVXYICeyHKc6nayPB2v6g3PRLqYwcV2MdKmUkmRENQ9Z7/
         tA/yMQZ7hidXs697z5+hV6RjdmVGZ+grJkAzi18MERqp7FN7uYkqZxpKoiYb39/WVPyW
         aUNQ==
X-Gm-Message-State: ACgBeo3CeK6AV4iRaccMhVjqSpf1s2BuVkv2RDmq6eiGx/OxYy0CmZhO
        5M4mEmnKrtPrIhT/z1sQBXFxrCJZbEOpqx5/
X-Google-Smtp-Source: AA6agR5mJoPXJIntbgz9XMkcLbTymkoST8GKix7AWwboHSdqzSMcKztibOB70mT+xwDZKy9j0opFSA==
X-Received: by 2002:adf:fe81:0:b0:21b:88ea:6981 with SMTP id l1-20020adffe81000000b0021b88ea6981mr9205338wrr.616.1661090333824;
        Sun, 21 Aug 2022 06:58:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 27/32] submodule--helper update: don't override 'checkout' exit code
Date:   Sun, 21 Aug 2022 15:57:36 +0200
Message-Id: <patch-v3-27.32-2795a3738c8-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When "git submodule update" runs it might call "checkout", "merge",
"rebase", or a custom command. Ever since run_update_command() was
added in c51f8f94e5b (submodule--helper: run update procedures from C,
2021-08-24) we'd either exit immediately if the
"submodule.<name>.update" method failed, or in the case of "checkout"
continue trying to update other submodules.

This code used to use the magical "2" return code, but in
55b3f12cb54 (submodule update: use die_message(), 2022-03-15) it was
made to exit(128), which in preceding commits has been changed to
return that 128 code to the top-level.

Let's "libify" this code even more by not having it arbitrarily
override the return code. In practice this doesn't change anything as
the code "git checkout" would return on any normal failure is "1", but
we'll now in principle properly abort the operation if "git checkout"
were to exit with 128.

It would make sense to follow-up this change with a change to allow
the "submodule.<name>.update = !..." (SM_UPDATE_COMMAND) method the
same liberties as "checkout", and perhaps to do the same with a failed
"merge" or "rebase". But let's leave that for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9e9d4fe0261..851000ae30e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2135,6 +2135,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
+	int ret;
 
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
@@ -2167,15 +2168,12 @@ static int run_update_command(struct update_data *ud, int subforce)
 
 	cp.dir = xstrdup(ud->sm_path);
 	prepare_submodule_repo_env(&cp.env);
-	if (run_command(&cp)) {
-		int ret;
-
+	if ((ret = run_command(&cp))) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			die_message(_("Unable to checkout '%s' in submodule path '%s'"),
 				    oid, ud->displaypath);
-			/* the command failed, but update must continue */
-			ret = 1;
+			/* No "ret" assignment, use "git checkout"'s */
 			break;
 		case SM_UPDATE_REBASE:
 			ret = die_message(_("Unable to rebase '%s' in submodule path '%s'"),
@@ -2497,7 +2495,6 @@ static int update_submodules(struct update_data *update_data)
 		ret = code;
 		if (ret == 128)
 			goto cleanup;
-		ret = 1;
 	}
 
 cleanup:
-- 
2.37.2.1279.g64dec4e13cf

