Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97444C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F11221E3
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 20:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRkIAMWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHFUYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUYM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 16:24:12 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2E8C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 13:24:11 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id t6so40291553ljk.9
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 13:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJy3kCWTz9+FoOL8fv7AqsDFZqglP+rZFfMjCbUHvY0=;
        b=jRkIAMWqPHPpplAvSom5gCnsOC0720DhQIm6OMwJsMlbgKPBZHXRRw9UT6omA97PQ2
         ft2IllcFY4BwDNTvmEhgHXuMXBqimP7eCmcDi4Kln+jeKHA0lqZ989E1fvnh2LmhfEog
         tUQuzGDDrEgtPzFLGRFjmwLAhbEYQ8Fe3+EG07XVNCGEVGbZEdmkMsojZmyGcdSKtaDt
         4FHL1/bm/9SuyJH/+8tBZD0Ev617RKbyHanJxL7P+O/E6SKGqdWpQDHppt4hx9cC9ADM
         FbI8MqI6wHeDIKjMRUV9WF4E7dc8HLad1FNQ3rz2Mpy0IPvl+HFi9sPeQkoV25Epk5C/
         IAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJy3kCWTz9+FoOL8fv7AqsDFZqglP+rZFfMjCbUHvY0=;
        b=JS/IjetaCKNsm7k36Smgf9Sbp1dKHt41s7B4MlIH3kUMM+m7GTNVIhB6fu2c+jG2hv
         +/OP2x01bjEpZ7GA+9PvFgsnq9aelNfj5J92VQdx9JyWQR6eXP2+HGJRdEyJrSUtdgOw
         +xh27VORkyRPUBPVyvoUvinlfjjLpX6Ub3K6ZAaj/0TADm7GO+1a1ds+i8oq2GumI8cO
         NuHe0Oi4NNlPfVfM0Cknh8iv9hIO4yAW413Sjqd4F7NoIJJAwB8gm4Ejl1Ry0NX3C20u
         F5/+/eJDoMu2wDomitM7L4LP1KCfWC/UoupxAfzR8V4lOvvnmnyGUGNRaKaW7VFcAGUo
         EMnQ==
X-Gm-Message-State: AOAM530CfTWWiZPGa9T96WNqClmGjdKq4M9RAJ0b+75bGvGyGfH3UDF9
        G3X/i/+W6FI1rdPuIh+JSKLj8Uf3
X-Google-Smtp-Source: ABdhPJzoZLCS4Nxtk+U4AhSLgL4g3cqLZjlandQUApxLwSbA/splAhnB5G1vsF6hfEaXDijW4lpDtQ==
X-Received: by 2002:a05:651c:155:: with SMTP id c21mr4999403ljd.453.1596745448995;
        Thu, 06 Aug 2020 13:24:08 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id a23sm2837859ljp.121.2020.08.06.13.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 13:24:08 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] Documentation: mark `--object-format=sha256` as experimental
Date:   Thu,  6 Aug 2020 22:23:58 +0200
Message-Id: <20200806202358.2265705-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.199.g4234a9100e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After eff45daab8 ("repository: enable SHA-256 support by default",
2020-07-29), vanilla builds of Git enable the user to run, e.g.,

  git init --object-format=sha256

and hack away. This can be a good way to gain experience with the
SHA-256 world, e.g., to find bugs that

  GIT_TEST_DEFAULT_HASH=sha256 make test

doesn't spot.

But it really is a separate world: Such SHA-256 repos will live entirely
separate from the (by now fairly large) set of SHA-1 repos. Interacting
across the border is possible in principle, e.g., through "diff + apply"
(or "format-patch + am"), but even that has its limitations: Applying a
SHA-256 diff in a SHA-1 repo works in the simple case, but if you need
to resort to `-3`, you're out of luck.

Similarly, "push + pull" should work, but you really will be operating
mostly offset from the rest of the world. That might be ok by the time
you initialize your repository, and it might be ok for several months
after that, but there might come a day when you're starting to regret
your use of `git init --object-format=sha256` and have dug yourself into
a fairly deep hole.

Workflows aside, let's consider a more technical aspect. Pack index
files (pack-*.idx) exist in two flavours: v1 and v2. The hash transition
document foresees a v3, which we do not yet support (and for all we
know, the final v3 might end up different from the one sketched in the
hash transition document).

