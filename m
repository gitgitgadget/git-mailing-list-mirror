Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77490C433E1
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537F120702
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 14:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSzl2h5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404016AbgFXOqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391295AbgFXOqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 10:46:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2473CC061795
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so2556647wru.6
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u6JG8xbS+cKtoN0338qGgi/g2nWe5Hm26yJvKNYy4hY=;
        b=cSzl2h5rHH+WqGSoLm1UndzEEMvoEFEx99FfApQvhK2J49WxiQRFsNmhYx3nb0MAeL
         i6TlE3j8g+JmPo/XgAi3RDZ0JrEs8EpU8kl6eKh+gkF+eqpgpymK4CLZzGU1VT/O8pyF
         kzzlbofyXV3WLmhb0r42TnpBZ8+lLxWphpoTTxbmypnBDSrDkwnCSKVFd/9T+A4I3N6E
         bBbD3udlA2YPd4c3U+/pIaDtEPY1ozlp3BTCvNno8I3EedEfhawntK+vZFkR4zfhMGB6
         JIWCXXjvdY8OZX90jh3BXnHd7BKP03D1XL9F6mDSg99Y9WLGT1LBz9DpdXg7zfXluI2k
         Pqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u6JG8xbS+cKtoN0338qGgi/g2nWe5Hm26yJvKNYy4hY=;
        b=SVAdbEzTy0oPiS8X2XrgnU3TpdOemDaBMU1metYhgRAwoHbXQXSGUbYdD0TjwU06x7
         ttLO5KW5z5Cr8Vj42nnDXQetbJWmo4EUAdJ2xC/SimroPXYcbPEi6YeDE5j1Y2qzfKBs
         d3q4eNS5Pm9qHzGMtqNTdAbU6GKI+H13j/G+8Z4pPLJ8e9gYmVo0edozOkUv+Z0oVCCN
         TKKX1PTbuzZjlopJSlAyU9BvUDlANrNZpscJX4ztQTv2jwHpnVHPF0xkcC+zvgo1hYuk
         qhK+6+oY9Y0c4yP1p7jiQaSMg+csebGbdq/8dVUoVHqoCEpIKpEGTlVZRhEBp9UH66Zu
         EIww==
X-Gm-Message-State: AOAM532xu3cA9NUgPB1U5LHSBBiPUWkJGEghY5hyR9bR+TXbDcvzeizV
        a21CCbEh5P+mV8DGUgYUiZ82baq84rk=
X-Google-Smtp-Source: ABdhPJzyH7NuyCnL7ljbL+uTQGJg+netuH7TDuYuE5q6Pmoct64TAJGONfNDEhkrZthHixfv4yVF8g==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr10306256wrg.205.1593010005788;
        Wed, 24 Jun 2020 07:46:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w17sm28792511wra.42.2020.06.24.07.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:46:45 -0700 (PDT)
Message-Id: <6c72abf677db0776a124a34f3e58ec58c36dd93f.1593009996.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
References: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <pull.656.v4.git.1593009996.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Jun 2020 14:46:36 +0000
Subject: [PATCH v4 9/9] testsvn: respect `init.defaultBranch`
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
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
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
