Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C6BC433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6CC60295
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhIJPj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhIJPj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:39:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C87C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so3198324wrh.10
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ZR+nOB9qttwxb+6zQfXMfVZ2f74wqGSBBZAnrE3NvA=;
        b=a87qxCxL7L+R1l6Rp4YVtF4f3Lwb9R1wXs3tH99dnb4uCsZOrleEkoBuLDZ91EIVQ+
         whD3M49CA9gMncUdwBEUQxR92SkxM/Yh5kkqrAf0pfTTkXCgTVFIAZ+8hmLo+7XyKQIO
         WZ1+OIUlLCAsJOIM6FAqVJCky1M73wEwrGuKmE+pm91sxcSkG1i+MP1pn5n+Lb44NQOl
         NsgRpePgq0qG8EGPtbVxAxVrpWqKUdXQnQ7EsLHZ+CORTbbsgJF/emN0uc3O89ccSrhb
         R0IipqYzfXj5P+mAXofJoo1prYCSLIYa8Pq4I/UAw7nQR+eO+ISPpAAT+AWYQYP8IA29
         kOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ZR+nOB9qttwxb+6zQfXMfVZ2f74wqGSBBZAnrE3NvA=;
        b=3gVjyfgO6WdRgf22G+DdKxM/jcK0ArRx7pg/GsVCPw17PioSfqmhJ/U01ZrqkUU+IK
         csnUFQTIhf1e6PXr3eGeCUScapg78sxvcAJBlEm5ZKXIURrXxvAzljMT8qeOIjgcELVT
         eDPtQxrWHUyPRDqp1KyfvPEqNDMoOeO/LiWslEN/HVm6VmnqJXKcF/7xHaZ+zWEUS6Zx
         mTJXPSvQVhEBGlxOB9+sqOSW9fFaLFq2OfQmZ70sPn6qRnQAFa5EsP1WuNgSIWBZwdX1
         vI62itLMj2cBJjpEfWDO9joNpaR23YCjdrKkIKGgi1mUaUDZTkCKq8fSYaYqeyCf7vnE
         Ct2g==
X-Gm-Message-State: AOAM530Dwv79mp2jNFIHNMmLmw1zHQvFfQVr1K8E/oYfPNiIlmVeXCvY
        ioKeBwM8GsiKJNqsbcsNIWtiDVsobVxQDQ==
X-Google-Smtp-Source: ABdhPJz9bX3NIjuSacP7+HgM53dnyGGNS/UMHTUW/+HhvimyS3yPfC41+XopV/C6Mrq4QNzR6TGCEw==
X-Received: by 2002:adf:ce0c:: with SMTP id p12mr983617wrn.194.1631288324226;
        Fri, 10 Sep 2021 08:38:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i5sm4181972wmq.17.2021.09.10.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 08:38:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] parse-options: properly align continued usage output & related
Date:   Fri, 10 Sep 2021 17:38:30 +0200
Message-Id: <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.876.g423ac861752
In-Reply-To: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes usage_with_options_internal() in parse-options.c
to properly align continued "\n" usage output.

This v2 now also gets rid of the support for "" in the usage string
array. Eric Sunshine had ideas[1] for how to simplify the code in v1,
along with a suggestion that we could just get rid of the "" from
"builtin/blame.c".

I'd done some experiments with that before submitting v1, but decided
to try to submit something simpler to begin with. But let's just grow
this in scope a bit and do that, as shown here we also need to do the
same in builtin/credential-cache*.c.

This gives us a much nicer end-state, and as an added bonus
effectively brings back the check removed with the removal of
USE_PARENS_AROUND_GETTEXT_N in in-flight ]2], which is what brought
this alignment issue & edge cases in parse_options() usage to my
attention in the first place.

1. https://lore.kernel.org/git/f8560b11-ba56-0a52-8bb4-5b71f0657764@sunshineco.com/
2. https://lore.kernel.org/git/878s0gwmvq.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (6):
  test-lib.sh: add a UNIX_SOCKETS prerequisite
  git.c: add a NEED_UNIX_SOCKETS option for built-ins
  parse-options: stop supporting "" in the usagestr array
  built-ins: "properly" align continued usage output
  send-pack: properly use parse_options() API for usage string
  parse-options: properly align continued usage output

 Documentation/git-send-pack.txt    |  4 +-
 builtin.h                          |  6 +++
 builtin/blame.c                    |  9 ++--
 builtin/credential-cache--daemon.c | 11 +----
 builtin/credential-cache.c         | 11 +----
 builtin/ls-remote.c                |  4 +-
 builtin/rev-parse.c                |  3 ++
 builtin/send-pack.c                |  8 ++--
 builtin/show-branch.c              |  6 +--
 builtin/stash.c                    |  2 +-
 builtin/tag.c                      |  4 +-
 git.c                              | 15 +++++--
 parse-options.c                    | 71 +++++++++++++++++++++++++-----
 t/helper/test-parse-options.c      |  2 -
 t/t0012-help.sh                    | 10 +++++
 t/t0040-parse-options.sh           |  2 -
 t/t0301-credential-cache.sh        |  5 ++-
 t/t1502-rev-parse-parseopt.sh      | 34 +++++++-------
 t/test-lib.sh                      |  1 +
 19 files changed, 131 insertions(+), 77 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  9e8facb6f8c test-lib.sh: add a UNIX_SOCKETS prerequisite
