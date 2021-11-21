Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EDBC433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 00:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhKUAuL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 19:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbhKUAuI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 19:50:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8166AC06173E
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:04 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so25325594wrr.8
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 16:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vLrjPUiGJjgMCpzwqn9JDmb83ofz3HcEdCbxB0pFgAs=;
        b=MbBctB8u0H9TsudPU4fTvMrZsnDv4zBIbf0JoPlaYbUTEmj+5g02o3SdgS3uscYT9Y
         rYd3/jnz7fN4L3epKD0FdkAYHYE9keWAKja4mhTGeTxyoixznWjzqHOb4Ath3V6idDjp
         m8EyFTRYHYPntXZ8+u8wxBEH0qism58dghQBAao3x5arEtm5fIap/x/FQiD3NUH/BGJK
         SWOemEgJUgwdvoR4f/8U5pK78oXxKColY1labqpNwr1kCNEug7OJ6OzW2omK6STaGUHB
         9cwwi2KqiWkYA9cJeI+uDZKQ/i1g85a1LdX+y7GSp4S2NGXFmEpKog8L4l6HsgTBe3S6
         0GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vLrjPUiGJjgMCpzwqn9JDmb83ofz3HcEdCbxB0pFgAs=;
        b=erptyFy3v1Y87j0YpSTeg+dhx36SUKHtsd+E+4BS7zKfS7O5iDxbD+qqKcm0c1s9Hr
         9Uetq5Qtw2MF+wQsmfNFtTL6Fvj0sD9IPoJSngPtOX366nPADxQviXKBFklwdgO7f7ai
         EgRi87l8/BkbdjUgSkuvZXS98+fToDK82bBHfbY+lEzNCqKq2FxZUqTx/SuypFEU8VNR
         f6mjxIhRhoFLhKy+GM1qnU1FwbMmIhVIoy341OIbAFtqLjKPrx94PTyl6P8qAlm4gHex
         r62qI6IBsRV2nkpb10jqSxTs8/mZiKBM3wXkhFuWexzCfs6qSez0kza1lxqAhHC1Iknu
         n4Jg==
X-Gm-Message-State: AOAM530oc/PilM80rHBUGSFI10qJ5e/+kFSHt+EfqSajJekX7I8z0E2s
        LCOwjIJ+UxjgpAJXZic1w+pRWPFA3vs=
X-Google-Smtp-Source: ABdhPJwBq1FontOzGQG/R1c+XVRSAxe+JaycAv4DR1tKVBaIpYTZY0+JMcdyV81L3f6V709b/DzqQg==
X-Received: by 2002:a5d:69c5:: with SMTP id s5mr22313182wrw.283.1637455623035;
        Sat, 20 Nov 2021 16:47:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n32sm4586325wms.42.2021.11.20.16.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 16:47:02 -0800 (PST)
Message-Id: <7b0c665fb75d3d73d9d8d03b629a09a0ec4244e6.1637455620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Nov 2021 00:46:54 +0000
Subject: [PATCH 2/8] repository, setup: introduce the_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Removing the current working directory causes all subsequent git
commands (and likely a number of non-git commands) run from that
directory to get confused and fail with a message about being unable to
read the current working directory.  That confuses end users,
particularly since the command they get the error from is not the one
that caused the problem; the problem came from the side-effect of some
previous command.

We would like to avoid removing the current working directory; towards
this end, introduce a new the_cwd variable that tracks the current
working directory.  Subsequent commits will make use of this new
variable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 repository.c | 1 +
 repository.h | 1 +
 setup.c      | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/repository.c b/repository.c
index c5b90ba93ea..69a106c553c 100644
--- a/repository.c
+++ b/repository.c
@@ -17,6 +17,7 @@
 static struct repository the_repo;
 struct repository *the_repository;
 struct index_state the_index;
+char *the_cwd;
 
 void initialize_the_repository(void)
 {
diff --git a/repository.h b/repository.h
index a057653981c..45de85d18ef 100644
--- a/repository.h
+++ b/repository.h
@@ -147,6 +147,7 @@ struct repository {
 };
 
 extern struct repository *the_repository;
+extern char *the_cwd;
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/setup.c b/setup.c
index 347d7181ae9..4466fa55af3 100644
--- a/setup.c
+++ b/setup.c
@@ -887,6 +887,7 @@ static const char *setup_explicit_git_dir(const char *gitdirenv,
 		set_git_dir(gitdirenv, 1);
 		if (chdir(worktree))
 			die_errno(_("cannot chdir to '%s'"), worktree);
+		the_cwd = xstrdup(cwd->buf + offset);
 		strbuf_addch(cwd, '/');
 		free(gitfile);
 		return cwd->buf + offset;
@@ -940,6 +941,7 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	/* Make "offset" point past the '/' (already the case for root dirs) */
 	if (offset != offset_1st_component(cwd->buf))
 		offset++;
+	the_cwd = xstrdup(cwd->buf + offset);
 	/* Add a '/' at the end */
 	strbuf_addch(cwd, '/');
 	return cwd->buf + offset;
-- 
gitgitgadget

