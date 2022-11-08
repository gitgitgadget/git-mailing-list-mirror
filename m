Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E53C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 03:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiKHDgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 22:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiKHDgl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 22:36:41 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1860810FF6
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 19:36:40 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id sc25so35187317ejc.12
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 19:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L6HtdQmh3X4f5NsYCeWwWmlv0lXUeYyy3cDUapQoF6w=;
        b=LzOX3IzXtCMChxgc6x61AdRdvz06xIsDbuyiCeC84nsVtISpDheXOcCbq2cdxf7/Ne
         LIM+Az7REZIfRfN8R7lsOs5+bxnTAsn1GsCGJ0a/7bzCdhmKFjmwAkcuunXK6d2dXSCP
         eWBQL6LMBBhcV45ZRz34No8WKa/1eFJpsivdSXczGbAJZiDeuYVS35Rnv3C6QjeqiYx9
         WTf5UTvFl2n5Oyf9U7s8JtNEfBIT+ATPwaAAtC+0wWSM0xL9wsz4lzozYhOMEBSTGjTj
         FpCeFaADSArMj7owvv+nxhELHAb7ANJhcUdXkn21LQULNXQnjtJcE7ZKk0IlGGsDASin
         qSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6HtdQmh3X4f5NsYCeWwWmlv0lXUeYyy3cDUapQoF6w=;
        b=000NzG6iQrXi7CxaYxXFVp2ZXxWCX0Da1WpO3s+5T49skoSzpZsg3IYLiMmc6RwAle
         C2KQseVizfwOZ5+fnm0B4cr6q1fpgK0xGK6w6TmRvbUbHPnbC/rSltLDBzDbCnYBBLBQ
         f0BdguAM+nLEV58WTtrBbzfhW/pvBRJ5SPRg8fORZfkKfyiPpvSCsjKSrhMFWoCqoeUR
         LdETWaV5BvVrURen0GHNbM0yHLUP3jPQUGi3ATUO/9Y0rljehERlbetYbUscf0aLxri4
         3GUXzQFgmxgTcGwApEa6F/d0DyRumFfTDHTmhdclbptj8h8G0KjqjoAxqdlxlvGXB81y
         pIDQ==
X-Gm-Message-State: ACrzQf208KqdxFPbjR9ntKYWzB+AOYeLXQUB48pRfULIgqmpwwmNR5//
        Rs5uw74n21mf1g7C4ye9QdKvjSaQ2dxTRg==
X-Google-Smtp-Source: AMsMyM4+2iwVmxqLmKBTzejc6gl9KhQjQoYvEO8TABxT3E0awfFWFo2BgvyKFKaRAtfGZEnuWn4w2A==
X-Received: by 2002:a17:907:6d12:b0:7ae:3b9b:4554 with SMTP id sa18-20020a1709076d1200b007ae3b9b4554mr18323914ejc.307.1667878598414;
        Mon, 07 Nov 2022 19:36:38 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id vl2-20020a170907b60200b0078d0981516esm4111064ejc.38.2022.11.07.19.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:36:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osFPh-000VMh-0M;
        Tue, 08 Nov 2022 04:36:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 05/13] bisect run: keep some of the post-v2.30.0 output
Date:   Tue, 08 Nov 2022 04:11:27 +0100
References: <cover.1667667058.git.congdanhqx@gmail.com>
 <cover.1667667460.git.congdanhqx@gmail.com>
 <5ba3bafdd48b47320624d0db06f379bc0a4b8d4e.1667667460.git.congdanhqx@gmail.com>
 <221107.86k046tp8p.gmgdl@evledraar.gmail.com> <Y2mwN3bpaiN/7vJh@danh.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2mwN3bpaiN/7vJh@danh.dev>
Message-ID: <221108.86y1smrube.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 08 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2022-11-07 22:40:33+0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>>=20
>> On Sun, Nov 06 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
>>=20
>> > From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> >
>> > Preceding commits fixed output and behavior regressions in
>> > d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
>> > in C, 2021-09-13), which did not claim to be changing the output of
>> > "git bisect run".
>> >
>> > But some of the output it emitted was subjectively better, so once
>> > we've asserted that we're back on v2.29.0 behavior, let's change some
>> > of it back:
>> >
>> > - We now quote the arguments again, but omit the first " " when
>> >   printing the "running" line.
>> > - Ditto for other cases where we emitted the argument
>> > - We say "found first bad commit" again, not just "run success"
>>=20
>> So, something you refactored here was that there's now a
>> do_bisect_run(), and:
>>=20
>> > -static int do_bisect_run(const char *command, int argc, const char **=
argv)
>> > +static int do_bisect_run(const char *command, int argc UNUSED, const =
char **argv UNUSED)
>> >  {
>> >  	struct child_process cmd =3D CHILD_PROCESS_INIT;
>> > -	struct strbuf buf =3D STRBUF_INIT;
>> > +	const char *trimed =3D command;
>> >=20=20
>> > -	strbuf_join_argv(&buf, argc, argv, ' ');
>> > -	printf(_("running %s\n"), buf.buf);
>> > -	strbuf_release(&buf);
>> > +	while (*trimed && isspace(*trimed))
>> > +		trimed++;
>> > +	printf(_("running %s\n"), trimed);
>> >  	cmd.use_shell =3D 1;
>> >  	strvec_push(&cmd.args, command);
>> >  	return run_command(&cmd);
>>=20
>> Instead of trimming with strbuf_ltrim() we're now using this loop, but
>> in any case, this has had the effect that you're only fixing one of many
>> of the output changes. We're still adding this leading whitespace to the
>> other messages we emit.
>
> Sorry, I can't follow, we're fixing in do_bisect_run, which meant we
> fixed all of the output changes for leading whitespace, no?
>
> 'do_bisect_run' will be called from normal 'git bisect run' iteration
> and also after receiving code 126/127 for the very first run.
>
> Which is the other cases you're talking about?

The other uses of command.buf in my initial version, i.e. I did:
=09
	-       strbuf_reset(&command);
	-       strbuf_join_argv(&command, argc, argv, ' ');
	+       /* Quoted, but skip initial " " */
	+       strbuf_ltrim(&command);

And the command.buf is then used by:

	printf(_("running %s\n"), command.buf);
	res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);

