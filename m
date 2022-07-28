Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9882C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbiG1Qas (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiG1Qaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3AF165B7
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h8so2914298wrw.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MZraaqpo5FGcZIRHuC+Tyd8g6Z35YRaVd3RXyNti4m8=;
        b=IIdXjA/rTMfv+j3U5ZjvvDMyJkhOXRRPbM+5DT9Kad6FW48AlJcaYQw2Zj+XOMxRd9
         Y9jqmGxiYC+xIlUB1rjFnjTRO51q5OHnLjNlbuBLg/JGlcrvWFk+Yn5O+3r2y/SYdMqD
         VF/1HKoNHYbg0KN7FK4MTz8RDz1yf8oDTRrWkLiZavPsnvv3i2oWo7bZFcsdRM2vuDEn
         10nTdsHhRXlLu6OjzoMF6DncB2sdASCHD5ghER1CZukENaSsa8Xbm19bQHs/HTDCadAv
         oGFvmarVcP49vZeg0EE4NLe4hiCd72ExjlyMwM6X2LD8vl4QwWL4Dlxd/TtuWj0HyYlT
         GuxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MZraaqpo5FGcZIRHuC+Tyd8g6Z35YRaVd3RXyNti4m8=;
        b=doAEjQ9V0vGPpawk2Od9/QLgoQqLbcZJXsS5yD5drf9QTzGq7jf1zMxzKQfIXj9ooV
         gA9KOrcWuEArD7qCLMKjFojH6HEBfHq0PejkuyxYTZkTOWTQHJ5PQJ9tz7YZyXgehbTx
         cofolGA9iq6S+oqqjMJIAoPBIDvZ48gWr9Q3bh5l66in9j5wPx7eVOR3OFMOjx/uhjsK
         Hqas+erLum5Bi/bl5QoUD7o1YOP7qXqdZr9yKMsky586sEWWWC7hwNx2Rlp2BgrCHfcS
         ANwvIWJxJtD5EoMaVB7t11Z7G4NytNEQx9PUVyPyM9JeDE/+tHFHkMvUbve7kbSVHzBP
         kyFg==
X-Gm-Message-State: AJIora+I/45wGR6PIhjWnXIunmBA6PxUIzM4ciFOjKEtzGNHjXBNJGzx
        nVyDBfrVKth4wMAcjpwK/v16+z3RcOblxA==
X-Google-Smtp-Source: AGRyM1vZ+ylobx+zN+V/sBXv8UeueZqSS8oKsi7gTK1uDr4XtXETVqe4umhELdRWBRutVarQO9Altw==
X-Received: by 2002:adf:e310:0:b0:21e:3e46:81f8 with SMTP id b16-20020adfe310000000b0021e3e4681f8mr17124932wrj.188.1659025825639;
        Thu, 28 Jul 2022 09:30:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/17] submodule--helper: fix "sm_path" and other "module_cb_list" leaks
Date:   Thu, 28 Jul 2022 18:30:02 +0200
Message-Id: <patch-v4-08.17-ef9e29d5bfe-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix leaks in "struct module_cb_list" and the "struct module_cb" which
it contains, these fixes leaks in e83e3333b57 (submodule: port
submodule subcommand 'summary' from shell to C, 2020-08-13).

The "sm_path" should always have been a "char *", not a "const
char *", we always create it with xstrdup().

We can't mark any tests passing passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
"t7401-submodule-summary.sh" gets closer to passing as a result of
this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 5cbe6a41e5f..becf686e47a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -735,16 +735,34 @@ struct module_cb {
 	struct object_id oid_src;
 	struct object_id oid_dst;
 	char status;
-	const char *sm_path;
+	char *sm_path;
 };
 #define MODULE_CB_INIT { 0 }
 
+static void module_cb_release(struct module_cb *mcb)
+{
+	free(mcb->sm_path);
+}
+
 struct module_cb_list {
 	struct module_cb **entries;
 	int alloc, nr;
 };
 #define MODULE_CB_LIST_INIT { 0 }
 
+static void module_cb_list_release(struct module_cb_list *mcbl)
+{
+	int i;
+
+	for (i = 0; i < mcbl->nr; i++) {
+		struct module_cb *mcb = mcbl->entries[i];
+
+		module_cb_release(mcb);
+		free(mcb);
+	}
+	free(mcbl->entries);
+}
+
 struct summary_cb {
 	int argc;
 	const char **argv;
@@ -1088,6 +1106,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
+	module_cb_list_release(&list);
 	return ret;
 }
 
-- 
2.37.1.1197.g7ed548b7807

