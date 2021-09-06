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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E4BC433FE
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C71261051
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 16:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhIFQxi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhIFQxd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 12:53:33 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91072C061757
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 09:52:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so265509wmh.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Q+Op4PTH28MvR0erQ9QO3PJo2ZFM6SERxS6JFjsgTR4=;
        b=bLpXIjwF07Oa518jEfnSuRTtq8U0L4Zmbd8Jxit38sX8T0ntvjf6OxieCj+fkfmC6W
         R2uwHQlXWyt2lXB7mV+hYBa7wMgziK1nXTaZiaAyLjLsFYWKpBlnzYXdeVWXgRuMZSNJ
         qfZtJeGYo5Y6Xvz2Hh8PMvaLNgvpPRLWU+48SIpMRUjUHOmHrfxZftSUliz5dAZCCd59
         o44d/8CfSb9ylWTo7bjEbGmoZbUiGrDIZXfqAjQ5L+0YDI+VLjQLbiBZYyZ2kZN3VEwn
         mYqpuZpQmZJ0vItAprQf1oay62tYtjFadSNXS2ZG9U0H3rGsuJmyYBj3Ew2oJMxQgv8o
         a3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Q+Op4PTH28MvR0erQ9QO3PJo2ZFM6SERxS6JFjsgTR4=;
        b=oDrkQAJBedZXyEpo3ay7K2oS2FBiGyV5hVSPhtv5i5suANpvBkAL4VYG7r0U2+TSOf
         yfnWpMhkaEdYv4ROwCEsw77xCFLVytE9dgGl5mTy1tI7bhYPppGEN0S3NpQDaxa6VhGF
         nrLFJS5KhHEDRRK6xP3sA54qXKziU28/2dS0dp6lZawPKeAF4tyeDMaR5NJn7Op9orru
         XasrT+q2eALT1dZKdzQfn8nWyMrzdw8krg3vQ9iB7cn/u8287uX/WaTLuabMVgBWM1c3
         S3u1gu5fSa1aLgfFHJw5SsgDYk3dxzMb+qlMieSoPfEkgK4APtmwOJkucpju6ONweL4B
         smNQ==
X-Gm-Message-State: AOAM531YBJXkX4OAR07phBlyWCAJONJRxj/FrMkP4dxSP/nOGmgu+mGi
        H3Aq8XGcAPoYOTbyJCO+M8mq0PrMAg0=
X-Google-Smtp-Source: ABdhPJzsvUhikDGknoYOwB4pnQuBpNFI/kEYMNgcDgajZ5eM6H7smeMUV+rEm2GLPtndrTZq3Addew==
X-Received: by 2002:a05:600c:3556:: with SMTP id i22mr69587wmq.104.1630947147247;
        Mon, 06 Sep 2021 09:52:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b4sm8282255wrp.33.2021.09.06.09.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 09:52:26 -0700 (PDT)
Message-Id: <f6a7c5ad56efceef9c11226beb854b806ef54687.1630947142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Sep 2021 16:52:22 +0000
Subject: [PATCH v2 5/5] RFC: refs: reflog entries aren't written based on
 reflog existence.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
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
 refs/files-backend.c  | 53 ++++++++++++++-----------------------------
 t/t1400-update-ref.sh |  5 ++--
 2 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b710d43be16..5ba68584aba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1551,51 +1551,32 @@ static int log_ref_setup(struct files_ref_store *refs,
 	struct strbuf logfile_sb = STRBUF_INIT;
 	char *logfile;
 
+	*logfd = -1;
+	if (!force_create && !should_autocreate_reflog(refname))
+		return 0;
+
 	files_reflog_path(refs, &logfile_sb, refname);
 	logfile = strbuf_detach(&logfile_sb, NULL);
 
-	if (force_create || should_autocreate_reflog(refname)) {
-		if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
-			if (errno == ENOENT)
-				strbuf_addf(err, "unable to create directory for '%s': "
-					    "%s", logfile, strerror(errno));
-			else if (errno == EISDIR)
-				strbuf_addf(err, "there are still logs under '%s'",
-					    logfile);
-			else
-				strbuf_addf(err, "unable to append to '%s': %s",
-					    logfile, strerror(errno));
-
-			goto error;
-		}
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
+	if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
+		if (errno == ENOENT)
+			strbuf_addf(err,
+				    "unable to create directory for '%s': "
+				    "%s",
+				    logfile, strerror(errno));
+		else if (errno == EISDIR)
+			strbuf_addf(err, "there are still logs under '%s'",
+				    logfile);
+		else
+			strbuf_addf(err, "unable to append to '%s': %s",
+				    logfile, strerror(errno));
 	}
 
 	if (*logfd >= 0)
 		adjust_shared_perm(logfile);
 
 	free(logfile);
-	return 0;
-
-error:
-	free(logfile);
-	return -1;
+	return (*logfd < 0) ? -1 : 0;
 }
 
 static int files_create_reflog(struct ref_store *ref_store, const char *refname,
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 8ced98e0fe8..446b568cef3 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -270,7 +270,7 @@ test_expect_success "(not) changed .git/$m" '
 '
 
 rm -f .git/logs/refs/heads/main
-test_expect_success "create $m (logged by touch)" '
+test_expect_success "create $m" '
 	test_config core.logAllRefUpdates false &&
 	GIT_COMMITTER_DATE="2005-05-26 23:30" \
 	git update-ref --create-reflog HEAD $A -m "Initial Creation" &&
@@ -318,9 +318,8 @@ test_expect_success 'symref empty directory removal' '
 
 cat >expect <<EOF
 $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
-$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
-$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB
 EOF
+
 test_expect_success "verifying $m's log (logged by touch)" '
 	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
 	test-tool ref-store main for-each-reflog-ent $m > actual &&
-- 
gitgitgadget
