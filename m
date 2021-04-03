Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C71C43460
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 01:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2122A611AC
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 01:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhDCBef (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 21:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhDCBea (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 21:34:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B00C061788
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 18:34:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id k8so4512413pgf.4
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 18:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WgB4kq8zCISBt2PQozTVeL58VOa2FVRGGaZSpMm0CHY=;
        b=3PejQqjaHbYCgLt7WuaTG5+7XniwdY2lJR7KDBg0HLaDNGdDNYRUvkxFgjYKLfmEH7
         6qX1oSZTKYHWW6h9UXI8QkYSWE4BmAWIkA2pOiMIvESX4WEXEZhIALwOKrocrhQmgldO
         dsVnMTi3EGWrp/6ehpHvK5SIibqQ3K2uw95e1zOP0QkInFqbSkp1Xd06eb+LAElppqiu
         cnz93rTEA/ODWtfSTyZN+Idsgxg0yTHj4ALzofpPyA1txpTdKuvh7GGsROcOVdxKaGyd
         ItqOT3SyZzL4NYauJg5o/tiTSCKNlm/CGeTTWD/6MzjpwIwE+Dkkk8sdHGxs8mUcoMx+
         EQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WgB4kq8zCISBt2PQozTVeL58VOa2FVRGGaZSpMm0CHY=;
        b=gCQF1XDa6nIut9/f07LgydbH96wAqP8cI3APRyhXTI5M5RG4X56YMHwFMYjatdka5U
         DYmYn5j++5C9tTZBfj4qJnzbiRm2yIwECe4/h0/mpciqGoNOe+y6UGq9nPwXBzZF9OHc
         OvvnjTUwH3Qv77toL7Sbed+4mpxgPiouTGaf8mC6fBcayma5twXMLx9dOObRd7ZKA6xS
         vnPQKb3ZtQv7SKEXRJbJSOj2m8nFEGScsSuPsTLiy+U9P/C/SUQljcnLsuAWVGcY0M2P
         +bGOFjYvR2Isp/a9buF8p7jzFt8blvRd2k651XwnPYJKIkpFtGvOv+3pohHrQRhpddFA
         yeww==
X-Gm-Message-State: AOAM532UDKyHIsN2uYAXJhHMfjQ6YMIwaYoIKwyTkgcbqneweTQe7X52
        D0YSNZGiJFyTUG7DZaz2Y6rt3Qbtt1XeOdmlxSc=
X-Google-Smtp-Source: ABdhPJwDg7W/Rsu32YmV+odb4K6V3swyFR9dlzX06allwDWMuVugP43w7DOvPb6MkLOOgPDvmwGjOA==
X-Received: by 2002:aa7:8a58:0:b029:1fb:8ab:866e with SMTP id n24-20020aa78a580000b02901fb08ab866emr14736316pfa.0.1617413666896;
        Fri, 02 Apr 2021 18:34:26 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id ot17sm8937518pjb.50.2021.04.02.18.34.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Apr 2021 18:34:26 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiask@skydio.com,
        Jerry Zhang <jerry@skydio.com>,
        Jerry Zhang <jerryxzha@googlemail.com>
Subject: [PATCH 1/1] git-apply: Allow simultaneous --cached and --3way options
Date:   Fri,  2 Apr 2021 18:34:10 -0700
Message-Id: <20210403013410.32064-2-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.164.g5aa78b22ae
In-Reply-To: <20210403013410.32064-1-jerry@skydio.com>
References: <20210403013410.32064-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, --cached and --3way were not
allowed to be used together, since --3way
wrote conflict markers into the working tree.

These changes change semantics so that if
these flags are given together and there is
a conflict, the conflict markers are added
directly to cache. If there is no conflict,
the patch is applied directly to cache as
expected.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
Signed-off-by: Jerry Zhang <jerryxzha@googlemail.com>
---
 Documentation/git-apply.txt |  4 +++-
 apply.c                     | 13 +++++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 91d9a8601c..3dc0085066 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -89,7 +89,9 @@ OPTIONS
 	and we have those blobs available locally, possibly leaving the
 	conflict markers in the files in the working tree for the user to
 	resolve.  This option implies the `--index` option, and is incompatible
-	with the `--reject` and the `--cached` options.
+	with the `--reject` option. When used with the --cached option, any
+	conflict markers are added directly to the cache rather than the
+	working tree.
 
 --build-fake-ancestor=<file>::
 	Newer 'git diff' output has embedded 'index information'
diff --git a/apply.c b/apply.c
index 6695a931e9..fc94ca0e99 100644
--- a/apply.c
+++ b/apply.c
@@ -133,8 +133,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
 
 	if (state->apply_with_reject && state->threeway)
 		return error(_("--reject and --3way cannot be used together."));
-	if (state->cached && state->threeway)
-		return error(_("--cached and --3way cannot be used together."));
 	if (state->threeway) {
 		if (is_not_gitdir)
 			return error(_("--3way outside a repository"));
@@ -4490,13 +4488,16 @@ static int create_file(struct apply_state *state, struct patch *patch)
 
 	if (!mode)
 		mode = S_IFREG | 0644;
-	if (create_one_file(state, path, mode, buf, size))
-		return -1;
+	if (!state->cached) {
+		if (create_one_file(state, path, mode, buf, size))
+			return -1;
+	}
 
-	if (patch->conflicted_threeway)
+	if (patch->conflicted_threeway && !state->cached)
 		return add_conflicted_stages_file(state, patch);
-	else if (state->update_index)
+	else if (state->update_index) {
 		return add_index_file(state, path, mode, buf, size);
+	}
 	return 0;
 }
 
-- 
2.29.0

