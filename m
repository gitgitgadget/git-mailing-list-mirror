Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E69C3F2D7
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2264820842
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfKSNtUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbgCCRId (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:08:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43389 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730598AbgCCRIc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 12:08:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id h9so4364344wrr.10
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 09:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3F1WhblCaq76I2GSsXi8kabBVtKiHkbEh1N2QDAk5Q4=;
        b=NfKSNtUqEyuIBs+srZqyqDhY9n40QulfKIerCuWOkfi6Ut1dILmj7zTOLxfQYMdFYM
         zskPkwsLsJOHEVV3TUkmz4xf2O+tHglfU0JNz0n/f4BFOO0YnXd1Vy9bv1nWXr+vTRQs
         /U8DiFOSUixOjl+QnKciqpsjkLU1DBoT6yPUkTAsuSBPf++3DqYt7W5oeG4SqlW6zvY+
         EVAusRMi8Q5/rj8GgO7ynX8/bh612/pD+JN/9Kd7Vx4e9yaNuQ0yFprbNHELtMz8Li3Y
         t7inoy5WfbYJP1UypTw0quzXH1I0vtEmBdECJuFLgw0iFTJjpLA3cuLT6D5rETflEwXE
         vvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3F1WhblCaq76I2GSsXi8kabBVtKiHkbEh1N2QDAk5Q4=;
        b=UqL5UXhbSMbsp+IcDYMmF7EfGsOym+6R9hAJ9VXV0nzABTLuS13iS29gb5zT0xlOYV
         yTTmTJiO+Eg3Fw6Fsy9PsDgkyhmqjGkhdWP//HzK8PkA0YI07Ve/q2F8pKpidD2OQxmQ
         XP7iPJMeRuS+p4SQNnG9qAgzBkGb71acMz8QNH5r/rRDINwuZbuOYP4xYMMy/dSpAKb0
         +K0KfVSWKgTcnQn5C/012lWMdlp/YbEAlI5XFaUkzg9vde2XUiZf5350Yo7ZlSx7qGjw
         RJIAOdaEFJjAxjeDAOagFQJMg46CcS+1whR3sOwH8q/USDT5YnYrVYWu8ULOKEFVUqHn
         iiFw==
X-Gm-Message-State: ANhLgQ20dFbFBN/5bE9imWwmydO9PhLxrgpDG/0HsKPHesILO1YdvD7N
        IHw1W5oXr66ToFi3KK0JBc+kZiS3gi0=
X-Google-Smtp-Source: ADFU+vs0rMYt3wmlS51iJ3whxVA+fWfnzN+3mMEdIq9+xCbY5AYarXsp4tJWmo57hTg+7bw0BC4NzQ==
X-Received: by 2002:adf:f491:: with SMTP id l17mr6935953wro.149.1583255309186;
        Tue, 03 Mar 2020 09:08:29 -0800 (PST)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id 16sm4746576wmi.0.2020.03.03.09.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:08:28 -0800 (PST)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v2 5/5] doc: --recurse-submodules only apply to active submodules
Date:   Tue,  3 Mar 2020 18:07:40 +0100
Message-Id: <20200303170740.1879432-6-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
 <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation refers to "initialized" or "populated" submodules,
to explain which submodules are affected by '--recurse-submodules', but
the real terminology here is 'active' submodules. Update the
documentation accordingly.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/fetch-options.txt | 6 +++---
 Documentation/git-checkout.txt  | 2 +-
 Documentation/git-grep.txt      | 2 +-
 Documentation/git-pull.txt      | 2 +-
 Documentation/git-read-tree.txt | 2 +-
 Documentation/git-switch.txt    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 58972b1a05..ba33009253 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -156,11 +156,11 @@ ifndef::git-pull[]
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
-	populated submodules should be fetched too. It can be used as a
+	active submodules should be fetched too. It can be used as a
 	boolean option to completely disable recursion when set to 'no' or to
-	unconditionally recurse into all populated submodules when set to
+	unconditionally recurse into all active submodules when set to
 	'yes', which is the default when this option is used without any
-	value. Use 'on-demand' to only recurse into a populated submodule
+	value. Use 'on-demand' to only recurse into a active submodule
 	when the superproject retrieves a commit that updates the submodule's
 	reference to a commit that isn't already in the local submodule
 	clone. By default this uses the fetch.recurseSubmodules value (see
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index c8fb995fa7..3be0a28284 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -292,7 +292,7 @@ Note that this option uses the no overlay mode by default (see also
 
 --recurse-submodules::
 --no-recurse-submodules::
-	Using `--recurse-submodules` will update the content of all initialized
+	Using `--recurse-submodules` will update the content of all active
 	submodules according to the commit recorded in the superproject. If
 	local modifications in a submodule would be overwritten the checkout
 	will fail unless `-f` is used. If nothing (or `--no-recurse-submodules`)
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index ddb6acc025..cdf8e26b47 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -93,7 +93,7 @@ OPTIONS
 	with `--no-index`.
 
 --recurse-submodules::
-	Recursively search in each submodule that has been initialized and
+	Recursively search in each submodule that is active and
 	checked out in the repository.  When used in combination with the
 	<tree> option the prefix of all submodule output will be the name of
 	the parent project's <tree> object. This option has no effect
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 47bc4a7061..2285f3729d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -85,7 +85,7 @@ OPTIONS
 	Pass --verbose to git-fetch and git-merge.
 
 --[no-]recurse-submodules[=yes|on-demand|no]::
-	This option controls if new commits of all populated submodules should
+	This option controls if new commits of all active submodules should
 	be fetched and updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and linkgit:gitmodules[5]).
 +
 If the checkout is done via rebase, local submodule commits are rebased as well.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index da33f84f33..aab6856341 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -116,7 +116,7 @@ OPTIONS
 	located in.
 
 --[no-]recurse-submodules::
-	Using --recurse-submodules will update the content of all initialized
+	Using --recurse-submodules will update the content of all active
 	submodules according to the commit recorded in the superproject by
 	calling read-tree recursively, also setting the submodules HEAD to be
 	detached at that commit.
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 197900363b..337852d86b 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -181,7 +181,7 @@ name, the guessing is aborted.  You can explicitly give a name with
 --recurse-submodules::
 --no-recurse-submodules::
 	Using `--recurse-submodules` will update the content of all
-	initialized submodules according to the commit recorded in the
+	active submodules according to the commit recorded in the
 	superproject. If nothing (or `--no-recurse-submodules`) is
 	used, the work trees of submodules will not be updated. Just
 	like linkgit:git-submodule[1], this will detach `HEAD` of the
-- 
Patched on top of v2.25.1-377-g2d2118b814 (git version 2.25.1)

