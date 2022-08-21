Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F44EC00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiHUOCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiHUOBw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5AE2494C
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso4734946wmb.2
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IC3i47e43BXqnGRabKb+jpomenaGDZN7beELP/8Xdfk=;
        b=ingrjIKfWZT8EBpkq5A2hgAOYoaI2Sx4no5QUwBWwip47D0SG1SzktRYSzwG8bpuZr
         WtOU5suJR3TQUmLe5fn1jzqzTHFdB3iilfpWxtAqzTOpY0JrrPaV+orUyw8cTXjoav+o
         X667PJUB9+YiS0dgHOQssFMIvSynnbiCiN+cZHXHqeorfBDFrTT5j6Ojglqnc7oc2rng
         iudkwmw/ZyDSHZN8bKf8+D//oQA7DUqCIYeU/R4/jGb7kbJUs+Pm/GHKhFhQ9KBfiOwj
         Xr+3j99AJeKFWipTTspvOBQbF7ESp3G4tCuXxbSJe15eZ97O/ojaN2M7TdF9NsjIHtGn
         xzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IC3i47e43BXqnGRabKb+jpomenaGDZN7beELP/8Xdfk=;
        b=ae/dsWoo1j0x+YLnCSb40GAjOSL3lJaIgcwSxghcTjNAzpc9DEt95fMfgxPxVIOgy7
         ethMb+a8tjI/B3EpWxlm8t+hUyL9VxUZlMUWV/QIjTpUFSfi4gh56d4+flaNwaFZ1GmN
         RSEQcDOCtr0NPpvCGzkprm8G2IdxUqBYaRJW9im2z9tXrMmwIKIAejQJmeD7L2ktsMVw
         sG058oWA3qnXLXF65bUsf0QQ/Pz3HTnC9/IoWcJKm2NgDuF7jyHH38B0rWT0lethr93B
         m3RoJKH3YmOct2JFpKDv222zyqPXnBDp5aGG+iHo5xLnUVMuDR0KGr3xjnL/vaED+CmJ
         R6vQ==
X-Gm-Message-State: ACgBeo1mfM50d6pZ8dVFbP07Mqs2W3ppfgGkLzyPUBKhkYL6ef8gB7vu
        1M9UorkdfhorRagO7d1idqZ3C92+wS6qiCu7
X-Google-Smtp-Source: AA6agR5FWStFeT1/umJlfPYyVYJtpVYvM/KSTqAMmaLsvYfuFkNkdDnfrylzejtdha+SfZctkzNRFg==
X-Received: by 2002:a05:600c:1c23:b0:3a5:d936:e5bb with SMTP id j35-20020a05600c1c2300b003a5d936e5bbmr9261144wms.59.1661090470763;
        Sun, 21 Aug 2022 07:01:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 08/17] submodule--helper: fix "sm_path" and other "module_cb_list" leaks
Date:   Sun, 21 Aug 2022 15:59:32 +0200
Message-Id: <patch-v6-08.17-2110b991913-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix leaks in "struct module_cb_list" and the "struct module_cb" which
it contains, these fix leaks in e83e3333b57 (submodule: port submodule
subcommand 'summary' from shell to C, 2020-08-13).

The "sm_path" should always have been a "char *", not a "const
char *", we always create it with xstrdup().

We can't mark any tests passing passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true" as a result of this change, but
"t7401-submodule-summary.sh" gets closer to passing as a result of
this change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c  | 21 ++++++++++++++++++++-
 t/t7401-submodule-summary.sh |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 42ec6127024..ea925178946 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -748,16 +748,34 @@ struct module_cb {
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
@@ -1104,6 +1122,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
+	module_cb_list_release(&list);
 	return ret;
 }
 
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9c3cc4cf404..542b3331a78 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -17,6 +17,7 @@ This test script tries to verify the sanity of summary subcommand of git submodu
 # various reasons, one of them being that there are lots of commands taking place
 # outside of 'test_expect_success' block, which is no longer in good-style.
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_file () {
-- 
2.37.2.1279.g64dec4e13cf

