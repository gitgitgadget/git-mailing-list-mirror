Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3915C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF4F610E9
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 03:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhFMDMo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 12 Jun 2021 23:12:44 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:34695 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFMDMm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jun 2021 23:12:42 -0400
Received: by mail-ej1-f53.google.com with SMTP id g8so10584965ejx.1
        for <git@vger.kernel.org>; Sat, 12 Jun 2021 20:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Tucu4c7CI6o8/Jpa71gAopLkDYri3gOS/v7lE3jvPM=;
        b=EhnmOIBKi7TDeFr7zKAm2EMziPMYjuuesnrYrYMKvY8bKCKV+42RIsAwsGYo7zi/XS
         8sUAaqHOsWA3uvaL2TP7hEdc7FQ8bbhBfTIxDzqzCC0ds8F69wFmKVz888wkF063ecdw
         tIz0y1P494umvZaESUhm+kNBQckSc+xxQCeiTL0gOmRqUfCa3R+kaD36byzQgDbaSX7h
         1g+QuWqKNw8EswvUPUYMIAIxz6VtN9zqUvYmt+DGv6guzoULRG4TuIENpPmoMFi2G6qq
         2xHlv5Td6Nxzqgn7WDudLCjqInkU6/LhxYRoWu571KYToXPjvWNNdtb1NjvPReH+0FEc
         412Q==
X-Gm-Message-State: AOAM530KsC9QM/dvgrgoio6YuONoHAE2FiCSEWNtBQ93XgqkaQSgYyJw
        j+aL1LWA1Xc2rQf8ZPP0Rvp5YXnLr/MjVs//spg=
X-Google-Smtp-Source: ABdhPJyb6BabZcbZ4Rr9cHnbA2bBajshOVUJxYwPgsUUtICF5Iqdc/BPqaTAEwoLrOYDZ8GaCyIUz1dKwWrs/eKl3Ag=
X-Received: by 2002:a17:906:dff2:: with SMTP id lc18mr9929000ejc.371.1623553830562;
 Sat, 12 Jun 2021 20:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210612042755.28342-1-congdanhqx@gmail.com> <20210612042755.28342-2-congdanhqx@gmail.com>
In-Reply-To: <20210612042755.28342-2-congdanhqx@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 12 Jun 2021 23:10:19 -0400
Message-ID: <CAPig+cR9OnRHYxzVsd6aX=Q_5Fkm4dMxPR2n6kXE+r+cTdw5ug@mail.gmail.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 12:28 AM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> In Git project, we have multiple occasions that requires checking number
> of lines of text in stdout and/or stderr of a command. One of such
> example is t6400, which checks number of files in various states.
>
> Some of those commands are Git command, and we would like to check their
> exit status.  In some of those checks, we pipe the stdout of those
> commands to "wc -l" to check for line count, thus loosing the exit status.
>
> Introduce a helper function to check for number of lines in stdout and
> stderr from those commands.
>
> This helper will create 2 temporary files in process, thus it may affect
> output of some checks.

If the presence of these files is a concern, I wonder if it would make
sense to turn these into dot-files (leading dot in name) or shove them
into the .git/ directory? (Not necessarily an actionable comment; just
tossing around some thoughts.)

> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -817,6 +817,70 @@ test_line_count () {
> +# test_line_count_cmd checks the number of lines of captured stdout and/or
> +# stderr of a command.
> +#
> +# NOTE: this helper function will create 2 temporary files named:
> +# * test_line_count_cmd_.out; and
> +# * test_line_count_cmd_.err
> +#
> +# And this helper function will remove those 2 files if the check is succeed.
> +# In case of failure, those files will be preserved.
> +test_line_count_cmd () {

It would be good to have some usage information in the above comment
so that people aren't forced to consult the implementation to learn
what options this function takes. At minimum, it should mention
`--out`, `--err`, and `!`, and should explain the arguments each
option takes (even if just through examples).

> +       local outop outval
> +       local errop errval
> +
> +       while test $# -ge 3
> +       do
> +               case "$1" in
> +               --out)
> +                       outop="$2"
> +                       outval="$3"
> +                       ;;
> +               --err)
> +                       errop="$2"
> +                       errval="$3"
> +                       ;;
> +               *)
> +                       break
> +                       ;;
> +               esac
> +               shift 3
> +       done &&

This is really minor, but if test_line_count_cmd() ever learns some
new option and that option does not consume two arguments, then the
`shift 3` at the end of the `case/esac` will need to be adjusted in
some fashion. It might make more sense, therefore, to perform the
`shift 3` closer to where it is needed (that is, in the `--out` case
and in the `--err` case) rather than delaying it as is done here. (Not
necessarily worth a re-roll.)

Another minor comment: Since you're &&-chaining everything else in the
function, it wouldn't hurt to also do so for the `local` declarations
and the assignments within each `case` arm, and to chain `esac` with
`shift 3`. Doing so could help some future programmer who might (for
some reason) insert code above the `while` loop, thinking that a
failure in the new code will abort the function, but not realizing
that the &&-chain is not intact in this area of the code.

> +       if test $# = 0 ||
> +          { test "x$1" = "x!" && test $# = 1 ; }
> +       then
> +               BUG "test_line_count_cmd: no command to be run"
> +       fi &&
> +       if test -z "$outop$errop"
> +       then
> +               BUG "test_line_count_cmd: check which stream?"
> +       fi &&
> +
> +       if test "x$1" = "x!"
> +       then
> +               shift &&
> +               if "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
> +               then
> +                       echo "error: '$@' succeed!"
> +                       return 1
> +               fi
> +       elif ! "$@" >test_line_count_cmd_.out 2>test_line_count_cmd_.err
> +       then
> +               echo "error: '$@' run into failure!"
> +               return 1
> +       fi &&

Do we care that the "!" negated case doesn't have the same semantics
as test_must_fail()? If we do care, then should there be a way to tell
the function whether we want test_must_fail() semantics or `!`
semantics (i.e. whether we're running a Git command or a non-Git
command) or should it infer it on its own? (These are genuine
questions -- not necessarily requests for changes -- as I'm trying to
reason through the implications of this implementation choice.)

> +       if test -n "$outop"
> +       then
> +               test_line_count "$outop" "$outval" test_line_count_cmd_.out
> +       fi &&
> +       if test -n "$errop"
> +       then
> +               test_line_count "$errop" "$errval" test_line_count_cmd_.err
> +       fi &&
> +       rm -f test_line_count_cmd_.out test_line_count_cmd_.err
> +}
