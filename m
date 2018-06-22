Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D04EA1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 01:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934283AbeFVB5j (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 21:57:39 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:38661 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934184AbeFVB5i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 21:57:38 -0400
Received: by mail-qt0-f201.google.com with SMTP id v14-v6so1390152qto.5
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 18:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/yrXO3xms8tjbtDTQ/L3nLk9m64In3M1WdHbLUD9hdo=;
        b=GdO6IHPz5Pvw/p5L2vvVJcs4wR6uYJ3/+me/PV1aXvoc77xXu4qrM+gSdmnqXNhpYu
         7vsyNIq2G9OwwuguD0ZZPmNc7wrYDoWzqIc/XOcR1G9ku5Bs+qI0sUZvUVYxRf9t4do+
         RLrDrHs56wJnaMTwqjOvpZYrTNTdPPtIVnFizOjzg0NoOJAg6JDjGQhyRkdOtZq1fndR
         b+uwEtHJOvNWBk4BmqRnAnxA4F2XNjM6xc/TD+MS2mWXnEcDVLi2VpW0t9+kJpxqUxyE
         UAOS6pstwu3BELzc52XJKd3VKuvJ6cEr47P3M+vI3v9EeaewuO2oN/5uRl+eDp5zrF2L
         q5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/yrXO3xms8tjbtDTQ/L3nLk9m64In3M1WdHbLUD9hdo=;
        b=QkGT0vhe/4OfFpROggLOCLtah0TA+JBV2YmM59AVt4+POhWBduh4lmkILUmVWvHOJd
         UyYt3zQOU6m0eJ154n+86XUAhZInx6LsCf9FabKmwxHTAdpHneQOJHJxv9qIeBCORD7N
         aQOFpr/IsCOP1aOO9c9RAcVj5duO6yJV77GZsfKlwSzXfBgk+l/LPKwrVXIQKSXcSnbH
         82R+7kfJA78ztFf+SlnG/9EqdwZp+hcUi52/GM9TXr3qUnMjE+HZyUQbufDlS9Bb+z3I
         I/5laV1lydnQ8FlHG6NTMQ6FzUy87tYyuKbLlCTIqCJa5H0mBS2YXbFzXckUFIaB4Evu
         2AkA==
X-Gm-Message-State: APt69E3dHNZNATnxCeCEzT0tSeNKuqxWgSaEifQM7GwTs9I1KJ1B9FYT
        Syhr6+Wqc8n5t7i1J5anDq1KoQ1vS4l3
X-Google-Smtp-Source: ADUXVKKRk1hw/34qF/w4V97u7Hnyl+RZUxbTxQp9ED9xdIH1t0RbbW5G6unzMObE078UQbKMfaML3xH+X84/
X-Received: by 2002:a37:52d6:: with SMTP id g205-v6mr15177758qkb.17.1529632657799;
 Thu, 21 Jun 2018 18:57:37 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:57:17 -0700
Message-Id: <20180622015725.219575-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v3 0/8] Moved code detection: ignore space on uniform indentation
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This replaces sb/diff-color-move-more and is also available at
https://github.com/stefanbeller/git/tree/color-moved-only
It applies on v2.18.0.

Move detection is a nice feature, but doesn't work well with indentation
or dedentation. Make it possible to indent/dedent code and still have
it recognized as moved code in the diff.

The fun is in the last patch, which allows white space sensitive
languages to trust the move detection, too. Each block that is marked as
moved will have the same delta in {in-, de-}dentation.
I would think this mode might be a reasonable default eventually.

Thanks,
Stefan

v3:
 This is a complete rewrite of the actual patch, with slight modifications]
 on the refactoring how to decouple the white space treatment from the
 move detection. See range-diff below.

v2: https://public-inbox.org/git/20180424210330.87861-1-sbeller@google.com/

v1: https://public-inbox.org/git/20180402224854.86922-1-sbeller@google.com/

