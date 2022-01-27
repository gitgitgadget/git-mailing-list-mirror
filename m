Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC839C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 11:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbiA0LZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiA0LZh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 06:25:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F06C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:25:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s9so4151254wrb.6
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X0DxfmVCVEy8M8b0JjFBZbtJewzcPEY4RAbe0D+HN6M=;
        b=linOykNYdtjoPHnLRmgGXXzyZaUntt6an+Y20bYvImu9+odd4kS1k2vFUoXNSFmEwk
         wTws6fqCmIuMVw/nnFCZ6GK0fYq6EI9E/ncRmTERwnegsHiu3PXco4Tuaqth+cEs++Bq
         BFKMW8mUGeeXYc/7tlsUOMNg5jVoidkbUvo/Z5uQCjW2Q1UUBtsCO1BeKse1gl7n/ggD
         uQJiKTxD674OEQG3dbLe4/xG9snkkn/wvaXnNvOVT0s9xKChuNhYHf+a9EoyLdDkeKGc
         92iVZ7IIz3CQ6SPK1iThRutpV9OEP8b2IGVz1CZmPk7yMXnD17gjjmKQ/GqBHwc8mQm1
         R+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X0DxfmVCVEy8M8b0JjFBZbtJewzcPEY4RAbe0D+HN6M=;
        b=yKK9tya0MwHe85RFNOanm9quALFvyCD/rw6b1jCj+DVfPpTx5Cz64XlEBU4YmLTVY8
         0qPqY3h1o6xA9vcd3ibcH3Xl1ox6Fu1t4AkS+ulb/TkuITpoZjoKu3ysKu34FI14hi/j
         IANuknuFjxVfjfypQ/aEJUA2cVGVmVr1O12WadzMZDIUDpEexwh+1viveG7g2GO0f9df
         RFX99V27HM3Mun7WOx1mLPnnEgIG1dMmTJWEjERGUPk9hN+9Jk5alLqDjIS94VwxG7zz
         gBu1VlevEcSZxCdwQPksEF4fNIGFzrhtzAMycg3E1BX2PG1CqV6KKoBHc+4liKbapkQQ
         k29Q==
X-Gm-Message-State: AOAM532kr1zqgK5itiXqUkqKESou3xRSKaVQOGmw4MVJIFKIv5oUE5py
        OF9J0CcRjpsJq3WK407Si4w=
X-Google-Smtp-Source: ABdhPJyhAHeGU9VDOd0Sxw9LDtmYMNlB8uQqStuHUBWFT24rf32dX5HDKcjHilif5t3/GpuoF7cHaw==
X-Received: by 2002:a5d:6d8b:: with SMTP id l11mr2596534wrs.595.1643282735903;
        Thu, 27 Jan 2022 03:25:35 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id y15sm3022187wry.36.2022.01.27.03.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 03:25:35 -0800 (PST)
