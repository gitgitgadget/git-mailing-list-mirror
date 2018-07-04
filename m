Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F207A1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 10:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932732AbeGDKEX (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 06:04:23 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41924 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932493AbeGDKEW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 06:04:22 -0400
Received: by mail-yb0-f195.google.com with SMTP id s8-v6so1876109ybe.8
        for <git@vger.kernel.org>; Wed, 04 Jul 2018 03:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ev0LxMEEp133bZFNZpLMhCFE11yTIJZCWSfa+FwRpFE=;
        b=AbseqjCAQnxyumS3Joz8WuF9Xj9tJgl37sHbpNg2N2tKThoT4xQfboQg3qYWr8VBb3
         Kn0d7YGkUhkLKivm7Web8kH1lIpoFQHZ7vAxcUXsZgQ70b0gjshtjCkT5AciRsXjUJ83
         kai6g2cI2lNiis3wDmI1PGIq1qywqrderdTiOVrH8xBPJOzIsO3sTqTedF9P+tmRrwhO
         wIWCFDqL8MDK2XPGLY5RC5AMhSRRpAyrZb0ppXLh/omohBQ4ZX+LgbSQ18KhBryRE1Pg
         UNYSzpTiNtD4bOlgrMederUESoK+dZgyz5BV/5z2M/0Yuo+20BBaVC/S8CLSPX0lnr+K
         Sjig==
X-Gm-Message-State: APt69E2mrB2Ti773acazRwxrIlq4wbtl89Gji2qyhWy2AUKdfui3jrF7
        skz/0JjO4MC6gPLpdMqrLfjlSMZquudUVCO/t2I=
X-Google-Smtp-Source: AAOMgpePMtnwzZdDK10sLGKiwxRguleTpsfi9mnOITaKJeIb6+kO0QWvMMxb6on8CoIJOgIGxINOVgSnDVuY+lN93mQ=
X-Received: by 2002:a25:8b04:: with SMTP id i4-v6mr608023ybl.12.1530698661571;
 Wed, 04 Jul 2018 03:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <26b538bd-df59-d9a6-460d-0b1042b35250@gmail.com> <20180703235337.31770-1-jyn514@gmail.com>
In-Reply-To: <20180703235337.31770-1-jyn514@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Jul 2018 06:04:10 -0400
Message-ID: <CAPig+cSkQ9FM=o7icJY-eSoJ0Po_1v8sb0oRX1T6J42N0dOisA@mail.gmail.com>
Subject: Re: [PATCH] ls-tree: make <tree-ish> optional
To:     jyn514@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 3, 2018 at 7:57 PM Joshua Nelson <jyn514@gmail.com> wrote:
> Use syntax similar to `git-checkout` to make <tree-ish> optional for
> `ls-tree`. If <tree-ish> is omitted, default to HEAD. Infer arguments as
> follows:
>
> 1. If args start with '--', assume <tree-ish> to be HEAD
> 2. If exactly one arg precedes '--', treat the argument as <tree-ish>
> 3. If more than one arg precedes '--', exit with an error
> 4. If '--' is not in args:
>         a) If args[0] is a valid <tree-ish> object, treat it as such
>         b) Else, assume <tree-ish> to be HEAD
>
> In all cases, every argument besides <tree-ish> is treated as a <path>.

See review comments below. However, it's not clear if you should be
putting more effort into this submissions since Junio did not seem too
interested in such a behavior change[1]. Perhaps wait for word from
him before acting on any of the below comments.

[1]: https://public-inbox.org/git/xmqqbmbonff3.fsf@gitster-ct.c.googlers.com/

> Signed-off-by: Joshua Nelson <jyn514@gmail.com>
> ---
> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  'git ls-tree' [-d] [-r] [-t] [-l] [-z]
>             [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
> -           <tree-ish> [<path>...]
> +           [<tree-ish>] [--] [<path>...]

The documentation should also explain what happens when the
now-optional <tree-ish> is omitted. A bit later in this document, you
find:

    <tree-ish>
        Id of a tree-ish.

You probably want to amend this to add: "When omitted, defaults to HEAD."

> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> @@ -122,7 +122,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
> +       const char *tree_ish;

I think 'treeish' would be a more common way to spell this in this code base.

> @@ -164,9 +166,33 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>         if (argc < 1)
> +               tree_ish = "HEAD";
> +       else {
> +               for (i = 0; i < argc; i++) {
> +                       if (!strcmp(argv[i], "--")) {
> +                               dash_dash_pos = i;
> +                               break;
> +                       }
> +               }
> +               if (dash_dash_pos == 0) {
> +                       tree_ish = "HEAD";
> +                       argv++;
> +               } else if (dash_dash_pos == 1) {
> +                       tree_ish = argv[0];
> +                       argv += 2;
> +               } else if (dash_dash_pos >= 2)
> +                       die(_("only one reference expected, %d given."), dash_dash_pos);
> +               else if (get_oid(argv[0], &oid)) // not a valid object

Mentioned previously: Use /* comments */ in this code-base, not // comments.

> +                       tree_ish = "HEAD";
> +               else {
> +                       argv++;
> +                       oid_initialized = 1;
> +               }
> +       }
> +
> +       if (!oid_initialized) /* if we've already run get_oid, don't run it again */
> +               if (get_oid(tree_ish, &oid))
> +                       die("Not a valid object name %s", tree_ish);

As explained in [2], I think 'oid_initialized' is unneeded since it
can be inferred from 'tree_ish', thus this code could be simplified.

[2]: https://public-inbox.org/git/CAPig+cQu-e63NUUXAB_QA+M-rgPfqBLOOm5fdjsSVuWHJt7TJA@mail.gmail.com/

> diff --git a/t/t3104-ls-tree-optional-args.sh b/t/t3104-ls-tree-optional-args.sh
> @@ -0,0 +1,63 @@
> +test_expect_success 'setup' '
> +       echo hi > test &&

Mentioned previously: Drop whitespace after ">". Same comment applies
to several other places in this script.

> +       cp test test2 &&
> +       git add test test2 &&
> +       git commit -m initial &&
> +       printf "100644 blob 45b983be36b73c0788dc9cbcb76cbb80fc7bb057\ttest\n" > expected1 &&
> +       printf "100644 blob 45b983be36b73c0788dc9cbcb76cbb80fc7bb057\ttest2\n" > expected2
> +'

There's work being done on Git to make it possible to swap in a new
hash algorithm in place of SHA-1, which means that these hard-coded
hash values won't fly. Instead, you'd want to determine them
dynamically. For instance:

    ...
    printf "100644 blob %s\ttest\n" $(git rev-parse HEAD:test) >expected1 &&
    printf "100644 blob %s\ttest2\n" $(git rev-parse HEAD:test2) >expected2

or something.

> +test_expect_success 'show HEAD when given no args' '
> +       if [ "$(git ls-tree)" != "$(cat expected1 expected2)" ]; then false; fi
> +'

In this code-base, we use 'test' rather than '[', and we wouldn't
bother with stuffing the comparison in an 'if' statement since its
value can be used directly as the test result. However, better is to
dump the result of git-ls-tree to a file and then use test_cmp() to
compare the expected and actual output. If the expected and actual
output don't match, test_cmp() will show the differences to aid
debugging. So, you might write this test like this:

    test_expect_success 'show HEAD when given no args' '
        cat expected1 expected2 >expected &&
        git ls-tree >actual &&
        test_cmp expected actual
    '

Same comment regarding remaining tests.
