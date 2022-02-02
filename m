Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6461CC433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 17:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiBBRPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 12:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBBRPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 12:15:11 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3B5C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 09:15:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id o12so67513093eju.13
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cRwwaEB1J2f6k19mSWEFN/Alfu5s3fWfpYkfIkuBm4s=;
        b=c3hfEF2D2DaFj741Ome1ydu5F8swWCT2MQS8Xd9fP25KO6Ae1tq75yLdDlP5oJfK5K
         b3gA/JzNk0KJ+BxmKr8k/bPrGZmbLqyZMgO33UQJYcKE1emLq24V+K4ip6encGEpGZe9
         4E3zj0q0JVJPZwE6+OGsM4jGJydEqbSHPR8562o2+aVTjabhJTkLVcBn0f+uYIOEoy8U
         1YgA/53XAeZKLAqaQA3BB9tUWBK/3NfkgmKWX3CBjPZNeevA2ywq83TDIGmAOU+VpPlD
         VVQ8lEN5uZReieWERDSX2oJ/NIMcnPenOrLQPTZ070Nox6txH4LOdmnMbRo3eQfi5RiD
         zY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRwwaEB1J2f6k19mSWEFN/Alfu5s3fWfpYkfIkuBm4s=;
        b=7KW+bBIznNP70vV6wsI9/giwTCdUxc03l47GqZHHeBhhN+I8+82rDHM6NW3MkwuXNH
         90QkCOmv+oXWh6lbeyMhI63PCuko5WOo4wUTacGaAgPPQEcPSYm7gwbiqyVAgLYxifsW
         W6CYAArQUTVVM6SjiO3mGyytNajfdPQFIVFx9h/yeP4yRjo5r/FZD7I16m+AbQ8neyPm
         LHFU1NAe/dZClJvSVvTJ5ifeMU3gdYszM0r6mrJ4dztRKzCRorvVLMqCWufx+6eftGf+
         7fwOrVvjARy03AzBvGcEd97lEKek846SWnZdFeUwfXbzUpRCqVRcZXKIEvtYG/yMtN2j
         CTXg==
X-Gm-Message-State: AOAM530BLSWH3jiwshaN93p19o7BOJ5xbHWWoxrJlm/cFfAbtttSayMu
        zcUPh6DwuT5xFdxJRHKT9a0=
X-Google-Smtp-Source: ABdhPJylgTaPtnOMJsLvDATBSeaGcNCtLybLeCqKwOVjLcRFbYaAUvS/rwcpoDgEQfgBJaDKmFlITA==
X-Received: by 2002:a17:906:9514:: with SMTP id u20mr21497168ejx.227.1643822109134;
        Wed, 02 Feb 2022 09:15:09 -0800 (PST)
Received: from [10.200.48.241] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id c5sm21250045edk.43.2022.02.02.09.15.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Feb 2022 09:15:08 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, avarab@gmail.com, me@ttaylorr.com, e@80x24.org
Subject: Re: [RFC v3] cat-file: add a --stdin-cmd mode
Date:   Wed, 02 Feb 2022 10:05:24 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <20D11066-BFC5-4888-B15B-66FE4EC1A050@gmail.com>
In-Reply-To: <e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gmail.com>
References: <20220128183319.43496-1-johncai86@gmail.com>
 <e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On 1 Feb 2022, at 5:43, Phillip Wood wrote:

> Hi John
>
> On 28/01/2022 18:33, John Cai wrote:
>> This RFC patch proposes a new flag --batch-command that works with
>> git-cat-file --batch. Similar to git-update-ref --stdin, it will accep=
t
>> commands and arguments from stdin.
>>
>> The start of this idea was discussed in [1], where the original
>> motivation was to be able to control when the buffer was flushed to
>> stdout in --buffer mode.
>>
>> However, this can actually be much more useful in situations when
>> git-cat-file --batch is being used as a long lived backend query
>> process. At GitLab, we use a pair of cat-file processes. One for
>> iterating over object metadata with --batch-check, and the other to gr=
ab
>> object contents with --batch. However, if we had --batch-command, we c=
ould
>> get rid of the second --batch-check process, and just have one process=