Message-ID: <1540ee6b-d7ef-428e-d2f8-74bc4847c34f@gmail.com>
Date:   Thu, 27 Jan 2022 11:25:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC v2] cat-file: add a --stdin-cmd mode
Content-Language: en-US
To:     John Cai <johncai86@gmail.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, me@ttaylorr.com
References: <20220125225008.45944-1-johncai86@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220125225008.45944-1-johncai86@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 25/01/2022 22:50, John Cai wrote:
> This RFC patch proposes a new flag --stdin-cmd that works with
> git-cat-file --batch. Similar to git-update-ref --stdin, it will accept
> commands and arguments from stdin.
> 
> The start of this idea was discussed in [1], where the original
> motivation was to be able to control when the buffer was flushed to
> stdout in --buffer mode.
> 
> However, this can actually be much more useful in situations when
> git-cat-file --batch is being used as a long lived backend query
> process. At GitLab, we use a pair of cat-file processes. One for
> iterating over object metadata with --batch-check, and the other to grab
> object contents with --batch. However, if we had --stdin-cmd, we could
> get rid of the second --batch-check process, and just have one progress
> where we can flip between getting object info, and getting object contents.
> This can lead to huge savings.
> 
> git cat-file --batch --stdin-cmd
> 
> $ <command> [arg1] [arg2] NL
> 
> We can also add a -z mode to allow for NUL-terminated lines
> 
> $ <command> [arg1] [arg2] NUL
> 
> This patch adds three commands: object, info, fflush
> 
> $ object <sha1> NL
> $ info <sha1> NL
> $ fflush NL
> 
> These three would be immediately useful in GitLab's context, but one can
> imagine this mode to be further extended for other things.
> 
> For instance, a non-trivial part of "cat-file --batch" time is spent
> on parsing its argument and seeing if it's a revision, ref etc. So we
> could add a command that only accepts a full-length 40
> character SHA-1.
> 
> This would be the first step in adding such an interface to
> git-cat-file.
> 
> [1] https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget@gmail.com/
> 
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
> Changes from v1:
> 
> - changed option name to batch-command.
> - changed command function interface to receive the whole line after the command
>    name to put the onus of parsing arguments to each individual command function.
> - pass in whole line to batch_one_object in both parse_cmd_object and
>    parse_cmd_info to support spaces in the object reference.
> - removed addition of -z to include in a separate patch series
> - added documentation.

I've left some comments below, they're mostly small details, I like the 
new option name and the changes you've made to the command parsing.

> ---
>   Documentation/git-cat-file.txt |  15 +++++
>   builtin/cat-file.c             | 114 ++++++++++++++++++++++++++++++++-
>   strvec.c                       |  23 +++++++
>   strvec.h                       |   8 +++
>   t/t1006-cat-file.sh            |  32 +++++++++
>   5 files changed, 191 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index bef76f4dd0..8aefa45e4c 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -96,6 +96,21 @@ OPTIONS
>   	need to specify the path, separated by whitespace.  See the
>   	section `BATCH OUTPUT` below for details.
>   
> +-batch-command::

is this missing a '-'?

> +	Enter a command mode that reads from stdin. May not be combined with any
> +	other options or arguments except `--textconv` or `--filters`, in which
> +	case the input lines also need to specify the path, separated by
> +	whitespace.  See the section `BATCH OUTPUT` below for details.
> +
> +object <object>::
> +	Print object contents for object reference <object>
> +
> +info <object>::
> +	Print object info for object reference <object>
> +
> +flush::
> +	Flush to stdout immediately when used with --buffer
> +
>   --batch-all-objects::
>   	Instead of reading a list of objects on stdin, perform the
>   	requested batch operation on all objects in the repository and
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 7b3f42950e..30794284d5 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -16,6 +16,7 @@
>   #include "packfile.h"
>   #include "object-store.h"
>   #include "promisor-remote.h"
> +#include "strvec.h"
>   
>   struct batch_options {
>   	int enabled;
> @@ -26,7 +27,10 @@ struct batch_options {
>   	int unordered;
>   	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
>   	const char *format;
> +	int stdin_cmd;

Now that the option has been renamed it would be nice to rename the 
corresponding variable to match

> +	int end_null;

If you're not adding '-z' here then you don't need this or the addition 
below.

>   };
> +static char line_termination = '\n';
>   
>   static const char *force_path;
>   
> @@ -508,6 +512,102 @@ static int batch_unordered_packed(const struct object_id *oid,
>   				      data);
>   }
>   
> +enum batch_state {
> +	/* Non-transactional state open for commands. */
> +	BATCH_STATE_OPEN,
> +};

I forgot to ask what the idea behind the batch state is last time - 
what's it for?

