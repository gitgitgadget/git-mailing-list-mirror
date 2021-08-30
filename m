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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7260C4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BEE6056B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbhH3Otz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhH3Otr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:49:47 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CB4C061760
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so14934093wme.1
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+kVMIGVVL9A+G/X97fSQ4jCQx6S3jsBdFy3QXy/th8U=;
        b=l7tscKQOANWCT79xLZiqFD5gnzJD+84bdEKT1PaDAs7+jQZqlPC5MD4iWxHj5ZDwPU
         nvdb5tMBnQRhzE887yyd7uynYgnPSqnKyPxjmfQref2dQJnsEWci5MdMOjkbFa9WZUEN
         ugD6tyKd0mU0R/f6KsUOiTFVVB69LSOlgtBMx+uMWAfabKwOnNs0psULxyfVFjWWqsbC
         BybKld7DvhUDewAFhc2FKG0Hyouc/lspGJxiJHA4wf6iSP/VqdmOg9VZlLVfFnFBlGSg
         uVoWXFYiySH7dvuI+xH9unTjmHXOjH42Uq5/kaFuP5a3I0/uLHR7LPw5I1K4XqNrGAtE
         CWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+kVMIGVVL9A+G/X97fSQ4jCQx6S3jsBdFy3QXy/th8U=;
        b=h9ABXdVE/A1uFBD52R4psZ0rEhWsr/QkPfh7Xkt/hymM5vFcYdR32Ky7n1WDYjbBrW
         lIG501B8sRi7neNRhqZUd5HsntCyjI5tlpq0MrG2ShtMhOFbC3ShhUQgpbpp1qhwX1kZ
         EKIjv6LyvhVUhITmFRicOkaOQs/cLiEDGIacs4LGCzpUMPpCDrQYhbBHZafnc6U2otW3
         /MOcnQjxuMZ6wMdxyVHHfvNYMcnwZOVNDVEshJqCdQsHFPN2wiZ01TQGw/iuQmpqf63H
         RyT9QP1x+065bu3klWDg4smpXLhxQWarg4a0YzCk6hVwsLLEp4p0UBzkJ/v/CJrlq2D2
         mBAw==
X-Gm-Message-State: AOAM532WjHFHP02McbayF1aPgksYBtmPrTWSdna6iutwH5AUhl0G+b78
        s8EhF3RJCVFzmpSWvVTip5lvzaFPO0g=
X-Google-Smtp-Source: ABdhPJzi8vdqEPufndPMyf8DBMvvxuCtVWg9Wgj/A3IthuWdj4XXCGZo8e7aPJtlT6q+CkdSC1Ojxw==
X-Received: by 2002:a05:600c:4f03:: with SMTP id l3mr34337532wmq.0.1630334932316;
        Mon, 30 Aug 2021 07:48:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm15632833wrv.84.2021.08.30.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:48:52 -0700 (PDT)
Message-Id: <2f11fd7718005d1e94b3139f086134896da202f1.1630334929.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:48:48 +0000
Subject: [PATCH 4/4] RFC: refs: reflog entries aren't written based on reflog
 existence.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Before, if we aren't supposed to update reflogs (eg.
core.logallrefupdates=NONE), we would still write reflog entries if the
reflog file (.git/logs/REFNAME) existed.

The reftable storage backend cannot distinguish between a non-existing
reflog, and an empty one. Therefore it cannot mimick this functionality.

In CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com,
we came to the conclusion that this feature is probably a remnant from
the time that reflogs weren't enabled by default, and it does not need
to be kept.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c  | 20 +-------------------
 t/t1400-update-ref.sh |  7 +++----
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e05ada9286d..25f5a4ce777 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1551,6 +1551,7 @@ static int log_ref_setup(struct files_ref_store *refs,
 	struct strbuf logfile_sb = STRBUF_INIT;
 	char *logfile;
 
+	*logfd = -1;
 	files_reflog_path(refs, &logfile_sb, refname);
 	logfile = strbuf_detach(&logfile_sb, NULL);
 
@@ -1565,26 +1566,8 @@ static int log_ref_setup(struct files_ref_store *refs,
 			else
 				strbuf_addf(err, "unable to append to '%s': %s",
 					    logfile, strerror(errno));
-
 			goto error;
 		}
-	} else {
-		*logfd = open(logfile, O_APPEND | O_WRONLY, 0666);
-		if (*logfd < 0) {
-			if (errno == ENOENT || errno == EISDIR) {
-				/*
-				 * The logfile doesn't already exist,
-				 * but that is not an error; it only
-				 * means that we won't write log
-				 * entries to it.
-				 */
-				;
-			} else {
-				strbuf_addf(err, "unable to append to '%s': %s",
-					    logfile, strerror(errno));
-				goto error;
-			}
-		}
 	}
 
 	if (*logfd >= 0)
@@ -1592,7 +1575,6 @@ static int log_ref_setup(struct files_ref_store *refs,
 
 	free(logfile);
 	return 0;
-
 error:
 	free(logfile);
 	return -1;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index de0cf678f8e..52433f6d0d2 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -269,7 +269,7 @@ test_expect_success "(not) changed .git/$m" '
 '
 
 rm -f .git/logs/refs/heads/main
-test_expect_success "create $m (logged by touch)" '
+test_expect_success "create $m" '
 	test_config core.logAllRefUpdates false &&
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
 	git update-ref --create-reflog HEAD $A -m "Initial Creation" &&
@@ -315,12 +315,10 @@ test_expect_success 'symref empty directory removal' '
 	test_path_is_file .git/logs/HEAD
 '
 
-TAB='	'
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
-$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
-$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB
 EOF
+
 test_expect_success "verifying $m's log (logged by touch)" '
 	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
 	test-tool ref-store main for-each-reflog-ent $m > actual &&
@@ -346,6 +344,7 @@ test_expect_success "set $m (logged by config)" '
 	test $A = $(git show-ref -s --verify $m)
 '
 
+TAB='	'
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
-- 
gitgitgadget
