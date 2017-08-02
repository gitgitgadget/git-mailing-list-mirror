Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B2E20899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdHBTlZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:41:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34908 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752118AbdHBTlX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:41:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id c24so91454wra.2
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZeayTbf1p1ArbLfvbjH4aoQfTSXK5ZodzvLIf30x5U=;
        b=RB7fl+yc3unQ4iqaCBvVjlK81p60uBlhdNTSsKFdVqJ5sVU0u2iRilXJRdiEr1/X9N
         J5nvQPj6HWJlm0ap1TOBv07lKAOGEqiNl2Qj5ABe7+UVuyF2VgxCoIIziVguUjvEbF2W
         Wpmtn/aqVs/G3nw+uJ1pd9QidQ2cMwzrGhAgaqbg8i2H/lq7RRtQHSzUJfFXAV373TIq
         AF+g5gWrj0TFcqLKcx4vOTVvfYbFmWFefbLiXsNemU5rCikqM3b51TYxv924md/JjJis
         aJmg6eADl9kMU3S5oH/OYU4S0jaxqyi/2dr4qahwlxG8BAmUNvxkUdWICpJKpRBuyiKp
         G9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZeayTbf1p1ArbLfvbjH4aoQfTSXK5ZodzvLIf30x5U=;
        b=QdSIX9nr76O94GmhJcLp7evUxj9otsFEt150WmotiMrEz4BtPq0YdDltszzdUG9cwV
         J4OpDcMfdmS1djf6yQgdxLUN2FtaD8+WUATFFfsIXJpLsORbh00kK+67WWwywo2/9VlK
         E7NbHoX3GdM80JxeUog1vstKdEDCMzk2hr5+nXfukeiQ8xPNhaT6EJGMIRxY9RZINYuE
         31yeRptq7zMdMsC/MIuiEUCVLnwVDSGKfsYRqrs4R7kU1mcpCtiMMXElWbfhEyUpa5KA
         h0BvyB4U7ej1YZlSUCD+4pSyyLQ5CJtGzP5b7nSBLQ12lj/snnsDKR+kar1OR6SuAgny
         44wQ==
X-Gm-Message-State: AIVw111I3j28r8KM4LQG2964YD02N2jrFucRZhuY1BexxtK0toyNarnJ
        f9tHXTLlpLqSRxrA
X-Received: by 10.223.148.103 with SMTP id 94mr19550082wrq.174.1501702882105;
        Wed, 02 Aug 2017 12:41:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id t13sm103576wra.22.2017.08.02.12.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 12:41:21 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 5/7] tag: respect `pager.tag` in list-mode only
Date:   Wed,  2 Aug 2017 21:40:53 +0200
Message-Id: <c6763c7bc1c02be905c54ed64096ab494cf060c6.1501701128.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc1.12.ge2d9c4613
In-Reply-To: <cover.1501701128.git.martin.agren@gmail.com>
References: <cover.1500321657.git.martin.agren@gmail.com> <cover.1501701128.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using, e.g., `git -c pager.tag tag -a new-tag` results in errors such as
"Vim: Warning: Output is not to a terminal" and a garbled terminal.
Someone who makes use of both `git tag -a` and `git tag -l` will
probably not set `pager.tag`, so that `git tag -a` will actually work,
at the cost of not paging output of `git tag -l`.

Use the mechanisms introduced in two earlier patches to ignore
`pager.tag` in git.c and let the `git tag` builtin handle it on its own.
Only respect `pager.tag` when running in list-mode.

There is a window between where the pager is started before and after
this patch. This means that early errors can behave slightly different
before and after this patch. Since operation-parsing has to happen
inside this window, this can be seen with `git -c pager.tag="echo pager
is used" tag -l --unknown-option`. This change in paging-behavior should
be acceptable since it only affects erroneous usages.

Update the documentation and update tests.

If an alias is used to run `git tag -a`, then `pager.tag` will still be
respected. Document this known breakage. It will be fixed in a later
commit. Add a similar test for `-l`, which works.

Noticed-by: Anatoly Borodin <anatoly.borodin@gmail.com>
Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-tag.txt |  3 +++
 t/t7006-pager.sh          | 15 ++++++++++++++-
 builtin/tag.c             |  3 +++
 git.c                     |  2 +-
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 1eb15afa1..875d135e0 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -205,6 +205,9 @@ it in the repository configuration as follows:
     signingKey = <gpg-keyid>
 -------------------------------------
 
+`pager.tag` is only respected when listing tags, i.e., when `-l` is
+used or implied.
+See linkgit:git-config[1].
 
 DISCUSSION
 ----------
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index b56d4cdd4..570b2f252 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -187,7 +187,7 @@ test_expect_success TTY 'git tag -a defaults to not paging' '
 	! test -e paginated.out
 '
 
-test_expect_failure TTY 'git tag -a ignores pager.tag' '
+test_expect_success TTY 'git tag -a ignores pager.tag' '
 	test_when_finished "git tag -d newtag" &&
 	rm -f paginated.out &&
 	test_terminal git -c pager.tag tag -am message newtag &&
@@ -201,6 +201,19 @@ test_expect_success TTY 'git tag -a respects --paginate' '
 	test -e paginated.out
 '
 
+test_expect_failure TTY 'git tag as alias ignores pager.tag with -a' '
+	test_when_finished "git tag -d newtag" &&
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag -c alias.t=tag t -am message newtag &&
+	! test -e paginated.out
+'
+
+test_expect_success TTY 'git tag as alias respects pager.tag with -l' '
+	rm -f paginated.out &&
+	test_terminal git -c pager.tag -c alias.t=tag t -l &&
+	test -e paginated.out
+'
+
 # A colored commit log will begin with an appropriate ANSI escape
 # for the first color; the text "commit" comes later.
 colorful() {
diff --git a/builtin/tag.c b/builtin/tag.c
index 01154ea8d..5ad1af252 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -461,6 +461,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			cmdmode = 'l';
 	}
 
+	if (cmdmode == 'l')
+		setup_auto_pager("tag", 0);
+
 	if ((create_tag_object || force) && (cmdmode != 0))
 		usage_with_options(git_tag_usage, options);
 
diff --git a/git.c b/git.c
index 66832f232..82ac2a092 100644
--- a/git.c
+++ b/git.c
@@ -466,7 +466,7 @@ static struct cmd_struct commands[] = {
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
-	{ "tag", cmd_tag, RUN_SETUP },
+	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP },
 	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP },
 	{ "update-index", cmd_update_index, RUN_SETUP },
-- 
2.14.0.rc1.12.ge2d9c4613

