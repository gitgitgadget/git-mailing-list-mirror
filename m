Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18818C35DFE
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF81F21556
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 10:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1p+x+Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgBYKzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:55:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40551 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgBYKzq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 05:55:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so2646649wmi.5
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 02:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZbArm5/ltUwonlXTTTsbxmBlkxzE7MIsaRPNbv7/5fM=;
        b=S1p+x+BoBfLt1inIVW0YkSKR1mY+FXSh5kfiFagXxySH6XEwRlbwXyAs4u1qHr7MQZ
         mzGgm0MzBKBgk/coGWhv1ALfwHyJ6lnritnXAGzp1Ca0MgSnB757+dkRzbaUv+pKK2Ow
         v1YxO9ApV4BCrU0nnc6PrkRs9OxaQiq2FolIz+dRMyg/LEl/ph30ahLaVDSzWdFwxSgR
         SIEJESCpIPYEjyrsV5s84hWYJub4lD4PFuThAVCDWS74O73ClhIhlOEq+LnPBolT85DJ
         UxJ6zqPT123+lLija+HjC94fX4pv8i0ddB4HmfJnEiPP+qT+vsm1nwogb6BFhFsIEdEH
         Ppaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZbArm5/ltUwonlXTTTsbxmBlkxzE7MIsaRPNbv7/5fM=;
        b=ExCUw4FtyI4UZXyReqUCQOXjIi5I2MVzC7Vw5xwqLSdDn78N9d8qvIq9mu2iBXeWyn
         xEvqmfd5ZolWBPHpibjYPIanH6KBzR8s3SpFVjbJXeARiOWTYbE+Tdj7ZvEcQtwGWCcq
         /d/pqYIZyyiZ6Nxbn07qVzh8uv02rQWhK0YsmrSoHtR9VIrtJu5HCuxEdNf9rEDVxeoI
         PPk+FwY17dl4OBPzVSkgPNobYKRu0r+4Gcy1NxHo2E9VFknnA4qRdavFluavQepVQK/K
         os4fcdB4Fhc9HkuxpMTY7/nqH1Mn6lCvwem9foY0YCBEAp6Sx1nQacCcwIyQF1Hmh/Z5
         98dw==
X-Gm-Message-State: APjAAAV1bbNsxfW3RDZqr8Cpekrx8aDXTNsshXN/dTeWgqBenmpp08qD
        nYHU1uwJPsUfiLlcrErIz/seUq+h
X-Google-Smtp-Source: APXvYqyYpQ0ArGzLquq5UHQWI3abYZ96EpWvZwN2KAnWPG7FxcrgHOU0rMciCw/h1RViFYBsszAeGQ==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr4608052wmb.0.1582628145426;
        Tue, 25 Feb 2020 02:55:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y131sm3886048wmc.13.2020.02.25.02.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:55:44 -0800 (PST)
Message-Id: <01b195ebe1d2ab1593915318b7e8adbee5d9614c.1582628141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Feb 2020 10:55:40 +0000
Subject: [PATCH v5 3/3] tag: use new advice API to check visibility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>, Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Following the new helpers added to the advice library,
replace the global variable check approach by the new
API calls

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 advice.c       | 2 --
 advice.h       | 1 -
 builtin/tag.c  | 5 +++--
 t/t7004-tag.sh | 1 +
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/advice.c b/advice.c
index 5c2068b8f8a..ea6e65c1ce0 100644
--- a/advice.c
+++ b/advice.c
@@ -29,7 +29,6 @@ int advice_ignored_hook = 1;
 int advice_waiting_for_editor = 1;
 int advice_graft_file_deprecated = 1;
 int advice_checkout_ambiguous_remote_branch_name = 1;
-int advice_nested_tag = 1;
 int advice_submodule_alternate_error_strategy_die = 1;
 
 static int advice_use_color = -1;
@@ -89,7 +88,6 @@ static struct {
 	{ "waitingForEditor", &advice_waiting_for_editor },
 	{ "graftFileDeprecated", &advice_graft_file_deprecated },
 	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
-	{ "nestedTag", &advice_nested_tag },
 	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
 
 	/* make this an alias for backward compatibility */
diff --git a/advice.h b/advice.h
index a8461a362a3..509b562edb1 100644
--- a/advice.h
+++ b/advice.h
@@ -29,7 +29,6 @@ extern int advice_ignored_hook;
 extern int advice_waiting_for_editor;
 extern int advice_graft_file_deprecated;
 extern int advice_checkout_ambiguous_remote_branch_name;
-extern int advice_nested_tag;
 extern int advice_submodule_alternate_error_strategy_die;
 
 /*
diff --git a/builtin/tag.c b/builtin/tag.c
index e0a4c253828..45e959d5f8f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -231,8 +231,9 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 	if (type <= OBJ_NONE)
 		die(_("bad object type."));
 
-	if (type == OBJ_TAG && advice_nested_tag)
-		advise(_(message_advice_nested_tag), tag, object_ref);
+	if (type == OBJ_TAG)
+		advise_if_enabled(NESTED_TAG, _(message_advice_nested_tag),
+				  tag, object_ref);
 
 	strbuf_addf(&header,
 		    "object %s\n"
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 6db92bd3ba6..74b637deb25 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1726,6 +1726,7 @@ test_expect_success 'recursive tagging should give advice' '
 	hint: already a tag. If you meant to tag the object that it points to, use:
 	hint: |
 	hint: 	git tag -f nested annotated-v4.0^{}
+	hint: Disable this message with "git config advice.nestedTag false"
 	EOF
 	git tag -m nested nested annotated-v4.0 2>actual &&
 	test_i18ncmp expect actual
-- 
gitgitgadget