When the test suite is run with SHA-1 as the default hash algo, it
creates and consumes v2 pack files. But with SHA-256, we use an
undocumented, hybrid format where the header looks like v2, but where
the payload is not only "not correct SHA1", but where even the data
sizes are different. The trailing checksum is different, meaning no-one
(except us!) should/would try to interpret this file as a proper v2 pack
index.

We could certainly (re)define v2 to match our SHA-256 behavior, but we
do foresee v3 for a reason. And that would still just fix this specific
issue. And even when everything around SHA-256 is well-defined and we
have SHA-1--SHA-256 interoperability, there's a risk, at least
initially, that somewhere we'd be permeating buggy data that we'd then
feel responsible for and need to be able to handle for a long time to
come.

In short: we need some time and leeway.

Wherever `--object-format` is mentioned in our documentation, let's make
it clear that using it with "sha256" is experimental. If we later need
to explain why we can't handle data we generated back in 2020, we can
always point to this paragraph we're adding here.

By "include::"-ing a small blurb, we should be able to be consistent
throughout the documentation and can eventually gradually tone down the
severity of this text. One day, we might even use it to start phasing
out `--object-format=sha1`, but let's not get ahead of ourselves...

There's also `extensions.objectFormat`, but it's only mentioned three
times. Twice where we're adding this new disclaimer and in the third
spot we already have a "do not edit" warning. From there, interested
readers should eventually find this new one that we're adding here.

Because `GIT_DEFAULT_HASH` provides another entry point to this
functionality, document the experimental nature of it too.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-index-pack.txt           | 2 ++
 Documentation/git-init.txt                 | 2 ++
 Documentation/git-show-index.txt           | 2 ++
 Documentation/git.txt                      | 3 ++-
 Documentation/object-format-disclaimer.txt | 6 ++++++
 5 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/object-format-disclaimer.txt

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 9316d9a80b..139285dd0f 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -100,6 +100,8 @@ OPTIONS
 	value is set or outside a repository.
 +
 This option cannot be used with --stdin.
++
+include::object-format-disclaimer.txt[]
 
 NOTES
 -----
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index ddfe265da5..f35f70f13d 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -53,6 +53,8 @@ current working directory.
 
 Specify the given object format (hash algorithm) for the repository.  The valid
 values are 'sha1' and (if enabled) 'sha256'.  'sha1' is the default.
++
+include::object-format-disclaimer.txt[]
 
 --template=<template_directory>::
 
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index 39b1d8eaa1..e49318a5a0 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -44,6 +44,8 @@ OPTIONS
 	valid values are 'sha1' and (if enabled) 'sha256'.  The default is the
 	algorithm for the current repository (set by `extensions.objectFormat`), or
 	'sha1' if no value is set or outside a repository..
++
+include::object-format-disclaimer.txt[]
 
 GIT
 ---
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3e50065198..e0a2690ba2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -497,7 +497,8 @@ double-quotes and respecting backslash escapes. E.g., the value
 	If this variable is set, the default hash algorithm for new
 	repositories will be set to this value. This value is currently
 	ignored when cloning; the setting of the remote repository
-	is used instead. The default is "sha1".
+	is used instead. The default is "sha1". THIS VARIABLE IS
+	EXPERIMENTAL! See `--object-format` in linkgit:git-init[1].
 
 Git Commits
 ~~~~~~~~~~~
diff --git a/Documentation/object-format-disclaimer.txt b/Documentation/object-format-disclaimer.txt
new file mode 100644
index 0000000000..4cb106f0d1
--- /dev/null
+++ b/Documentation/object-format-disclaimer.txt
@@ -0,0 +1,6 @@
+THIS OPTION IS EXPERIMENTAL! SHA-256 support is experimental and still
+in an early stage.  A SHA-256 repository will in general not be able to
+share work with "regular" SHA-1 repositories.  It should be assumed
+that, e.g., Git internal file formats in relation to SHA-256
+repositories may change in backwards-incompatible ways.  Only use
+`--object-format=sha256` for testing purposes.
-- 
2.28.0.199.g4234a9100e

