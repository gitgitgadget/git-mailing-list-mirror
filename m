Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4283120248
	for <e@80x24.org>; Mon, 25 Mar 2019 20:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfCYUXp (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 16:23:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33557 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730389AbfCYUXo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 16:23:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so11768757wrp.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 13:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D6mjq6dzb+kEIaIxIGULImm0HiZsaS/TGmgFCinqALo=;
        b=WVZsqeODcNSnt8hoHrXrJ/ACHDDV3p7ELwcXmgaKYk8a1MwYFJtjyk7YZo1950ZMVA
         nOUW0Zli501DrHHKylpfLA/lUXxae7lIq8PjfKydna72ChgoeCHcGPP9dO+7GYfKrjWT
         xDv7VF0BvePgIIe1q5m2EtiSMV5vWJ2xoN8wImDNSUNBgq+V/UNNL/8ofYGWB3omoXz8
         9p+CYnfgKcS8HsQ915HyYXjFfLNK8uiMEWP0gbHQs3OKUXenHFloS/7X9K5bdzwPpAvQ
         WUKMT7PcoIMWNa5Wl4qx0J7k/ZDLTPTAFrnYzY7twseM9wuCJdMg17kbH4SReQZaMM4k
         UTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D6mjq6dzb+kEIaIxIGULImm0HiZsaS/TGmgFCinqALo=;
        b=qKojiczt9ArU3VELI6xFccIkKR0bZ0RB0FJOoUp1rPl6KgaXxawDbx46S6sSYzeYfg
         Z8vFGSzkDS6JOxqigVQHaPtEgLS5lW8Zaq8R/skazyQY+NSMIUrwoku0QYElJqRLK+0s
         hspjnzy00dwznbMD6FbF2eLfY6dQdCj5VybXiFSLzIARBhlfnwmLxDhBI3dACw4Yy8P2
         zxhbhF4UuT/pfvNbrr5oqA7BQi3BHDiF72bQew6gd9YhbI/M0hkrcxrbhLjj8ax/10An
         /0ZIV3RrTGg2n+PDazDoFBTWXEPpEzP7+akTrTS1PhA2wK8AEMYQaV3qtIFzz48EHlIb
         ZxyQ==
X-Gm-Message-State: APjAAAVcaJoZNzwaNsORjk5kgytBHl1U2OBdaKc1B+Bpqyr4z/aqp4a2
        XyXGIPTOv6C4fFZl/OUPu0SUvEFOwkQ=
X-Google-Smtp-Source: APXvYqxnzsneWA+V4axLWf2pboCHrvajmL8x9ewW9FBQk5j5LqRIlQeaQr14DBs4NslsaeFFvoTJ1A==
X-Received: by 2002:a5d:6b4a:: with SMTP id x10mr16633850wrw.63.1553545422204;
        Mon, 25 Mar 2019 13:23:42 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q26sm16506904wmc.6.2019.03.25.13.23.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 13:23:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] parse-options: don't emit "ambiguous option" for aliases
Date:   Mon, 25 Mar 2019 21:23:29 +0100
Message-Id: <20190325202329.26033-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com>
References: <pull.167.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the option parsing machinery so that e.g. "clone --recurs ..."
doesn't error out because "clone" understands both "--recursive" and
"--recurse-submodules" to mean the same thing.

Initially "clone" just understood --recursive until the
--recurses-submodules alias was added in ccdd3da652 ("clone: Add the
--recurse-submodules option as alias for --recursive",
2010-11-04). Since bb62e0a99f ("clone: teach --recurse-submodules to
optionally take a pathspec", 2017-03-17) the longer form has been
promoted to the default.

But due to the way the options parsing machinery works this resulted
in the rather absurd situation of:

    $ git clone --recurs [...]
    error: ambiguous option: recurs (could be --recursive or --recurse-submodules)

Let's re-use the PARSE_OPT_NOCOMPLETE flag to mean "this option
doesn't contribute to abbreviation ambiguity". I was going to add a
new PARSE_OPT_NOABBREV flag, but it makes sense just to re-use
PARSE_OPT_NOCOMPLETE.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c          | 4 ++--
 parse-options.c          | 3 ++-
 parse-options.h          | 2 ++
 t/t0040-parse-options.sh | 5 +++++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..4dc26969a7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -100,8 +100,8 @@ static struct option builtin_clone_options[] = {
 		    N_("setup as shared repository")),
 	{ OPTION_CALLBACK, 0, "recursive", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
-	  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, recurse_submodules_cb,
-	  (intptr_t)"." },
+	  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE,
+	  recurse_submodules_cb, (intptr_t)"." },
 	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
 	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
diff --git a/parse-options.c b/parse-options.c
index d6a291f705..84f3a2996f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -294,7 +294,8 @@ static enum parse_opt_result parse_long_opt(
 		if (!rest) {
 			/* abbreviated? */
 			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
-			    !strncmp(long_name, arg, arg_end - arg)) {
+			    !strncmp(long_name, arg, arg_end - arg) &&
+			    !(options->flags & PARSE_OPT_NOCOMPLETE)) {
 is_abbreviated:
 				if (abbrev_option) {
 					/*
diff --git a/parse-options.h b/parse-options.h
index 74cce4e7fc..9362a397ae 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -96,6 +96,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *				Useful for options with multiple parameters.
  *   PARSE_OPT_NOCOMPLETE: by default all visible options are completable
  *			   by git-completion.bash. This option suppresses that.
+ *			   Will also skip this option when abbreviation is
+ *			   considered. See core.abbreviatedOptions.
  *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
  *			 complete an option as --name= not --name even if
  *			 the option takes optional argument.
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 19685d1582..c1ea50aa85 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -236,6 +236,11 @@ test_expect_success 'abbreviated options configured with core.abbreviatedOptions
 	git -c core.abbreviatedOptions=true init --ba C
 '
 
+test_expect_success 'NOCOMPLETE options do not contribute to abbreviation' '
+	test_when_finished "rm -rf A" &&
+	GIT_TEST_ABBREVIATED_OPTIONS=true git clone --recurs . A
+'
+
 cat >typo.err <<\EOF
 error: did you mean `--boolean` (with two dashes ?)
 EOF
-- 
2.21.0.360.g471c308f928

