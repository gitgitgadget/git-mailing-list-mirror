Return-Path: <SRS0=2Qsv=4E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7027C7619D
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 21:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBA920857
	for <git@archiver.kernel.org>; Sun, 16 Feb 2020 21:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEtflQDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgBPVjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Feb 2020 16:39:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56055 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgBPVjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Feb 2020 16:39:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so15228070wmj.5
        for <git@vger.kernel.org>; Sun, 16 Feb 2020 13:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KP2ZPrSVAYK5/fznbeEZZCeroqTbF+PoHk4hLWS9wIU=;
        b=KEtflQDHAR9y0lJYnEKaSpJaQtsNeaXKQzOvYP6BkWaf2Qcg2ywNRHU3Td65zcRGb5
         lULC2NEuvYsYdSwXIOW9VcNXkDGIk2j80oBNkLaS23YpPyQxBLpVtOVHG85Wd4thnnHe
         qJTHI30PoXLex1vwVjYw9wEQbRFSfVe+NSpvGZjTf4zEPrWF6Gf8YTY+gWNl2e1dRpS2
         390e8baWR3Xt36iIc+3yYARJL8TvT6xP+rtcXXNk/btCnXDGdVxUJ9g/HGnokwkydhsl
         5zV4yYnPXVkFPpFjTWRiWzmbHVK7RN7qldXK6ubxIbR4FZGqW96aTNi7g5mhW0t/A4qj
         p5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KP2ZPrSVAYK5/fznbeEZZCeroqTbF+PoHk4hLWS9wIU=;
        b=tFLRon4UVH+XOcJU2PlJJfXkebI5WgFzJWbfFtmSRlru2dv0+AA04jSu1gjff3e5R8
         lLxqOlIB26cNGvyzZeGt5Bw5QShnAmly/HY35UXyKvMgSTlGOukoFhTqdD6qQj1W1oUH
         qRmy6ys0MeTFHpn6sCFPH02SQSVQU6m0XCxPnOCqX7UHEbhRsUKITUJmnD5BiRomwv+C
         gtb5nKoDJdUxpj/pxDzA40LqDDNKV0HCXXUoLchVdaJNv0tEh/43/Hg1HjKAmccjfcam
         Cbh4OUfO6stjkILc8vYhOuOAI7V15llDDcJsuaq95tOltui87Zrfc6MlNNFc18kiqccJ
         yaaw==
X-Gm-Message-State: APjAAAW7QmH61H/iXa3pdKy7iWqOvPhou7acvTucdLdW1z6SIRKtY+Z6
        BdoHrtIk3MQRfUrPE5eg98vXPZRG
X-Google-Smtp-Source: APXvYqy6SQDDhQB2zSEGaEsCBnQuZg9qjW+vMMqO5EM7XhoqVL0ql9t4Sl3E1UvyTgMB9i1gOPL1ww==
X-Received: by 2002:a05:600c:1009:: with SMTP id c9mr17545478wmc.162.1581889151364;
        Sun, 16 Feb 2020 13:39:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a26sm17599342wmm.18.2020.02.16.13.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 13:39:10 -0800 (PST)
Message-Id: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
In-Reply-To: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Feb 2020 21:39:07 +0000
Subject: [PATCH v2 0/2] [RFC][Outreachy] advice: refactor advise API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Main changes in V2: 1- Rename advise_ng to advise_if_enabled. 2- Add a new
advise_enabled() helper. 3- Add a list of config variables names to replace
advice_config[] (used by list_config_advices()). 4- Send an enum parameter
to the new advise helpers instead of strings. 5- Extract vadvise() from
advise() and advise_if enabled().


----------------------------------------------------------------------------

The advice API is currently a little bit confusing to call. quoting from
[1]:

When introducing a new advice message, you would

 * come up with advice.frotz configuration variable

 * define and declare advice_frotz global variable that defaults to
   true

 * sprinkle calls like this:

  if (advice_frotz)
    advise(_("helpful message about frotz"));

A new approach was suggested in [1] which this patch is based upon.

A new advise_if_enabled() is introduced to gradually replace advise()
advice_enabled() helper is also introduced to be used by those callers who:

 * Only need to check the visibility without calling advise() (they call
   die() or error() instead for example)
 * Need to carry out some heavy processing to display an advice, in this
   case they'll do: if(advice_enabled(advice_type))  advise("some advice message");
   
   

