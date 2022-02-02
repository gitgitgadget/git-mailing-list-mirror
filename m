Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786A4C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 13:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344262AbiBBNL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 08:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiBBNLY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 08:11:24 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C01BC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 05:11:24 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id j24so15716369qkk.10
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 05:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwHqSBYt7IjLjzKcq97VDJAeH93FiZR8qbneTVzNan0=;
        b=AlQSpu9ldHlSMC7PrKDBvOxWl2Jz3681TdoQJAC2I3pEtFIB2uUgRIFli9E/HuSXs/
         tDgHrBroeDGEMBhC0PrcYCAmm5xsQR7u90xuHoOL4yBvE+90eja2ZHUzIxeJ92eJCkDO
         AHbyMFjtB5IRGnYy8aH61ZI3uKGKLz8Z33tadOkkWDmkDTX6brNBy7VJpZrjIk4QsmLt
         ySBgfotnMaG9M4L9gTjBFTIohdBoeWPKIT7w7+XavY9b24lz1cG5DqgxJD6oyGEx7gkS
         XdwjSxTzWh0Hdlj5Ptb9P6FkUJhJ3pHaBmFVQHYHKh1RNg++MsoyNxSqzb2nkLxBGsXC
         O/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwHqSBYt7IjLjzKcq97VDJAeH93FiZR8qbneTVzNan0=;
        b=Z30iFK3DquvuZpFVyUrzdVh0bxBc8TjaMNHQyG5uguBjEMz7o7z+Hzm1+7MfqP6cCz
         XvbYmIt9F/9qjBVB1lKEqXMM2aQIIpLuznqZYKxxLRGVYiHSwrvtRsVUJpiQUbAVagen
         LQEsBPULJ3xBsRRdbS+ErZ0uuAdU/14JTOkENUpKrj1v+IHR49h9wXoRIA1GJLkMjaoN
         RSQJD0rv++zY5WMzrYSjCKQXDwX0evvppRyH2Olqy27/WcBU/zJe40AZrwHBopK1WdXF
         O9ReWRZbRBrrZhi7Ds8IUZg4glCyIlW+1Iw0Mhnjjujhq1TcKxE8QfDzHKlw565f2hxM
         Rmzg==
X-Gm-Message-State: AOAM533uTi3oVPDCMBA1ebf0q41Rw2bHWISJOMi6UgUH5H6+po+6afat
        /bSV7+QiYBY1lM70HAeS4fWV65ZhAWmhpQ==
X-Google-Smtp-Source: ABdhPJw7aRWHk6Eylg12bcnoVrtjuptOhBv9ftTTCf+dh4H3fvYqbnu6UfS/YX5c3nYIzKrtKmm3mg==
X-Received: by 2002:a05:620a:2406:: with SMTP id d6mr20019637qkn.212.1643807483417;
        Wed, 02 Feb 2022 05:11:23 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id u21sm11383748qtw.80.2022.02.02.05.11.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Feb 2022 05:11:22 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
Date:   Wed, 02 Feb 2022 08:11:22 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <A17C623A-D6F7-4300-AE72-64DDE49A5DAA@gmail.com>
In-Reply-To: <CAP8UFD3sHvA3Gx9+d=VjQ11sEqWF47AEeo-m4bGsVO3OUJ4dLw@mail.gmail.com>
References: <20220128183319.43496-1-johncai86@gmail.com>
 <CAP8UFD3sHvA3Gx9+d=VjQ11sEqWF47AEeo-m4bGsVO3OUJ4dLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian

On 1 Feb 2022, at 4:39, Christian Couder wrote:

> On Mon, Jan 31, 2022 at 9:34 PM John Cai <johncai86@gmail.com> wrote:
>>
>> This RFC patch proposes a new flag --batch-command that works with
>> git-cat-file --batch.
>
> The subject is "Re: [RFC v3] cat-file: add a --stdin-cmd mode" and now
> you are talking about '--batch-command' instead of '--stdin-cmd'.
>
> "that works with git-cat-file --batch" is not very clear. Maybe you
> could find a wording that explains better how --batch-command is
> different from --batch.
>
> Also I think at this point this should probably not be an RFC patch
> anymore but a regular one.
>
>> Similar to git-update-ref --stdin, it will accept
>> commands and arguments from stdin.
>>
>> The start of this idea was discussed in [1], where the original
>> motivation was to be able to control when the buffer was flushed to
>> stdout in --buffer mode.
>
> That would be nice in a cover letter but I am not sure a commit
> message is the right place for this.
>
>> However, this can actually be much more useful in situations when
>> git-cat-file --batch is being used as a long lived backend query
>> process. At GitLab, we use a pair of cat-file processes. One for
>> iterating over object metadata with --batch-check, and the other to gr=
ab
>> object contents with --batch. However, if we had --batch-command, we c=
ould
>> get rid of the second --batch-check process,
>
> Maybe s/second// would make it clear that there are no two
> --batch-command processes.
>
>> and just have one process
>> where we can flip between getting object info, and getting object cont=
ents.
>> This can lead to huge savings since on a given server there could be h=
undreds to
>> thousands of git cat-file processes at a time.
>
> It's not clear if all the git cat-file processes you are talking about
> are mostly --batch-check processes or --batch processes, or a roughly
> equal amount of both. My guess is the latter and that --batch-command
> would mean that there would be around two times fewer cat-file
> processes.
>
>> git cat-file --batch-command
>>
>> $ <command> [arg1] [arg2] NL
>
> It's a bit unclear what the 2 above lines mean. Maybe you could add a
> small explanation like for example "The new flag can be used like
> this:" and "It receives commands from stdin in the format:"
>
> Also not sure why there is a '$' char in front of '<command> [arg1]
> [arg2] NL' but not in front of 'git cat-file --batch-command'. It
> doesn't look like in the 'git update-ref --stdin' doc that '$' are
> used in front of the commands that can be passed through stdin.
>
>> This patch adds three commands: object, info, fflush
>
> Maybe s/three commands/the following first three commands/
>
>> $ object <sha1> NL
>> $ info <sha1> NL
>> $ fflush NL
>
> Idem about '$'.
>
>> These three would be immediately useful in GitLab's context, but one c=
an
>> imagine this mode to be further extended for other things.
>
> Not very clear which "mode" you are talking about. You have been
> talking about a mode only in the subject so far. Maybe you should talk
> a bit about that above when '<command> [arg1] [arg2] NL' is
> introduced.
>
> Also you don't talk about the output format. --batch and --batch-check
> accept [=3D<format>], but it looks like --batch-command doesn't.
>
>> Future improvements:
>> - a non-trivial part of "cat-file --batch" time is spent
>> on parsing its argument and seeing if it's a revision, ref etc. So we
>> could add a command that only accepts a full-length 40
>> character SHA-1.
>
> In a cover letter that would be ok, but I am not sure that a commit
> message is the best place for this kind of details about future work.
>
>> This would be the first step in adding such an interface to
>> git-cat-file.
>>
>> [1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgad=
get@gmail.com/
>>
>> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>>
>> Taylor, I'd be interested in your thoughts on this proposal since you =
helped
>> review the previous patch that turned into this RFC. Thanks!
>>
>> Changes from v2:
>>
>> - refactored tests to be within run_tests()
>> - added a test to test --buffer behavior with fflush
>> - cleaned up cat-file.c: clarified var names, removed unnecessary code=

>>   based on suggestions from Phillip Wood
>> - removed strvec changes
>>
>> Changes from v1:
>>
>> - changed option name to batch-command.
>> - changed command function interface to receive the whole line after t=
he command
>>   name to put the onus of parsing arguments to each individual command=
 function.
>> - pass in whole line to batch_one_object in both parse_cmd_object and
>>   parse_cmd_info to support spaces in the object reference.
>> - removed addition of -z to include in a separate patch series
>> - added documentation.
>> ---
>>  Documentation/git-cat-file.txt |  15 +++++
>>  builtin/cat-file.c             | 114 +++++++++++++++++++++++++++++++-=
-
>>  t/t1006-cat-file.sh            |  83 ++++++++++++++++++++++++
>>  3 files changed, 205 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fi=
le.txt
>> index bef76f4dd0..254e546c79 100644
>> --- a/Documentation/git-cat-file.txt
>> +++ b/Documentation/git-cat-file.txt
>> @@ -96,6 +96,21 @@ OPTIONS
>>         need to specify the path, separated by whitespace.  See the
>>         section `BATCH OUTPUT` below for details.
>>
>> +--batch-command::
>> +       Enter a command mode that reads from stdin.
>
> Maybe s/a command mode that reads from stdin/a mode that reads
> commands from stdin/
>
> Also I would expect something about the output, like perhaps "...and
> ouputs the command results to stdout".
>
>> May not be combined with any
>> +       other options or arguments except `--textconv` or `--filters`,=
 in which
>> +       case the input lines also need to specify the path, separated =
by
>> +       whitespace.  See the section `BATCH OUTPUT` below for details.=

>
> The BATCH OUTPUT section says that a format can be passed but that
> doesn't seem to be the case with --batch-command. So you might need to
> make some changes to that section too or add a bit more details about
> the output here.

Thinking about this more, I wonder if it'd be worth it to allow the --bat=
ch-command=3D<format>
for backwards compatibility reasons for users who switch over to using --=
batch-command
from --batch and --batch-check.

The only thing that makes me hesitant is that the <format> would only be =
relevant to
the "info" and "object" commands instead of being relevant to all command=
s in --batch-command
mode.

>
>> +object <object>::
>> +       Print object contents for object reference <object>
>> +
>> +info <object>::
>> +       Print object info for object reference <object>
>> +
>> +flush::
>> +       Flush to stdout immediately when used with --buffer
>> +
>>  --batch-all-objects::
>>         Instead of reading a list of objects on stdin, perform the
>>         requested batch operation on all objects in the repository and=

>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 7b3f42950e..cc9e47943b 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -24,9 +24,11 @@ struct batch_options {
>>         int buffer_output;
>>         int all_objects;
>>         int unordered;
>> -       int cmdmode; /* may be 'w' or 'c' for --filters or --textconv =
*/
>> +       int mode; /* may be 'w' or 'c' for --filters or --textconv */
>>         const char *format;
>> +       int command;
>>  };
>
> Maybe add a blank line here.
>
>> +static char line_termination =3D '\n';
>>
>>  static const char *force_path;
>>
>> @@ -302,19 +304,19 @@ static void print_object_or_die(struct batch_opt=
ions *opt, struct expand_data *d
>>         if (data->type =3D=3D OBJ_BLOB) {
>>                 if (opt->buffer_output)
>>                         fflush(stdout);
>> -               if (opt->cmdmode) {
>> +               if (opt->mode) {
>
> The mechanical s/cmdmode/mode/g change could have been made in a
> preparatory patch to make this patch a bit smaller and easier to
> digest.
>
>> +static void batch_objects_command(struct batch_options *opt,
>> +                                   struct strbuf *output,
>> +                                   struct expand_data *data)
>> +{
>> +       struct strbuf input =3D STRBUF_INIT;
>> +
>> +       /* Read each line dispatch its command */
>> +       while (!strbuf_getwholeline(&input, stdin, line_termination)) =
{
>> +               int i;
>> +               const struct parse_cmd *cmd =3D NULL;
>> +               const char *p, *cmd_end;
>> +
>> +               if (*input.buf =3D=3D line_termination)
>> +                       die("empty command in input");
>> +               else if (isspace(*input.buf))
>> +                       die("whitespace before command: %s", input.buf=
);
>> +
>> +               for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>> +                       const char *prefix =3D commands[i].prefix;
>> +                       char c;
>> +                       if (!skip_prefix(input.buf, prefix, &cmd_end))=

>> +                               continue;
>> +                       /*
>> +                        * If the command has arguments, verify that i=
t's
>> +                        * followed by a space. Otherwise, it shall be=
 followed
>> +                        * by a line terminator.
>> +                        */
>> +                       c =3D commands[i].takes_args ? ' ' : line_term=
ination;
>> +                       if (input.buf[strlen(prefix)] !=3D c)
>> +                               die("arguments invalid for command: %s=
", commands[i].prefix);
>> +
>> +                       cmd =3D &commands[i];
>> +                       if (cmd->takes_args) {
>> +                               p =3D cmd_end + 1;
>> +                               // strip newline before handing it to =
the
>> +                               // handling function
>
> So above the /* */ comments delimiters are used but here // is used. I
> am not sure we support // these days, but if we do, I think it would
> be better to avoid mixing comment styles in the same function.
>
>> +                               input.buf[strcspn(input.buf, "\n")] =3D=
 '\0';
>> +                       }
>> +
>> +                       break;
>> +               }
>> +
>> +               if (!cmd)
>> +                       die("unknown command: %s", input.buf);
>> +
>> +               cmd->fn(opt, p, output, data);
>> +       }
>> +       strbuf_release(&input);
>> +}
>
>> @@ -590,6 +682,9 @@ static int batch_objects(struct batch_options *opt=
)
>>         save_warning =3D warn_on_object_refname_ambiguity;
>>         warn_on_object_refname_ambiguity =3D 0;
>>
>> +       if (command)
>> +               batch_objects_command(opt, &output, &data);
>> +
>>         while (strbuf_getline(&input, stdin) !=3D EOF) {
>
> I think batch_objects_command() will consume everything from stdin, so
> it doesn't make sense to try to read again from stdin after it. Maybe
> the whole while (...) { ... } clause should be inside an else clause
> or something.
>
>>                 if (data.split_on_whitespace) {
>>                         /*
>> @@ -636,6 +731,7 @@ static int batch_option_callback(const struct opti=
on *opt,
>>
>>         bo->enabled =3D 1;
>>         bo->print_contents =3D !strcmp(opt->long_name, "batch");
>> +       bo->command =3D !strcmp(opt->long_name, "batch-command");
>>         bo->format =3D arg;
>>
>>         return 0;
