Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE584C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9142960555
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 04:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhKFEIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 00:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhKFEIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 00:08:09 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5655BC061570
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 21:05:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v11so37173454edc.9
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 21:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=77NzcgN+pH+dvhezK7kegeyOfi8lRy4rDoF7bunHhVY=;
        b=P/8N6xwThWYarcKzlCMkzZzUcAl7ErhsI1roRRKFTP9MyeG9z0M8O67YCIv4YluNVu
         9wli5KvIN5HedRjnpcc8jbY9M0NAzngjhcdv1mcRoi/nz0NN/eYXBcpBr3VmwJW8ss7J
         IoACW/u1LSoZ/dpqN3T2APmdekulTT9Uh+lFZQoFkWxXMtdOI6KyUK2STDLUMYy5HfZp
         Vqy9EWzcq3kTmLgRs9IsHv00lvv9yB1JPgWhsrVPHxq9xBBdmGg1iHdBYD8kkVyKiFCC
         AQ0OMEVM/u4dt53JrQnT1yGAkVN7+/0UkIV2zxSsAy+l7aRxxMo8VBHz4dKHhUrnqu7r
         4MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=77NzcgN+pH+dvhezK7kegeyOfi8lRy4rDoF7bunHhVY=;
        b=4Xu6I0R5axsWGo6bnYqOKc6gQQnvMCv61+Krqme6dWz/DhB5jGuF7wrGu+hg8dYT5Y
         Awr1LA4nXJokWKM68qnM4Qj90LYL1hTjGSffeQsb+Rx4U81z8Bbx349eXEutsw8IAoK3
         MGvnc3E1CAtVU0iIY07DpNqirdL5iekDwWZavR02/0if+CFsc0syNWP9MuNmeB9mzSw9
         gKSsxVDfxUV3ntGaIpXuu1UmUU2iPY/Q72C8FCGwcPkLf2HoDWcwic57Dn10akg2tUAm
         MW16SBh19Dp7N2PTz55xFsYH+81z3B4zsayTt4qXUzrYqzmRVqiDYrZ1+VclrHiYI8xU
         Acxw==
X-Gm-Message-State: AOAM531b+59DAHXl8paLvLZqYgeyFYaXXuwqdbvqE8BKhyOMYsHZqxHP
        wbZvPaOc/GDgq6hNicDllGU=
X-Google-Smtp-Source: ABdhPJw+RPckRr6jpD7GSbTeHbosSXESxfVFtNf593aH3GuMozum9hAUW4Mq0xqc55DfNe7yThscdA==
X-Received: by 2002:a17:906:2c16:: with SMTP id e22mr5720155ejh.501.1636171526158;
        Fri, 05 Nov 2021 21:05:26 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a15sm5460175edr.76.2021.11.05.21.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 21:05:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mjCxJ-000Z5w-3M;
        Sat, 06 Nov 2021 05:05:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] cat-file: force flush of stdout on empty string
Date:   Sat, 06 Nov 2021 05:01:10 +0100
References: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
 <2d687baeed82e7b90d383bad8e209f50e0ce8c87.1636149400.git.gitgitgadget@gmail.com>
 <xmqqsfwaumlc.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqsfwaumlc.fsf@gitster.g>
Message-ID: <211106.86k0hmgc8q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 05 2021, Junio C Hamano wrote:

> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> @@ -405,6 +405,11 @@ static void batch_one_object(const char *obj_name,
>>  	int flags =3D opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
>>  	enum get_oid_result result;
>>=20=20
>> +	if (opt->buffer_output && obj_name[0] =3D=3D '\0') {
>> +		fflush(stdout);
>> +		return;
>> +	}
>> +
>
> This might work in practice, but it a bad design taste to add this
> change here.  The function is designed to take an object name
> string, and it even prepares a flag variable needed to make a call
> to turn that object name into object data.  We do not need to
> contaminate the interface with "usually this takes an object name,
> but there are these other special cases ...".  The higher in the
> callchain we place special cases, the better the lower level
> functions become, as that allows them to concentrate on doing one
> single thing well.
>
>>  	result =3D get_oid_with_context(the_repository, obj_name,
>>  				      flags, &data->oid, &ctx);
>>  	if (result !=3D FOUND) {
>> @@ -609,7 +614,11 @@ static int batch_objects(struct batch_options *opt)
>>  			data.rest =3D p;
>>  		}
>>=20=20
>> -		batch_one_object(input.buf, &output, opt, &data);
>> +		 /*
>> +		  * When in buffer mode and input.buf is an empty string,
>> +		  * flush to stdout.
>> +		  */
>
> Checking "do we have the flush instruction (in which case we'd do
> the flush here), or do we have textual name of an object (in which
> case we'd call batch_one_object())?" here would be far cleaner and
> results in an easier-to-explain code.  With a cleanly written code
> to do so, it probably does not even need a new comment here.
>
> This brings up another issue.  Is "flushing" the *ONLY* special
> thing we would ever do in this codepath in the future?  I doubt so.
> Squatting on an "empty string" is a selfish design that hurts those
> who will come after you in the future, as they need to find other
> ways to ask for a "special thing".
>
> If we are inventing a special syntax that allows us to spell
> commands that are distinguishable from a validly-spelled object name
> to cause something special (like "flushing the output stream"),
> perhaps we want to use a bit more extensible and explicit syntax and
> use it from day one?
>
> For example, if no string that begins with three dots can ever be a
> valid way to spell an object name, perhaps "...flush" might be a
> better "please do this special thing" syntax than an empty string.
> It is easily extensible (the next special thing can follow suit to
> say "...$verb" to tell the machinery to $verb the input).  When we
> compare between an empty string and "...flush", the latter clearly
> is more descriptive, too.
>
> Note that I offhand do not know if "a valid string that name an
> object would never begin with three-dot" is true.  Please check
> if that is true if you choose to use it, or you can find and use
> another convention that allows us to clearly distinguish the
> "special" instruction and object names.

I had much the same thought, this is a useful feature, but let's not
squat on the one bit of open syntax we have.

John: I think a better direction here is to add a mode to cat-file to
emulate what "git update-ref --stdin" supports. Here's a demo of that
(also quoted below):
https://github.com/git/git/commit/7794f6cfdbdca0dd6bab0dea16193ebf018b86a9

That's on top of some general UI improvements to cat-file I've got
locally:
https://github.com/git/git/compare/master...avar:avar/cat-file-usage-and-op=
tions-handling

That WIP patch on top follows below, of course it's a *lot* more initial
scaffolding, but I think once we get past that initial step it's a much
better path forward. As noted the code is also almost entirely
copy/pasted from update-ref.c, and perhaps some of the shared parts
could be moved to some library both could use.

I couldn't think of a better name than --stdin-cmd, suggestions most
welcome.

From 7794f6cfdbdca0dd6bab0dea16193ebf018b86a9 Mon Sep 17 00:00:00 2001
Message-Id: <patch-1.1-7794f6cfdbd-20211106T040307Z-avarab@gmail.com>
From: =3D?UTF-8?q?=3DC3=3D86var=3D20Arnfj=3DC3=3DB6r=3DC3=3DB0=3D20Bjarmaso=
n?=3D
 <avarab@gmail.com>
Date: Sat, 6 Nov 2021 04:54:04 +0100
Subject: [PATCH] WIP cat-file: add a --stdin-cmd mode
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

This WIP patch is mostly stealing code from builtin/update-ref.c and
implementing the same sort of prefixed command-mode that it
supports. I.e. in addition to --batch now supporting:

    <object> LF

It'll support with --stdin-cmd, with and without -z, respectively:

    object <object> NL
    object <object> NUL

The plus being that we can now implement additional commands. Let's
start that by scratching the itch John Cai wanted to address in [1]
and implement a (with and without -z):

    fflush NL
    fflush NUL

That command simply calls fflush(stdout), which could be done as an
emergent effect before by feeding the input a "NL".

I think this will be useful for other things, e.g. I've observed in
the past that a not-trivial part of "cat-file --batch" time is spent
on parsing its <object> argument and seeing if it's a revision, ref
etc.

So we could e.g. add a command that only accepts a full-length 40
character SHA-1, or switch the --format output mid-request etc.

1. https://lore.kernel.org/git/pull.1124.git.git.1636149400.gitgitgadget@gm=
ail.com/

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 116 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b76f2a00046..afdb976c6e7 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -26,7 +26,10 @@ struct batch_options {
 	int unordered;
 	int cmdmode; /* may be 'w' or 'c' for --filters or --textconv */
 	const char *format;
+	int stdin_cmd;
+	int end_null;
 };
+static char line_termination =3D '\n';
=20
 static const char *force_path;
=20
@@ -507,6 +510,106 @@ static int batch_unordered_packed(const struct object=
_id *oid,
 				      data);
 }