>> where we can flip between getting object info, and getting object cont=
ents.
>> This can lead to huge savings since on a given server there could be h=
undreds to
>> thousands of git cat-file processes at a time.
>>
>> git cat-file --batch-command
>>
>> $ <command> [arg1] [arg2] NL
>>
>> This patch adds three commands: object, info, fflush
>>
>> $ object <sha1> NL
>> $ info <sha1> NL
>> $ fflush NL
>>
>> These three would be immediately useful in GitLab's context, but one c=
an
>> imagine this mode to be further extended for other things.
>
> I think this is moving in the right direction, I've left some comments =
below.
>
>> Future improvements:
>> - a non-trivial part of "cat-file --batch" time is spent
>> on parsing its argument and seeing if it's a revision, ref etc. So we
>> could add a command that only accepts a full-length 40
>> character SHA-1.
>>
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

>>    based on suggestions from Phillip Wood
>> - removed strvec changes
>>
>> Changes from v1:
>>
>> - changed option name to batch-command.
>> - changed command function interface to receive the whole line after t=
he command
>>    name to put the onus of parsing arguments to each individual comman=
d function.
>> - pass in whole line to batch_one_object in both parse_cmd_object and
>>    parse_cmd_info to support spaces in the object reference.
>> - removed addition of -z to include in a separate patch series
>> - added documentation.
>> ---
>>   Documentation/git-cat-file.txt |  15 +++++
>>   builtin/cat-file.c             | 114 +++++++++++++++++++++++++++++++=
--
>>   t/t1006-cat-file.sh            |  83 ++++++++++++++++++++++++
>>   3 files changed, 205 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fi=
le.txt
>> index bef76f4dd0..254e546c79 100644
>> --- a/Documentation/git-cat-file.txt
>> +++ b/Documentation/git-cat-file.txt
>> @@ -96,6 +96,21 @@ OPTIONS
>>   	need to specify the path, separated by whitespace.  See the
>>   	section `BATCH OUTPUT` below for details.
>>  +--batch-command::
>> +	Enter a command mode that reads from stdin. May not be combined with=
 any
>> +	other options or arguments except `--textconv` or `--filters`, in wh=
ich
>> +	case the input lines also need to specify the path, separated by
>> +	whitespace.  See the section `BATCH OUTPUT` below for details.
>> +
>> +object <object>::
>> +	Print object contents for object reference <object>
>> +
>> +info <object>::
>> +	Print object info for object reference <object>
>> +
>> +flush::
>
> I think this is a better name than fflush as calling fflush is just an =
implementation detail. I've been thinking about this and have some concer=
ns with the current implementation as it allows the caller to force a flu=
sh but the output may be flushed at other times and so it does not allow =
for deadlock free reading and writing to cat-file from a single process. =
If instead we buffered the input lines and only processed then when we re=
ceived a flush command it would be easy to read and write to cat-file fro=
m a single process without deadlocks. This would mean that callers would =
have to add flush commands to get any output before they closed the pipe =
writing to cat-file.

To address this concern, I wonder if instead of a flush command what we c=
ould do is to have --batch-command support "read transactions" similar to=
 update-ref. eg:

git cat-file --batch-command

begin info
<sha1>
<sha1>
<sha1>
<sha1>
commit

We could queue up these references, and then get them all once "commit" i=
s entered and call fflush().

