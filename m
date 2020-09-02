Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB5C43461
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 14:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E303320773
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 14:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKVS4qcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgIBO1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBOYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 10:24:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC09C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 07:23:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g4so4964409wrs.5
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 07:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=H5iV20sgGQDP1iecEwwbkQSOLGU2DDFt3CObRLvDYso=;
        b=KKVS4qcp9PUgJ4sfD3alzTz8BUYH9xqWN6D4u7JsRk79MnrYCfj0QsxxPLaEXiolnC
         UHhRIJBvbiKdYDtUhevF7EmKjFQT3YQ6FsfcqzbxPx7wjBA1sKCfiz6SZAQankNRzdsn
         uO/FLbjSwW5Tkaijv1Pc6VTD+0Vcw2CgGstEb2TQRxUEdEP3k3rzpl7Q9hWIKMZ6Ixzm
         4CSE/HqGEWMB8MeJUHRh1U0hj5mfYxhR/rA8+Stnz7OsIKXBmUTGuwrFNXlOpZRxaSEi
         uVBuYMITaCulSDAGfwZA+SHr4X6CPrc63iVdK4lBzcpdrbsFmeANuVINSe9GzdMHaQFI
         vIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H5iV20sgGQDP1iecEwwbkQSOLGU2DDFt3CObRLvDYso=;
        b=HQMafYWMvJBpeCgjc9zWHCOVKzU5MVEdh7ksISiScT5ysTSLps8MKYCU2G5pXc/qfT
         weYl3r2RQ0rTd2jNzYutEpnggQcoPEnIcsByO2jgPEiJDb18of5hnGj+GuK0KED88Je/
         AvslJhqjw56r7xt/Fdeb+OxRNBxGAUxmBDNcPA50VjIDiMNkfSbVk+PcIYqFri/2Mm9Y
         e+2+cqIFgiMRbtO6xyXuYPQerobbLBtSXehC/hD5l23AEqVstLYh7nr13r50WltzV1do
         LoPLh/aV+4KnIx1UbeTQaxl3xuGmx+Fjhw9xCpos6fdcoS9iN3JwADDMfgkLkZPFwW2U
         3Dqg==
X-Gm-Message-State: AOAM530cifZ0NaujtTlNNe5iZFr4MrkWfnXvssTtAEpaMCk93yaTlPk3
        kfD98Q3NnfEDZOtGsYaGIjl8K7Jyo8A=
X-Google-Smtp-Source: ABdhPJyFhN4dkY6TFXhzgjXWCxv3fOscLeDLPY+8SrXdphrb6rtmrVf+XcEEzvBpGCEA0aaZaqG8ig==
X-Received: by 2002:adf:90d1:: with SMTP id i75mr7112805wri.278.1599056636656;
        Wed, 02 Sep 2020 07:23:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d18sm7134208wrm.10.2020.09.02.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 07:23:56 -0700 (PDT)
Message-Id: <pull.720.git.1599056635276.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 02 Sep 2020 14:23:55 +0000
Subject: [PATCH] fetch: do not look for submodule changes in unchanged refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

This operation is very expensive, as it scans all the refs using
setup_revisions, which resolves each ref, including checking if it
is ambiguous, or if it is a file name etc.

There is no reason to do all that for refs that haven't changed in this
fetch.

Reported here:
https://public-inbox.org/git/CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-iAjxRCpqNK5bnhRg@mail.gmail.com/

Amends commit be76c2128234d94b47f7087152ee55d08bb65d88.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    fetch: do not look for submodule changes in unchanged refs
    
    This operation is very expensive, as it scans all the refs using
    setup_revisions, which resolves each ref, including checking if it is
    ambiguous, or if it is a file name etc.
    
    There is no reason to do all that for refs that hasn't changed in this
    fetch.
    
    Reported here:
    https://public-inbox.org/git/CAGHpTBKSUJzFSWc=uznSu2zB33qCSmKXM-iAjxRCpqNK5bnhRg@mail.gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-720%2Forgads%2Ffetch-less-submodules-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-720/orgads/fetch-less-submodules-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/720

 builtin/fetch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0f23dd4b8c..d3f922fc89 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -958,8 +958,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				ref->force = rm->peer_ref->force;
 			}
 
-			if (recurse_submodules != RECURSE_SUBMODULES_OFF)
+			if (recurse_submodules != RECURSE_SUBMODULES_OFF &&
+			    (!rm->peer_ref || !oideq(&ref->old_oid, &ref->new_oid))) {
 				check_for_new_submodule_commits(&rm->old_oid);
+			}
 
 			if (!strcmp(rm->name, "HEAD")) {
 				kind = "";

base-commit: e19713638985533ce461db072b49112da5bd2042
-- 
gitgitgadget
