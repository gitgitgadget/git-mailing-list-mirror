Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4131C56201
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73BE820866
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 21:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HgG04ICq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbgKXVnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 16:43:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52440 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733175AbgKXVnY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 16:43:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 815E6F2C1E;
        Tue, 24 Nov 2020 16:43:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vPvmYOwvn4nP1KbafazBxeqbtLo=; b=HgG04I
        CqPf6bIBsEyk0nYwjH4lhePu+uAInqviXkVNEE3LhPRkz3ktlnkCf42ciVpHfAo6
        Iha2t4F3kp0juvv/91Zv5VhQhQTbPOB0FbKxNkDcneqcwvIHhTpL5yJY/Nz8piN2
        pAf2rB0FbycQsTEtCPT6hYS9vMQJoP6lLSVU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tWZn0ocbmL6QGrTisMSCSOWJIvULfrTw
        RUeRwb/gFAPv3FGWWWhU8XD7qUxiWFtVzuWX8HshpVfHg07JDBU0MTtaBMe7cBxB
        tYgfiNg1Y33ea0SJMWXHyzPdRax7Zm/FqYjoEeU8Wc0pL2xPYTUOwVtAsyM69eLd
        eEMb1vrulxU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 791DDF2C1D;
        Tue, 24 Nov 2020 16:43:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B2D05F2C1C;
        Tue, 24 Nov 2020 16:43:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org, lanodan <contact+git@hacktivis.me>
Subject: Re: [PATCH v5] help.c: expand options for help.autocorrect
References: <20201124163752.20306-1-sir@cmpwn.com>
Date:   Tue, 24 Nov 2020 13:43:14 -0800
In-Reply-To: <20201124163752.20306-1-sir@cmpwn.com> (Drew DeVault's message of
        "Tue, 24 Nov 2020 11:37:52 -0500")
Message-ID: <xmqqmtz6ig7h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F1203AE-2E9E-11EB-AE4E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> writes:

> While help.autocorrect can be set to 0 to decline auto-execution of
> possibly mistyped commands, it still spends cycles to compute the
> suggestions, and it wastes screen real estate.
>
> Update help.autocorrect to accept the string "never" to just exit
> with error upon mistyped commands to help users who prefer to never
> see suggested corrections at all.
>
> While at it, introduce "immediate" as a more readable way to
> immediately execute the auto-corrected command, which can be done
> with negative value.
>
> Signed-off-by: Drew DeVault <sir@cmpwn.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> v5 incorporates Junio's suggested commit message and test.

Hmph,...

> +	If git detects typos and can identify exactly one valid command similar
> +	to the error, git will automatically run the intended command after
> +	waiting a duration of time defined by this configuration value in
> +	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
> +	will be shown, but not executed. If "immediate", the suggested command
> +	is run immediately. If "never", suggestions are not shown at all. The
> +	default value is zero.
> ++
> +Negative integers are interpreted as "immediately" for historical reasons.

I do not think we should place too much stress on things that are
there for "historical reasons"---they do not deserve their own
paragraph.  That is why the version I queued with tweak said:

	...  If this value is 0, the suggested corrections will be
	shown, but not executed. If it is a negative integer, or
	"immediate", the suggested command is run immediately. If
	"never", suggestions are not shown at all. The default value
	is zero.

> +test_expect_success 'autocorrect can be declined altogether' '
> +	git config help.autocorrect never &&
> +
> +	test_must_fail git lfg 2>actual &&
> +	if test_have_prereq C_LOCALE_OUTPUT
> +	then
> +		: cannot test with poisoned i18n
> +	else
> +		grep "is not a git command" actual &&
> +		test_line_count = 1 actual
> +	fi
> +'

This test for 'never' is good.  We'd probably want to also add a
test for immediate.

Taking them together, perhaps like the attached patch.

Thanks.


