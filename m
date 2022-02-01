Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579FDC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 09:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiBAJjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 04:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiBAJjn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 04:39:43 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388CC061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 01:39:43 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 23so48966658ybf.7
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 01:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ReFQ0bW/PiADUPnTK4BqpSVkQhNTGQBaEzNXQsruH+w=;
        b=lgkxjjfS4SoS99xXNIRkYfjodTYQHW5jbfb+RAtnGhRWrsDKZXu7xLXFV/7Bx1DERY
         h9e/OBK5JanZvRNTQ7+eyzKfKS1FT2q3NKLDBQILh2pRm7Li0kzNMTwzC6nZUd06Cz4j
         8h7lOfsQSJojE1iPH4TTC8xJQMYxiZSrn291j2L6woQCv3kdYteqYsDiP9q4T/Cj76mI
         tiMXqJ8BXjJnjI8+WSpBkvKanZllgFbUTjW2gSkquOsz5n6FCPtq1C2bvt3sBHi0u+EG
         uscR/rg55AYWNlAc2EQF3KqitqluF08VoJu49XoOfmlBMhb3/ixp+yMwf90FegLaoCV3
         klqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ReFQ0bW/PiADUPnTK4BqpSVkQhNTGQBaEzNXQsruH+w=;
        b=UWExHtk7k5YqbNFxd7EtfJXB/alGnhGhuHmEVYPrZD9PoDvrdtkfMMdAY+PC2hMXIT
         W9Z7PmtvVyyry9pZLgu/PHACxgyMlSA3QJnT+tSAiZlTHZiFfDm1CLJ3IFxqIZEf2Yjv
         rRtbdYJKtahqCfVtRxqQh9lfcREKJboJtNh+Xw0sRabS2JDbp0ZptRSK5hunyztGoh+I
         uu13iosWC0hbKDNnsaq8psq7T1qY+FMP2HrKA+/KvqiKRKimX95JZa4x635zgFv+6Jv4
         efW275glBxI3Al4tx5XLaND9tx29qZUhFRbWAEHXhonvxWbxf/PNUtVcXKZIJGZ6kWCb
         zlmw==
X-Gm-Message-State: AOAM532DVR5PrVPKVlvdui/bOxjtox/7B1A6cXx+cm/PFqxO4tjBK4Yg
        TTUjJ7+9N0zEblS1y5RPufbdlI4+yTHDitV9T6M=
X-Google-Smtp-Source: ABdhPJzmzPk4rGZQGgq5/3edeyRkdV8PXbQY1sjtcSj8HeXEk37nLyqG80sJLTuDod/4t4ksXXfsnbn3wF9F/5gv+BY=
X-Received: by 2002:a25:5057:: with SMTP id e84mr36361923ybb.404.1643708382165;
 Tue, 01 Feb 2022 01:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20220128183319.43496-1-johncai86@gmail.com>
In-Reply-To: <20220128183319.43496-1-johncai86@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 1 Feb 2022 10:39:30 +0100
Message-ID: <CAP8UFD3sHvA3Gx9+d=VjQ11sEqWF47AEeo-m4bGsVO3OUJ4dLw@mail.gmail.com>
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
To:     John Cai <johncai86@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 9:34 PM John Cai <johncai86@gmail.com> wrote:
>
> This RFC patch proposes a new flag --batch-command that works with
> git-cat-file --batch.

The subject is "Re: [RFC v3] cat-file: add a --stdin-cmd mode" and now
you are talking about '--batch-command' instead of '--stdin-cmd'.

"that works with git-cat-file --batch" is not very clear. Maybe you
could find a wording that explains better how --batch-command is
different from --batch.

Also I think at this point this should probably not be an RFC patch
anymore but a regular one.

> Similar to git-update-ref --stdin, it will accept
> commands and arguments from stdin.
>
> The start of this idea was discussed in [1], where the original
> motivation was to be able to control when the buffer was flushed to
> stdout in --buffer mode.

That would be nice in a cover letter but I am not sure a commit
message is the right place for this.

