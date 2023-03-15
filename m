Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE3EC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 15:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjCOPPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjCOPPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 11:15:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24718AA1
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v16so17695760wrn.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678893335;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1fZE859NduZbyWuIX3xEGeUxQ0RfFRHfVEG4XDrPQwA=;
        b=QKA14Z37y++mFTwCwSB0O0VyWZ0dhRvFiSA4lwiAuL7qLg9ivukvxxakr+PHTVt6mi
         3v9HCOMKDUIMlaGtDRSolPaOEyQhbuYtFSx2N4e46yTFi+BDO212c0rX1GXGUykOknZU
         2F6rrnHqsKHokUS6j+LXzH6sjz2oI7OxdXjzY3/+xasgKqd8k3aATwJqZXiZaDVhyPMV
         d3L21HuT0QOqTsVw/az6s4x9tsEj40iu6JjlgXoPc+SoQt1b7QsAUqiG4mY3bTf0751H
         4MTgwKLb5+6ftNFvsb4IcwelgAUuXQlj/uADkE0YFgIIgfrf1byu1GX7DUJv90NyBtz6
         rmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893335;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fZE859NduZbyWuIX3xEGeUxQ0RfFRHfVEG4XDrPQwA=;
        b=ydP0iN8w2YP1xyNjnkQi0TK4lDUXk9nfRvYD5ZhYdOCdHIdKGl17ssmac86V6XAUGt
         Agk658ZG14G7tnB7p5AU3BQKm2r3UJSwx9KvrQcM09FlVl3CTwLsuUTBCkI2Kz/8lNHE
         +mFCZtiEtdiaNudcAaE80IcKdz3fMHPSst5dOwvO8V2RJwTQdmx0QgP+SUrhzcXzY6zH
         LbYo6rK1atl+lahk4cDWGXYP49m8163A7aqeCwyBS2Ok/YfpXzkNfRUZyRC/d8C0i8bH
         pnxlRzFARx/pLbVg2RnFHIIE6gVcQmxZOmno+VlZGL/R2g7DtRpninnXUsG1WSy6/iys
         OgYA==
X-Gm-Message-State: AO0yUKXePOlj6cJeoXbi29Y5b6gCVG4BQ8fuYvRC6qxya39C/Kvid2qM
        TSjMeKnigWpKxXQR1AlRHenYhpwpfmw=
X-Google-Smtp-Source: AK7set/RJB7O3Pz/r57B33/VUCsdfKWiXE9/ua8MahCPIkrER3n8ntPD7Lppz9TWoH+g894U7hlHlw==
X-Received: by 2002:a05:6000:4c:b0:2ce:d152:dae1 with SMTP id k12-20020a056000004c00b002ced152dae1mr2164224wrx.13.1678893334962;
        Wed, 15 Mar 2023 08:15:34 -0700 (PDT)
Received: from localhost.localdomain ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d550a000000b002c706c754fesm4783191wrv.32.2023.03.15.08.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:15:34 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/4] rebase -m: fix serialization of strategy options
Date:   Wed, 15 Mar 2023 15:14:58 +0000
Message-Id: <9af68cb065871d9b89e99ef6b48870d322bb5faa.1678893298.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

To store the strategy options rebase prepends " --" to each one and
writes them to a file. To load them it reads the file and passes the
contents to split_cmdline(). This roughly mimics the behavior of the
scripted rebase but has a couple of limitations, (1) options containing
whitespace are not properly preserved (this is true of the scripted
rebase as well) and (2) options containing '"' or '\' are incorrectly
parsed and may cause the parser to return an error.

Fix these limitations by quoting each option when they are stored so
that they can be parsed correctly. Now that "--preserve-merges" no
longer exist this change also stops prepending "--" to the options when
they are stored as that was an artifact of the scripted rebase.

These changes are backwards compatible so the files written by an older
version of git can be still be read. They are also forwards compatible,
the file can still be parsed by recent versions of git as they treat the
"--" prefix as optional.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                    | 23 +++++++++++++++++++----
 t/t3418-rebase-continue.sh     | 34 ++++++++++++++++++++++------------
 t/t3436-rebase-more-options.sh | 24 ------------------------
 3 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 83ea1016ae..8890d1f7a1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2930,7 +2930,7 @@ static void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
 	count = split_cmdline(strategy_opts_string,
 			      (const char ***)&opts->xopts);
 	if (count < 0)