--- >8 ------ >8 ------ >8 ------ >8 ------ >8 ------ >8 ------
From 59c61bb206242f750a3b63d9b5e16f4e1cf343e7 Mon Sep 17 00:00:00 2001
From: Drew DeVault <sir@cmpwn.com>
Date: Tue, 24 Nov 2020 11:37:52 -0500
Subject: [PATCH] help.c: help.autocorrect=never means "do not even compute
 suggestions"

While help.autocorrect can be set to 0 to decline auto-execution of
possibly mistyped commands, it still spends cycles to compute the
suggestions, and it wastes screen real estate.

Update help.autocorrect to accept the string "never" to just exit
with error upon mistyped commands to help users who prefer to never
see suggested corrections at all.

While at it, introduce "immediate" as a more readable way to
immediately execute the auto-corrected command, which can be done
with negative value.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Range-diff:
1:  4ea4744d46 ! 1:  59c61bb206 help.c: expand options for help.autocorrect
    @@ Metadata
     Author: Drew DeVault <sir@cmpwn.com>
     
      ## Commit message ##
    -    help.c: expand options for help.autocorrect
    +    help.c: help.autocorrect=never means "do not even compute suggestions"
     
         While help.autocorrect can be set to 0 to decline auto-execution of
         possibly mistyped commands, it still spends cycles to compute the
    @@ Documentation/config/help.txt: help.format::
     +	to the error, git will automatically run the intended command after
     +	waiting a duration of time defined by this configuration value in
     +	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
    -+	will be shown, but not executed. If "immediate", the suggested command
    ++	will be shown, but not executed. If it is a negative integer, or
    ++	"immediate", the suggested command
     +	is run immediately. If "never", suggestions are not shown at all. The
     +	default value is zero.
    -++
    -+Negative integers are interpreted as "immediately" for historical reasons.
      
      help.htmlPath::
      	Specify the path where the HTML documentation resides. File system paths
    @@ help.c: const char *help_unknown_cmd(const char *cmd)
      				     "you meant '%s'."),
     
      ## t/t9003-help-autocorrect.sh ##
    -@@ t/t9003-help-autocorrect.sh: test_expect_success 'autocorrect running commands' '
    - 	test_cmp expect actual
    +@@ t/t9003-help-autocorrect.sh: test_expect_success 'autocorrect showing candidates' '
    + 	grep "^	distimdistim" actual
      '
      
    +-test_expect_success 'autocorrect running commands' '
    +-	git config help.autocorrect -1 &&
    ++for immediate in -1 immediate
    ++do
    ++	test_expect_success 'autocorrect running commands' '
    ++		git config help.autocorrect $immediate &&
    + 
    +-	git lfg >actual &&
    +-	echo "a single log entry" >expect &&
    +-	test_cmp expect actual &&
    ++		git lfg >actual &&
    ++		echo "a single log entry" >expect &&
    ++		test_cmp expect actual &&
    + 
    +-	git distimdist >actual &&
    +-	echo "distimdistim was called" >expect &&
    +-	test_cmp expect actual
    ++		git distimdist >actual &&
    ++		echo "distimdistim was called" >expect &&
    ++		test_cmp expect actual
    ++	'
    ++done
    ++
     +test_expect_success 'autocorrect can be declined altogether' '
     +	git config help.autocorrect never &&
     +
    @@ t/t9003-help-autocorrect.sh: test_expect_success 'autocorrect running commands'
     +		grep "is not a git command" actual &&
     +		test_line_count = 1 actual
     +	fi
    -+'
    -+
    + '
    + 
      test_done

 Documentation/config/help.txt | 15 ++++++++-------
 help.c                        | 25 ++++++++++++++++++++++---
 t/t9003-help-autocorrect.sh   | 32 ++++++++++++++++++++++++--------
 3 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 224bbf5a28..783a90a0f9 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -8,13 +8,14 @@ help.format::
 	the default. 'web' and 'html' are the same.
 
 help.autoCorrect::