> +static void parse_cmd_object(struct batch_options *opt,
> +			     const char *line,
> +			     struct strbuf *output,
> +			     struct expand_data *data)
> +{
> +	opt->print_contents = 1;
> +	batch_one_object(line, output, opt, data);
> +}
> +
> +static void parse_cmd_info(struct batch_options *opt,
> +			   const char *line,
> +			   struct strbuf *output,
> +			   struct expand_data *data)
> +{
> +	opt->print_contents = 0;
> +	batch_one_object(line, output, opt, data);
> +}
> +
> +static void parse_cmd_fflush(struct batch_options *opt,
> +			     const char *line,
> +			     struct strbuf *output,
> +			     struct expand_data *data)
> +{
> +	fflush(stdout);
> +}
> +
> +typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
> +			       struct strbuf *, struct expand_data *);
> +
> +static const struct parse_cmd {
> +	const char *prefix;
> +	parse_cmd_fn_t fn;
> +	unsigned args;

This is now a flag so maybe 'takes_args' would better describe its purpose.

> +	enum batch_state state;
> +} commands[] = {
> +	{ "object", parse_cmd_object, 1, BATCH_STATE_OPEN },
> +	{ "info", parse_cmd_info, 1, BATCH_STATE_OPEN },
> +	{ "fflush", parse_cmd_fflush, 0, BATCH_STATE_OPEN },
> +};
> +
> +static void batch_objects_stdin_cmd(struct batch_options *opt,
> +				    struct strbuf *output,
> +				    struct expand_data *data)
> +{
> +	struct strbuf input = STRBUF_INIT;
> +	enum batch_state state = BATCH_STATE_OPEN;
> +
> +	/* Read each line dispatch its command */
> +	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
> +		int i;
> +		const struct parse_cmd *cmd = NULL;
> +		const char *p;
> +
> +		if (*input.buf == line_termination)
> +			die("empty command in input");
> +		else if (isspace(*input.buf))
> +			die("whitespace before command: %s", input.buf);
> +
> +		for (i = 0; i < ARRAY_SIZE(commands); i++) {
> +			const char *prefix = commands[i].prefix;
> +			char c;
> +			const char *cmd_name;

skip_prefix() sets this to the end of the name so maybe 'cmd_end' would 
be clearer?

> +			if (!skip_prefix(input.buf, prefix, &cmd_name))
> +				continue;
> +			/*
> +			 * If the command has arguments, verify that it's
> +			 * followed by a space. Otherwise, it shall be followed
> +			 * by a line terminator.
> +			 */
> +			c = commands[i].args ? ' ' : line_termination;
> +			if (input.buf[strlen(prefix)] != c)

Now that you're using skip_prefix() you can write this as
			if (*cmd_end != c)

> +				continue;
> +
> +			cmd = &commands[i];
> +			break;
> +		}
> +		if (!cmd)
> +			die("unknown command: %s", input.buf);
> +
> +		p = input.buf + strlen(cmd->prefix) + 1;

This can be simplified to
		p = cmd_end + 1;

> +		const char *pos = strstr(p, &line_termination);

This isn't needed without '-z'. If it were required then using 
strchrnul() would prevent a NULL pointer dereference when the last input 
line does not end with a terminator. I think we typically call a pointer 
to the end of the line 'eol' or 'end'. Also variables should be declared 
at the top of the function.

> +		switch (state) {
> +		case BATCH_STATE_OPEN:
> +			break;
> +		}
> +		cmd->fn(opt, xstrndup(p, pos-p), output, data);

Is there a reason this is passing a copy of the string?

> +	}
> +	strbuf_release(&input);
> +}
> +
>   static int batch_objects(struct batch_options *opt)
>   {
>   	struct strbuf input = STRBUF_INIT;
> @@ -515,6 +615,7 @@ static int batch_objects(struct batch_options *opt)
>   	struct expand_data data;
>   	int save_warning;
>   	int retval = 0;
> +	const int stdin_cmd = opt->stdin_cmd;
>   
>   	if (!opt->format)
>   		opt->format = "%(objectname) %(objecttype) %(objectsize)";
> @@ -590,7 +691,8 @@ static int batch_objects(struct batch_options *opt)
>   	save_warning = warn_on_object_refname_ambiguity;
>   	warn_on_object_refname_ambiguity = 0;
>   
> -	while (strbuf_getline(&input, stdin) != EOF) {
> +	while (!stdin_cmd &&

If you moved the 'if (stdin_cmd)' block above this block we could loose 
this change. I'm not sure if that is possible without looking at the 
whole function though.

> +	       strbuf_getline(&input, stdin) != EOF) {
>   		if (data.split_on_whitespace) {
>   			/*
>   			 * Split at first whitespace, tying off the beginning
> @@ -608,6 +710,9 @@ static int batch_objects(struct batch_options *opt)
>   		batch_one_object(input.buf, &output, opt, &data);
>   	}
>   
> +	if (stdin_cmd)
> +		batch_objects_stdin_cmd(opt, &output, &data);
> +
>   	strbuf_release(&input);
>   	strbuf_release(&output);
>   	warn_on_object_refname_ambiguity = save_warning;
> @@ -636,6 +741,7 @@ static int batch_option_callback(const struct option *opt,
>   
>   	bo->enabled = 1;
>   	bo->print_contents = !strcmp(opt->long_name, "batch");
> +	bo->stdin_cmd = !strcmp(opt->long_name, "batch-command");
>   	bo->format = arg;
>   
>   	return 0;
> @@ -683,6 +789,10 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>   			N_("like --batch, but don't emit <contents>"),
>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>   			batch_option_callback),
> +		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
> +			 N_("enters batch mode that accepts commands"),
> +			 PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> +			 batch_option_callback),
>   		OPT_CMDMODE(0, "batch-all-objects", &opt,
>   			    N_("with --batch[-check]: ignores stdin, batches all known objects"), 'b'),
>   		/* Batch-specific options */
> @@ -738,6 +848,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>   	/* Batch defaults */
>   	if (batch.buffer_output < 0)
>   		batch.buffer_output = batch.all_objects;
> +	if (batch.end_null)
> +		line_termination = '\0';
>   
>   	/* Return early if we're in batch mode? */
>   	if (batch.enabled) {
> diff --git a/strvec.c b/strvec.c
> index 61a76ce6cb..7dca04bf7a 100644
> --- a/strvec.c
> +++ b/strvec.c
>[...]

We don't need any strvec changes now that we don't split the input lines 
to --bactch-command

> +F='%s\0'

This isn't used now

> +test_expect_success 'batch-command unknown command' '
> +	echo unknown_command >cmd &&
> +	test_expect_code 128 git cat-file --batch-command < cmd 2>err &&
> +	grep -E "^fatal:.*unknown command.*" err
> +'
> +
> +test_expect_success 'setup object data' '
> +	content="Object Data" &&
> +	size=$(strlen "$content") &&
> +	sha1=$(echo_without_newline "$content" | git hash-object -w --stdin)
> +'
> +
> +test_expect_success 'batch-command calling object works' '
> +	echo "object $sha1" | git cat-file --batch-command >actual &&
> +	echo "$sha1 blob $size" >expect &&
> +	echo `git cat-file -p "$sha1"` >>expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'batch-command calling info works' '
> +	echo "info $sha1" | git cat-file --batch-command >actual &&
> +	echo "$sha1 blob $size" >expect &&
> +	test_cmp expect actual
> +'

I had a quick look at this test file and there is a loop at the top that 
runs some --batch tests on various inputs, I wonder if these two tests 
could go in there.

> +test_expect_success 'batch-command fflush works' '
> +	printf "fflush\n" > cmd &&
> +	test_expect_code 0 git cat-file --batch-command < cmd 2>err
> +'

It'd be nice to check this actually flushes the output.

Best Wishes

Phillip

>   test_done

