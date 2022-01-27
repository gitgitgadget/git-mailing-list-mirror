Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A670C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 16:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiA0QXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243614AbiA0QXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 11:23:05 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68704C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u15so5780888wrt.3
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BcABkz0jpYOqqI5iCB+vV3s6748Kb9A9w5kvIrZs5Fc=;
        b=RzeFvepA3aHcQp/jNj+nieM6TIYqJhfyAQObOYwx6wkWfGnwdyM2JzQ9Z7ZE8gGPqb
         cQNmQnMIOAwhaU+3Dau1xi1KIlObge7ZkbDkq6GfyB5GCrujmmn4gWmLDB0BA+I185Dg
         yMvziM5NaCTt9I7wfmkRkZRJ547tcURKwSa4wuHXQhLw8Z6E/6N8O+ezRw9yx/KfFPvP
         7CtWfzjkvozIBOp9pHvA0QSU+EzaMAnOT7wFIb+riPl/YQLUmGFPNNqgATlGIZaKPDnd
         FOvioOV8OMHNxyhUo+R3Yw8BXYxMcPqfA3bspZf/afFKN4Rhnpqsnmvmatd13ZOX7+AZ
         CouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BcABkz0jpYOqqI5iCB+vV3s6748Kb9A9w5kvIrZs5Fc=;
        b=At5Py8uUNlmj/vdHVx1TfIKG5i9gsctzI1ROQkH0x/Uupn+GvGRkmErBNOKF67PhEJ
         7RoxaYHf7Wht6skSSIJc00tyFnySYhRpupG5Ej+Z2ftd7AXdSdzTFyHQqNOBCp8iCPbL
         TTNZ6iOSWEzeaX7natv6EExaG7uEXdM/wGnwdCcZEnC12SqsQhmHyTrhzkTG7cW85Hdp
         /b24nMfqth+epVA8X8iostEuLwZBVPSWxyRZynObcJFQBLyf7e8qTnzV4DfGdMkvPPZ9
         HO5xDMp5+t1deg/QYHxhMiV0ONOkJtQfHqMfkex0BxLTlnDyDEfuHSv2L9MoQ+4XQfjj
         X1Jw==
X-Gm-Message-State: AOAM531NXrYdkJQOtca2/qHS3muRTsu1C1SRqFDl7v75x9SoTqtkOhEF
        Kzapn8jaHGyPM0ZYwfFrvtpbnDYOdJRqMw==
X-Google-Smtp-Source: ABdhPJyPYjRgI66aujfXIferyRC+TA3XeDwdKCZzK1ebZTDv8nqCGanZkNX8l7JqlYFPhnkd5WxzTw==
X-Received: by 2002:adf:e489:: with SMTP id i9mr3591738wrm.107.1643300583733;
        Thu, 27 Jan 2022 08:23:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13sm3257186wry.77.2022.01.27.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:23:03 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/7] submodule--helper: refactor get_submodule_displaypath()
Date:   Thu, 27 Jan 2022 17:22:51 +0100
Message-Id: <patch-v4-2.7-7e2df3ff220-20220127T143552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
References: <20211013051805.45662-1-raykar.ath@gmail.com> <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 965260edb22..d38a64c7b7d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -263,11 +263,8 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
+static char *do_get_submodule_displaypath(const char *path, const char *prefix, const char *super_prefix)
 {
-	const char *super_prefix = get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -283,6 +280,13 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.35.0.894.g563b84683b9