-		die(_("could not split '%s': %s"), strategy_opts_string,
+		BUG("could not split '%s': %s", strategy_opts_string,
 			    split_cmdline_strerror(count));
 	opts->xopts_nr = count;
 	for (i = 0; i < opts->xopts_nr; i++) {
@@ -3054,12 +3054,27 @@ static int read_populate_opts(struct replay_opts *opts)
 
 static void write_strategy_opts(struct replay_opts *opts)
 {
-	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (i = 0; i < opts->xopts_nr; ++i)
-		strbuf_addf(&buf, " --%s", opts->xopts[i]);
+	/*
+	 * Quote strategy options so that they can be read correctly
+	 * by split_cmdline().
+	 */
+	for (size_t i = 0; i < opts->xopts_nr; i++) {
+		char *arg = opts->xopts[i];
 
+		if (i)
+			strbuf_addch(&buf, ' ');
+		strbuf_addch(&buf, '"');
+		for (size_t j = 0; arg[j]; j++) {
+			const char c = arg[j];
+
+			if (c == '"' || c =='\\')
+				strbuf_addch(&buf, '\\');
+			strbuf_addch(&buf, c);
+		}
+		strbuf_addch(&buf, '"');
+	}
 	write_file(rebase_path_strategy_opts(), "%s\n", buf.buf);
 	strbuf_release(&buf);
 }
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 130e2f9b55..42c3954125 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -62,29 +62,39 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F2-on-topic-branch &&
 	test_commit "commit-new-file-F3-on-topic-branch" F3 32 &&
-	test_when_finished "rm -fr test-bin funny.was.run" &&
+	test_when_finished "rm -fr test-bin" &&
 	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF &&
-	#!$SHELL_PATH
-	case "\$1" in --opt) ;; *) exit 2 ;; esac
-	shift &&
-	>funny.was.run &&
-	exec git merge-recursive "\$@"
+
+	write_script test-bin/git-merge-funny <<-\EOF &&
+	printf "[%s]\n" $# "$1" "$2" "$3" "$5" >actual
+	shift 3 &&
+	exec git merge-recursive "$@"
 	EOF
-	chmod +x test-bin/git-merge-funny &&
+
+	cat >expect <<-\EOF &&
+	[7]
+	[--option=arg with space]
+	[--op"tion\]
+	[--new
+	line ]
+	[--]
+	EOF
+
+	rm -f actual &&
 	(
 		PATH=./test-bin:$PATH &&
-		test_must_fail git rebase -s funny -Xopt main topic
+		test_must_fail git rebase -s funny -X"option=arg with space" \
+				-Xop\"tion\\ -X"new${LF}line " main topic
 	) &&
-	test -f funny.was.run &&
-	rm funny.was.run &&
+	test_cmp expect actual &&
+	rm actual &&
 	echo "Resolved" >F2 &&
 	git add F2 &&
 	(
 		PATH=./test-bin:$PATH &&
 		git rebase --continue
 	) &&
-	test -f funny.was.run
+	test_cmp expect actual
 '
 
 test_expect_success 'rebase -i --continue handles merge strategy and options' '
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 3adf42f47d..94671d3c46 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -40,30 +40,6 @@ test_expect_success 'setup' '
 	EOF
 '
 
-test_expect_success 'bad -X <strategy-option> arguments: unclosed quote' '
-	test_when_finished "test_might_fail git rebase --abort" &&
-	cat >expect <<-\EOF &&
-	fatal: could not split '\''--bad'\'': unclosed quote
-	EOF
-	GIT_SEQUENCE_EDITOR="echo break >" \
-		git rebase -i -X"bad argument\"" side main &&
-	test_expect_code 128 git rebase --continue >out 2>actual &&
-	test_must_be_empty out &&
-	test_cmp expect actual
-'
-
-test_expect_success 'bad -X <strategy-option> arguments: bad escape' '
-	test_when_finished "test_might_fail git rebase --abort" &&
-	cat >expect <<-\EOF &&
-	fatal: could not split '\''--bad'\'': cmdline ends with \
-	EOF
-	GIT_SEQUENCE_EDITOR="echo break >" \
-		git rebase -i -X"bad escape \\" side main &&
-	test_expect_code 128 git rebase --continue >out 2>actual &&
-	test_must_be_empty out &&
-	test_cmp expect actual
-'
-
 test_expect_success '--ignore-whitespace works with apply backend' '
 	test_must_fail git rebase --apply main side &&
 	git rebase --abort &&
-- 
2.39.2