>
>> +	Flush to stdout immediately when used with --buffer
>> +
>>   --batch-all-objects::
>>   	Instead of reading a list of objects on stdin, perform the
>>   	requested batch operation on all objects in the repository and
>> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
>> index 7b3f42950e..cc9e47943b 100644
>> --- a/builtin/cat-file.c
>> +++ b/builtin/cat-file.c
>> @@ -24,9 +24,11 @@ struct batch_options {
>>   	int buffer_output;
>>   	int all_objects;
>>   	int unordered;
>> -	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
>> +	int mode; /* may be 'w' or 'c' for --filters or --textconv */
>
> If you really need to rename  this variable then doing that in a separa=
te preparatory patch would make this easier to review as it separates out=
 two separate sets of changes.
>
>>   	const char *format;
>> +	int command;
>
> Can't we just call this batch_command and leave cmdmode alone? I don't =
know maybe cmdmode would be confused with having something to do with bat=
ch_command then.
>
>>   };
>> +static char line_termination =3D '\n';
>
> This seems unnecessary as it is the only permitted line ending
>
>>   static const char *force_path;
>>  @@ -302,19 +304,19 @@ static void print_object_or_die(struct batch_op=
tions *opt, struct expand_data *d
>>   	if (data->type =3D=3D OBJ_BLOB) {
>>   		if (opt->buffer_output)
>>   			fflush(stdout);
>> -		if (opt->cmdmode) {
>> +		if (opt->mode) {
>>   			char *contents;
>>   			unsigned long size;
>>    			if (!data->rest)
>>   				die("missing path for '%s'", oid_to_hex(oid));
>>  -			if (opt->cmdmode =3D=3D 'w') {
>> +			if (opt->mode =3D=3D 'w') {
>>   				if (filter_object(data->rest, 0100644, oid,
>>   						  &contents, &size))
>>   					die("could not convert '%s' %s",
>>   					    oid_to_hex(oid), data->rest);
>> -			} else if (opt->cmdmode =3D=3D 'c') {
>> +			} else if (opt->mode =3D=3D 'c') {
>>   				enum object_type type;
>>   				if (!textconv_object(the_repository,
>>   						     data->rest, 0100644, oid,
>> @@ -326,7 +328,7 @@ static void print_object_or_die(struct batch_optio=
ns *opt, struct expand_data *d
>>   					die("could not convert '%s' %s",
>>   					    oid_to_hex(oid), data->rest);
>>   			} else
>> -				BUG("invalid cmdmode: %c", opt->cmdmode);
>> +				BUG("invalid mode: %c", opt->mode);
>>   			batch_write(opt, contents, size);
>>   			free(contents);
>>   		} else {
>> @@ -508,6 +510,95 @@ static int batch_unordered_packed(const struct ob=
ject_id *oid,
>>   				      data);
>>   }
>>  +static void parse_cmd_object(struct batch_options *opt,
>> +			     const char *line,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	opt->print_contents =3D 1;
>> +	batch_one_object(line, output, opt, data);
>> +}
>> +
>> +static void parse_cmd_info(struct batch_options *opt,
>> +			   const char *line,
>> +			   struct strbuf *output,
>> +			   struct expand_data *data)
>> +{
>> +	opt->print_contents =3D 0;
>> +	batch_one_object(line, output, opt, data);
>> +}
>> +
>> +static void parse_cmd_fflush(struct batch_options *opt,
>> +			     const char *line,
>> +			     struct strbuf *output,
>> +			     struct expand_data *data)
>> +{
>> +	fflush(stdout);
>> +}
>> +
>> +typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
>> +			       struct strbuf *, struct expand_data *);
>> +
>> +static const struct parse_cmd {
>> +	const char *prefix;
>> +	parse_cmd_fn_t fn;
>> +	unsigned takes_args;
>> +} commands[] =3D {
>> +	{ "object", parse_cmd_object, 1},
>> +	{ "info", parse_cmd_info, 1},
>> +	{ "fflush", parse_cmd_fflush, 0},
>> +};
>> +
>> +static void batch_objects_command(struct batch_options *opt,
>> +				    struct strbuf *output,
>> +				    struct expand_data *data)
>> +{
>> +	struct strbuf input =3D STRBUF_INIT;
>> +
>> +	/* Read each line dispatch its command */
>> +	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
>> +		int i;
>> +		const struct parse_cmd *cmd =3D NULL;
>> +		const char *p, *cmd_end;
>> +
>> +		if (*input.buf =3D=3D line_termination)
>> +			die("empty command in input");
>> +		else if (isspace(*input.buf))
>> +			die("whitespace before command: %s", input.buf);
>> +
>> +		for (i =3D 0; i < ARRAY_SIZE(commands); i++) {
>> +			const char *prefix =3D commands[i].prefix;
>> +			char c;
>> +			if (!skip_prefix(input.buf, prefix, &cmd_end))
>> +				continue;
>> +			/*
>> +			 * If the command has arguments, verify that it's
>> +			 * followed by a space. Otherwise, it shall be followed
>> +			 * by a line terminator.
>> +			 */
>> +			c =3D commands[i].takes_args ? ' ' : line_termination;
>> +			if (input.buf[strlen(prefix)] !=3D c)
>
> As I pointed out in the last round you can use cmd_end here rather than=
 calling strlen. I've just noticed that this will fail for a command that=
 does not take arguments when the last input line does not end with '\n'.=
 I think
>     if (*cmd_end && *cmd_end !=3D c)
> would be safer
>
>> +				die("arguments invalid for command: %s", commands[i].prefix);
>> +
>> +			cmd =3D &commands[i];
>> +			if (cmd->takes_args) {
>> +				p =3D cmd_end + 1;
>> +				// strip newline before handing it to the
>> +				// handling function
>> +				input.buf[strcspn(input.buf, "\n")] =3D '\0';
>
> When I suggested replacing strstr() last time I failed to notice that w=
e  know that if there is a newline character it is at input.buf[len - 1] =
so we don't need to scan the whole string to find it.
>
>     if (input.buf[input.len - 1] =3D=3D '\n')
>     	input.buf[--buf.len] =3D '\0';
>
> (feel free to change it to avoid the prefix operator)
>
>> +			}
>> +
>> +			break;
>> +		}
>> +
>> +		if (!cmd)
>> +			die("unknown command: %s", input.buf);
>> +
>> +		cmd->fn(opt, p, output, data);
>> +	}
>> +	strbuf_release(&input);
>> +}
>> +
>>   static int batch_objects(struct batch_options *opt)
>>   {
>>   	struct strbuf input =3D STRBUF_INIT;
>> @@ -515,6 +606,7 @@ static int batch_objects(struct batch_options *opt=
)
>>   	struct expand_data data;
>>   	int save_warning;
>>   	int retval =3D 0;
>> +	const int command =3D opt->command;
>>    	if (!opt->format)
>>   		opt->format =3D "%(objectname) %(objecttype) %(objectsize)";
>> @@ -529,7 +621,7 @@ static int batch_objects(struct batch_options *opt=
)
>>   	strbuf_expand(&output, opt->format, expand_format, &data);
>>   	data.mark_query =3D 0;
>>   	strbuf_release(&output);
>> -	if (opt->cmdmode)
>> +	if (opt->mode)
>>   		data.split_on_whitespace =3D 1;
>>    	/*
>> @@ -590,6 +682,9 @@ static int batch_objects(struct batch_options *opt=
)
>>   	save_warning =3D warn_on_object_refname_ambiguity;
>>   	warn_on_object_refname_ambiguity =3D 0;
>>  +	if (command)
>> +		batch_objects_command(opt, &output, &data);
>> +
>
> Moving this is good as we no longer need to touch the line below
>
>>   	while (strbuf_getline(&input, stdin) !=3D EOF) {
>>   		if (data.split_on_whitespace) {
>>   			/*
>> @@ -636,6 +731,7 @@ static int batch_option_callback(const struct opti=
on *opt,
>>    	bo->enabled =3D 1;
>>   	bo->print_contents =3D !strcmp(opt->long_name, "batch");
>> +	bo->command =3D !strcmp(opt->long_name, "batch-command");
>>   	bo->format =3D arg;
>>    	return 0;
>> @@ -683,6 +779,10 @@ int cmd_cat_file(int argc, const char **argv, con=
st char *prefix)
>>   			N_("like --batch, but don't emit <contents>"),
>>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>>   			batch_option_callback),
>> +		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
>> +			 N_("enters batch mode that accepts commands"),
>> +			 PARSE_OPT_NOARG | PARSE_OPT_NONEG,
>> +			 batch_option_callback),
>>   		OPT_CMDMODE(0, "batch-all-objects", &opt,
>>   			    N_("with --batch[-check]: ignores stdin, batches all known ob=
jects"), 'b'),
>>   		/* Batch-specific options */
>> @@ -742,7 +842,7 @@ int cmd_cat_file(int argc, const char **argv, cons=
t char *prefix)
>>   	/* Return early if we're in batch mode? */
>>   	if (batch.enabled) {
>>   		if (opt_cw)
>> -			batch.cmdmode =3D opt;
>> +			batch.mode =3D opt;
>>   		else if (opt && opt !=3D 'b')
>>   			usage_msg_optf(_("'-%c' is incompatible with batch mode"),
>>   				       usage, options, opt);
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index 145eee11df..92f0b14a95 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -112,6 +112,46 @@ maybe_remove_timestamp () {
>>       fi
>>   }
>
> It's really good that you've found a way to test fflush
>
>> +run_buffer_test () {
>> +	type=3D$1
>> +	sha1=3D$2
>> +	size=3D$3
>> +	flush=3D$4
>> +
>> +	mkfifo V.input
>> +	exec 8<>V.input
>> +	rm V.input
>> +
>> +	mkfifo V.output
>> +	exec 9<>V.output
>> +	rm V.output
>> +	=

>> +	(
>> +		git cat-file --buffer --batch-command <&8 >&9 &
>> +		echo $! >&9 &&
>> +		wait $!
>> +		echo >&9 EARLY_EXIT
>> +	) &
>> +	sh_pid=3D$!
>> +	read fi_pid <&9 > +	test_when_finished "
>> +		exec 8>&-; exec 9>&-;
>> +		kill $sh_pid && wait $sh_pid
>> +		kill $fi_pid && wait $fi_pid
>> +		true"
>> +	expect=3D$(echo "$sha1 $type $size")
>> +	echo "info $sha1" >&8
>> +	if test "$flush" =3D "true"
>> +	then
>> +		echo "fflush" >&8
>
> If I change "fflush" to "bad-command" then this test still passes. This=
 is because die() flushes stdout and the read below will get the output i=
t was expecting and not 'EARLY_EXIT'. I have a suggested change below to =
get around that also checks the exit code of "git cat-file" (This test ef=
fectively puts a git command upstream of a pipe which we try to avoid in =
order to pick up any crashes)
>
>> +	else
>> +		expect=3D"EARLY_EXIT"
>> +		kill $fi_pid && wait $fi_pid
>> +	fi
>> +	read actual <&9
>> +	test "$actual" =3D "$expect"
>> +}
>> +
>>   run_tests () {
>>       type=3D$1
>>       sha1=3D$2
>> @@ -177,6 +217,18 @@ $content"
>>   	test_cmp expect actual
>>       '
>
> Here is my suggestion based on your test - I ended up splitting the ffl=
ush and no-fflush cases
>
> run_buffer_test_flush () {
>     type=3D$1
>     sha1=3D$2
>     size=3D$3
>
>     mkfifo input &&
>     test_when_finished 'rm input'
>     mkfifo output &&
>     exec 9<>output &&
>     test_when_finished 'rm output; exec 9<&-'
>     (
>         	# TODO - Ideally we'd pipe the output of cat-file
>         	# through "sed s'/$/\\/'" to make sure that that read
>         	# would consume all the available
>         	# output. Unfortunately we cannot do this as we cannot
>         	# control when sed flushes its output. We could write
>         	# a test helper in C that appended a '\' to the end of
>     	# each line and flushes its output after every line.
>     	git cat-file --buffer --batch-command <input 2>err &
>     	echo $! &&
>     	wait $!
>     	echo $?
>     ) >&9 &
>     sh_pid=3D$! &&
>     read cat_file_pid <&9 &&
>     test_when_finished "kill $cat_file_pid
>     		    kill $sh_pid; wait $sh_pid; :" &&
>     (
>     	test_write_lines "info $sha1" fflush "info $sha1" &&
>     	# TODO - consume all available input, not just one
>     	# line (see above).
>     	read actual <&9 &&
>     	echo "$actual" >actual &&
>     	echo "$sha1 $type $size" >expect &&
>     	test_cmp expect actual
>     ) >input &&
>     # check output is flushed on exit
>     read actual <&9 &&
>     echo "$actual" >actual &&
>     test_cmp expect actual &&
>     test_must_be_empty err &&
>     read status <&9 &&
>     test "$status" -eq 0
> }
>
> run_buffer_test_no_flush () {
>     type=3D$1
>     sha1=3D$2
>     size=3D$3
>
>     mkfifo input &&
>     test_when_finished 'rm input'
>     mkfifo pid &&
>     exec 9<>pid &&
>     test_when_finished 'rm pid; exec 9<&-'
>     (
>     	git cat-file --buffer --batch-command <input >output &
>     	echo $! &&
>     	wait $!
>     	echo $?
>     ) >&9 &
>     sh_pid=3D$! &&
>     read cat_file_pid <&9 &&
>     test_when_finished "kill $cat_file_pid
>     		    kill $sh_pid; wait $sh_pid; :" &&
>     (
>     	test_write_lines "info $sha1" "info $sha1" &&
>     	kill $cat_file_pid &&
>     	read status <&9 &&
>     	test "$status" -ne 0 &&
>     	test_must_be_empty output
>     ) >input
> }
>
> Best Wishes
>
> Phillip
>
>> +    test -z "$content" ||
>> +    test_expect_success "--batch-command output of $type content is c=
orrect" '
>> +	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
>> +	maybe_remove_timestamp "$(echo object $sha1 | git cat-file --batch-c=
ommand)" $no_ts >actual &&
>> +	test_cmp expect actual
>> +    '
>> +
>> +    test_expect_success "batch-command output of $type info is correc=
t" '
>> +	echo "$sha1 $type $size" >expect &&
>> +	echo "info $sha1" | git cat-file --batch-command >actual &&
>> +	test_cmp expect actual
>> +'
>>       test_expect_success "custom --batch-check format" '
>>   	echo "$type $sha1" >expect &&
>>   	echo $sha1 | git cat-file --batch-check=3D"%(objecttype) %(objectna=
me)" >actual &&
>> @@ -232,12 +284,29 @@ test_expect_success '--batch-check without %(res=
t) considers whole line' '
>>   	test_cmp expect actual
>>   '
>>  +test_expect_success '--batch-command --buffer with flush is correct =
for blob' '
>> +	run_buffer_test 'blob' $hello_sha1 $hello_size true
>> +'
>> +
>> +test_expect_success '--batch-command --buffer without flush is correc=
t for blob' '
>> +	run_buffer_test 'blob' $hello_sha1 $hello_size false
>> +'
>> +
>>   tree_sha1=3D$(git write-tree)
>> +
>>   tree_size=3D$(($(test_oid rawsz) + 13))
>>   tree_pretty_content=3D"100644 blob $hello_sha1	hello"
>>    run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
>>  +test_expect_success '--batch-command --buffer with flush is correct =
for tree' '
>> +	run_buffer_test 'tree' $tree_sha1 $tree_size true
>> +'
>> +
>> +test_expect_success '--batch-command --buffer without flush is correc=
t for tree' '
>> +	run_buffer_test 'tree' $tree_sha1 $tree_size false
>> +'
>> +
>>   commit_message=3D"Initial commit"
>>   commit_sha1=3D$(echo_without_newline "$commit_message" | git commit-=
tree $tree_sha1)
>>   commit_size=3D$(($(test_oid hexsz) + 137))
>> @@ -263,6 +332,14 @@ tag_size=3D$(strlen "$tag_content")
>>    run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1=

>>  +test_expect_success '--batch-command --buffer with flush is correct =
for tag' '
>> +	run_buffer_test 'tag' $tag_sha1 $tag_size true
>> +'
>> +
>> +test_expect_success '--batch-command --buffer without flush is correc=
t for tag' '
>> +	run_buffer_test 'tag' $tag_sha1 $tag_size false
>> +'
>> +
>>   test_expect_success \
>>       "Reach a blob from a tag pointing to it" \
>>       "test '$hello_content' =3D \"\$(git cat-file blob $tag_sha1)\""
>> @@ -964,4 +1041,10 @@ test_expect_success 'cat-file --batch-all-object=
s --batch-check ignores replace'
>>   	test_cmp expect actual
>>   '
>>  +test_expect_success 'batch-command unknown command' '
>> +	echo unknown_command >cmd &&
>> +	test_expect_code 128 git cat-file --batch-command < cmd 2>err &&
>> +	grep -E "^fatal:.*unknown command.*" err
>> +'
>> +
>>   test_done