Stefan Beller (8):
  xdiff/xdiff.h: remove unused flags
  xdiff/xdiffi.c: remove unneeded function declarations
  diff.c: do not pass diff options as keydata to hashmap
  diff.c: adjust hash function signature to match hashmap expectation
  diff.c: add a blocks mode for moved code detection
  diff.c: decouple white space treatment from move detection algorithm
  diff.c: factor advance_or_nullify out of mark_color_as_moved
  diff.c: add white space mode to move detection that allows indent
    changes

 Documentation/diff-options.txt |  29 +++-
 diff.c                         | 253 +++++++++++++++++++++++++++++----
 diff.h                         |   9 +-
 t/t4015-diff-whitespace.sh     | 202 +++++++++++++++++++++++++-
 xdiff/xdiff.h                  |   8 --
 xdiff/xdiffi.c                 |  17 ---
 6 files changed, 458 insertions(+), 60 deletions(-)

-- 
2.18.0.rc2.346.g013aa6912e-goog

git branch-diff fe0a9eaf31dd0c349ae4308498c33a5c3794b293..origin/sb/diff-color-move-more origin/master..HEAD

1:  a7a7af6b76b = 1:  7e01bd9a972 xdiff/xdiff.h: remove unused flags
2:  a7b6aaf7bc0 = 2:  46e11a99bb7 xdiff/xdiffi.c: remove unneeded function declarations
3:  d9e57cc6b05 = 3:  8fd0ce94aaf diff.c: do not pass diff options as keydata to hashmap
4:  87111ba726d = 4:  4a07b39163c diff.c: adjust hash function signature to match hashmap expectation
5:  9559b8cb456 = 5:  ef1976a301d diff.c: add a blocks mode for moved code detection
6:  41a70464209 ! 6:  a60a3f0de9d diff.c: decouple white space treatment from move detection algorithm
    @@ -7,24 +7,30 @@
         for the regular diff.  Some cases came up where different treatment would
         have been nice.
     
    -    Allow the user to specify that whitespace should be ignored differently
    +    Allow the user to specify that white space should be ignored differently
         during detection of moved lines than during generation of added and removed
         lines. This is done by providing analogs to the --ignore-space-at-eol,
    -    -b, and -w options (namely,
    -      --color-moved-[no-]ignore-space-at-eol
    -      --color-moved-[no-]ignore-space-change
    -      --color-moved-[no-]ignore-all-space) that affect only the color of the
    -    output, and making the existing --ignore-space-at-eol, -b, and -w options
    -    no longer affect the color of the output.
    +    -b, and -w options by introducing the option --color-moved-ws=<modes>
    +    with the modes named "ignore-space-at-eol", "ignore-space-change" and
    +    "ignore-all-space", which is used only during the move detection phase.
     
         As we change the default, we'll adjust the tests.
     
    -    For now we do not infer any options to treat whitespaces in the move
    +    For now we do not infer any options to treat white spaces in the move
         detection from the generic white space options given to diff.
         This can be tuned later to reasonable default.
     
    +    As we plan on adding more white space related options in a later patch,
    +    that interferes with the current white space options, use a flag field
    +    and clamp it down to  XDF_WHITESPACE_FLAGS, as that (a) allows to easily
    +    check at parse time if we give invalid combinations and (b) can reuse
    +    parts of this patch.
    +
    +    By having the white space treatment in its own option, we'll also
    +    make it easier for a later patch to have an config option for
    +    spaces in the move detection.
    +
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
     diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
     --- a/Documentation/diff-options.txt
    @@ -33,18 +39,21 @@
      	blocks are considered interesting, the rest is uninteresting.
      --
      
    -+--color-moved-[no-]ignore-space-at-eol::
    -+	Ignore changes in whitespace at EOL when performing the move
    -+	detection for --color-moved.
    -+--color-moved-[no-]ignore-space-change::
    -+	Ignore changes in amount of whitespace when performing the move
    -+	detection for --color-moved.  This ignores whitespace
    ++--color-moved-ws=<modes>::
    ++	This configures how white spaces are ignored when performing the
    ++	move detection for `--color-moved`. These modes can be given
    ++	as a comma separated list:
    +++
    ++--
    ++ignore-space-at-eol::
    ++	Ignore changes in whitespace at EOL.
    ++ignore-space-change::
    ++	Ignore changes in amount of whitespace.  This ignores whitespace
     +	at line end, and considers all other sequences of one or
     +	more whitespace characters to be equivalent.
    -+--color-moved-[no-]ignore-all-space::
    -+	Ignore whitespace when comparing lines when performing the move
    -+	detection for --color-moved.  This ignores differences even if
    -+	one line has whitespace where the other line has none.
    ++ignore-all-space::
    ++	Ignore whitespace when comparing lines. This ignores differences
    ++	even if one line has whitespace where the other line has none.
     +
      --word-diff[=<mode>]::
      	Show a word diff, using the <mode> to delimit changed words.
    @@ -53,6 +62,43 @@
     diff --git a/diff.c b/diff.c
     --- a/diff.c
     +++ b/diff.c
    +@@
    + 		return error(_("color moved setting must be one of 'no', 'default', 'blocks', 'zebra', 'dimmed_zebra', 'plain'"));
    + }
    + 
    ++static int parse_color_moved_ws(const char *arg)
    ++{
    ++	int ret = 0;
    ++	struct string_list l = STRING_LIST_INIT_DUP;
    ++	struct string_list_item *i;
    ++
    ++	string_list_split(&l, arg, ',', -1);
    ++
    ++	for_each_string_list_item(i, &l) {
    ++		struct strbuf sb = STRBUF_INIT;
    ++		strbuf_addstr(&sb, i->string);
    ++		strbuf_trim(&sb);
    ++
    ++		if (!strcmp(sb.buf, "ignore-space-change"))
    ++			ret |= XDF_IGNORE_WHITESPACE_CHANGE;
    ++		else if (!strcmp(sb.buf, "ignore-space-at-eol"))
    ++			ret |= XDF_IGNORE_WHITESPACE_AT_EOL;
    ++		else if (!strcmp(sb.buf, "ignore-all-space"))
    ++			ret |= XDF_IGNORE_WHITESPACE;
    ++		else
    ++			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
    ++
    ++		strbuf_release(&sb);
    ++	}
    ++
    ++	string_list_clear(&l, 0);
    ++
    ++	return ret;
    ++}
    ++
    + int git_diff_ui_config(const char *var, const char *value, void *cb)
    + {
    + 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
     @@
      	const struct diff_options *diffopt = hashmap_cmp_fn_data;
      	const struct moved_entry *a = entry;
    @@ -79,24 +125,14 @@
      	ret->next_line = NULL;
      
     @@
    - 		DIFF_XDL_SET(options, IGNORE_CR_AT_EOL);
    - 	else if (!strcmp(arg, "--ignore-blank-lines"))
    - 		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
    -+	else if (!strcmp(arg, "--color-moved-no-ignore-all-space"))
    -+		options->color_moved_ws_handling &= ~XDF_IGNORE_WHITESPACE;
    -+	else if (!strcmp(arg, "--color-moved-no-ignore-space-change"))
    -+		options->color_moved_ws_handling &= ~XDF_IGNORE_WHITESPACE_CHANGE;
    -+	else if (!strcmp(arg, "--color-moved-no-ignore-space-at-eol"))
    -+		options->color_moved_ws_handling &= ~XDF_IGNORE_WHITESPACE_AT_EOL;
    -+	else if (!strcmp(arg, "--color-moved-ignore-all-space"))
    -+		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE;
    -+	else if (!strcmp(arg, "--color-moved-ignore-space-change"))
    -+		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE_CHANGE;
    -+	else if (!strcmp(arg, "--color-moved-ignore-space-at-eol"))
    -+		options->color_moved_ws_handling |= XDF_IGNORE_WHITESPACE_AT_EOL;
    - 	else if (!strcmp(arg, "--indent-heuristic"))
    - 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
    - 	else if (!strcmp(arg, "--no-indent-heuristic"))
    + 		if (cm < 0)
    + 			die("bad --color-moved argument: %s", arg);
    + 		options->color_moved = cm;
    ++	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
    ++		options->color_moved_ws_handling = parse_color_moved_ws(arg);
    + 	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
    + 		options->use_color = 1;
    + 		options->word_diff = DIFF_WORDS_COLOR;
     
     diff --git a/diff.h b/diff.h
     --- a/diff.h
    @@ -113,39 +149,13 @@
     diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
     --- a/t/t4015-diff-whitespace.sh
     +++ b/t/t4015-diff-whitespace.sh
    -@@
    - 	line 4
    - 	line 5
    - 	EOF
    --	git diff HEAD --no-renames --color-moved --color |
    -+	git diff HEAD --no-renames --color-moved --color \
    -+		--color-moved-no-ignore-all-space \
    -+		--color-moved-no-ignore-space-change \
    -+		--color-moved-no-ignore-space-at-eol |
    - 		grep -v "index" |
    - 		test_decode_color >actual &&
    - 	cat <<-\EOF >expected &&
     @@
      	EOF
      	test_cmp expected actual &&
      
     -	git diff HEAD --no-renames -w --color-moved --color |
     +	git diff HEAD --no-renames --color-moved --color \
    -+		--color-moved-ignore-all-space \
    -+		--color-moved-no-ignore-space-change \
    -+		--color-moved-no-ignore-space-at-eol |
    - 		grep -v "index" |
    - 		test_decode_color >actual &&
    - 	cat <<-\EOF >expected &&
    -@@
    - 	line 5
    - 	EOF
    - 
    --	git diff HEAD --no-renames --color-moved --color |
    -+	git diff HEAD --no-renames --color-moved --color \
    -+		--color-moved-no-ignore-all-space \
    -+		--color-moved-no-ignore-space-change \
    -+		--color-moved-no-ignore-space-at-eol |
    ++		--color-moved-ws=ignore-all-space |
      		grep -v "index" |
      		test_decode_color >actual &&
      	cat <<-\EOF >expected &&
    @@ -155,21 +165,7 @@
      
     -	git diff HEAD --no-renames -b --color-moved --color |
     +	git diff HEAD --no-renames --color-moved --color \
    -+		--color-moved-no-ignore-all-space \
    -+		--color-moved-no-ignore-space-at-eol \
    -+		--color-moved-ignore-space-change |
    - 		grep -v "index" |
    - 		test_decode_color >actual &&
    - 	cat <<-\EOF >expected &&
    -@@
    - 	# avoid cluttering the output with complaints about our eol whitespace
    - 	test_config core.whitespace -blank-at-eol &&
    - 
    --	git diff HEAD --no-renames --color-moved --color |
    -+	git diff HEAD --no-renames --color-moved --color \
    -+		--color-moved-no-ignore-all-space \
    -+		--color-moved-no-ignore-space-change \
    -+		--color-moved-no-ignore-space-at-eol |
    ++		--color-moved-ws=ignore-space-change |
      		grep -v "index" |
      		test_decode_color >actual &&
      	cat <<-\EOF >expected &&
    @@ -179,9 +175,7 @@
      
     -	git diff HEAD --no-renames --ignore-space-at-eol --color-moved --color |
     +	git diff HEAD --no-renames --color-moved --color \
    -+		--color-moved-no-ignore-all-space \
    -+		--color-moved-no-ignore-space-change \
    -+		--color-moved-ignore-space-at-eol |
    ++		--color-moved-ws=ignore-space-at-eol |
      		grep -v "index" |
      		test_decode_color >actual &&
      	cat <<-\EOF >expected &&
    @@ -211,10 +205,7 @@
     +	EOF
     +
     +	# Make sure we get a different diff using -w
    -+	git diff --color --color-moved -w \
    -+		--color-moved-no-ignore-all-space \
    -+		--color-moved-no-ignore-space-change \
    -+		--color-moved-no-ignore-space-at-eol |
    ++	git diff --color --color-moved -w |
     +		grep -v "index" |
     +		test_decode_color >actual &&
     +	q_to_tab <<-\EOF >expected &&
    @@ -231,9 +222,7 @@
     +
     +	# And now ignoring white space only in the move detection
     +	git diff --color --color-moved \
    -+		--color-moved-ignore-all-space \
    -+		--color-moved-ignore-space-change \
    -+		--color-moved-ignore-space-at-eol |
    ++		--color-moved-ws=ignore-all-space,ignore-space-change,ignore-space-at-eol |
     +		grep -v "index" |
     +		test_decode_color >actual &&
     +	q_to_tab <<-\EOF >expected &&
7:  ce99fa38553 < -:  ----------- diff.c: add --color-moved-ignore-space-delta option
8:  39c5337cd9e < -:  ----------- diff: color-moved white space handling options imply color-moved
-:  ----------- > 7:  b76faee22fe diff.c: factor advance_or_nullify out of mark_color_as_moved
-:  ----------- > 8:  ab003ed7e27 diff.c: add white space mode to move detection that allows indent changes
