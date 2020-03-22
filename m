Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21587C4332E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A8F20754
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9nt6RG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgCVA4T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:19 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51000 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgCVA4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:19 -0400
Received: by mail-pj1-f67.google.com with SMTP id v13so4317747pjb.0
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IB755LcfuSoIWiwR1OhUu7cTx+eFXhivtO80o0JADj0=;
        b=i9nt6RG7ZutfDAbgR6SklMEKDSrBAzB5ipju6p/iO3KAHaSPlG6xDsA7vWYQSx617m
         Mug0wGbehTD1pudSL/jAB+heeZPYUyqdj1u9SQsnQ3gpjjR/hn2wMpV0YaQR727zV2QF
         X29IgvPRSBkiNQWpVhWu0kTh4Z1FYdT7qxAfQjpxV/pwmDL9PF3Aka3vs7ICc3NaI0G/
         uhqZsBrOeUWrSL0ik5GUBeau28jEIimR6xZA05AU6rD7uR5RZQ6iES+hvf5bvTktqtV/
         ly9dijYNT6GaxISj10DoLkr3ufXsOlDn/wKCabb+XIg/53/lVHT10FzqBvSHyVgockPQ
         f6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IB755LcfuSoIWiwR1OhUu7cTx+eFXhivtO80o0JADj0=;
        b=KBIanaYnU7k0p3lH9huKlxld2pmwJNNLL9wvU2ZUc2oKwcu/sOGKApFZjAjLFmkYiQ
         ywX8madS9jN176SnwOaE44tRL+FXPw67Q1fucE93h0mVZiDdSvYys91A+vCeVG5NLhH4
         ymfDwWk4erjGU3oI7ymoGTg4xTqUlhdaNi2koWUmNhGLekCQiNXgxXse2V9AaGFbUXRP
         kvWEcX+mVjI6JVNz4+JKOpodEAtq2vSM+lIOVcgOlLMj0KEv7XrKHsoaWyXus2Ow+Zy+
         xmerpXnLnpVNaR19wFRAPnvVJ+f+ZpDK4QOZwWvOTjKpvfw5kl47+twcx9rkH436uYtR
         uXRA==
X-Gm-Message-State: ANhLgQ19bt5LWAUN9WZ4uQA0t3eRiAMpNEG3QTmVRzsvFSaCzk/z4HHm
        v/+CbCD/T/xsY+n1sX9toBwaPRDo
X-Google-Smtp-Source: ADFU+vu+CYCUU2iXFr1ZPS6FPJrzdS3tIkyMmUIZI/e4X7kDEPToZ5sQzW+OB1ITWjh1xHvAVsRM2Q==
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr17504307pje.90.1584838576334;
        Sat, 21 Mar 2020 17:56:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:15 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 6/8] t7063: drop non-POSIX argument "-ls" from find(1)
Date:   Sun, 22 Mar 2020 07:55:20 +0700
Message-Id: <59e3f73784b2a3bd9ccec87412e6178411c3708e.1584838148.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838148.git.congdanhqx@gmail.com>
References: <cover.1584838148.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit 6b7728db81, (t7063: work around FreeBSD's lazy mtime
update feature, 2016-08-03), we started to use ls as a trick to update
directory's mtime.

However, `-ls` flag isn't required by POSIX's find(1), and
busybox(1) doesn't implement it.

From the original conversation, it seems like find(1) with "-type d"
could trigger enough "lstat(2)" to ask FreeBSD update mtime.

Use only filter "-type d" for now.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t7063-status-untracked-cache.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 190ae149cf..6791c6b95a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -18,7 +18,7 @@ GIT_FORCE_UNTRACKED_CACHE=true
 export GIT_FORCE_UNTRACKED_CACHE
 
 sync_mtime () {
-	find . -type d -ls >/dev/null
+	find . -type d >/dev/null
 }
 
 avoid_racy() {
-- 
2.26.0.rc2.310.g2932bb562d

