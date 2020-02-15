Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B9AC76195
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E93D217F4
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0I+J2dZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBOVhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:37:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54921 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgBOVg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id g1so13509098wmh.4
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Llosp/0hmQAk5xQqrYXFRvAnt0y1QB/UdcQeu4hGGw0=;
        b=Y0I+J2dZ0Zs8G02m+YyuhXc7MpFkNwTm00r5bXH1r0efw+0L31kvJpuHd9O1DNW1nl
         uEr0kXNa1Ca8EmX8J1Dp+c4atTO6SAuySww0xkFPk6sdD83VOfm88BPFl8QGRlOVL71w
         4YaI8rzora1QslmgRaha8lAy961ntq+7F+S4zvHT7pql0m0/HrY5qKIVN92sMEgn/B25
         bboKEqAuht6EBsEcs+6W83K5HL4dL08VW990LcSyMnNrn9YykF6hUE1+m/ZnmmSbFgUj
         9FGn+C6ul5rdnLGbj2XkpKjqVBCM0Z3oVhhSSnwWrmYQ35uSZKzaUkt5dVkE3IR8Jz9S
         nFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Llosp/0hmQAk5xQqrYXFRvAnt0y1QB/UdcQeu4hGGw0=;
        b=R76znKZRSs5z+8brk+sMEEWbbcHEnh8188xhHj5mTbWSF+TlGfxRJSzMGWMGZVuut4
         mtXMfkqa2PfeKIguymwaaUjs+hFwmCW4dZsCFoDZ6b0Y7vDGkBgyafozYm5RrZ4znonh
         QfKcC64o3zxMv1EgMfDxovv69aO7QHT+dDS7bx6AKXsUVdIgaifAzDN94fS/okXCx2En
         hrSppuxRl6xkkQIudQCKiBfc8iaQLE6gnfyf0P32X1CisWcn08MpFA6HvIgN/Rx1K3nt
         SG1d4M1D1luwXoVyLFbhOE6i/Cx8Y6FyjhiWmchTJkkIuJvkMQZ0j0v+cBnuZ328k+o5
         D0HQ==
X-Gm-Message-State: APjAAAW5X6M2nEAs0/XT7Ui54BzUHeCHtuelfoSedrMsNk3k8ZIiDJqf
        VLN/X983XJjNKkZaKumXbNMcAxx1
X-Google-Smtp-Source: APXvYqyTRnnMbg3t1lqkpR3Moqa6mCjlGUlGv/etQRHAAZiFL72okpLPD1E6yy57oVCS7S3HjEAUZw==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr12934802wmb.114.1581802615930;
        Sat, 15 Feb 2020 13:36:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm12519013wrr.56.2020.02.15.13.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:55 -0800 (PST)
Message-Id: <dc12574a8b3a9bd9afd6146354ea7d4071ab855d.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:38 +0000
Subject: [PATCH v5 17/20] rebase tests: repeat some tests using the merge
 backend instead of am
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to ensure the merge/interactive backend gets similar coverage
to the am one, add some tests for cases where previously only the am
backend was tested.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5520-pull.sh                   | 17 +++++++++++++++--
 t/t6047-diff3-conflict-markers.sh | 13 +++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 602d996a33b..3fff6a06fa8 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -277,14 +277,27 @@ test_expect_success '--rebase' '
 	test_cmp expect actual
 '
 
-test_expect_success '--rebase fast forward' '
+test_expect_success '--rebase (merge) fast forward' '
 	git reset --hard before-rebase &&
 	git checkout -b ff &&
 	echo another modification >file &&
 	git commit -m third file &&
 
 	git checkout to-rebase &&
-	git pull --rebase . ff &&
+	git -c rebase.backend=merge pull --rebase . ff &&
+	test_cmp_rev HEAD ff &&
+
+	# The above only validates the result.  Did we actually bypass rebase?
+	git reflog -1 >reflog.actual &&
+	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
+'
+
+test_expect_success '--rebase (am) fast forward' '
+	git reset --hard before-rebase &&
+
+	git -c rebase.backend=am pull --rebase . ff &&
 	test_cmp_rev HEAD ff &&
 
 	# The above only validates the result.  Did we actually bypass rebase?
diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6047-diff3-conflict-markers.sh
index 860542aad00..d383ce81302 100755
--- a/t/t6047-diff3-conflict-markers.sh
+++ b/t/t6047-diff3-conflict-markers.sh
@@ -186,7 +186,7 @@ test_expect_success 'check multiple merge bases' '
 	)
 '
 
-test_expect_success 'rebase describes fake ancestor base' '
+test_expect_success 'rebase --merge describes parent of commit being picked' '
 	test_create_repo rebase &&
 	(
 		cd rebase &&
@@ -194,7 +194,16 @@ test_expect_success 'rebase describes fake ancestor base' '
 		test_commit master file &&
 		git checkout -b side HEAD^ &&
 		test_commit side file &&
-		test_must_fail git -c merge.conflictstyle=diff3 rebase master &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --merge master &&
+		grep "||||||| parent of" file
+	)
+'
+
+test_expect_success 'rebase --am describes fake ancestor base' '
+	(
+		cd rebase &&
+		git rebase --abort &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --am master &&
 		grep "||||||| constructed merge base" file
 	)
 '
-- 
gitgitgadget

