Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D16C63697
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E6420719
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/8ovk9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgKWXUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgKWXUO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:20:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B0BC061A4D
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:20:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 1so1091965wme.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 15:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sw5FFiK/t6evnu3E904I82pkwQ3g660/lP3rLmMmBPk=;
        b=g/8ovk9T2OxIKjNCyEnzpZBSx/alCFhGa9I5Q0QqWFKGQQtYSC6iCWPe/qDsM0cBmC
         Tf0KAJG+3XhYnDY2cdDMNYa6rAsytQisGxaQy7uI5QO2XNMoLPMlvJBEkm1UG66pLPRd
         CF3UZOkjSOAC9w/Dap/BMpT0dgCf3oMn9G0xj6YsUSjc67wMBU0BHeigOY1+w3Iap0Gu
         A/z34AUMfvHZ7R80ZBPXJfOq7EbH/eA6ABNJ+PRl+vQQcdeSXjws+CAg9RIeQSCdofuJ
         37txxlO+GY/bZqjp7gn6Q9BWE1T7/9tTDE7nUUbd1mhAhSB+QVhPzjwosSkZsqyu94jL
         S/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sw5FFiK/t6evnu3E904I82pkwQ3g660/lP3rLmMmBPk=;
        b=jS6OuNhfqz77iQYlcDNe3jLk6hJFFhQ2eeX1A99w4QXRKdlZAYKpDPV9V5HxgRQa59
         ZGvjEecWHGcTC8xgIsJ2J/hOriW2lTn9LdZ4yBA7WfvjfBz9g4SNK8Few1M+aIT5eIu6
         XQzL3IqLfeU9xRQ2pEhjUshJSYxQXo/k+7OiYRqJ/9Fu6+3o7UpDdDnkTWqfKRVbVxh3
         ZqUxLOPx7hj2aUfkubCMchj0+DVLt50Kz2rIdWIOIvC/d1CraC+PiC0l5AWEQaOQrC0V
         1+6rneP/uI1QLkIx7l4SrGKBaJvqkPBOV6MJzfIQyuU2MzvmXiIrDXzZihF35fZYTSCR
         RZ8A==
X-Gm-Message-State: AOAM531ny31D7uH3QyWIEeCJ1TazPxmwnuixylNHNkF1+416KOsxtg5u
        jlbo6OYIJhCtwga+Hg/uEiDtvWtTdvM=
X-Google-Smtp-Source: ABdhPJzto4FToq+oIPwCE/ifvyBWNT6dQaPGTN0a3p2HZwmONolWrp58FlKDn5m+mNlkDldfYZtkrg==
X-Received: by 2002:a1c:df8a:: with SMTP id w132mr1213028wmg.90.1606173611090;
        Mon, 23 Nov 2020 15:20:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm1500797wmh.7.2020.11.23.15.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 15:20:10 -0800 (PST)
Message-Id: <8de0c0eb228c8d9608d3a78c992cbd6829cb9329.1606173607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>
        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 23:20:05 +0000
Subject: [PATCH v2 2/4] branch -m: allow renaming a yet-unborn branch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In one of the next commits, we would like to give users some advice
regarding the initial branch name, and how to modify it.

To that end, it would be good if `git branch -m <name>` worked in a
freshly initialized repository without any commits. Let's make it so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch.c | 3 ++-
 t/t0001-init.sh  | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index efb30b8820..10609981e6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -538,7 +538,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
 
-	if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
+	if (!copy && (oldname != head || !is_null_oid(&head_oid)) &&
+	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch copy failed"));
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 69a320489f..69c5ad179c 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -571,4 +571,10 @@ test_expect_success 'invalid default branch name' '
 	test_i18ngrep "invalid branch name" err
 '
 
+test_expect_success 'branch -m with the initial branch' '
+	git init rename-initial-branch &&
+	git -C rename-initial-branch branch -m renamed &&
+	test renamed = $(git -C rename-initial-branch symbolic-ref --short HEAD)
+'
+
 test_done
-- 
gitgitgadget

