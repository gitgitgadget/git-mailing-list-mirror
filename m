Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07F3C433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B4F2078A
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUz8mVDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388521AbgFWWri (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbgFWWr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:47:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A7C061258
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so197048wrw.12
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u6JG8xbS+cKtoN0338qGgi/g2nWe5Hm26yJvKNYy4hY=;
        b=TUz8mVDVb1Nqh92ymLLIsgzqxVoP0bx3TNVL33dIw866HKf2IAhIdvwQGxCvWnbaUL
         XzxTbcWoSyLfyYwkS+TGXLopVKlyWSiAN6UXa7LWJ7Oq9aAZGmBGsioFAOhu3zEbO4Oe
         r957tO0Vw2wwKGx4qC0GeINwSTzVoNX0HVPA3KXIHJ0Yi2+HYp77bGncvRRQEX3PVRkY
         sBMyFoYVvGmO3ulbNs3zQrUx7dkdT/XRBnXFjSWAVziodW6iiRkSJJhKjxN98QrdqVP+
         QDIV/cR/Czre+k1t6JUtfUHG9VPFRDh0ISk3jTO4Y+tVXeZnZyzR7IDDR1acmNf+9mfT
         OLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u6JG8xbS+cKtoN0338qGgi/g2nWe5Hm26yJvKNYy4hY=;
        b=rrbcmOuQLFRyQBN1c2naOR4DZ+H7pUegiPJoTH760GvAfeVfBMNZsw5EgRj25wgnIW
         k+lIEDL7kuR/5AGFSPcekTvGM6PFJRZ6aEeoflbkvmYogr1fbUl7Zsq+YpXhbIajE5SE
         2A2UUnwhiw5lCZpB0NhzrwIuiv1MMf7pXCS3Xj7g+qArbe0TCAVOEftOcKIKfXkOBflo
         nlurKH3x7ROznITsJjW7xqqHh9i1ScZJhiE5UkB8K796+QpbTp3yIoNfDGQzJ50ilb7g
         VOkpmrYinJlK87ZWE49vOTdVQZhtKSuyRrZfnSFFPhEDe9UwfCAfcDfm6baZDL0Emj2L
         YSuw==
X-Gm-Message-State: AOAM532bnFBa1RloormDJoMX2RyRbPqi1GS1svh2zMgH/lWPeHaO6+jp
        geXHC7M6pYirzHgeqwAkh3vwOtGh
X-Google-Smtp-Source: ABdhPJyi9S08gr3CqhycUERJJcnm0PArNsDQPETDcGHya3CFAhlaSifRhHwpJMTL/JLZJkx4shzIXQ==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr26493611wro.375.1592951621346;
        Tue, 23 Jun 2020 15:33:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm25229104wrv.47.2020.06.23.15.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:33:40 -0700 (PDT)
Message-Id: <1aa0e63785c5c64cc0d45f51f5ce4b45a16e89c8.1592951611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 22:33:30 +0000
Subject: [PATCH v3 8/8] testsvn: respect `init.defaultBranch`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The default name of the initial branch in new repositories can now be
configured. The `testsvn` remote helper translates the remote Subversion
repository's branch name `trunk` to the hard-coded name `master`.
Clearly, the intention was to make the name align with Git's defaults.

So while we are not talking about a newly-created repository in the
`testsvn` context, it is a newly-created _Git_ repository, si it _still_
makes sense to use the overridden default name for the initial branch
whenever users configured it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote-testsvn.c      | 10 +++++++---
 t/t9020-remote-svn.sh |  6 ++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 3af708c5b6..cde39b94fb 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -13,7 +13,7 @@
 static const char *url;
 static int dump_from_file;
 static const char *private_ref;
-static const char *remote_ref = "refs/heads/master";
+static char *remote_ref;
 static const char *marksfilename, *notes_ref;
 struct rev_note { unsigned int rev_nr; };
 
@@ -286,7 +286,7 @@ int cmd_main(int argc, const char **argv)
 			private_ref_sb = STRBUF_INIT, marksfilename_sb = STRBUF_INIT,
 			notes_ref_sb = STRBUF_INIT;
 	static struct remote *remote;
-	const char *url_in;
+	const char *url_in, *remote_ref_short;
 
 	setup_git_directory();
 	if (argc < 2 || argc > 3) {
@@ -294,6 +294,9 @@ int cmd_main(int argc, const char **argv)
 		return 1;
 	}
 
+	remote_ref_short = git_default_branch_name();
+	remote_ref = xstrfmt("refs/heads/%s", remote_ref_short);
+
 	remote = remote_get(argv[1]);
 	url_in = (argc == 3) ? argv[2] : remote->url[0];
 
@@ -306,7 +309,8 @@ int cmd_main(int argc, const char **argv)
 		url = url_sb.buf;
 	}
 
-	strbuf_addf(&private_ref_sb, "refs/svn/%s/master", remote->name);
+	strbuf_addf(&private_ref_sb, "refs/svn/%s/%s",
+		    remote->name, remote_ref_short);
 	private_ref = private_ref_sb.buf;
 
 	strbuf_addf(&notes_ref_sb, "refs/notes/%s/revs", remote->name);
diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index 9fcfa969a9..754c4a3284 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -84,6 +84,12 @@ test_expect_success REMOTE_SVN 'incremental imports must lead to the same head'
 	test_cmp master.good .git/refs/remotes/svnsim/master
 '
 
+test_expect_success REMOTE_SVN 'respects configured default initial branch' '
+	git -c init.defaultBranch=trunk remote add -f trunk \
+		"testsvn::file://$TEST_DIRECTORY/t9154/svn.dump" &&
+	git rev-parse --verify refs/remotes/trunk/trunk
+'
+
 test_debug 'git branch -a'
 
 test_done
-- 
gitgitgadget
