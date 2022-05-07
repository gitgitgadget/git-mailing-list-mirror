Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217ADC433EF
	for <git@archiver.kernel.org>; Sat,  7 May 2022 02:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356711AbiEGC1V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 22:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243739AbiEGC1U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 22:27:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7357D69CDA
        for <git@vger.kernel.org>; Fri,  6 May 2022 19:23:35 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l18so17428240ejc.7
        for <git@vger.kernel.org>; Fri, 06 May 2022 19:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOjFr+/oBC4uIwCbFNhgo0+rQVjdEi0K1OKs/w5GOPA=;
        b=LZqx+9p9+LMv6ND/TAB6l6DiEpg6LaTASHNSpOoI5n1JEYZKyJLYBjw/obuf8ke0Lk
         5jCvjPHHh7kZqGG1CKSJc+hFzhZ5GRWFbts0xbUTb/Ey9kHvlkWktE91plEhi4iAm8l9
         RRwnUZxgG1aTzORqRB9R4mHWdG/CCge7lZHZ8M+x1pISPqKo9p9F42C4/3CTiobHeZNP
         +4CqZBcf3cW4qh1+H7D83osKEC7ScB9ZPoFlnlriQxHJBJ1Gi2yj4JrYd5RTVbjhuEd5
         45tuHxtcwX5Vo6yy9jDWed9aHeQ3mvfn1erysZQHY1r2FzbERF4IsJ0fwX9133rUobY5
         hLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOjFr+/oBC4uIwCbFNhgo0+rQVjdEi0K1OKs/w5GOPA=;
        b=gaBunq7fW1qYPz4GEGLbAvJDibqwUnbYhVivr2acisrRTboZ6njELyEl2y31IbIbO9
         3yz8i2L/ltkZ/lAMCBIqjJLkNtFG0SrvsxGsl4TS2KpzpZrQitB6V95c2XPE6dHnlrGk
         bh5h0SgrY3FbNCZ9NYNWQsRJO+Ytj+WE1jxIWsyeW3AS1MZzbKHg4LXG6h29Hj4P0ieL
         YJPTO/epoKwLfpRTg7WBO/qdSW1Kpis5lNagQpxCiag7DbRvfwfwIMBouNexxfm5r1zG
         55Frjqr5/pFehLbuMqG5T3J/VPGS+QFfrmsS3m/fdmfZDCvyCQeNxHazw4Ir0UjRfZLF
         KPaQ==
X-Gm-Message-State: AOAM530rLO6+Gs+2Hv2u+erI/GgcQpVXSOaydUOkXr4vyX/Ecv0sAVhf
        XacD9SwFXgEqKFI6Jkdt8xYcSMXuom3tinNYeM0=
X-Google-Smtp-Source: ABdhPJyZ5smouuhXEuWwYHMecczxCcfVVo3VQ1y/6zAmhaI1y00QQhBB2uaY/b5Gp54EZ+KDFgAg5XtLpypmqJ0AYH0=
X-Received: by 2002:a17:906:c106:b0:6f4:45d9:2d85 with SMTP id
 do6-20020a170906c10600b006f445d92d85mr5501036ejc.493.1651890213929; Fri, 06
 May 2022 19:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com> <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
In-Reply-To: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 May 2022 19:23:22 -0700
Message-ID: <CABPp-BHbVFkqbw=zoBmJPNkUv3e_+i72A=9sCEU7gWHGfDsEsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] scalar: implement the subcommand "diagnose"
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 4, 2022 at 8:25 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Over the course of the years, we developed a sub-command that gathers
> diagnostic data into a .zip file that can then be attached to bug reports.
> This sub-command turned out to be very useful in helping Scalar developers
> identify and fix issues.
>
> Changes since v2:
>
>  * Clarified in the commit message what the biggest benefit of
>    --add-file-with-content is.
>  * The <path> part of the -add-file-with-content argument can now contain
>    colons. To do this, the path needs to start and end in double-quote
>    characters (which are stripped), and the backslash serves as escape
>    character in that case (to allow the path to contain both colons and
>    double-quotes).

You addressed all my previous feedback from an earlier round.  The
only thing I noticed in this round is I wonder if we should use
unquote_c_style() for this, as commented on the patch in question.

