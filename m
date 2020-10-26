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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17244C5DF9D
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96F320872
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+aSjZtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793178AbgJZTc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:32:59 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:52700 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793157AbgJZTc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:32:58 -0400
Received: by mail-wm1-f44.google.com with SMTP id c194so12832911wme.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/aWn/mLews+3vRoUVYodxrwzfdXHwlQxxixYUwKS1M0=;
        b=k+aSjZtOQEoGSj40YzXoZwNwQH10JLyWCtMXAA6mNKwct8I+N2BeJ493yHEtIdegJ0
         mhBgGQLbX+YusGLyBs/rIbht6Udo1ArW/aljEZHyTcn3udnsUZH5KvaKprhl1EDzG4aS
         CV9petF16ttG23TGpIiJG0slHE6ORMmmqmcpDXrnHeEkt9VudKtpEbu1l+XanLWTkVqZ
         TmzebIlxBW3fUFsXZATus0wBtDPCcig3DUOzY5uWWMYRSICVuCbE9hIllhXmjTY43a82
         EuSvAPcpCBXkStTvf6CG7RxMn73qsiLondZMWP2T3v8hL78fLlf5M6FSoCfgkdGENYIA
         e8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/aWn/mLews+3vRoUVYodxrwzfdXHwlQxxixYUwKS1M0=;
        b=AAXqXwgbTu79Z0PbsoDlvU4icrWMJkAMxkN47vJKjtkJRAUrjx88FJqEWrl3aXZh+B
         2E9BIdWAk7i6YX25dh3RgqJZJskA6sxYQQU1lTXStvmur3wf8KtYaet48YWqgSVFpbaI
         lku2Q5YE4D3KjDJWeaRzF9neeICO4hMdOK3CejC29DoCMUYnZFXZfkqGmZGgQuadOjWM
         har4qDWgJrSHfjIiMlXGXNilL6i65aVrfCtoJUA8FoEEs2bXcDmShJ69KYv/0CfnqK8B
         0D/FqxXPVwolPsZJGjAV+HDCdlMdFQa9gvAJ4wvLNg7h5DCwz/F47uF0iUnzL0F+JtI1
         37zg==
X-Gm-Message-State: AOAM5317ZDVRXyXC6P2nruwDyqFl2qdE1jXeTSrQQGpB6x2eIBDqehlC
        DxeUAtZJI923plMn9z6a0o9MYMTTR74=
X-Google-Smtp-Source: ABdhPJx37IXVHEZK/x5FVY/uIGloPQYV0/eZAHJUBi39Vmee1KtYD+lp+iIc+hegxwjiGDPgQ/WNeA==
X-Received: by 2002:a1c:5f42:: with SMTP id t63mr17274262wmb.19.1603740776356;
        Mon, 26 Oct 2020 12:32:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm8794225wmb.20.2020.10.26.12.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:32:55 -0700 (PDT)
Message-Id: <34d11447b46b06ae5f4fa8700885bcc8b70a3a43.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:45 +0000
Subject: [PATCH 02/10] t/perf/fsmonitor: move watchman setup to
 one-time-repo-setup
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

It is only required to be set up once. This prepares for
testing multiple hooks in one invocation.

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 23755012df..4030f569cf 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -94,7 +94,13 @@ test_expect_success "one time repo setup" '
 	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
 	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
 	git add 1_file 10_files 100_files 1000_files 10000_files &&
-	git commit -m "Add files"
+	git commit -m "Add files" &&
+
+	# If Watchman exists, watch the work tree and attempt a query.
+	if test_have_prereq WATCHMAN; then
+		watchman watch "$GIT_WORK_TREE" &&
+		watchman watch-list | grep -q -F "$GIT_WORK_TREE"
+	fi
 '
 
 test_expect_success "setup for fsmonitor" '
@@ -105,17 +111,13 @@ test_expect_success "setup for fsmonitor" '
 	else
 		#
 		# Choose integration script based on existence of Watchman.
-		# If Watchman exists, watch the work tree and attempt a query.
-		# If everything succeeds, use Watchman integration script,
-		# else fall back to an empty integration script.
+		# Fall back to an empty integration script.
 		#
 		mkdir .git/hooks &&
 		if test_have_prereq WATCHMAN
 		then
 			INTEGRATION_SCRIPT=".git/hooks/fsmonitor-watchman" &&
-			cp "$TEST_DIRECTORY/../templates/hooks--fsmonitor-watchman.sample" "$INTEGRATION_SCRIPT" &&
-			watchman watch "$GIT_WORK_TREE" &&
-			watchman watch-list | grep -q -F "$GIT_WORK_TREE"
+			cp "$TEST_DIRECTORY/../templates/hooks--fsmonitor-watchman.sample" "$INTEGRATION_SCRIPT"
 		else
 			INTEGRATION_SCRIPT=".git/hooks/fsmonitor-empty" &&
 			write_script "$INTEGRATION_SCRIPT"<<-\EOF
-- 
gitgitgadget

