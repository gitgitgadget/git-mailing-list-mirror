Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49ADC43331
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBC0207FC
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 21:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYfS1MnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCYVKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:10:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50583 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbgCYVKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 17:10:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id d198so4300244wmd.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2020 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNPb5oYBS4R0kbCu+dDQM3OBW7xvpjOe+8Ve5+pcj28=;
        b=TYfS1MnWsKG/ApngDlPpwAeSGnXn2vM41T6lLTe2uk4Ha/LIwRhODT9EtMt3c3onSh
         +2YHcziv2GdY2nUqx3oSjF4z0neMuCxy6H5GtBG7hl6HQljGMGC7s5rLo4Nihf24l1NT
         U2e4AiMEdBNqHnaHz0+svhDGLiKg9RDiaTJ7AwAMJa67lRCHahF3s090WIdeXZ0X5pi2
         MLaLa8XcUNQoQaJzUzXE+4cg9a6mW1lvsoi191VCzzpP6o0Kzdt511NZafpZl+dDWiTn
         z5PojHKaZ8VFiFFRfsJzjaFR66Wr9VlX2m2OwwjmOmA3OlSE1BgNnK3+tEl2l4LlDzuq
         s75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNPb5oYBS4R0kbCu+dDQM3OBW7xvpjOe+8Ve5+pcj28=;
        b=t3NjriEbFruAXLzdGXTp3bGAx5USlL/JVvO5u4YKiXucjWSk5BmpO/vcNUpa6juRyL
         CFbNqscPP6V7mKOEkuX9LFBidfA161qgkxE/v3a3pR+6vqDejZ3YQnb5Jnqlip7VD+Sx
         /QbLJauSA6ISckR5DqwFPIxX5yPDL35q3QQKUjkhL/JPIOCITx2MOM5ENXn4qOjiX0Yg
         5epfJilW7f7k6D95ECEU3Ozp2Bun/YQFEqr6RoMUUqvhtuHMLwk0byAwDRAxzWM1eW3C
         4BoOyyIL8lx2t74uphcIzQDD54UPa5PCkTeLBmGNek/XruUVkSFMaLMbt9yHf653t2Lw
         GKAg==
X-Gm-Message-State: ANhLgQ1wvSGmcf1QToL9v8eOfJpwMwq2Q4QGsHkOyvplhmnTaXXA/PY/
        VQATy+zNQks1D8Z5yGWIZc9M0slX8ZA=
X-Google-Smtp-Source: ADFU+vvnT2YPmMi+KTZhe9FvuvpdyDRxK1Xx3tMvTaxEgBEttCu/uLJqSN63OrH8M73njlf1RQoT+w==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr5214473wml.156.1585170629140;
        Wed, 25 Mar 2020 14:10:29 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id u16sm352760wro.23.2020.03.25.14.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:10:28 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v4 4/5] doc: be more precise on (fetch|push).recurseSubmodules
Date:   Wed, 25 Mar 2020 22:09:42 +0100
Message-Id: <20200325210943.339240-5-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
References: <20200325210943.339240-1-damien.olivier.robert+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The default value also depends on the value of submodule.recurse.
Use this opportunity to correct some grammar mistakes in
Documentation/config/fetch.txt signaled by Robert P. J. Day.

Also mention `fetch.recurseSubmodules` in fetch-options.txt. In
git-push.txt, `push.recurseSubmodules` is implicitly mentioned (by
explaining how to disable it), so no need to add it there.

Lastly add a link to `git-fetch` in `git-pull.txt` to explain the
meaning of `--recurse-submodules` there.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 Documentation/config/fetch.txt  | 9 +++++----
 Documentation/config/push.txt   | 2 ++
 Documentation/fetch-options.txt | 3 ++-
 Documentation/git-pull.txt      | 3 +--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index f11940280f..cd5b1417c4 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -1,11 +1,12 @@
 fetch.recurseSubmodules::
-	This option can be either set to a boolean value or to 'on-demand'.
+	This option can be set either to a boolean value or to 'on-demand'.
 	Setting it to a boolean changes the behavior of fetch and pull to
-	unconditionally recurse into submodules when set to true or to not
-	recurse at all when set to false. When set to 'on-demand' (the default
-	value), fetch and pull will only recurse into a populated submodule
+	recurse unconditionally into submodules when set to true or to not
+	recurse at all when set to false. When set to 'on-demand',
+	fetch and pull will only recurse fetching into a populated submodule
 	when its superproject retrieves a commit that updates the submodule's
 	reference.
+	Defaults to 'on-demand', or to the value of 'submodule.recurse' if set.
 
 fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
index 0a7aa322a9..f5e5b38c68 100644
--- a/Documentation/config/push.txt
+++ b/Documentation/config/push.txt
@@ -112,3 +112,5 @@ push.recurseSubmodules::
 	is 'no' then default behavior of ignoring submodules when pushing
 	is retained. You may override this configuration at time of push by
 	specifying '--recurse-submodules=check|on-demand|no'.
+	If not set, 'no' is used by default, unless 'submodule.recurse' is
+	set (in which case a 'true' value means 'on-demand').
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index a115a1ae0e..b1058d63bc 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -163,7 +163,8 @@ ifndef::git-pull[]
 	value. Use 'on-demand' to only recurse into a populated submodule
 	when the superproject retrieves a commit that updates the submodule's
 	reference to a commit that isn't already in the local submodule
-	clone.
+	clone. By default, 'on-demand' is used, unless
+	`fetch.recurseSubmodules` is set (see linkgit:git-config[1]).
 
 -j::
 --jobs=<n>::
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index dfb901f8b8..47bc4a7061 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -86,8 +86,7 @@ OPTIONS
 
 --[no-]recurse-submodules[=yes|on-demand|no]::
 	This option controls if new commits of all populated submodules should
-	be fetched and updated, too (see linkgit:git-config[1] and
-	linkgit:gitmodules[5]).
+	be fetched and updated, too (see linkgit:git-fetch[1], linkgit:git-config[1] and linkgit:gitmodules[5]).
 +
 If the checkout is done via rebase, local submodule commits are rebased as well.
 +
-- 
Patched on top of v2.26.0 (git version 2.25.2)

