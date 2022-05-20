Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38BCC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352973AbiETSll (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352967AbiETSlB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:41:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D83820BCF
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id f2so12666674wrc.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pAmjfZ/qRZAPyOcPXAG/ywCb5OVVlR+UFdolfRENHZY=;
        b=J2jkjje+K9/CfYzwBnbv1ihqKe2fzcoh+O7Q7GaAnPmolbIu2mRWB3MEBZkVoF2cM5
         3jD0a4S6kXhpBzs84QLfUgYEjF2o05pzOzNmMjI33H+l9/kXPVDS4JUEA0pI9eIWo4Ib
         wFuCFfLWG5Sq1NuNKUlPJFeZMdctD435r4oQpLtc5W7S023jj1BfH8JWBNY2S4PTMQZC
         dhx5bTQM2nKIKVJI6SCOCTf4DiqQPXkZsMw9GXJ9lhExEPnI4EpPn3x2Pe1vebSptWVy
         /VSbj8dIcrEahAgyRjICRih3bNUmsfA7gb4H1+FOf6g5IduFlJEVxuO8WQDgxMqAr3pU
         L3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pAmjfZ/qRZAPyOcPXAG/ywCb5OVVlR+UFdolfRENHZY=;
        b=8EUOSUzgzeQoaJneudsLISOgzjyg/eAfvz6tSb4cxuGfCbxeLvDVm31rhUQ4caKigG
         06D/cxQcW0fl/j8lmX12NeTfxc+J94OpUxzZCmlR1fmaeSQL0ZilL3Qdt/SoRQKhtMm2
         Edt4xESi5q78s9k+7Im3o+Xsutu1pGL83YbKbpcjWH2NnwToWN9UkZWwHje5KiO7lKVX
         y9V2iHnm7SDsMPEEmn24RpyFNqC8kdlR42cn79yiquX40NKPVc6OBqkhBDu2Vkjg17YE
         mnFX+M2xMN6CXMm430zoDFCMZDHky0Bt+RZdlltO5zDWF17Fe86BAJmEEgW7a9yAHwBH
         tr2w==
X-Gm-Message-State: AOAM533mjiAOiK6SLpclMQp8+6Pr8j84KimSzokkLeMcUjGurFgdKbDY
        PARTL30iBGlDl5+MP0Rwlr7daslG/K4=
X-Google-Smtp-Source: ABdhPJxR5lO20FTk6IAJDBs+IgZcLaP08RBzCNPskhZ+lmJwdmB0ufKu4OFwecpnX9xgcIv7QOv/rw==
X-Received: by 2002:a05:6000:1689:b0:20e:6de0:a578 with SMTP id y9-20020a056000168900b0020e6de0a578mr7626481wrd.85.1653072050121;
        Fri, 20 May 2022 11:40:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6-20020adfa546000000b0020c635ca28bsm3187112wrb.87.2022.05.20.11.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:40:49 -0700 (PDT)
Message-Id: <c7ec97011e0b2b6a347a144549be93bd78526476.1653072042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
References: <pull.1234.git.1653072042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 May 2022 18:40:23 +0000
Subject: [PATCH 05/24] fetch: add --bundle-uri option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Teng Long <dyroneteng@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Teach 'git fetch' a new --bundle-uri=<uri> option which changes the mode
from fetching from a remote using the Git protocol to fetching a bundle
from the given <uri>. See Documentation/technical/bundle-uri.txt for
more information on the design of this feature.

This implementation is limited to the most basic version of the feature.
We expect the content at that URI to be a bundle file, not a bundle
list. Bundle lists will be implemented later.

This implementation is sufficient for a bundle provider to create a
single bootstrap bundle for a large repository. The user would bootstrap
a repository using a sequence of Git commands, such as:

 1. git init <repo> && cd <repo>
 2. git fetch --bundle-uri=<uri>
 3. git remote add origin <url>
 4. git fetch origin
 5. git checkout FETCH_HEAD

Later changes will make this seamless within a 'git clone' command, but
this implementation is large enough to delay that integration.

Currently, this option supports URIs using "http(s)://", "file://" or
simply specifying a filename. Other protocols could be added in the
future.

RFC TODO: add end-to-end tests of this workflow.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/fetch-options.txt |  5 +++++
 Documentation/git-fetch.txt     |  1 +
 builtin/fetch.c                 | 10 ++++++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 622bd84768b..09bd1feeed8 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -317,3 +317,8 @@ endif::git-pull[]
 -6::
 --ipv6::
 	Use IPv6 addresses only, ignoring IPv4 addresses.
+
+--bundle-uri=<uri>::
+	Instead of fetching from a remote, fetch a bundle from the given
+	`<uri>` and unbundle the data into the local repository. The refs
+	in the bundle will be stored under the `refs/bundle/*` namespace.
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index e9d364669af..4fd8911b336 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git fetch' [<options>] <group>
 'git fetch' --multiple [<options>] [(<repository> | <group>)...]
 'git fetch' --all [<options>]
+'git fetch' --bundle-uri=<uri> [<options>]
 
 
 DESCRIPTION
diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed5..cb0d2fbe82c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,7 @@
 #include "commit-graph.h"
 #include "shallow.h"
 #include "worktree.h"
+#include "bundle-uri.h"
 
 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
 
@@ -37,6 +38,7 @@ static const char * const builtin_fetch_usage[] = {
 	N_("git fetch [<options>] <group>"),
 	N_("git fetch --multiple [<options>] [(<repository> | <group>)...]"),
 	N_("git fetch --all [<options>]"),
+	N_("git fetch --bundle-uri=<uri> [<options>]"),
 	NULL
 };
 
@@ -86,6 +88,7 @@ static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 static int fetch_write_commit_graph = -1;
 static int stdin_refspecs = 0;
 static int negotiate_only;
+static const char *bundle_uri;
 
 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -224,6 +227,8 @@ static struct option builtin_fetch_options[] = {
 		 N_("write the commit-graph after fetching")),
 	OPT_BOOL(0, "stdin", &stdin_refspecs,
 		 N_("accept refspecs from stdin")),
+	OPT_STRING(0, "bundle-uri", &bundle_uri, N_("uri"),
+		   N_("download bundle data from the given URI instead of from a remote")),
 	OPT_END()
 };
 
@@ -2181,6 +2186,11 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (dry_run)
 		write_fetch_head = 0;
 
+	if (bundle_uri) {
+		result = fetch_bundle_uri(the_repository, bundle_uri);
+		goto cleanup;
+	}
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
-- 
gitgitgadget

