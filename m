Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E06C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiGUTO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbiGUTOE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055CB8E1C0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m17so3327471wrw.7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNx4urEnxYRsUVVoSPu1gr9ek4cEFoLS1upNocJRgwo=;
        b=JX2a0yM6hHqpZabc+QFfKr3d0myopuCqKT5mxIhz+UljpT+JaP/dTjXYvTYHmvdCwC
         OUq9D7yYfNFypOLp5ez6XMoU+qop6mM4b+uy9HOK8bl6lc+HKe3IiKvzlNQ0xQ21r88H
         qw/np2iIAQTR/ys4xq10KYcqqvK9O/6uj/GbY0QG30PxmoYVSkgpGYnRFlJfm206xS9W
         DxjPbSNOJc53fb7mMLM4YCPnN8PHCfUu7XwB8SUGYOkLw+1Bdc9/w76Qb5lAV1MH22qv
         q17sve2NvxTMsSPWqqbCRyj1X5+m11+gOj4UOfwR9QHJ2ncJdOgT9oB+5rxdqnRI1AHg
         EJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNx4urEnxYRsUVVoSPu1gr9ek4cEFoLS1upNocJRgwo=;
        b=bnucsQELMfVZVXpzVyWhh1/u54bXw38HJLUu0c7gsDNnkvbFJNZ9dfEGdUA6YhPBeP
         Vqn6URpwUARoDJqIBf4bKq1uUjg2tpSrmNJ597+AvpVlbha/67fg7eHRZy7Jtp0HldXx
         iBu4gRWbfuHel2XEYa28Dj35a1MAaXuQEykshf3XIi6ex9rMmC/Ew8kmo1TbE1dZ5/FX
         qQDvLi+nsiMTwRJmbFf1RcZpvR5TuYyzUGsTIOxDjkpMfL4yYsE0FiMKE8g3ATphXjJL
         cZ06AFxv6H0gXkM71+zYR6ZS7xJC3XwCY4ihnPqPsEYB4nsQO66sC2pgk8+eRDx+v9hX
         bHtQ==
X-Gm-Message-State: AJIora9dkdCWKjsyWBUx3OlgaWhQc+XYuQwUS6YyW7V4cWlWqjTNqUW8
        PAYip9t7XMCKuJIbui/NCgeqAtSsjmxq0g==
X-Google-Smtp-Source: AGRyM1vfwdX+IU1pBkJnMoMehUrSsgbsvyTQFc/2Bzcsp/uluMCnUzz7JoxDoP5Yqc9QdJr4MEv0Kw==
X-Received: by 2002:a05:6000:1f0b:b0:21d:6dae:7d04 with SMTP id bv11-20020a0560001f0b00b0021d6dae7d04mr36151502wrb.414.1658430838263;
        Thu, 21 Jul 2022 12:13:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/26] submodule--helper: fix "sm_path" and other "module_cb_list" leaks
Date:   Thu, 21 Jul 2022 21:13:09 +0200
Message-Id: <patch-v3-13.26-5be941b3d1b-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index ad11ff20022..a5492c6d89a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -820,16 +820,34 @@ struct module_cb {
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
@@ -1172,6 +1190,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 cleanup:
 	strvec_clear(&diff_args);
 	release_revisions(&rev);
+	module_cb_list_release(&list);
 	return ret;
 }
 
-- 
2.37.1.1095.g0bd6f54ba8a

