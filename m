Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3C2C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3BA5207EA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2DnvpcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgIANWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgIANUY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 09:20:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A872DC061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 06:20:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o5so1478205wrn.13
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=56t6yj1alMCTpjUopvExQ5j9/jbTl8WTrrDWEBWQadg=;
        b=N2DnvpcZB2jwMgbKpMDZfEpiHlWOoPVGpN++IgUuelZ2iuMAEL6+Pri+/6ghC5sJcR
         39wzYDKqzJAI3TZC9keTDABcfrH7R2le/i9gkAJXFYES4iZDXHQuE9lE2Em4ff8OEi4f
         oASMPPPICQPbSgr/qjtKLaU3BM+QJ/Ud8yWpYZOSxlnvkplZoc3JqaENLRH0ubRW8acn
         vvTeW1LBTnxWbJn5qGO+r5zy+YOytLdcigKPqI4SjwRfpNAnrub1ggR3J56Ssz8H/Bur
         7syeNbIN1eqbA2uPwLSfjmH167V5e+4gcYoTZcTvB8zJ9AFRiyOISzp8+y9rp3bbC+e0
         k1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=56t6yj1alMCTpjUopvExQ5j9/jbTl8WTrrDWEBWQadg=;
        b=RdtzbwxVX048078hzgWborBC/tDfzZCnqcwoNrMjjCMf/y7540PvtpLBC06/iSWJ7p
         Dp5Sp12Klu7MY8DyYe5Jq4oGIfG7ySYG3ctpD1sp1cE0a7+5YRaq5vaxfJC6ro9DMQuS
         uXnnPg6mFLjtIRqi0oa63cSFlwLk8Gqwp5Ob4k6nN0+i1d4vi9QgTrQhzcIzXCdy2Qc8
         uHSBdNaeaeEM8p1krKnqdZwQXGToPoKqUAO1UdxZ3rXpaixH1j+OZ0dJ8KGGc2LZ71LF
         lcO3c/KuRYYMzGYaJneG2Fcj8zMyDS8+sSsaRc6SzmIqB1boudDMugfbWrJ/bR3Zpaow
         W+4Q==
X-Gm-Message-State: AOAM530DpC+mmnHIPm8tU5ldCq47Omi1yHk+IIIBR2PKYkbqxlsOjUkq
        fsRxWJ5/Gp9Myq7//Ve+odln6Ez7f5c=
X-Google-Smtp-Source: ABdhPJzanAORHk+sPR8SnlBAALzarXBfnjq7VlXA3iQyxgjWK5GkVqT+RxpEbuwJFwslt3RsRhZqnw==
X-Received: by 2002:adf:f511:: with SMTP id q17mr1881966wro.414.1598966413457;
        Tue, 01 Sep 2020 06:20:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1sm1909567wmc.18.2020.09.01.06.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 06:20:12 -0700 (PDT)
Message-Id: <pull.718.git.1598966412371.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Sep 2020 13:20:12 +0000
Subject: [PATCH] git.txt: correct stale 'GIT_EXTERNAL_DIFF' description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Estabrooks <seanlkml@sympatico.ca>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

In fde97d8ac6 (Update documentation to remove incorrect GIT_DIFF_OPTS
example., 2006-11-27), the description of the 'GIT_EXTERNAL_DIFF'
variable was moved from 'diff-format.txt' to 'git.txt', and the
documentation was updated to remove a 'diff(1)' invocation since Git did
not use an external diff program anymore by default.

However, the description of 'GIT_EXTERNAL_DIFF' still mentions "instead
of the diff invocation described above", which is confusing.

Correct that outdated sentence.

Also, link to git(1) in 'diff-generate-patch.txt' when GIT_DIFF_OPTS and
GIT_EXTERNAL_DIFF are mentioned, so that users can easily know what
these variables are about.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    git.txt: correct stale 'GIT_EXTERNAL_DIFF' description

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-718%2Fphil-blain%2Fgit-external-diff-wording-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-718/phil-blain/git-external-diff-wording-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/718

 Documentation/diff-generate-patch.txt | 3 ++-
 Documentation/git.txt                 | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index e8ed6470fb..b10ff4caa6 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -10,7 +10,8 @@ linkgit:git-diff-tree[1], or
 linkgit:git-diff-files[1]
 with the `-p` option produces patch text.
 You can customize the creation of patch text via the
-`GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables.
+`GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables
+(see linkgit:git[1]).
 
 What the -p option produces is slightly different from the traditional
 diff format:
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2fc92586b5..98bdf0983c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -551,8 +551,9 @@ Git Diffs
 
 `GIT_EXTERNAL_DIFF`::
 	When the environment variable `GIT_EXTERNAL_DIFF` is set, the
-	program named by it is called, instead of the diff invocation
-	described above.  For a path that is added, removed, or modified,
+	program named by it is called to generate diffs, and Git
+	does not use its builtin diff machinery.
+	For a path that is added, removed, or modified,
 	`GIT_EXTERNAL_DIFF` is called with 7 parameters:
 
 	path old-file old-hex old-mode new-file new-hex new-mode

base-commit: d9cd4331470f4d9d78677f12dc79063dab832f53
-- 
gitgitgadget
