Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5F8C05027
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 02:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBRC5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 21:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBRC5o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 21:57:44 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B869296
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 18:57:42 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id y14so2833677ljq.10
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 18:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oqOk2zQGzqakh0gFLHZIAlfPG8f251BMqwpgoZMJLcY=;
        b=Ckw6mYcFQ/l9W9DSqlfdbJU0Xkd2weu7QwjuY6+r46vfd4t0IDyxG4QEkTp9kRz5iN
         h1PMRaIGCc6NjayVi41oYIHFgEpomewXK7jCSw8SqPlEHYhFOFs4MpTFoDFOZCOkpgbH
         Lu0tAXcCLBG1keQV6L1LHOoT1CL8wzlQ9nn+NH2G947P8JV3pm8VzYV9wKGOl5JmPYhm
         ENBy33wvDWntU6mBAtLxBnGl4608ZUfA4E668cAgta0oWPLyvFDGo517Ge+bIOnRpVs3
         pGfcEkdjNx/gUldmtzCpjBYRTvspU8cInrmrU1+ajKdQ3gFnW45DNsW8quwvYU0Az/s2
         HjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oqOk2zQGzqakh0gFLHZIAlfPG8f251BMqwpgoZMJLcY=;
        b=SAFM/HMeMoU55+MJQOIRgZXFtiJY7k5hQMzEh7yhEGeP74bEhDzxb2RzvlTRxOcU1I
         88HTyWH5HdpSzVyGZsGEH6EL6l/VrrJ2hNTpY2T9jimQ6LRI9EtgwE//gXvRy1NxsxzI
         5c5rzUcJTN3J+rgIQCEF8qyWmG41NqhGeehA+UL7hzuMeMxSPk6tVxu9mGdnyv002cU0
         GTbNUgtL5GHH2WuxTW9Z5e27dIB2yt9esa6jYoiDKXwSfBBXKrr99rECtialK919vvZ1
         eUV72LLa/K2j/84DhsFXgYuNsT/LyaD1p121z7Z93cvei3FFYiG8ihqdB68jppyROY6d
         AjmA==
X-Gm-Message-State: AO0yUKU7st1yoLao+/DT5ikiXUr9DSLnkYZfs20pQrhxAkchZuSMfyld
        KiioBO8s3ymz68e1qHRAOp3OfY+N+7IOq44KERyKIvFJH3U=
X-Google-Smtp-Source: AK7set9ei4FsOUqsuW0hMEIw6V1E+NZFKTwh4G3YyE6vjy6zTQrTyu9nIsHwOzl6Zk+8+BUgKHum0VVALZrD8TBp5P4=
X-Received: by 2002:a2e:bc13:0:b0:293:4862:5e31 with SMTP id
 b19-20020a2ebc13000000b0029348625e31mr3268104ljf.5.1676689060573; Fri, 17 Feb
 2023 18:57:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com> <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
In-Reply-To: <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 17 Feb 2023 18:56:00 -0800
Message-ID: <CABPp-BFCMpA=nHtb5RuQL7ACbkhSEKtvmRxKwMuktcf24uQJtQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] diff: teach diff to read algorithm from diff driver
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2023 at 12:21 PM John Cai via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: John Cai <johncai86@gmail.com>
>
> It can be useful to specify diff algorithms per file type. For example,
> one may want to use the minimal diff algorithm for .json files, another
> for .c files, etc.
>
> The diff machinery already checks attributes for a diff driver. Teach
> the diff driver parser a new type "algorithm" to look for in the
> config, which will be used if a driver has been specified through the
> attributes.
>
> Enforce precedence of the diff algorithm by favoring the command line
> option, then looking at the driver attributes & config combination, then
> finally the diff.algorithm config.
>
> To enforce precedence order, use a new `ignore_driver_algorithm` member
> during options pasing to indicate the diff algorithm was set via command
> line args.

s/pasing/parsing/

> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  Documentation/gitattributes.txt | 37 ++++++++++++++++++++++++++++++++
>  diff.c                          | 33 ++++++++++++++++++++--------
>  diff.h                          |  1 +
>  t/lib-diff-alternative.sh       | 38 ++++++++++++++++++++++++++++++++-
>  userdiff.c                      |  4 +++-
>  userdiff.h                      |  1 +
>  6 files changed, 103 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index c19e64ea0ef..f212079a131 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -758,6 +758,43 @@ with the above configuration, i.e. `j-c-diff`, with 7
>  parameters, just like `GIT_EXTERNAL_DIFF` program is called.
>  See linkgit:git[1] for details.
>
> +Setting the internal diff algorithm
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The diff algorithm can be set through the `diff.algorithm` config key, but
> +sometimes it may be helpful to set the diff algorithm by path. For example, one
> +might wish to set a diff algorithm automatically for all `.json` files such that
> +the user would not need to pass in a separate command line `--diff-algorithm`
> +flag each time.
> +
> +First, in `.gitattributes`, assign the `diff` attribute for paths.
> +
> +------------------------
> +*.json diff=<name>
> +------------------------
> +
> +Then, define a "diff.<name>.algorithm" configuration to specify the diff