To introduce a new advice message, the caller needs to:

 * Add a new_advice_type to 'enum advice_type'
 * Come up with a new config variable name and add this name to 
   advice_config_keys[]
 * Call advise_if_enabled(new_advice_type, "advice message to be printed")
 * Or call advice_enabled(new_advice_type) first and then follow is by
   advice("advice message to be printed") as explained earlier.
 * Add the new config variable to Documentation/config/advice.txt

The reason a new list of configuration variables was added to the library is
to be used by the list_config_advices() function instead of advice_config[].
And we should get rid of advice_config[] once we migrate all the callers to
use the new APIs instead of checking the global variables (which we'll get
rid of as well).

In the future, we can investigate generating the documentation from the list
of config variables or vice versa to make introducing a new advice much
easier, but this approach will do it for now.

V2 makes the process of introducing a new advice longer than V1 and almost
as long as the original library, but having the advice library responsible
for checking the message visibility is still an improvement and in my own
opinion the new structure makes better sense and makes the library less
confusing to use.

After this patch the plan is to change the advise() calls to
advise_if_enabled() whenever possible, or at least replace the global
variables checks by advise_enabled() when advise_if_enabled() is not
suitable.

[1] https://public-inbox.org/git/xmqqzhf5cw69.fsf@gitster-ct.c.googlers.com/

Heba Waly (2):
  advice: refactor advise API
  advice: extract vadvise() from advise()

 Makefile               |  1 +
 advice.c               | 89 ++++++++++++++++++++++++++++++++++++++----
 advice.h               | 58 ++++++++++++++++++++++++++-
 builtin/tag.c          |  4 +-
 t/helper/test-advise.c | 16 ++++++++
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  1 +
 t/t0018-advice.sh      | 28 +++++++++++++
 t/t7004-tag.sh         |  1 +
 9 files changed, 188 insertions(+), 11 deletions(-)
 create mode 100644 t/helper/test-advise.c
 create mode 100755 t/t0018-advice.sh


base-commit: c7a62075917b3340f908093f63f1161c44ed1475
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-548%2FHebaWaly%2Fadvice_refactoring-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-548/HebaWaly/advice_refactoring-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/548

