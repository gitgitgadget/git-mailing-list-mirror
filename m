Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8B5C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3A020774
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSTpX1mK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgF3MFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbgF3MFm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 08:05:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6044C03E979
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:41 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dg28so15902817edb.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mj5ZbJ12LR3v8Yt4MmtqwCsvAWZFVJ2iC7ETEQzbIiw=;
        b=OSTpX1mKlvOQQhSZa+PQsb8y5NpGJ3F/n7UWazS9c2HGApOdk+MMaXdQPjnZBigxxI
         0E4CpOkqe+Uk3vmv4p3xNlKjBhmTlZxBJhDmtGMTeiSOT5OgE2k8mXxvqU9YR4Aiv+EO
         ZiV7s7tT0o1J7eEZMZS0mzYRV5G0KFl5yoja7fcJoOOzNQiYQab4kqtVf8kNOK/CmeS4
         VjW+1O5wpvO9rKU8SYaDlWJNpWH7MhIOaTVN1YeN6QXMRzVSKKHkVD8QYc2H9cJMNVMl
         CkNYtQrCS4wmIOBXtl+8sUZqOAnYiz4VOAFLSiWyM3ONDdmOW9u4yYabTsBaUPhtYU5g
         Oi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mj5ZbJ12LR3v8Yt4MmtqwCsvAWZFVJ2iC7ETEQzbIiw=;
        b=COllDPT1PrM+HGOUvHKDuwaGOyfAOP5Sbrio6GpvovOoMYHVeg3m5Ycum+WqYl+tqA
         6PjS+VlzAvpXXjfEyZFPMKlMp9H4Jw++G8YUb0/DDpDJHQZa+g6I2e1nvE6DHxHMO1FF
         CwyC9MOCzv5HU1ijhJ7ok4ZD0ht3iBpnRxDlvIBMPtH+nzq5C+9X6AU8+uTL6oBmD6si
         mGWCvovwOXr6JVAkSyZCCkcPnJ8v0NaPQDVowo6+CTLVJFnabRlqxYtX8lWUReKDBEop
         Lz2WXx1FcUPiptBxQmVoWOcA30PvYimp+5KNU+eBiE8t35UUUrk3o9cQ/fItbjZPtwcv
         42pw==
X-Gm-Message-State: AOAM531DKfrHnm43iw1hATHz0Z4pnmgWyV7hvTMlP1Q/JEivAgJPnlwZ
        t+3wrZCZFviRmug+fQiMlSrQx+YxFV8=
X-Google-Smtp-Source: ABdhPJyPPCEGNPSE2jdSvz9VICVOLPXTHMER8Yj8UtqKr0rPR07xmMnz8TbC5rGD36yF+uNx3QgyNg==
X-Received: by 2002:a50:fe18:: with SMTP id f24mr22540032edt.14.1593518740320;
        Tue, 30 Jun 2020 05:05:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dt22sm2002241ejc.104.2020.06.30.05.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:05:39 -0700 (PDT)
Message-Id: <b7b2ad8e79efe534c48947da5ac83835df6fb73d.1593518738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.669.git.1593518738.gitgitgadget@gmail.com>
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Jun 2020 12:05:35 +0000
Subject: [PATCH 1/4] lib-t6000.sh: write tag using git-update-ref
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/lib-t6000.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index b0ed4767e3..fba6778ca3 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -1,7 +1,5 @@
 : included from 6002 and others
 
-mkdir -p .git/refs/tags
-
 >sed.script
 
 # Answer the sha1 has associated with the tag. The tag must exist under refs/tags
@@ -26,7 +24,8 @@ save_tag () {
 	_tag=$1
 	test -n "$_tag" || error "usage: save_tag tag commit-args ..."
 	shift 1
-	"$@" >".git/refs/tags/$_tag"
+
+	git update-ref "refs/tags/$_tag" $("$@")
 
 	echo "s/$(tag $_tag)/$_tag/g" >sed.script.tmp
 	cat sed.script >>sed.script.tmp
-- 
gitgitgadget