> However, this can actually be much more useful in situations when
> git-cat-file --batch is being used as a long lived backend query
> process. At GitLab, we use a pair of cat-file processes. One for
> iterating over object metadata with --batch-check, and the other to grab
> object contents with --batch. However, if we had --batch-command, we coul=
d
> get rid of the second --batch-check process,

Maybe s/second// would make it clear that there are no two
--batch-command processes.

> and just have one process
> where we can flip between getting object info, and getting object content=
s.
> This can lead to huge savings since on a given server there could be hund=
reds to
> thousands of git cat-file processes at a time.

It's not clear if all the git cat-file processes you are talking about
are mostly --batch-check processes or --batch processes, or a roughly
equal amount of both. My guess is the latter and that --batch-command
would mean that there would be around two times fewer cat-file
processes.

> git cat-file --batch-command
>
> $ <command> [arg1] [arg2] NL

It's a bit unclear what the 2 above lines mean. Maybe you could add a
small explanation like for example "The new flag can be used like
this:" and "It receives commands from stdin in the format:"

Also not sure why there is a '$' char in front of '<command> [arg1]
[arg2] NL' but not in front of 'git cat-file --batch-command'. It
doesn't look like in the 'git update-ref --stdin' doc that '$' are
used in front of the commands that can be passed through stdin.

> This patch adds three commands: object, info, fflush

Maybe s/three commands/the following first three commands/

> $ object <sha1> NL
> $ info <sha1> NL
> $ fflush NL

Idem about '$'.

> These three would be immediately useful in GitLab's context, but one can
> imagine this mode to be further extended for other things.

Not very clear which "mode" you are talking about. You have been
talking about a mode only in the subject so far. Maybe you should talk
a bit about that above when '<command> [arg1] [arg2] NL' is
introduced.

Also you don't talk about the output format. --batch and --batch-check
accept [=3D<format>], but it looks like --batch-command doesn't.

> Future improvements:
> - a non-trivial part of "cat-file --batch" time is spent
> on parsing its argument and seeing if it's a revision, ref etc. So we
> could add a command that only accepts a full-length 40
> character SHA-1.

In a cover letter that would be ok, but I am not sure that a commit
message is the best place for this kind of details about future work.