-	Automatically correct and execute mistyped commands after
-	waiting for the given number of deciseconds (0.1 sec). If more
-	than one command can be deduced from the entered text, nothing
-	will be executed.  If the value of this option is negative,
-	the corrected command will be executed immediately. If the
-	value is 0 - the command will be just shown but not executed.
-	This is the default.
+	If git detects typos and can identify exactly one valid command similar
+	to the error, git will automatically run the intended command after
+	waiting a duration of time defined by this configuration value in
+	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
+	will be shown, but not executed. If it is a negative integer, or
+	"immediate", the suggested command
+	is run immediately. If "never", suggestions are not shown at all. The
+	default value is zero.
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 919cbb9206..3c3bdec213 100644
--- a/help.c
+++ b/help.c
@@ -472,12 +472,26 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 static int autocorrect;
 static struct cmdnames aliases;
 
+#define AUTOCORRECT_NEVER (-2)
+#define AUTOCORRECT_IMMEDIATELY (-1)
+
 static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 {
 	const char *p;
 
-	if (!strcmp(var, "help.autocorrect"))
-		autocorrect = git_config_int(var,value);
+	if (!strcmp(var, "help.autocorrect")) {
+		if (!value)
+			return config_error_nonbool(var);
+		if (!strcmp(value, "never")) {
+			autocorrect = AUTOCORRECT_NEVER;
+		} else if (!strcmp(value, "immediate")) {
+			autocorrect = AUTOCORRECT_IMMEDIATELY;
+		} else {
+			int v = git_config_int(var, value);
+			autocorrect = (v < 0)
+				? AUTOCORRECT_IMMEDIATELY : v;
+		}
+	}
 	/* Also use aliases for command lookup */
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&aliases, p, strlen(p));
@@ -525,6 +539,11 @@ const char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(git_unknown_cmd_config, NULL);
 
+	if (autocorrect == AUTOCORRECT_NEVER) {
+		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
+		exit(1);
+	}
+
 	load_command_list("git-", &main_cmds, &other_cmds);
 
 	add_cmd_list(&main_cmds, &aliases);
@@ -594,7 +613,7 @@ const char *help_unknown_cmd(const char *cmd)
 			   _("WARNING: You called a Git command named '%s', "
 			     "which does not exist."),
 			   cmd);
-		if (autocorrect < 0)
+		if (autocorrect == AUTOCORRECT_IMMEDIATELY)
 			fprintf_ln(stderr,
 				   _("Continuing under the assumption that "
 				     "you meant '%s'."),
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index b1c7919c4a..a1b180338f 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -37,16 +37,32 @@ test_expect_success 'autocorrect showing candidates' '
 	grep "^	distimdistim" actual
 '
 
-test_expect_success 'autocorrect running commands' '
-	git config help.autocorrect -1 &&
+for immediate in -1 immediate
+do
+	test_expect_success 'autocorrect running commands' '
+		git config help.autocorrect $immediate &&
 
-	git lfg >actual &&
-	echo "a single log entry" >expect &&
-	test_cmp expect actual &&
+		git lfg >actual &&
+		echo "a single log entry" >expect &&
+		test_cmp expect actual &&
 
-	git distimdist >actual &&
-	echo "distimdistim was called" >expect &&
-	test_cmp expect actual
+		git distimdist >actual &&
+		echo "distimdistim was called" >expect &&
+		test_cmp expect actual
+	'
+done
+
+test_expect_success 'autocorrect can be declined altogether' '
+	git config help.autocorrect never &&
+
+	test_must_fail git lfg 2>actual &&
+	if test_have_prereq C_LOCALE_OUTPUT
+	then
+		: cannot test with poisoned i18n
+	else
+		grep "is not a git command" actual &&
+		test_line_count = 1 actual
+	fi
 '
 
 test_done
-- 
2.29.2-520-gf7cd35e8a7