Should there be a link to `git-config` right after "configuration"?
Otherwise, users may think that they are being told to specify
additional configuration within the .gitattributes file.

> +algorithm, choosing from `meyers`, `patience`, `minimal`, or `histogram`.

s/meyers/myers/

> +
> +----------------------------------------------------------------
> +[diff "<name>"]
> +  algorithm = histogram
> +----------------------------------------------------------------

It's pretty easy to assume the above is meant to be part of the
.gitattributes file instead of the .git/config file.  Don't most users
run `git config` commands directly rather than edit the .git/config
file?  Should we provide a sample command rather than showing what the
config file will contain?

> +
> +This diff algorithm applies to user facing diff output like git-diff(1),
> +git-show(1) and is used for the `--stat` output as well. The merge machinery
> +will not use the diff algorithm set through this method.

Yaay, thanks for including this!


I'm still curious if this should this also include warnings/caveats, such as:
  * The diff attribute specified in .gitattributes will be ignored in
a bare clone
  * The diff attribute specified in .gitattributes will be ignored if
it is only specified in another branch (e.g. on a branch "special-file
diff=patience" recorded in .gitattributes, then checkout master but
run `git log -1 -p $branch`)
  * When a file is renamed, the diff attribute for the pre-image name
is the only one the system pays attention to (thus adding "-R" can
flip which diff algorithm is run for the renamed file).

Also, since I tested the three items above to verify they are valid
warnings, I'm a bit confused.  I thought your intent was to use this
server-side[1], so isn't the bare clone aspect a deal-breaker for your
intended usecase?

[1] https://lore.kernel.org/git/7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@gmail.com/