>  * Fixed incorrect grammar.
>  * Instead of strcmp(<what-we-don't-want>), we now say
>    !strcmp(<what-we-want>).
>  * The help text for --add-file-with-content was improved a tiny bit.
>  * Adjusted the commit message that still talked about spawning plenty of
>    processes and about a throw-away repository for the sake of generating a
>    .zip file.
>  * Simplified the code that shows the diagnostics and adds them to the .zip
>    file.
>  * The final message that reports that the archive is complete is now
>    printed to stderr instead of stdout.
>
> Changes since v1:
>
>  * Instead of creating a throw-away repository, staging the contents of the
>    .zip file and then using git write-tree and git archive to write the .zip
>    file, the patch series now introduces a new option to git archive and
>    uses write_archive() directly (avoiding any separate process).
>  * Since the command avoids separate processes, it is now blazing fast on
>    Windows, and I dropped the spinner() function because it's no longer
>    needed.
>  * While reworking the test case, I noticed that scalar [...] <enlistment>
>    failed to verify that the specified directory exists, and would happily
>    "traverse to its parent directory" on its quest to find a Scalar
>    enlistment. That is of course incorrect, and has been fixed as a "while
>    at it" sort of preparatory commit.
>  * I had forgotten to sign off on all the commits, which has been fixed.
>  * Instead of some "home-grown" readdir()-based function, the code now uses
>    for_each_file_in_pack_dir() to look through the pack directories.
>  * If any alternates are configured, their pack directories are now included
>    in the output.
>  * The commit message that might be interpreted to promise information about
>    large loose files has been corrected to no longer promise that.
>  * The test cases have been adjusted to test a little bit more (e.g.
>    verifying that specific paths are mentioned in the output, instead of
>    merely verifying that the output is non-empty).
>
> Johannes Schindelin (5):
>   archive: optionally add "virtual" files
>   archive --add-file-with-contents: allow paths containing colons
>   scalar: validate the optional enlistment argument
>   Implement `scalar diagnose`
>   scalar diagnose: include disk space information
>
> Matthew John Cheetham (2):
>   scalar: teach `diagnose` to gather packfile info
>   scalar: teach `diagnose` to gather loose objects information
>
>  Documentation/git-archive.txt    |  16 ++
>  archive.c                        |  75 +++++++-
>  contrib/scalar/scalar.c          | 289 ++++++++++++++++++++++++++++++-
>  contrib/scalar/scalar.txt        |  12 ++
>  contrib/scalar/t/t9099-scalar.sh |  27 +++
>  t/t5003-archive-zip.sh           |  20 +++
>  6 files changed, 429 insertions(+), 10 deletions(-)
>
>
> base-commit: ddc35d833dd6f9e8946b09cecd3311b8aa18d295
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1128%2Fdscho%2Fscalar-diagnose-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1128/dscho/scalar-diagnose-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1128
>
> Range-diff vs v2:
>
>  1:  49ff3c1f2b3 ! 1:  45662cf582a archive: optionally add "virtual" files
>      @@ Commit message
>           archive` now supports use cases where relatively trivial files need to
>           be added that do not exist on disk.
>
>      +    This will allow us to generate `.zip` files with generated content,
>      +    without having to add said content to the object database and without
>      +    having to write it out to disk.
>      +
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
>        ## Documentation/git-archive.txt ##
>      @@ Documentation/git-archive.txt: OPTIONS
>       + basename of <file>.
>       ++
>       +The `<path>` cannot contain any colon, the file mode is limited to
>      -+a regular file, and the option may be subject platform-dependent
>      ++a regular file, and the option may be subject to platform-dependent
>       +command-line limits. For non-trivial cases, write an untracked file
>       +and use `--add-file` instead.
>       +
>      @@ archive.c: static int add_file_cb(const struct option *opt, const char *arg, int
>       - if (!S_ISREG(info->stat.st_mode))
>       -         die(_("Not a regular file: %s"), path);
>       +
>      -+ if (strcmp(opt->long_name, "add-file-with-content")) {
>      ++ if (!strcmp(opt->long_name, "add-file")) {
>       +         path = prefix_filename(args->prefix, arg);
>       +         if (stat(path, &info->stat))
>       +                 die(_("File not found: %s"), path);
>      @@ archive.c: static int parse_archive_args(int argc, const char **argv,
>                   N_("add untracked file to archive"), 0, add_file_cb,
>                   (intptr_t)&base },
>       +         { OPTION_CALLBACK, 0, "add-file-with-content", args,
>      -+           N_("file"), N_("add untracked file to archive"), 0,
>      ++           N_("path:content"), N_("add untracked file to archive"), 0,
>       +           add_file_cb, (intptr_t)&base },
>                 OPT_STRING('o', "output", &output, N_("file"),
>                         N_("write the archive to this file")),
>  -:  ----------- > 2:  ce4b1b680c9 archive --add-file-with-contents: allow paths containing colons
>  2:  600da8d465e = 3:  5a3eeb55409 scalar: validate the optional enlistment argument
>  3:  0d570137bb6 ! 4:  dfe821d10fe Implement `scalar diagnose`
>      @@ Commit message
>           we had the luxury of a comprehensive standard library that includes
>           basic functionality such as writing a `.zip` file. In the C version, we
>           lack such a commodity. Rather than introducing a dependency on, say,
>      -    libzip, we slightly abuse Git's `archive` command: Instead of writing
>      -    the `.zip` file directly, we stage the file contents in a Git index of a
>      -    temporary, bare repository, only to let `git archive` have at it, and
>      -    finally removing the temporary repository.
>      -
>      -    Also note: Due to the frequently-spawned `git hash-object` processes,
>      -    this command is quite a bit slow on Windows. Should it turn out to be a
>      -    big problem, the lack of a batch mode of the `hash-object` command could
>      -    potentially be worked around via using `git fast-import` with a crafted
>      -    `stdin`.
>      +    libzip, we slightly abuse Git's `archive` machinery: we write out a
>      +    `.zip` of the empty try, augmented by a couple files that are added via
>      +    the `--add-file*` options. We are careful trying not to modify the
>      +    current repository in any way lest the very circumstances that required
>      +    `scalar diagnose` to be run are changed by the `diagnose` run itself.
>
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
>      @@ contrib/scalar/scalar.c: cleanup:
>       + time_t now = time(NULL);
>       + struct tm tm;
>       + struct strbuf path = STRBUF_INIT, buf = STRBUF_INIT;
>      -+ size_t off;
>       + int res = 0;
>       +
>       + argc = parse_options(argc, argv, NULL, options,
>      @@ contrib/scalar/scalar.c: cleanup:
>       + strvec_pushl(&archiver_args, "scalar-diagnose", "--format=zip", NULL);
>       +
>       + strbuf_reset(&buf);
>      -+ strbuf_addstr(&buf,
>      -+               "--add-file-with-content=diagnostics.log:"
>      -+               "Collecting diagnostic info\n\n");
>      ++ strbuf_addstr(&buf, "Collecting diagnostic info\n\n");
>       + get_version_info(&buf, 1);
>       +
>       + strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
>      -+ off = strchr(buf.buf, ':') + 1 - buf.buf;
>      -+ write_or_die(stdout_fd, buf.buf + off, buf.len - off);
>      -+ strvec_push(&archiver_args, buf.buf);
>      ++ write_or_die(stdout_fd, buf.buf, buf.len);
>      ++ strvec_pushf(&archiver_args,
>      ++              "--add-file-with-content=diagnostics.log:%.*s",
>      ++              (int)buf.len, buf.buf);
>       +
>       + if ((res = add_directory_to_archiver(&archiver_args, ".git", 0)) ||
>       +     (res = add_directory_to_archiver(&archiver_args, ".git/hooks", 0)) ||
>      @@ contrib/scalar/scalar.c: cleanup:
>       + }
>       +
>       + if (!res)
>      -+         printf("\n"
>      ++         fprintf(stderr, "\n"
>       +                "Diagnostics complete.\n"
>       +                "All of the gathered info is captured in '%s'\n",
>       +                zip_path.buf);
>  4:  938e38b5a09 ! 5:  bb162abd383 scalar diagnose: include disk space information
>      @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
>
>         strbuf_addf(&buf, "Enlistment root: %s\n", the_repository->worktree);
>       + get_disk_info(&buf);
>      -  off = strchr(buf.buf, ':') + 1 - buf.buf;
>      -  write_or_die(stdout_fd, buf.buf + off, buf.len - off);
>      -  strvec_push(&archiver_args, buf.buf);
>      +  write_or_die(stdout_fd, buf.buf, buf.len);
>      +  strvec_pushf(&archiver_args,
>      +               "--add-file-with-content=diagnostics.log:%.*s",
>
>        ## contrib/scalar/t/t9099-scalar.sh ##
>       @@ contrib/scalar/t/t9099-scalar.sh: SQ="'"
>  5:  bd9428919fa ! 6:  32aaad7cce1 scalar: teach `diagnose` to gather packfile info
>      @@ contrib/scalar/scalar.c: cleanup:
>        {
>         struct option options[] = {
>       @@ contrib/scalar/scalar.c: static int cmd_diagnose(int argc, const char **argv)
>      -  write_or_die(stdout_fd, buf.buf + off, buf.len - off);
>      -  strvec_push(&archiver_args, buf.buf);
>      +               "--add-file-with-content=diagnostics.log:%.*s",
>      +               (int)buf.len, buf.buf);
>
>       + strbuf_reset(&buf);
>       + strbuf_addstr(&buf, "--add-file-with-content=packs-local.txt:");
>  6:  7a8875be425 = 7:  322932f0bb8 scalar: teach `diagnose` to gather loose objects information
>
> --
> gitgitgadget