Which your version covers, but also this, in bisect_run() just a few
lines later:

	error(_("unable to verify '%s' on good"
	      " revision"), command.buf);

And, for:

	error(_("bisect run failed: exit code %d from"
	      " '%s' is < 0 or >=3D 128"), res, command.buf);

In the original *.sh version of this it used the same variable.

But yours deals with the refactored do_bisect_run() from Ren=C3=A9's
e8de018438e (bisect--helper: factor out do_bisect_run(), 2022-10-27).

So that first "running" takes place in its ownown do_bisect_run()
function, and you only skip past the whitespace in the "const char
*command" local to that function.

Thus you're only trimming the whitespace for 1/3 cases, the 2/3 being
noted in the 04/13 as the ones I didn't write a test for.

I think this squashed in should be functionally equivalent:
=09
	diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
	index f16b9df8fd6..493e062e76d 100644
	--- a/builtin/bisect--helper.c
	+++ b/builtin/bisect--helper.c
	@@ -1141,20 +1141,17 @@ static int get_first_good(const char *refname UNUS=
ED,
	 	return 1;
	 }
=09=20
	-static int do_bisect_run(const char *command, int argc UNUSED, const char=
 **argv UNUSED)
	+static int do_bisect_run(const char *command, const char *trimmed)
	 {
	 	struct child_process cmd =3D CHILD_PROCESS_INIT;
	-	const char *trimed =3D command;
=09=20
	-	while (*trimed && isspace(*trimed))
	-		trimed++;
	-	printf(_("running %s\n"), trimed);
	+	printf(_("running %s\n"), trimmed);
	 	cmd.use_shell =3D 1;
	 	strvec_push(&cmd.args, command);
	 	return run_command(&cmd);
	 }
=09=20
	-static int verify_good(const struct bisect_terms *terms, const char *comm=
and, int argc, const char **argv)
	+static int verify_good(const struct bisect_terms *terms, const char *comm=
and, const char *trimmed)
	 {
	 	int rc;
	 	enum bisect_error res;
	@@ -1174,7 +1171,7 @@ static int verify_good(const struct bisect_terms *te=
rms, const char *command, in
	 	if (res !=3D BISECT_OK)
	 		return -1;
=09=20
	-	rc =3D do_bisect_run(command, argc, argv);
	+	rc =3D do_bisect_run(command, trimmed);
=09=20
	 	res =3D bisect_checkout(&current_rev, no_checkout);
	 	if (res !=3D BISECT_OK)
	@@ -1187,6 +1184,7 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
	 {
	 	int res =3D BISECT_OK;
	 	struct strbuf command =3D STRBUF_INIT;
	+	struct strbuf trimmed =3D STRBUF_INIT;
	 	const char *new_state;
	 	int temporary_stdout_fd, saved_stdout;
	 	int is_first_run =3D 1;
	@@ -1200,8 +1198,10 @@ static int bisect_run(struct bisect_terms *terms, c=
onst char **argv, int argc)
	 	}
=09=20
	 	sq_quote_argv(&command, argv);
	+	strbuf_addbuf(&trimmed, &command);
	+	strbuf_ltrim(&trimmed);
	 	while (1) {
	-		res =3D do_bisect_run(command.buf, argc, argv);
	+		res =3D do_bisect_run(command.buf, trimmed.buf);
=09=20
	 		/*
	 		 * Exit code 126 and 127 can either come from the shell
	@@ -1211,7 +1211,7 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
	 		 * missing or non-executable script.
	 		 */
	 		if (is_first_run && (res =3D=3D 126 || res =3D=3D 127)) {
	-			int rc =3D verify_good(terms, command.buf, argc, argv);
	+			int rc =3D verify_good(terms, command.buf, trimmed.buf);
	 			is_first_run =3D 0;
	 			if (rc < 0) {
	 				error(_("unable to verify '%s' on good"

Some of that's a bit of a hassle with e8de018438e, but this way we use
the whitespace-prefixed for run_command(), but not for the output. Maybe
we can just always use the trimmed version, I didn't check.

This approach would also mean that you can drop your 03/13 and 06/13
surrounding this commit, in 03/13 you added that argv/argc because:

	[...]=09
	In a later change, we would like to restore the old behaviours,
	which would need information regarding argc and argv.

That "later change" is your 04/13, then in 05/13 you're back to them
being UNUSED, before 06/13 finally drops them.

But if we just pass both trimmed & non-trimmed into do_bisect_run() to
begin with we don't need to go through all of that...