> +
> +NOTE: If the `command` key also exists, then Git will treat this as an external
> +diff and attempt to use the value set for `command` as an external program. For
> +instance, the following config, combined with the above `.gitattributes` file,
> +will result in `command` favored over `algorithm`.
> +
> +----------------------------------------------------------------
> +[diff "<name>"]
> +  command = j-c-diff
> +  algorithm = histogram
> +----------------------------------------------------------------
>
>  Defining a custom hunk-header
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> diff --git a/diff.c b/diff.c
> index 5efc22ca06b..04469da6d34 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4456,15 +4456,13 @@ static void run_diff_cmd(const char *pgm,
>         const char *xfrm_msg = NULL;
>         int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
>         int must_show_header = 0;
> +       struct userdiff_driver *drv = NULL;
>
> -
> -       if (o->flags.allow_external) {
> -               struct userdiff_driver *drv;
> -
> +       if (o->flags.allow_external || !o->ignore_driver_algorithm)
>                 drv = userdiff_find_by_path(o->repo->index, attr_path);
> -               if (drv && drv->external)
> -                       pgm = drv->external;
> -       }
> +
> +       if (o->flags.allow_external && drv && drv->external)
> +               pgm = drv->external;
>
>         if (msg) {
>                 /*
> @@ -4481,12 +4479,16 @@ static void run_diff_cmd(const char *pgm,
>                 run_external_diff(pgm, name, other, one, two, xfrm_msg, o);
>                 return;
>         }
> -       if (one && two)
> +       if (one && two) {
> +               if (drv && !o->ignore_driver_algorithm && drv->algorithm)
> +                       set_diff_algorithm(o, drv->algorithm);
> +
>                 builtin_diff(name, other ? other : name,
>                              one, two, xfrm_msg, must_show_header,
>                              o, complete_rewrite);
> -       else
> +       } else {
>                 fprintf(o->file, "* Unmerged path %s\n", name);
> +       }
>  }
>
>  static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *istate)
> @@ -4583,6 +4585,14 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
>         const char *name;
>         const char *other;
>
> +       if (!o->ignore_driver_algorithm) {
> +               struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
> +
> +               if (drv && drv->algorithm) {
> +                       set_diff_algorithm(o, drv->algorithm);
> +               }
> +       }
> +
>         if (DIFF_PAIR_UNMERGED(p)) {
>                 /* unmerged */
>                 builtin_diffstat(p->one->path, NULL, NULL, NULL,
> @@ -5130,6 +5140,8 @@ static int diff_opt_diff_algorithm(const struct option *opt,
>                 return error(_("option diff-algorithm accepts \"myers\", "
>                                "\"minimal\", \"patience\" and \"histogram\""));
>
> +       options->ignore_driver_algorithm = 1;
> +
>         return 0;
>  }
>
> @@ -5145,6 +5157,8 @@ static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
>                 BUG("available diff algorithms include \"myers\", "
>                                "\"minimal\", \"patience\" and \"histogram\"");
>
> +       options->ignore_driver_algorithm = 1;
> +
>         return 0;
>  }
>
> @@ -5285,6 +5299,7 @@ static int diff_opt_patience(const struct option *opt,
>         for (i = 0; i < options->anchors_nr; i++)
>                 free(options->anchors[i]);
>         options->anchors_nr = 0;
> +       options->ignore_driver_algorithm = 1;
>
>         return set_diff_algorithm(options, "patience");
>  }
> diff --git a/diff.h b/diff.h
> index 41eb2c3d428..8d770b1d579 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -333,6 +333,7 @@ struct diff_options {
>         int prefix_length;
>         const char *stat_sep;
>         int xdl_opts;
> +       int ignore_driver_algorithm;
>
>         /* see Documentation/diff-options.txt */
>         char **anchors;
> diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
> index 8d1e408bb58..2dc02bca873 100644
> --- a/t/lib-diff-alternative.sh
> +++ b/t/lib-diff-alternative.sh
> @@ -105,10 +105,46 @@ index $file1..$file2 100644
>   }
>  EOF
>
> +       cat >expect_diffstat <<EOF
> + file1 => file2 | 21 ++++++++++-----------
> + 1 file changed, 10 insertions(+), 11 deletions(-)
> +EOF
> +
>         STRATEGY=$1
>
> +       test_expect_success "$STRATEGY diff from attributes" '
> +               echo "file* diff=driver" >.gitattributes &&
> +               git config diff.driver.algorithm "$STRATEGY" &&
> +               test_must_fail git diff --no-index file1 file2 > output &&
> +               cat expect &&
> +               cat output &&
> +               test_cmp expect output
> +       '
> +
> +       test_expect_success "$STRATEGY diff from attributes has valid diffstat" '
> +               echo "file* diff=driver" >.gitattributes &&
> +               git config diff.driver.algorithm "$STRATEGY" &&
> +               test_must_fail git diff --stat --no-index file1 file2 > output &&
> +               test_cmp expect_diffstat output
> +       '
> +
>         test_expect_success "$STRATEGY diff" '
> -               test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > output &&
> +               test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
> +               test_cmp expect output
> +       '
> +
> +       test_expect_success "$STRATEGY diff command line precedence before attributes" '
> +               echo "file* diff=driver" >.gitattributes &&
> +               git config diff.driver.algorithm meyers &&

Is this misspelling of myers intentional?  I think with the typo, the
code falls back to the default algorithm, which happens to be myers,
so I think the test works either way, but were you intending to test
fallback behavior in case of a typo here, or was that accidental?



> +               test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
> +               test_cmp expect output
> +       '
> +
> +       test_expect_success "$STRATEGY diff attributes precedence before config" '
> +               git config diff.algorithm default &&
> +               echo "file* diff=driver" >.gitattributes &&
> +               git config diff.driver.algorithm "$STRATEGY" &&
> +               test_must_fail git diff --no-index file1 file2 > output &&
>                 test_cmp expect output
>         '
>
> diff --git a/userdiff.c b/userdiff.c
> index d71b82feb74..ff25cfc4b4c 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -293,7 +293,7 @@ PATTERNS("scheme",
>          "|([^][)(}{[ \t])+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
>          "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
> -{ "default", NULL, -1, { NULL, 0 } },
> +{ "default", NULL, NULL, -1, { NULL, 0 } },
>  };
>  #undef PATTERNS
>  #undef IPATTERN
> @@ -394,6 +394,8 @@ int userdiff_config(const char *k, const char *v)
>                 return parse_bool(&drv->textconv_want_cache, k, v);
>         if (!strcmp(type, "wordregex"))
>                 return git_config_string(&drv->word_regex, k, v);
> +       if (!strcmp(type, "algorithm"))
> +               return git_config_string(&drv->algorithm, k, v);
>
>         return 0;
>  }
> diff --git a/userdiff.h b/userdiff.h
> index aee91bc77e6..24419db6973 100644
> --- a/userdiff.h
> +++ b/userdiff.h
> @@ -14,6 +14,7 @@ struct userdiff_funcname {
>  struct userdiff_driver {
>         const char *name;
>         const char *external;
> +       const char *algorithm;
>         int binary;
>         struct userdiff_funcname funcname;
>         const char *word_regex;
> --
> gitgitgadget
