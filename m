Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 886691F405
	for <e@80x24.org>; Mon, 17 Dec 2018 17:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeLQRAB (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 12:00:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45215 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLQRAB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 12:00:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so6400080plm.12
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 09:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jfMvXm/EKHV8iUsNsPK1k807VI8ZeyJfFgWVMnoUS48=;
        b=nxS0LUdgj9Dgj/YiwBrxUfBcS+TsCc3SKrc9AAU69JsbItdxfPfCwTgRrPnoFakMiV
         54N5axpIMJNXXeUajmBpdP+fRGjU5w0qzEd6albx/9G8Yic15T8n7QfbTjyNzBOC4SIc
         z+gnyADbBpLn/A7l5usvCtp3dHf1PyiXn1mp35gvFPJvn1lhl4GH2zYYvnczMe0pt9H0
         YG6/ms6EiPkTRubLXhvHScM2IJhS4dy+gVHA/V/MpwHk9jHDjCUaQ5RmGOyFrkPSOKIg
         +/YRruEEFQBwz+OE42M+7bfVrkVax3z8XOc2WAtI40aE23zOeprLQUQjhGzZvxz9WIgq
         FATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jfMvXm/EKHV8iUsNsPK1k807VI8ZeyJfFgWVMnoUS48=;
        b=cJUr20cgl3rWhj4Pql1qwKQGoMeiEuVgSaYD2mUh2pdgfJp95wlkRncs9Q+bFHbcXF
         nuudNDgOl2wuE7XYKU55tdoBFVsJvTa1JaFB1qW/M5YKCALtD5hMNgvBb5sQ2YEStKnC
         rDVclfHRbV8cEmi8gaKsMqiDGxcw1IpazwZ8nO6A5q02S5NPQMH3KVpRSz7cm/J3JEkF
         bbd8mTlfLocq06JyvaEFxGCAJbcQ6qnBTjc+p3k4DKDz/lV4y3pVEFsfqhoWFdjCp3YK
         qgUYTCIn4KlkEkhfyf3hTvfYUhfIecDUPYMf0t/LMy/MO/KJViZlxiBnRv4PWbyMpt40
         oOaA==
X-Gm-Message-State: AA+aEWYbFtmv4cTunqO8JkS3NMpx0pKTrPZgqVK5mM/EovRgLadfZ01P
        m6bWxpV4qKwNuSrFaLooHOgOBul/
X-Google-Smtp-Source: AFSGD/VJXwYf1befKOj65O0cXyWX+ZHNW7B/BAeFaHoKUwPA5WjAy5Mwcs9v2cuXvV7bsSeVf1MInw==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr13470048pld.181.1545066000000;
        Mon, 17 Dec 2018 09:00:00 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id f67sm30321123pff.29.2018.12.17.08.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 08:59:59 -0800 (PST)
Date:   Mon, 17 Dec 2018 08:59:57 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] stripspace: allow -s/-c outside git repository
Message-ID: <20181217165957.GA60293@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2.11.0-rc3~3^2~1 (stripspace: respect repository config, 2016-11-21)
improved stripspace --strip-comments / --comentlines by teaching them
to read repository config, but it went a little too far: when running
stripspace outside any repository, the result is

	$ git stripspace --strip-comments <test-input
	fatal: not a git repository (or any parent up to mount point /tmp)

That makes experimenting with the stripspace command unnecessarily
fussy.  Fix it by discovering the git directory gently, as intended
all along.

Reported-by: Han-Wen Nienhuys <hanwen@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/stripspace.c  |  3 ++-
 t/t0030-stripspace.sh | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index bdf0328869..be33eb83c1 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -30,6 +30,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	enum stripspace_mode mode = STRIP_DEFAULT;
+	int nongit;
 
 	const struct option options[] = {
 		OPT_CMDMODE('s', "strip-comments", &mode,
@@ -46,7 +47,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 		usage_with_options(stripspace_usage, options);
 
 	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
-		setup_git_directory_gently(NULL);
+		setup_git_directory_gently(&nongit);
 		git_config(git_default_config, NULL);
 	}
 
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 5ce47e8af5..0c24a0f9a3 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -430,9 +430,15 @@ test_expect_success '-c with changed comment char' '
 test_expect_success '-c with comment char defined in .git/config' '
 	test_config core.commentchar = &&
 	printf "= foo\n" >expect &&
-	printf "foo" | (
-		mkdir sub && cd sub && git stripspace -c
-	) >actual &&
+	rm -fr sub &&
+	mkdir sub &&
+	printf "foo" | git -C sub stripspace -c >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '-c outside git repository' '
+	printf "# foo\n" >expect &&
+	printf "foo" | nongit git stripspace -c >actual &&
 	test_cmp expect actual
 '
 
-- 
2.20.0.405.gbc1bbc6f85