Range-diff vs v1:

 1:  0dcab7b4eb3 ! 1:  080d12b5c69 advice: refactor advise API
     @@ -2,15 +2,25 @@
      
          advice: refactor advise API
      
     -    Add a new advise_ng function that can check the visibility of advice
     -    messages before printing.
     +    Currently it's very easy for the advice library's callers to miss
     +    checking the visibility step before printing an advice. Also, it makes
     +    more sense for this step to be handled by the advice library.
      
     -    Currently it's very easy for the callers to miss checking the
     -    visibility step. Also, it makes more sense for this step to be handled
     -    by the advice library.
     +    Add a new advise_if_enabled function that checks the visibility of
     +    advice messages before printing.
      
     -    Also change the advise call in tag library from advise() to advise_ng()
     -    to construct an example of the usage of the new API.
     +    Add a new helper advise_enabled to check the visibility of the advice
     +    if the caller needs to carry out complicated processing based on that
     +    value.
     +
     +    A list of config variables 'advice_config_keys' is added to be used by
     +    list_config_advices() instead of 'advice_config[]' because we'll get
     +    rid of 'advice_config[]' and the global variables once we migrate all
     +    the callers to use the new APIs.
     +
     +    Also change the advise call in tag library from advise() to
     +    advise_if_enabled() to construct an example of the usage of the new
     +    API.
      
          Signed-off-by: Heba Waly <heba.waly@gmail.com>
      
     @@ -45,48 +55,112 @@
       	{ "submoduleAlternateErrorStrategyDie", &advice_submodule_alternate_error_strategy_die },
       
       	/* make this an alias for backward compatibility */
     + 	{ "pushNonFastForward", &advice_push_update_rejected }
     + };
     + 
     ++static const char *advice_config_keys[] = {
     ++	[FETCH_SHOW_FORCED_UPDATES]		 = "fetchShowForcedUpdates",
     ++	[PUSH_UPDATE_REJECTED]			 = "pushUpdateRejected",
     ++	/* make this an alias for backward compatibility */
     ++	[PUSH_UPDATE_REJECTED_ALIAS]		 = "pushNonFastForward",
     ++	
     ++	[PUSH_NON_FF_CURRENT]			 = "pushNonFFCurrent",
     ++	[PUSH_NON_FF_MATCHING]			 = "pushNonFFMatching",
     ++	[PUSH_ALREADY_EXISTS]			 = "pushAlreadyExists",
     ++	[PUSH_FETCH_FIRST]			 = "pushFetchFirst",
     ++	[PUSH_NEEDS_FORCE]			 = "pushNeedsForce",
     ++	[PUSH_UNQUALIFIED_REF_NAME]		 = "pushUnqualifiedRefName",
     ++	[STATUS_HINTS]				 = "statusHints",
     ++	[STATUS_U_OPTION]			 = "statusUoption",
     ++	[STATUS_AHEAD_BEHIND_WARNING]		 = "statusAheadBehindWarning",
     ++	[COMMIT_BEFORE_MERGE]			 = "commitBeforeMerge",
     ++	[RESET_QUIET_WARNING]			 = "resetQuiet",
     ++	[RESOLVE_CONFLICT]			 = "resolveConflict",
     ++	[SEQUENCER_IN_USE]			 = "sequencerInUse",
     ++	[IMPLICIT_IDENTITY]			 = "implicitIdentity",
     ++	[DETACHED_HEAD]				 = "detachedHead",
     ++	[SET_UPSTREAM_FAILURE]			 = "setupStreamFailure",
     ++	[OBJECT_NAME_WARNING]			 = "objectNameWarning",
     ++	[AMWORKDIR]				 = "amWorkDir",
     ++	[RM_HINTS]				 = "rmHints",
     ++	[ADD_EMBEDDED_REPO]			 = "addEmbeddedRepo",
     ++	[IGNORED_HOOK]				 = "ignoredHook",
     ++	[WAITING_FOR_EDITOR] 			 = "waitingForEditor",
     ++	[GRAFT_FILE_DEPRECATED]			 = "graftFileDeprecated",
     ++	[CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]	 = "checkoutAmbiguousRemoteBranchName",
     ++	[NESTED_TAG]				 = "nestedTag",
     ++	[SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie"
     ++};
     ++
     + void advise(const char *advice, ...)
     + {
     + 	struct strbuf buf = STRBUF_INIT;
      @@
       	strbuf_release(&buf);
       }
       
     ++int advice_enabled(enum advice_type type)
     ++{
     ++	int value = 1;
     ++	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
     ++	git_config_get_bool(key, &value);
     ++	return value;
     ++}
     ++
     ++int advice_push_update_rejected_enabled(void)
     ++{
     ++	return advice_enabled(PUSH_UPDATE_REJECTED) ||
     ++	       advice_enabled(PUSH_UPDATE_REJECTED_ALIAS);
     ++	
     ++}
     ++
      +static const char turn_off_instructions[] =
      +N_("\n"
     -+"Turn this message off by running\n"
     -+"\"git config %s false\"");
     ++   "Disable this message with \"git config %s false\"");
      +
     -+void advise_ng(const char *key, const char *advice, ...)
     ++void advise_if_enabled(enum advice_type type, const char *advice, ...)
      +{
     -+	int value = 1;
      +	struct strbuf buf = STRBUF_INIT;
     ++	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
      +	va_list params;
      +	const char *cp, *np;
      +	
     -+	git_config_get_bool(key, &value);
     ++	if(!advice_enabled(type))
     ++		return;
     ++
     ++	va_start(params, advice);
     ++	strbuf_vaddf(&buf, advice, params);
     ++	va_end(params);
     ++
     ++	strbuf_addf(&buf, turn_off_instructions, key);
      +	
     -+	if(value)
     -+	{
     -+		va_start(params, advice);
     -+		strbuf_vaddf(&buf, advice, params);
     -+		va_end(params);
     -+
     -+		strbuf_addf(&buf, turn_off_instructions, key);
     -+		
     -+		for (cp = buf.buf; *cp; cp = np) {
     -+			np = strchrnul(cp, '\n');
     -+			fprintf(stderr,	_("%shint: %.*s%s\n"),
     -+				advise_get_color(ADVICE_COLOR_HINT),
     -+				(int)(np - cp), cp,
     -+				advise_get_color(ADVICE_COLOR_RESET));
     -+			if (*np)
     -+				np++;
     -+		}
     -+		strbuf_release(&buf);
     ++	for (cp = buf.buf; *cp; cp = np) {
     ++		np = strchrnul(cp, '\n');
     ++		fprintf(stderr,	_("%shint: %.*s%s\n"),
     ++			advise_get_color(ADVICE_COLOR_HINT),
     ++			(int)(np - cp), cp,
     ++			advise_get_color(ADVICE_COLOR_RESET));
     ++		if (*np)
     ++			np++;
      +	}
     ++	strbuf_release(&buf);
     ++
      +}
      +
       int git_default_advice_config(const char *var, const char *value)
       {
       	const char *k, *slot_name;
     +@@
     + {
     + 	int i;
     + 
     +-	for (i = 0; i < ARRAY_SIZE(advice_config); i++)
     +-		list_config_item(list, prefix, advice_config[i].name);
     ++	for (i = 0; i < ARRAY_SIZE(advice_config_keys); i++)
     ++		list_config_item(list, prefix, advice_config_keys[i]);
     + }
     + 
     + int error_resolve_conflict(const char *me)
      
       diff --git a/advice.h b/advice.h
       --- a/advice.h
     @@ -98,14 +172,66 @@
      -extern int advice_nested_tag;
       extern int advice_submodule_alternate_error_strategy_die;
       
     ++/**
     ++ To add a new advice, you need to:
     ++ - Define an advice_type.
     ++ - Add a new entry to advice_config_keys list.
     ++ - Add the new config variable to Documentation/config/advice.txt.
     ++ - Call advise_if_enabled to print your advice.
     ++ */
     ++enum advice_type {
     ++	FETCH_SHOW_FORCED_UPDATES = 0,
     ++	PUSH_UPDATE_REJECTED = 1,
     ++	PUSH_UPDATE_REJECTED_ALIAS = 2,
     ++	PUSH_NON_FF_CURRENT = 3,
     ++	PUSH_NON_FF_MATCHING = 4,
     ++	PUSH_ALREADY_EXISTS = 5,
     ++	PUSH_FETCH_FIRST = 6,
     ++	PUSH_NEEDS_FORCE = 7,
     ++	PUSH_UNQUALIFIED_REF_NAME = 8,
     ++	STATUS_HINTS = 9,
     ++	STATUS_U_OPTION = 10,
     ++	STATUS_AHEAD_BEHIND_WARNING = 11,
     ++	COMMIT_BEFORE_MERGE = 12,
     ++	RESET_QUIET_WARNING = 13,
     ++	RESOLVE_CONFLICT = 14,
     ++	SEQUENCER_IN_USE = 15,
     ++	IMPLICIT_IDENTITY = 16,
     ++	DETACHED_HEAD = 17,
     ++	SET_UPSTREAM_FAILURE = 18,
     ++	OBJECT_NAME_WARNING = 19,
     ++	AMWORKDIR = 20,
     ++	RM_HINTS = 21,
     ++	ADD_EMBEDDED_REPO = 22,
     ++	IGNORED_HOOK = 23,
     ++	WAITING_FOR_EDITOR = 24,
     ++	GRAFT_FILE_DEPRECATED = 25,
     ++	CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME = 26,
     ++	NESTED_TAG = 27,
     ++	SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE = 28,
     ++};
     ++
     ++
       int git_default_advice_config(const char *var, const char *value);
       __attribute__((format (printf, 1, 2)))
       void advise(const char *advice, ...);
      +
      +/**
     ++ Checks if advice type is enabled (can be printed to the user).
     ++ Should be called before advise().
     ++ */
     ++int advice_enabled(enum advice_type type);
     ++
     ++/**
     ++ Checks if PUSH_UPDATE_REJECTED advice type is enabled.
     ++ */
     ++int advice_push_update_rejected_enabled(void);
     ++
     ++/**
      + Checks the visibility of the advice before priniting.
      + */
     -+void advise_ng(const char *key, const char *advice, ...);
     ++void advise_if_enabled(enum advice_type type, const char *advice, ...);
     ++
       int error_resolve_conflict(const char *me);
       void NORETURN die_resolve_conflict(const char *me);
       void NORETURN die_conclude_merge(void);
     @@ -120,7 +246,7 @@
      -	if (type == OBJ_TAG && advice_nested_tag)
      -		advise(_(message_advice_nested_tag), tag, object_ref);
      +	if (type == OBJ_TAG)
     -+		advise_ng("advice.nestedTag", _(message_advice_nested_tag), tag, object_ref);
     ++		advise_if_enabled(NESTED_TAG, _(message_advice_nested_tag), tag, object_ref);
       
       	strbuf_addf(&header,
       		    "object %s\n"
     @@ -134,14 +260,15 @@
      +#include "cache.h"
      +#include "advice.h"
      +
     -+int cmd__advise_ng(int argc, const char **argv)
     ++int cmd__advise_if_enabled(int argc, const char **argv)
      +{
     -+	if (!argv[1] || !argv[2])
     -+	die("usage: %s <key> <advice>", argv[0]);
     ++	if (!argv[1])
     ++	die("usage: %s <advice>", argv[0]);
      +
      +	setup_git_directory();
     -+
     -+	advise_ng(argv[1], argv[2]);
     ++	
     ++	//use any advice type for testing
     ++	advise_if_enabled(NESTED_TAG, argv[1]);
      +
      +	return 0;
      +}
     @@ -153,7 +280,7 @@
       };
       
       static struct test_cmd cmds[] = {
     -+	{ "advise", cmd__advise_ng },
     ++	{ "advise", cmd__advise_if_enabled },
       	{ "chmtime", cmd__chmtime },
       	{ "config", cmd__config },
       	{ "ctype", cmd__ctype },
     @@ -165,7 +292,7 @@
       #define USE_THE_INDEX_COMPATIBILITY_MACROS
       #include "git-compat-util.h"
       
     -+int cmd__advise_ng(int argc, const char **argv);
     ++int cmd__advise_if_enabled(int argc, const char **argv);
       int cmd__chmtime(int argc, const char **argv);
       int cmd__config(int argc, const char **argv);
       int cmd__ctype(int argc, const char **argv);
     @@ -177,29 +304,28 @@
      @@
      +#!/bin/sh
      +
     -+test_description='Test advise_ng functionality'
     ++test_description='Test advise_if_enabled functionality'
      +
      +. ./test-lib.sh
      +
      +cat > expected <<EOF
      +hint: This is a piece of advice
     -+hint: Turn this message off by running
     -+hint: "git config advice.configVariable false"
     ++hint: Disable this message with "git config advice.nestedTag false"
      +EOF
      +test_expect_success 'advise should be printed when config variable is unset' '
     -+	test-tool advise "advice.configVariable" "This is a piece of advice" 2>actual &&
     ++	test-tool advise "This is a piece of advice" 2>actual &&
      +	test_i18ncmp expected actual
      +'
      +
      +test_expect_success 'advise should be printed when config variable is set to true' '
     -+	test_config advice.configVariable true &&
     -+	test-tool advise "advice.configVariable" "This is a piece of advice" 2>actual &&
     ++	test_config advice.nestedTag true &&
     ++	test-tool advise "This is a piece of advice" 2>actual &&
      +	test_i18ncmp expected actual
      +'
      +
      +test_expect_success 'advise should not be printed when config variable is set to false' '
     -+	test_config advice.configVariable false &&
     -+	test-tool advise "advice.configVariable" "This is a piece of advice" 2>actual &&
     ++	test_config advice.nestedTag false &&
     ++	test-tool advise "This is a piece of advice" 2>actual &&
      +	test_must_be_empty actual
      +'
      +
     @@ -212,8 +338,7 @@
       	hint: already a tag. If you meant to tag the object that it points to, use:
       	hint: |
       	hint: 	git tag -f nested annotated-v4.0^{}
     -+	hint: Turn this message off by running
     -+	hint: "git config advice.nestedTag false"
     ++	hint: Disable this message with "git config advice.nestedTag false"
       	EOF
       	git tag -m nested nested annotated-v4.0 2>actual &&
       	test_i18ncmp expect actual
 -:  ----------- > 2:  3e4f52e5526 advice: extract vadvise() from advise()

-- 
gitgitgadget
