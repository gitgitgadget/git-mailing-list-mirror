Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F973C433FE
	for <git@archiver.kernel.org>; Mon, 16 May 2022 20:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiEPU3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 16:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347638AbiEPU1y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 16:27:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6595819020
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t6so21974978wra.4
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IA0kKKKs58LIhalOyAIitJlhv4C2akwYJCreZK372cs=;
        b=PsWcx4bTdpEGftHbQ1Oin9aOBwzLrraQQYDDeUlgQRm8fOe6aUh1DNa+EXhZTtusn1
         tqCNtl0LYt2cAEG2ybbY73vJKmy1V8Ot7CA/3mM+jJRoky60sYKOufnCUhNn446qnnlv
         YPXnxBg/nk70V6iwHFBSWkyGDbPbEQbhgwUrRxiFbIeEEXcBcJ6Zp+Ninun+yMewJr5E
         mZXMSrjSd/hr8XwoHSK0Ff95lWKtzlnOfyOJ7BkeluQay+MkvfbgSSTZJWckBgXsAZiR
         YcfDKFDZ1kEJL/11eUVoDfcN+C9g8eXuwoyT4CL2fe3dokF3OfM0c7hVbZ5pcn3SMP4N
         pKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=IA0kKKKs58LIhalOyAIitJlhv4C2akwYJCreZK372cs=;
        b=toXIxInVjVgMUgWV2/7NqWg2e+2QDkLrRxKJ2ADksuAHnatGpHZDhpcCtuLsekxuUs
         baK9/O2vjVMQ61qyolU/k3GyUt3FkOsg+0DSMV5Vjq/LPrNkXKhs1pCn72yCLhkayg/1
         sEHm0n4/CG7zdNbFopnsczs4/TjYewCBJd1XWwq6zlCSGQRAZirLlMAtBPyiOFBvBwsJ
         5nQF9TZHGOxOflynsIF+eHZ8tZpC8eFDsMI9wMcrSE6J1UvnCMyfYJeumIOwGQun88tv
         2iSfLiBam4UeZbKAsHbKB7tsmawY/Hjf6Alk0fneqkiV6P17/l6LCQBHrNi/1m0IQB4e
         Uflw==
X-Gm-Message-State: AOAM533YGOjobdMe/IKN2/YT33Jkvn28uOH2ovebZTslkTcfwh5g/qHD
        Y1R2gRTcECkN6ets4uos5ZbnUYHeeyw=
X-Google-Smtp-Source: ABdhPJzz76MXt7AsUhzTAAhnQ+Znv9TVE/mhO7yX3/le03v/8zRUN/LDU1/UtPDEASHKrOhbA/btrw==
X-Received: by 2002:a5d:4529:0:b0:20d:1108:8d76 with SMTP id j9-20020a5d4529000000b0020d11088d76mr2596723wra.60.1652731876636;
        Mon, 16 May 2022 13:11:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c500600b00395b809dfd3sm224250wmr.12.2022.05.16.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 13:11:16 -0700 (PDT)
Message-Id: <d73b578e990c37781ea50e13d00f5385400e81ad.1652731865.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
References: <pull.1233.git.1652731865.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 20:11:04 +0000
Subject: [PATCH 7/8] remote: allow relative_url() to return an absolute url
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, albertqcui@gmail.com, robbat2@gentoo.org,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When the 'url' parameter was absolute, the previous implementation would
concatenate 'remote_url' with 'url'. Instead, we want to return 'url' in
this case.

The documentation now discusses what happens when supplying two
absolute URLs.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 remote.c | 12 ++++++++++--
 remote.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 87656138645..7576f673fcd 100644
--- a/remote.c
+++ b/remote.c
@@ -2761,10 +2761,18 @@ char *relative_url(const char *remote_url, const char *url,
 	int is_relative = 0;
 	int colonsep = 0;
 	char *out;
-	char *remoteurl = xstrdup(remote_url);
+	char *remoteurl;
 	struct strbuf sb = STRBUF_INIT;
-	size_t len = strlen(remoteurl);
+	size_t len;
+
+	if (!url_is_local_not_ssh(url) || is_absolute_path(url))
+		return xstrdup(url);
+
+	len = strlen(remote_url);
+	if (!len)
+		BUG("invalid empty remote_url");
 
+	remoteurl = xstrdup(remote_url);
 	if (is_dir_sep(remoteurl[len-1]))
 		remoteurl[len-1] = '\0';
 
diff --git a/remote.h b/remote.h
index f18fd27e530..dd4402436f1 100644
--- a/remote.h
+++ b/remote.h
@@ -434,6 +434,7 @@ void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
  * http://a.com/b  ../../../c       http:/c          error out
  * http://a.com/b  ../../../../c    http:c           error out
  * http://a.com/b  ../../../../../c    .:c           error out
+ * http://a.com/b  http://d.org/e   http://d.org/e   as is
  * NEEDSWORK: Given how chop_last_dir() works, this function is broken
  * when a local part has a colon in its path component, too.
  */
-- 
gitgitgadget

