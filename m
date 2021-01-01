Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FDBC433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05AD221EC
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbhAACgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbhAACgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:36:13 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA4C06179E
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y23so8379088wmi.1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L/WVsRYrspMW4RmRifIMouf1b8GyIYjbnvZIWb8/lPo=;
        b=ugWDDGAn6vkhORea0Inc5egp5ocmWoGDEKnUm4NSyy7t//NSPMt1fHIOkV2BMJAoqH
         7gouky3hBes78wGl0wQtj9ohSJoikwOG+InlV6Qy8xlcdaiF31BnbvEzYNEp7wIA2L95
         M5lqylC9Wya8txiLlf3O0RKgkavDmDTFyjc9HVbMYFZiA37dKQg+hXyYkXDQEkt0zU5v
         X/oUo8iP5WCfPIEupcsJ6I+4QhFtNCv+4kY3hsEu3bynGOWnDE0gMju1Hu7kcWccvCRf
         I0Vcgf6+ZJ9Ui4+58gXuJFhvxcWD3JfoZ5yjRZuCVbVwcdpKuN7jtl1zb48YqVkkZfFz
         bmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L/WVsRYrspMW4RmRifIMouf1b8GyIYjbnvZIWb8/lPo=;
        b=SoP565o1z6+v9GaD5C91DIUaQIMGqqerBJDrmIi3GOVxDsis+lGB+9iJhSUoutz0Sx
         +cKkiLLtvQ/XXOxl3q28mrZ75icnfQzAgQ2tLEIS6J06VT7ZcREvR/jHG/RLcifwzoMi
         t9ydy0kzc87z7jQ+1dDW7njqeKlpbh1Jdf3OPRPOdaaxxzI/0DfVMHJjlU1Cf4wA4myN
         Gwh/PWlmy/fb/qhg2cHdhyCVM6dXDfpBPsoWxl0WLNUCVk5PV+0vUqTMhpULiDyi+jnn
         Ukzlpd4xbVOeg6wzTeAamhgiwl2v1UQw1hjf974TUzxhEQVU3DmBMwL8sW6JSbar/+j5
         wahg==
X-Gm-Message-State: AOAM532TTa9wT66RZVCplAGOd5gJiJhwGsNflOWNjz7ujbzCZrTSkCTl
        OonY+x/5ZPZvK4LS5HbFYQiwCzlkIdo=
X-Google-Smtp-Source: ABdhPJygLsaBvVLkdpXWBnPxCkbtF9vDkdjIl7ySvahOYH2o9uAW2jPHL9LIPW5dL/WstpnPhQkIog==
X-Received: by 2002:a1c:67c5:: with SMTP id b188mr14066691wmc.147.1609468496406;
        Thu, 31 Dec 2020 18:34:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm73543173wrp.56.2020.12.31.18.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:34:55 -0800 (PST)
Message-Id: <b0bfada5d8151429513821b4bd692ba28b3f9689.1609468488.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
        <pull.815.v2.git.1609468488.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Jan 2021 02:34:46 +0000
Subject: [PATCH v2 08/10] merge-ort: implement format_commit()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This implementation is based on a mixture of print_commit() and
output_commit_title() from merge-recursive.c so that it can be used to
take over both functions.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 2dfab1858fc..bf704bcd34d 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -328,7 +328,19 @@ static void format_commit(struct strbuf *sb,
 			  int indent,
 			  struct commit *commit)
 {
-	die("Not yet implemented.");
+	struct merge_remote_desc *desc;
+	struct pretty_print_context ctx = {0};
+	ctx.abbrev = DEFAULT_ABBREV;
+
+	strbuf_addchars(sb, ' ', indent);
+	desc = merge_remote_util(commit);
+	if (desc) {
+		strbuf_addf(sb, "virtual %s\n", desc->name);
+		return;
+	}
+
+	format_commit_message(commit, "%h %s", sb, &ctx);
+	strbuf_addch(sb, '\n');
 }
 
 __attribute__((format (printf, 4, 5)))
-- 
gitgitgadget

