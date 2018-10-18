Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FE11F453
	for <e@80x24.org>; Thu, 18 Oct 2018 22:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeJSHBD (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 03:01:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55320 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJSHBD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 03:01:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id 206-v6so1829979wmb.5
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 15:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zYxZSuQ3bKI447b/PAX8Fr2+oh2YHC8yclsmce7U+q4=;
        b=WJscdcAMpAD6SgsBFL3X43AuG/0bj65Nay5078uk5K7+FCYclctnxnK08RwPZvhpwn
         7FEYBSAg/1HnvAmjeNfGOQqFbxMe34mBs1qnX7+ExMKDigf2xHtbU2SIwm6N4qFkHGp/
         9UfP+FHcn/YoKwgAR1UihqMePxzL2pY1vhrNZEdcr7utLGWhbpI5xLoFjaPgHQBPwnJA
         7QdhrIkeA/jV3Ah06f1lmIeKT0tdvcVZMX2H9ZWWX16tuzaaf93pBieqyOylPs25szqe
         wscwcDyaKDCjEoBWquZn6idQQHjo4rQa/O7Pd+x2tThPJLGGvZETFAHY7xjjWqMdrk7T
         ZK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zYxZSuQ3bKI447b/PAX8Fr2+oh2YHC8yclsmce7U+q4=;
        b=eiq73pMMVD5ib5sXgGp+X4Jl7wZ/fgluAka4YTSxYx7y+z4SPUhjDkPJ93Suh6PgPx
         z+N39aJrL7G+nEv/pTA8uNuQtc/nlV5wQpnPFi9nuiv+nhlUJvoLSBKzfqYnzZPKkz1l
         nzvgsyo/01o/gFQeKASbrHPBmwT55tnGhrtqi5hNhpsoap5onn6OmY+i6PkMe9GSEr6D
         uhY+3kBEl8IwjXW1Cw85pPxa62dgFflAxhhzWCj22dajiefn/eAhqqqPQxQagZT6l5/R
         wcHSpBmL9I+hJpCNRJWFDYVdg49ArR9miOtFeE6J9TWvOZzAJutU8cWhT1VrDpuv/rK7
         O8PA==
X-Gm-Message-State: ABuFfoi2atU9eSD/HtZLMk7XjkpE+lfEH8uWon6FTdrMlh+zxcfwDk0f
        aSLlGTES0r3IukyAuJ3iY31khdWr
X-Google-Smtp-Source: ACcGV61zfkOYCCApv/G2Ll8D2eev1C+kok1RkcMGrRphFzIpOe7NJcJKzBTgHQ5mHtqYWD8ihYdD2g==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186-v6mr2254876wmf.16.1539903469162;
        Thu, 18 Oct 2018 15:57:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y65-v6sm1306361wmg.40.2018.10.18.15.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 15:57:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Tim Schumacher <timschumi@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] alias: detect loops in mixed execution mode
Date:   Thu, 18 Oct 2018 22:57:39 +0000
Message-Id: <20181018225739.28857-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336
In-Reply-To: <87o9dar9qc.fsf@evledraar.gmail.com>
References: <87o9dar9qc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add detection for aliasing loops in cases where one of the aliases
re-invokes git as a shell command. This catches cases like:

    [alias]
    foo = !git bar
    bar = !git foo

Before this change running "git {foo,bar}" would create a
forkbomb. Now using the aliasing loop detection and call history
reporting added in 82f71d9a5a ("alias: show the call history when an
alias is looping", 2018-09-16) and c6d75bc17a ("alias: add support for
aliases of an alias", 2018-09-16) we'll instead report:

    fatal: alias loop detected: expansion of 'foo' does not terminate:
      foo <==
      bar ==>

Since the implementation carries the call history in an environment
variable, using the same sort of trick as used for -c (see
2b64fc894d ("pass "git -c foo=bar" params through environment",
2010-08-23) ). For example:

    [alias]
    one = two
    two = !git three
    three = four
    four = !git five
    five = two

Will, on "git one" report:

    fatal: alias loop detected: expansion of 'one' does not terminate:
      one
      two <==
      three
      four
      five ==>

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Implements what I suggested in
https://public-inbox.org/git/87o9dar9qc.fsf@evledraar.gmail.com/

 cache.h          |  1 +
 git.c            | 36 ++++++++++++++++++++++++++++++++++--
 t/t0001-init.sh  |  1 +
 t/t0014-alias.sh | 15 ++++++---------
 4 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index d508f3d4f8..00cbd25f1c 100644
--- a/cache.h
+++ b/cache.h
@@ -478,6 +478,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
+#define COMMAND_HISTORY_ENVIRONMENT "GIT_COMMAND_HISTORY"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
diff --git a/git.c b/git.c
index 5920f8019b..cba242836c 100644
--- a/git.c
+++ b/git.c
@@ -672,12 +672,43 @@ static void execv_dashed_external(const char **argv)
 		exit(128);
 }
 
