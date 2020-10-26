Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A492C2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE4A21D7B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Y7zxDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793339AbgJZTeB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:34:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37608 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793149AbgJZTc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:32:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so14074714wre.4
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=baYrUf0z9Aoj8NYpTrRWQMTgfWzZ+3JSg+DTT0+CWsw=;
        b=J3Y7zxDYPi3ySE9z/y6yIfE4sjeuJZHCNaRVbQRNE2oy9U222q981gg3JjDB7m5c4p
         3W+oYqdLVRS9gZjJvz7KDJry2+aSW9qpxWk7LD0/Legh0qY0a+r2EPVKIJdH7c09Ropw
         1WCLfmQUzfKA0N2cWyO+qzGQ1I1TFZNqDR3hnXTE/k/pjFdrVyHAuvlwNpwZHMcF+oyn
         pMvtO0+VocWwoVY+Erx2QKnSzqvNv9MdrkzN7s4xMFo6cx4Qfg5NxSZ3UtdcRYKVH9Ph
         MPE15c5ngCAKndVFptBUUH0CI39vzRJChkZN/5BvDM8SdbgP7EA3UNAM3hy1/ssrX/sp
         DFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=baYrUf0z9Aoj8NYpTrRWQMTgfWzZ+3JSg+DTT0+CWsw=;
        b=oFU0/Ha5egXGeAIpmciTUnV7HwDMGruTBUS8Ckp/T+RRyv2rDxnmQsDZzWRkDb535Y
         yF57K0J1yv8MzjGfCXnaxQL3rTfufdUkVAwNC682YzZMgUP4P0FaTbctXE9BS7XxBDDY
         kcnCdevRS1XoXRn6skTTZZiwfaxyYh35Bm52b1AqBJXA1jlsHOo9ws0QBA72lVzZKVUT
         q/O+FMlJ70pv3H+mgtTy/gV1jQIuNTTxj7SQJlC656u0Bt6K9CzFTxQslK6eCHnEXDI0
         nZfktAQ7N+cG8V5C8vQyHRDSrX5EJD+28eD3cw53pKKeICoW/eqcZzOGKSk2wc55W/Hj
         xc4Q==
X-Gm-Message-State: AOAM533hAeJrnOb7EaYw45d7Er897kD2Z1WrSfDnbhoQy04iMiGaCBK+
        OnLcnjbulJ/GEoUiJy7nFULHDAcYxKQ=
X-Google-Smtp-Source: ABdhPJymBSHKpfZvA4sRjmsIJnCSeyTyleQ39N6JTG7eKzBNouLP2F/OEgH5tMwX0fTrGCAspbQFdQ==
X-Received: by 2002:adf:e8cf:: with SMTP id k15mr19483645wrn.262.1603740775593;
        Mon, 26 Oct 2020 12:32:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g8sm25718550wma.36.2020.10.26.12.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:32:55 -0700 (PDT)
Message-Id: <a9d989e07428149a5fbc51aa2f5193cff0f1a31f.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:44 +0000
Subject: [PATCH 01/10] t/perf/fsmonitor: separate one time repo initialization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

In preparation for testing multiple fsmonitor hooks

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index fb20fe0937..23755012df 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -68,7 +68,7 @@ then
 	fi
 fi
 
-test_expect_success "setup for fsmonitor" '
+test_expect_success "one time repo setup" '
 	# set untrackedCache depending on the environment
 	if test -n "$GIT_PERF_7519_UNTRACKED_CACHE"
 	then
@@ -88,6 +88,16 @@ test_expect_success "setup for fsmonitor" '
 		git config core.splitIndex "$GIT_PERF_7519_SPLIT_INDEX"
 	fi &&
 
+	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
+	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
+	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
+	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
+	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
+	git add 1_file 10_files 100_files 1000_files 10000_files &&
+	git commit -m "Add files"
+'
+
+test_expect_success "setup for fsmonitor" '
 	# set INTEGRATION_SCRIPT depending on the environment
 	if test -n "$GIT_PERF_7519_FSMONITOR"
 	then
@@ -115,13 +125,6 @@ test_expect_success "setup for fsmonitor" '
 
 	git config core.fsmonitor "$INTEGRATION_SCRIPT" &&
 	git update-index --fsmonitor &&
-	mkdir 1_file 10_files 100_files 1000_files 10000_files &&
-	for i in $(test_seq 1 10); do touch 10_files/$i; done &&
-	for i in $(test_seq 1 100); do touch 100_files/$i; done &&
-	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
-	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
-	git add 1_file 10_files 100_files 1000_files 10000_files &&
-	git commit -m "Add files" &&
 	git status  # Warm caches
 '
 
-- 
gitgitgadget