-:  ----------- > 2:  d6c44402715 git.c: add a NEED_UNIX_SOCKETS option for built-ins
-:  ----------- > 3:  11f4a119563 parse-options: stop supporting "" in the usagestr array
1:  ccc024c414f ! 4:  4547cc968b1 built-ins: "properly" align continued usage output
    @@ Commit message
         output.
     
         But two wrongs don't make a right, let's "fix" this by making it worse
    -    temporarily, in anticipating of improving parse-options.c to handle
    +    temporarily, in anticipation of improving parse-options.c to handle
         this alignment.
     
         The issue is that we should have whitespace corresponding to the
    @@ builtin/stash.c: static const char * const git_stash_push_usage[] = {
      
     
      ## builtin/tag.c ##
    -@@ builtin/tag.c: static const char * const git_tag_usage[] = {
    - 		"\t\t<tagname> [<head>]"),
    +@@
    + 
    + static const char * const git_tag_usage[] = {
    + 	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>]\n"
    +-		"\t\t<tagname> [<head>]"),
    ++	   "        <tagname> [<head>]"),
      	N_("git tag -d <tagname>..."),
      	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
     -		"\t\t[--format=<format>] [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
-:  ----------- > 5:  b884b361ace send-pack: properly use parse_options() API for usage string
2:  ab4bb70902b ! 6:  e83d66da6d4 parse-options: properly align continued usage output
    @@ Commit message
     
                 N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
                    "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
    +               [...]
     
         We'd like to have that output aligned with the length of the initial
         "git stash " output, but since usage_with_options_internal() adds its
    @@ Commit message
                              [-u|--include-untracked] [-a|--all] [-m|--message <message>]
                              [...]
     
    -    In making this change we can can fold the two for-loops over *usagestr
    -    into one. We had two of them purely to account for the case where an
    -    empty string in the array delimits the usage output from free-form
    -    text output.
    +    We could also go for an approach where we have the caller support no
    +    padding of their own, i.e. (same as the first example, except for the
    +    padding on the second line):
    +
    +            N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
    +               "[-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
    +               [...]
    +
    +    But to do that we'll need to find the length of "git stash". We can
    +    discover that from the "cmd" in the "struct cmd_struct", but there
    +    might cases with sub-commands or "git" itself taking arguments that
    +    would make that non-trivial.
    +
    +    Even if it was I still think this approach is better, because this way
    +    we'll get the same legible alignment in the C code. The fact that
    +    usage_with_options_internal() is adding its own prefix padding is an
    +    implementation detail that callers shouldn't need to worry about.
    +
    +    Implementation notes:
     
         We could skip the string_list_split() with a strchr(str, '\n') check,
         but we'd then need to duplicate our state machine for strings that do
    @@ Commit message
         automatically, 2007-10-15) which isn't RTL-safe, but that code would
         be easy to fix. Let's not introduce new RTL translation problems here.
     
    +    I'm also adding a check to catch the mistake of needlessly adding a
    +    trailing "\n", such as:
    +
    +            N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
    +               "          [-u|--include-untracked] [-a|--all] [<message>]\n"),
    +
    +    Or even a mistake like adding just one "\n" in a string with no other
    +    newlines:
    +
    +            N_("git stash list [<options>]\n"),
    +
    +    This catches the cases already tested for in cmd_parseopt(), but this
    +    covers the purely C API. As noted a preceding commit that added the
    +    die() to cmd_parseopt() I'm fairly confident that this will be
    +    triggered by no in-tree user I've missed.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## parse-options.c ##
    @@ parse-options.c: static int usage_with_options_internal(struct parse_opt_ctx_t *
      
     +	const char *usage_prefix = _("usage: %s");
     +	/*
    ++	 * The translation could be anything, but we can count on
    ++	 * msgfmt(1)'s --check option to have asserted that "%s" is in
    ++	 * the translation. So compute the length of the "usage: "
    ++	 * part. We are assuming that the translator wasn't overly
    ++	 * clever and used e.g. "%1$s" instead of "%s", there's only
    ++	 * one "%s" in "usage_prefix" above, so there's no reason to
    ++	 * do so even with a RTL language.
    ++	 */
    ++	size_t usage_len = strlen(usage_prefix) - strlen("%s");
    ++	/*
     +	 * TRANSLATORS: the colon here should align with the
     +	 * one in "usage: %s" translation.
     +	 */
     +	const char *or_prefix = _("   or: %s");
    ++
     +	/*
     +	 * TRANSLATORS: You should only need to translate this format
     +	 * string if your language is a RTL language (e.g. Arabic,
    @@ parse-options.c: static int usage_with_options_internal(struct parse_opt_ctx_t *
     +	 * Russian, Chinese etc.).
     +	 *
     +	 * When a translated usage string has an embedded "\n" it's
    -+	 * because options have wrapped o the next line. The line
    ++	 * because options have wrapped to the next line. The line
     +	 * after the "\n" will then be padded to align with the
     +	 * command name, such as N_("git cmd [opt]\n<8
     +	 * spaces>[opt2]"), where the 8 spaces are the same length as
    @@ parse-options.c: static int usage_with_options_internal(struct parse_opt_ctx_t *
     +	 * This format string prints out that already-translated
     +	 * line. The "%*s" is whitespace padding to account for the
     +	 * padding at the start of the line that we add in this
    -+	 * function, the "%s" is a line in the (hopefully already
    ++	 * function. The "%s" is a line in the (hopefully already
     +	 * translated) N_() usage string, which contained embedded
     +	 * newlines before we split it up.
     +	 */
     +	const char *usage_continued = _("%*s%s");
    -+
    -+	/*
    -+	 * The translation could be anything, but we can count on
    -+	 * msgfmt(1)'s --check option to have asserted that "%s" is in
    -+	 * the translation. So compute the length of the " or: "
    -+	 * part. We are assuming that the translator wasn't overly
    -+	 * clever and used e.g. "%1$s" instead of "%s", there's only
    -+	 * one "%s" in "or_prefix" above, so there's no reason to do
    -+	 * so even with a RTL language.
    -+	 */
    -+	size_t or_len = strlen(or_prefix) - strlen("%s");
    -+	int i;
    -+	int saw_empty_line = 0;
    ++	const char *prefix = usage_prefix;
     +
      	if (!usagestr)
      		return PARSE_OPT_HELP;
    @@ parse-options.c: static int usage_with_options_internal(struct parse_opt_ctx_t *
      		fprintf(outfile, "cat <<\\EOF\n");
      
     -	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
    --	while (*usagestr && **usagestr)
    + 	while (*usagestr) {
     -		/*
     -		 * TRANSLATORS: the colon here should align with the
     -		 * one in "usage: %s" translation.
     -		 */
     -		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
    --	while (*usagestr) {
    --		if (**usagestr)
    --			fprintf_ln(outfile, _("    %s"), _(*usagestr));
    --		else
    --			fputc('\n', outfile);
    --		usagestr++;
    -+	for (i = 0; *usagestr; i++) {
    -+		const char *str = _(*usagestr++);
     +		struct string_list list = STRING_LIST_INIT_DUP;
     +		unsigned int j;
     +
    -+		string_list_split(&list, str, '\n', -1);
    ++		string_list_split(&list, _(*usagestr++), '\n', -1);
     +		for (j = 0; j < list.nr; j++) {
     +			const char *line = list.items[j].string;
     +
    -+			if (!saw_empty_line && !*line)
    -+				saw_empty_line = 1;
    ++			if (!*line)
    ++				BUG("empty or trailing line in usage string");
     +
    -+			if (saw_empty_line && *line)
    -+				fprintf_ln(outfile, _("    %s"), line);
    -+			else if (saw_empty_line)
    -+				fputc('\n', outfile);
    -+			else if (!j && !i)
    -+				fprintf_ln(outfile, usage_prefix, line);
    -+			else if (!j)
    -+				fprintf_ln(outfile, or_prefix, line);
    ++			if (!j)
    ++				fprintf_ln(outfile, prefix, line);
     +			else
     +				fprintf_ln(outfile, usage_continued,
    -+					   (int)or_len, "", line);
    ++					   (int)usage_len, "", line);
     +		}
     +		string_list_clear(&list, 0);
    ++
    ++		prefix = or_prefix;
      	}
      
      	need_newline = 1;
-- 
2.33.0.876.g423ac861752