+static void init_cmd_history(struct strbuf *env, struct string_list *cmd_list)
+{
+	const char *old = getenv(COMMAND_HISTORY_ENVIRONMENT);
+	struct strbuf **cmd_history, **ptr;
+
+	if (!old || !*old)
+		return;
+
+	strbuf_addstr(env, old);
+	strbuf_rtrim(env);
+
+	cmd_history = strbuf_split_buf(old, strlen(old), ' ', 0);
+	for (ptr = cmd_history; *ptr; ptr++) {
+		strbuf_rtrim(*ptr);
+		string_list_append(cmd_list, (*ptr)->buf);
+	}
+	strbuf_list_free(cmd_history);
+}
+
+static void add_cmd_history(struct strbuf *env, struct string_list *cmd_list,
+			    const char *cmd)
+{
+	string_list_append(cmd_list, cmd);
+	if (env->len)
+		strbuf_addch(env, ' ');
+	strbuf_addstr(env, cmd);
+	setenv(COMMAND_HISTORY_ENVIRONMENT, env->buf, 1);
+}
+
 static int run_argv(int *argcp, const char ***argv)
 {
 	int done_alias = 0;
-	struct string_list cmd_list = STRING_LIST_INIT_NODUP;
+	struct string_list cmd_list = STRING_LIST_INIT_DUP;
 	struct string_list_item *seen;
+	struct strbuf env = STRBUF_INIT;
 
+	init_cmd_history(&env, &cmd_list);
 	while (1) {
 		/*
 		 * If we tried alias and futzed with our environment,
@@ -711,7 +742,7 @@ static int run_argv(int *argcp, const char ***argv)
 			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
 		}
 
-		string_list_append(&cmd_list, *argv[0]);
+		add_cmd_history(&env, &cmd_list, *argv[0]);
 
 		/*
 		 * It could be an alias -- this works around the insanity
@@ -724,6 +755,7 @@ static int run_argv(int *argcp, const char ***argv)
 	}
 
 	string_list_clear(&cmd_list, 0);
+	strbuf_release(&env);
 
 	return done_alias;
 }
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 182da069f1..eb2ca8a172 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -93,6 +93,7 @@ test_expect_success 'No extra GIT_* on alias scripts' '
 		sed -n \
 			-e "/^GIT_PREFIX=/d" \
 			-e "/^GIT_TEXTDOMAINDIR=/d" \
+			-e "/^GIT_COMMAND_HISTORY=/d" \
 			-e "/^GIT_/s/=.*//p" |
 		sort
 	EOF
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index a070e645d7..9ed03a4a4f 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -27,14 +27,11 @@ test_expect_success 'looping aliases - internal execution' '
 	test_i18ngrep "^fatal: alias loop detected: expansion of" output
 '
 
-# This test is disabled until external loops are fixed, because would block
-# the test suite for a full minute.
-#
-#test_expect_failure 'looping aliases - mixed execution' '
-#	git config alias.loop-mixed-1 loop-mixed-2 &&
-#	git config alias.loop-mixed-2 "!git loop-mixed-1" &&
-#	test_must_fail git loop-mixed-1 2>output &&
-#	test_i18ngrep "^fatal: alias loop detected: expansion of" output
-#'
+test_expect_success 'looping aliases - mixed execution' '
+	git config alias.loop-mixed-1 loop-mixed-2 &&
+	git config alias.loop-mixed-2 "!git loop-mixed-1" &&
+	test_must_fail git loop-mixed-1 2>output &&
+	test_i18ngrep "^fatal: alias loop detected: expansion of" output
+'
 
 test_done
-- 
2.19.1.568.g152ad8e336

