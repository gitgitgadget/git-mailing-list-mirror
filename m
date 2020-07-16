Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C91CC433E6
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 06:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172BB206F5
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 06:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gks0+n7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgGPGYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGPGYc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 02:24:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFD5C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 23:24:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x9so3428874plr.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 23:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TwT/F3D0OUP5MZAReI9r9Xys4Jt7cNi9btatDIgLIP4=;
        b=Gks0+n7kyqx35x1OqIlDPtJfyBA9pY6S4y3nSS5Qe0cUszxkYBTxP8DYSIHFj2Cimw
         daQqlbWL51UU6CXwC1VIBkdP4hC+/AgnJn1hmWwomvUmc/eyVPzEZhEOoUol2bEJPbNu
         9AK5h1sDZZ4Urn6fhnFNkIegCSZd4LayEu1jTNOJ/epFs1Qa52qIaXEGerTs5Y/oMrFc
         E8lRFFJ1nYCGSuURoCQ2nqxjEZdNFYipeW2QDESLcJtHVqjhsvnvu0hQ7/9Gc+OGeWSm
         uqJDfAuOzMhS7BEqjgzfYpgqZPZiGwe4XQFAh2RaU8q/Fs45yvUWDo78LJraAdbWEKTa
         Z4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TwT/F3D0OUP5MZAReI9r9Xys4Jt7cNi9btatDIgLIP4=;
        b=MHzwFqrD6p6TNpB02bAi7BA4hObIrMbpqEDFUadRjz6Pzr9T660d0ErFbubLOTcCqk
         UHvCOf1Apa0F+iqQrsRETc6g5/1MecLH7oycJTQL3HXh1CqtrSKe0vEyS5D+v863PHFB
         vpNd6z0svRI2jtOvRsHQmznj7uAfcHrmBoKPxIqZ1oZThyS6GJiF3qjsrdhI4S9IbzYt
         AbmxAO9Tm6xFXs/Sg3Ik0LR52ZxCqtLtEoKFCP/ssqeDeJaEl8KCmrNc61kZ+QqxXXGf
         cL8C9hziU1As7LbgkDSA9nys40BwcOsUh6pQRclW0yoX4AgZUTuGbNF7QBwAtXsZBJI1
         Zb8g==
X-Gm-Message-State: AOAM531u0CEULrX9cSrL/22T1uQuvc8dDnhl4vbHu7Uwiw7JRDuzllcS
        dtV1DwLhC2zDI4ILH2ucbw8=
X-Google-Smtp-Source: ABdhPJw+Cdc4XtOe7/OhizhLjIy28XZoif/0SHhal+6ok8Ic5KMoP5736xhGippBKnnTPTE22CMTEQ==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4mr2358354plt.131.1594880672209;
        Wed, 15 Jul 2020 23:24:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id m20sm4068135pfk.52.2020.07.15.23.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 23:24:31 -0700 (PDT)
Date:   Wed, 15 Jul 2020 23:24:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>
Subject: [PATCH 1/2] Revert "check_repository_format_gently(): refuse
 extensions for old repositories"
Message-ID: <20200716062429.GB3242764@google.com>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716062054.GA3242764@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit 14c7fa269e42df4133edd9ae7763b678ed6594cd.

The core.repositoryFormatVersion field was introduced in ab9cb76f661
(Repository format version check., 2005-11-25), providing a welcome
bit of forward compatibility, thanks to some welcome analysis by
Martin Atukunda.  The semantics are simple: a repository with
core.repositoryFormatVersion set to 0 should be comprehensible by all
Git implementations in active use; and Git implementations should
error out early instead of trying to act on Git repositories with
higher core.repositoryFormatVersion values representing new formats
that they do not understand.

A new repository format did not need to be defined until 00a09d57eb8
(introduce "extensions" form of core.repositoryformatversion,
2015-06-23).  This provided a finer-grained extension mechanism for
Git repositories.  In a repository with core.repositoryFormatVersion
set to 1, Git implementations can act on "extensions.*" settings that
modify how a repository is interpreted.  In repository format version
1, unrecognized extensions settings cause Git to error out.

What happens if a user sets an extension setting but forgets to
increase the repository format version to 1?  The extension settings
were still recognized in that case; worse, unrecognized extensions
settings do *not* cause Git to error out.  So combining repository
format version 0 with extensions settings produces in some sense the
worst of both worlds.

To improve that situation, since 14c7fa269e4
(check_repository_format_gently(): refuse extensions for old
repositories, 2020-06-05) Git instead ignores extensions in v0 mode.
This way, v0 repositories get the historical (pre-2015) behavior and
maintain compatibility with Git implementations that do not know about
the v1 format.  Unfortunately, users had been using this sort of
configuration and this behavior change came to many as a surprise:

- users of "git config --worktree" that had followed its advice
  to enable extensions.worktreeConfig (without also increasing the
  repository format version) would find their worktree configuration
  no longer taking effect

- tools such as copybara[*] that had set extensions.partialClone in
  existing repositories (without also increasing the repository format
  version) would find that setting no longer taking effect

The behavior introduced in 14c7fa269e4 might be a good behavior if we
were traveling back in time to 2015, but we're far too late.  For some
reason I thought that it was what had been originally implemented and
that it had regressed.  Apologies for not doing my research when
14c7fa269e4 was under development.

Let's return to the behavior we've had since 2015: always act on
extensions.* settings, regardless of repository format version.  While
we're here, include some tests to describe the effect on the "upgrade
repository version" code path.

[*] https://github.com/google/copybara/commit/ca76c0b1e13c4e36448d12c2aba4a5d9d98fb6e7

Reported-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 setup.c                  | 12 +++---------
 t/t0410-partial-clone.sh | 15 +++++++++++++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/setup.c b/setup.c
index dbac2eabe8f..87bf0112cf3 100644
--- a/setup.c
+++ b/setup.c
@@ -507,15 +507,9 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		die("%s", err.buf);
 	}
 
-	if (candidate->version >= 1) {
-		repository_format_precious_objects = candidate->precious_objects;
-		set_repository_format_partial_clone(candidate->partial_clone);
-		repository_format_worktree_config = candidate->worktree_config;
-	} else {
-		repository_format_precious_objects = 0;
-		set_repository_format_partial_clone(NULL);
-		repository_format_worktree_config = 0;
-	}
+	repository_format_precious_objects = candidate->precious_objects;
+	set_repository_format_partial_clone(candidate->partial_clone);
+	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
 
 	if (repository_format_worktree_config) {
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 463dc3a8be0..51d1eba6050 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -42,14 +42,25 @@ test_expect_success 'convert shallow clone to partial clone' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
 
-test_expect_success 'convert shallow clone to partial clone must fail with any extension' '
+test_expect_success 'converting to partial clone fails with noop extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
 	test_commit -C server my_commit2 1 &&
 	git clone --depth=1 "file://$(pwd)/server" client &&
 	test_cmp_config -C client 0 core.repositoryformatversion &&
-	git -C client config extensions.partialclone origin &&
+	git -C client config extensions.noop true &&
+	test_must_fail git -C client fetch --unshallow --filter="blob:none"
+'
+
+test_expect_success 'converting to partial clone fails with unrecognized extension' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=1 "file://$(pwd)/server" client &&
+	test_cmp_config -C client 0 core.repositoryformatversion &&
+	git -C client config extensions.nonsense true &&
 	test_must_fail git -C client fetch --unshallow --filter="blob:none"
 '
 
-- 
2.28.0.rc0.105.gf9edc3c819

