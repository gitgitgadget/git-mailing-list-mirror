Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D40CC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E5A2074D
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omrq6MZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgFOMuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbgFOMuc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA17C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y17so16965258wrn.11
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1Lcp/55PZGA7b1YnQeh9i6U1RYtL8orkupFk07X1fBc=;
        b=omrq6MZUQ15GTqV5WkTbZgJswKh9UpLCj9LUcCLK8VC0dzx7JSYtbRS9sTaPGt6Nnb
         ri6Oju9d9IgLrJN/qhT8jKKUNOnTmx59A7m5WAQaHabI5HEJhf8DgxePvc7AQn6BreKz
         AX7JL7msb6exZU5MajTiPTpCqGRtAIsK0alorvClOSI3icXcFBIqUuiWZIMMEz/kBKfJ
         FlZz5Fv3oS2CzCpEuyLLgDO/9wpOVoALTw54+PLZdLBW0wAUQIkUCH7DzR0W5jlSEhLj
         OTsr6MTbKJ4N3Arpa3mJnW5dKOOdJk1vja8I4s/M81zBpoBuQ5hdmgP48fMwcfML9oqa
         XusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1Lcp/55PZGA7b1YnQeh9i6U1RYtL8orkupFk07X1fBc=;
        b=K8njRcIvdffcYCGN1kB5Dxt/6ceVTr+4fqtfjTyyE9baDvv0jDq11yXizdZovaGHjC
         D4E6Y3aSvhvtHj7w6Pv6Dv293iTIpJIPFMAhN1u2alcmjKC9o6eoocAIw4yVlxGjq17D
         HuzsdraZcIaggAdTbYXkg0ZudIrKeeYccdycsc3oxAIhbotPgqOFrT87xg0AlQ22sqWs
         LmRE/wW5n75+9MVfwLGvM8GJEktqK/XR4Ju4ZqfBEUU1bPpR0S8vKEU7RvuOC56Q+/Ua
         V8T1bL9MC5pCIip4g6xvsXNlH39caYVpSOH6VW2cmjZOld/acaKtQBLCbhKx+SrG1Tgg
         aajw==
X-Gm-Message-State: AOAM530os+VKxde/0jZZREcbJRpJQlIQaMTcZfcRGsU1dTIlHNE+akiP
        YdFsnihmQo7VHaOG479Bt0D6rq6G
X-Google-Smtp-Source: ABdhPJx2tq0UCXa2dw5Flg82s8RgXzCbmohb+PuMwiAEsAqBrhepL0/+mtxokuL1RbHRvdqm+fRczw==
X-Received: by 2002:adf:dec5:: with SMTP id i5mr30367177wrn.16.1592225430474;
        Mon, 15 Jun 2020 05:50:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm27082236wrb.46.2020.06.15.05.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:30 -0700 (PDT)
Message-Id: <e09f857f06857fedc46b91bc918486f34dde8b02.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:16 +0000
Subject: [PATCH v2 12/12] testsvn: respect `init.defaultBranch`
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The default name of the main branch in new repositories can now be
configured. The `testsvn` remote helper translates the remote Subversion
repository's branch name `trunk` to the hard-coded name `master`.
Clearly, the intention was to make the name align with Git's detaults.

So while we are not talking about a newly-created repository in the
`testsvn` context, it _still_ makes sense to use the overridden default
name for the main branch whenever users configured it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote-testsvn.c      | 12 +++++++++---
 t/t9020-remote-svn.sh |  6 ++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 3af708c5b67..6ec300bf6c3 100644
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
@@ -294,6 +294,11 @@ int cmd_main(int argc, const char **argv)
 		return 1;
 	}
 
+	remote_ref = git_main_branch_name(MAIN_BRANCH_FULL_NAME |
+					  MAIN_BRANCH_FOR_INIT);
+	if (!skip_prefix(remote_ref, "refs/heads/", &remote_ref_short))
+		BUG("unexpected remote_ref '%s'", remote_ref);
+
 	remote = remote_get(argv[1]);
 	url_in = (argc == 3) ? argv[2] : remote->url[0];
 
@@ -306,7 +311,8 @@ int cmd_main(int argc, const char **argv)
 		url = url_sb.buf;
 	}
 
-	strbuf_addf(&private_ref_sb, "refs/svn/%s/master", remote->name);
+	strbuf_addf(&private_ref_sb, "refs/svn/%s/%s",
+		    remote->name, remote_ref_short);
 	private_ref = private_ref_sb.buf;
 
 	strbuf_addf(&notes_ref_sb, "refs/notes/%s/revs", remote->name);
diff --git a/t/t9020-remote-svn.sh b/t/t9020-remote-svn.sh
index 6fca08e5e35..c931193f013 100755
--- a/t/t9020-remote-svn.sh
+++ b/t/t9020-remote-svn.sh
@@ -84,6 +84,12 @@ test_expect_success REMOTE_SVN 'incremental imports must lead to the same head'
 	test_cmp master.good .git/refs/remotes/svnsim/master
 '
 
+test_expect_success REMOTE_SVN 'respects configured default main branch' '
+	git -c init.defaultBranch=trunk remote add -f trunk \
+		"testsvn::file://$TEST_DIRECTORY/t9154/svn.dump" &&
+	git rev-parse --verify refs/remotes/trunk/trunk
+'
+
 test_debug 'git branch -a'
 
 test_done
-- 
gitgitgadget
