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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE321C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB8861057
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbhIGNiM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344579AbhIGNiE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:38:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35930C061796
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:36:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j17-20020a05600c1c1100b002e754875260so2251051wms.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O8TvS/RYI1/f14ABLT38ETUNLnRVHqlQFrNFSAh4SFE=;
        b=PpMJba0RrG4qbcwsgTKgAR3uquhhZGhRREoIh+sn7BAsciGsthE4ouA5LpBWBVYKpb
         1h06iaf/ch8ZSDOIxlkAJEpDLRKNR1aBgtJIOzKJXfRh0zE7UKuCPAwCTXqjOXMDf7Me
         /K3iB0ODM3PXJRdxoSZpiibRf/CNwLv0pY6Nzx4X3TERgSW0JRRlQxGGEv9U87BSaQA8
         ZAMN/FCToIqoYRgX5CkI+AwaRkib8K6HUgDTIY50SeBj23QFsR2eI6YXo7EqYEI6M5cM
         7Pr5fEwRFpsoNSXmka8YSPWwjPXZ6XkdRnGeD1qI6r1+0rleRb7aWXiwOK3/DMjcsKSy
         UReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=O8TvS/RYI1/f14ABLT38ETUNLnRVHqlQFrNFSAh4SFE=;
        b=fMRdL2VOB7kuCYNDnBh+pM9MGcOMDtVlq2tr22dfHxpYxGdVADjfdfbmpHxZTnnEk5
         qGSH+BFwBS8v8iQKCnc3o5MewYs8X2sVPwvRZmkAnwxhwbEl/lYuaMYiMYexajyHa10/
         OlaAbMJYu/edZs4QNSahfJQWLC1fzLErxR0PP3EhaRthkpC+33wv9LQSZDttpr7X4X5Z
         zGf1CU5KDSyRmwUO1h4iluBMWaAKiskZWnD/NHVDJ3K9g+4vg6CmuMMIhWRi4dNNrAWf
         jPmT8Hy5pi/PtmEpNgDe5iowxVE/z7tQY9ra6rXs3fytwMgBig7QNbFTeQhGEE2+Fskz
         jHqA==
X-Gm-Message-State: AOAM531wYZq1vCvkIYxFUeRW1Nb+guRKWTAvNEaBcqE+DgSLofn8e8S7
        ec2jVTrNFgXNswEFuAbvs69OTcgjIhA=
X-Google-Smtp-Source: ABdhPJziQO8B/a/TMsuPAKzBoMI5PC+EGrW8a82ZMYDvrU23cFtZzWdecSXcZuTplLjK1XxAjPqgbA==
X-Received: by 2002:a1c:2313:: with SMTP id j19mr3900066wmj.189.1631021813843;
        Tue, 07 Sep 2021 06:36:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm10815929wrx.30.2021.09.07.06.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:36:53 -0700 (PDT)
Message-Id: <7a030cfd3e2521f08562ff7ecc00743b786c0e32.1631021808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
        <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 13:36:47 +0000
Subject: [PATCH v3 6/7] RFC: refs: reflog entries aren't written based on
 reflog existence.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
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

With this feature, it is possible to mark only specific branches as subject to
reflog updates. When introduced, it presumably served as a cheap substitute for
introducing branch.$NAME.logRefUpdate configuration setting.

Reflogs are small and don't impact the runtime of normal operations, so this
flexibility is not very useful. Since it incurs complexity for alternate ref
backends, we remove it.

Further background to this change is in
<CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c  | 53 ++++++++++++++-----------------------------
 t/t1400-update-ref.sh |  5 ++--
 2 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 04d73b89c9c..4aa4d2bbba1 100644
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