=20
+enum batch_state {
+	/* Non-transactional state open for commands. */
+	BATCH_STATE_OPEN,
+};
+
+static void parse_cmd_object(struct batch_options *opt,
+			     const char *next, const char *end,
+			     struct strbuf *output,
+			     struct expand_data *data)
+{
+	size_t len =3D end - next - 1;
+	char *p =3D (char *)next;
+	char old =3D p[len];
+
+	p[len] =3D '\0';
+	batch_one_object(next, output, opt, data);
+	p[len] =3D old;
+}
+
+static void parse_cmd_fflush(struct batch_options *opt,
+			     const char *next, const char *end,
+			     struct strbuf *output,
+			     struct expand_data *data)
+{
+	if (*next !=3D line_termination)
+		die("fflush: extra input: %s", next);
+	fflush(stdout);
+}
+
+static const struct parse_cmd {
+	const char *prefix;
+	void (*fn)(struct batch_options *, const char *, const char *, struct str=
buf *, struct expand_data *);
+	unsigned args;
+	enum batch_state state;
+} command[] =3D {
+	{ "object", parse_cmd_object, 1, BATCH_STATE_OPEN },
+	{ "fflush", parse_cmd_fflush, 0, BATCH_STATE_OPEN },
+};
+
+static void batch_objects_stdin_cmd(struct batch_options *opt,
+				    struct strbuf *output,
+				    struct expand_data *data)
+{
+	struct strbuf input =3D STRBUF_INIT;
+	enum batch_state state =3D BATCH_STATE_OPEN;
+
+	/* Read each line dispatch its command */
+	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
+		size_t i, j;
+		const struct parse_cmd *cmd =3D NULL;
+
+		if (*input.buf =3D=3D line_termination)
+			die("empty command in input");
+		else if (isspace(*input.buf))
+			die("whitespace before command: %s", input.buf);
+
+		for (i =3D 0; i < ARRAY_SIZE(command); i++) {
+			const char *prefix =3D command[i].prefix;
+			char c;
+
+			if (!starts_with(input.buf, prefix))
+				continue;
+
+			/*
+			 * If the command has arguments, verify that it's
+			 * followed by a space. Otherwise, it shall be followed
+			 * by a line terminator.
+			 */
+			c =3D command[i].args ? ' ' : line_termination;
+			if (input.buf[strlen(prefix)] !=3D c)
+				continue;
+
+			cmd =3D &command[i];
+			break;
+		}
+		if (!cmd)
+			die("unknown command: %s", input.buf);
+
+		/*
+		 * Read additional arguments if NUL-terminated. Do not raise an
+		 * error in case there is an early EOF to let the command
+		 * handle missing arguments with a proper error message.
+		 */
+		for (j =3D 1; line_termination =3D=3D '\0' && j < cmd->args; j++)
+			if (strbuf_appendwholeline(&input, stdin, line_termination))
+				break;
+
+		switch (state) {
+		case BATCH_STATE_OPEN:
+			/* TODO: command state management */
+			break;
+		}
+
+		cmd->fn(opt, input.buf + strlen(cmd->prefix) + !!cmd->args,
+			input.buf + input.len, output, data);
+	}
+
+	strbuf_release(&input);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input =3D STRBUF_INIT;
@@ -514,6 +617,7 @@ static int batch_objects(struct batch_options *opt)
 	struct expand_data data;
 	int save_warning;
 	int retval =3D 0;
+	const int stdin_cmd =3D opt->stdin_cmd;
=20
 	if (!opt->format)
 		opt->format =3D "%(objectname) %(objecttype) %(objectsize)";
@@ -589,7 +693,8 @@ static int batch_objects(struct batch_options *opt)
 	save_warning =3D warn_on_object_refname_ambiguity;
 	warn_on_object_refname_ambiguity =3D 0;
=20
-	while (strbuf_getline(&input, stdin) !=3D EOF) {
+	while (!stdin_cmd &&
+	       strbuf_getline(&input, stdin) !=3D EOF) {
 		if (data.split_on_whitespace) {
 			/*
 			 * Split at first whitespace, tying off the beginning
@@ -607,6 +712,9 @@ static int batch_objects(struct batch_options *opt)
 		batch_one_object(input.buf, &output, opt, &data);
 	}
=20
+	if (stdin_cmd)
+		batch_objects_stdin_cmd(opt, &output, &data);
+
 	strbuf_release(&input);
 	strbuf_release(&output);
 	warn_on_object_refname_ambiguity =3D save_warning;
@@ -684,6 +792,10 @@ int cmd_cat_file(int argc, const char **argv, const ch=
ar *prefix)
 			batch_option_callback),
 		OPT_CMDMODE(0, "batch-all-objects", &opt,
 			    N_("with --batch[-check]: ignores stdin, batches all known objects"=
), 'b'),
+		OPT_BOOL(0, "stdin-cmd", &batch.stdin_cmd,
+			 N_("with --batch[-check]: enters stdin 'command mode")),
+		OPT_BOOL('z', NULL, &batch.end_null, N_("with --stdin-cmd, use NUL termi=
nation")),
+
 		/* Batch-specific options */
 		OPT_GROUP(N_("Change or optimize batch output")),
 		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
@@ -737,6 +849,8 @@ int cmd_cat_file(int argc, const char **argv, const cha=
r *prefix)
 	/* Batch defaults */
 	if (batch.buffer_output < 0)
 		batch.buffer_output =3D batch.all_objects;
+	if (batch.end_null)
+		line_termination =3D '\0';
=20
 	/* Return early if we're in batch mode? */
 	if (batch.enabled) {
--=20
2.34.0.rc1.741.gab7bfd97031