> This would be the first step in adding such an interface to
> git-cat-file.
>
> [1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget=
@gmail.com/
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>
> Taylor, I'd be interested in your thoughts on this proposal since you hel=
ped
> review the previous patch that turned into this RFC. Thanks!
>
> Changes from v2:
>
> - refactored tests to be within run_tests()
> - added a test to test --buffer behavior with fflush
> - cleaned up cat-file.c: clarified var names, removed unnecessary code
>   based on suggestions from Phillip Wood
> - removed strvec changes
>
> Changes from v1:
>
> - changed option name to batch-command.
> - changed command function interface to receive the whole line after the =
command
>   name to put the onus of parsing arguments to each individual command fu=
nction.
> - pass in whole line to batch_one_object in both parse_cmd_object and
>   parse_cmd_info to support spaces in the object reference.
> - removed addition of -z to include in a separate patch series
> - added documentation.
> ---
>  Documentation/git-cat-file.txt |  15 +++++
>  builtin/cat-file.c             | 114 +++++++++++++++++++++++++++++++--
>  t/t1006-cat-file.sh            |  83 ++++++++++++++++++++++++
>  3 files changed, 205 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.=
txt
> index bef76f4dd0..254e546c79 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -96,6 +96,21 @@ OPTIONS
>         need to specify the path, separated by whitespace.  See the
>         section `BATCH OUTPUT` below for details.
>
> +--batch-command::
> +       Enter a command mode that reads from stdin.

Maybe s/a command mode that reads from stdin/a mode that reads
commands from stdin/

Also I would expect something about the output, like perhaps "...and
ouputs the command results to stdout".

> May not be combined with any
> +       other options or arguments except `--textconv` or `--filters`, in=
 which
> +       case the input lines also need to specify the path, separated by
> +       whitespace.  See the section `BATCH OUTPUT` below for details.

The BATCH OUTPUT section says that a format can be passed but that
doesn't seem to be the case with --batch-command. So you might need to
make some changes to that section too or add a bit more details about
the output here.

> +object <object>::
> +       Print object contents for object reference <object>
> +
> +info <object>::
> +       Print object info for object reference <object>
> +
> +flush::
> +       Flush to stdout immediately when used with --buffer
> +
>  --batch-all-objects::
>         Instead of reading a list of objects on stdin, perform the
>         requested batch operation on all objects in the repository and
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 7b3f42950e..cc9e47943b 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -24,9 +24,11 @@ struct batch_options {
>         int buffer_output;
>         int all_objects;
>         int unordered;
> -       int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
> +       int mode; /* may be 'w' or 'c' for --filters or --textconv */
>         const char *format;
> +       int command;
>  };

Maybe add a blank line here.

> +static char line_termination =3D '\n';
>
>  static const char *force_path;
>
> @@ -302,19 +304,19 @@ static void print_object_or_die(struct batch_option=
s *opt, struct expand_data *d
>         if (data->type =3D=3D OBJ_BLOB) {
>                 if (opt->buffer_output)
>                         fflush(stdout);
> -               if (opt->cmdmode) {
> +               if (opt->mode) {

The mechanical s/cmdmode/mode/g change could have been made in a
preparatory patch to make this patch a bit smaller and easier to
digest.

> +static void batch_objects_command(struct batch_options *opt,
> +                                   struct strbuf *output,
> +                                   struct expand_data *data)
> +{
> +       struct strbuf input =3D STRBUF_INIT;
> +
> +       /* Read each line dispatch its command */
> +       while (!strbuf_getwholeline(&input, stdin, line_termination)) {
> +               int i;
> +               const struct parse_cmd *cmd =3D NULL;
> +               const char *p, *cmd_end;
> +
> +               if (*input.buf =3D=3D line_termination)
> +                       die("empty command in input");
> +               else if (isspace(*input.buf))
> +                       die("whitespace before command: %s", input.buf);
> +
> +               for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
> +                       const char *prefix =3D commands[i].prefix;
> +                       char c;
> +                       if (!skip_prefix(input.buf, prefix, &cmd_end))
> +                               continue;
> +                       /*
> +                        * If the command has arguments, verify that it's
> +                        * followed by a space. Otherwise, it shall be fo=
llowed
> +                        * by a line terminator.
> +                        */
> +                       c =3D commands[i].takes_args ? ' ' : line_termina=
tion;
> +                       if (input.buf[strlen(prefix)] !=3D c)
> +                               die("arguments invalid for command: %s", =
commands[i].prefix);
> +
> +                       cmd =3D &commands[i];
> +                       if (cmd->takes_args) {
> +                               p =3D cmd_end + 1;
> +                               // strip newline before handing it to the
> +                               // handling function

So above the /* */ comments delimiters are used but here // is used. I
am not sure we support // these days, but if we do, I think it would
be better to avoid mixing comment styles in the same function.

> +                               input.buf[strcspn(input.buf, "\n")] =3D '=
\0';
> +                       }
> +
> +                       break;
> +               }
> +
> +               if (!cmd)
> +                       die("unknown command: %s", input.buf);
> +
> +               cmd->fn(opt, p, output, data);
> +       }
> +       strbuf_release(&input);
> +}

> @@ -590,6 +682,9 @@ static int batch_objects(struct batch_options *opt)
>         save_warning =3D warn_on_object_refname_ambiguity;
>         warn_on_object_refname_ambiguity =3D 0;
>
> +       if (command)
> +               batch_objects_command(opt, &output, &data);
> +
>         while (strbuf_getline(&input, stdin) !=3D EOF) {

I think batch_objects_command() will consume everything from stdin, so
it doesn't make sense to try to read again from stdin after it. Maybe
the whole while (...) { ... } clause should be inside an else clause
or something.

>                 if (data.split_on_whitespace) {
>                         /*
> @@ -636,6 +731,7 @@ static int batch_option_callback(const struct option =
*opt,
>
>         bo->enabled =3D 1;
>         bo->print_contents =3D !strcmp(opt->long_name, "batch");
> +       bo->command =3D !strcmp(opt->long_name, "batch-command");
>         bo->format =3D arg;
>
>         return 0;
