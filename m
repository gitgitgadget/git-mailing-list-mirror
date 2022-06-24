Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A11C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 11:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiFXLvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 07:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiFXLvo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 07:51:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59132766E
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 04:51:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o9so3059983edt.12
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=c6H0FxaPClt+ufv/0ncdZ4o5i+LpiXc946pa8qmmFX4=;
        b=JRxVtn39V2XGrzRwuqA6F0K0NMym9HfU0sWBvzbTN0LxsJEyNdhL/yqXdx+QrA9xPn
         3VP4iDQkWF0u9qk/PB6ie9JOT3/aCkO3IsA45eBwtx1yBoohb3RpG0xZxb1cGJY1b5gj
         HD0FnZpNan7rqQea0PNNA9DgHsg8aNBDAZavAUYHJPFnagptXyovXSSUVvwLAP+E6326
         /+xxFmg9ZlsoviQDr9mAwKWKUJ5f4VBUOEA2uzGYqrumel0Q2EsrrcLSd6j7BoFMW+hd
         p6WuqFbB7w6VJWEv3PUkidGSkyHYI9u5ssINMT9lhol/01AfemB8XMAw4V13P8tNUe+X
         JCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=c6H0FxaPClt+ufv/0ncdZ4o5i+LpiXc946pa8qmmFX4=;
        b=nBdwgBOsPRmu1hUMVsSuzqLxIwuVjN4uI/Bi/DWuM8cKA8AH4OmGIK7u9jPk7fXoRC
         SWWlEYbca5rVq1wVsWS5OPzecnxs8rbUVSrR7s8hxsUTjOL9zXtvzpEgFHzRbpTMnnnA
         X7UF6im3V+n4xCSuBPyEoH57wIprdLxkYMCDm4oc7cWa//Ua45dc34GCC6Xo4gLxdbTB
         ZhVJPGayA/kCE1kn2CehCIM7YAVIMR4lwWuQFahfso2rMyEGAD2C+uvhSJ66lKreSTdt
         TpImeO0Uk8NIjcYzcp8FCkf7VWglhuQmgmVQk0vBTGZc969WeQNupgbQNqc7F5WWQ8il
         PT0g==
X-Gm-Message-State: AJIora8/fmA1ZbrFaPRbQbj9Z5d1SFden/grVcADViXg4o9DqO7qBLrg
        wXU5ER4x34Ou4Nxvemw85k8=
X-Google-Smtp-Source: AGRyM1smbWKw8nVxtRs1uMlIphjKskklHU1hW1wYQVannHJEUMr1EPjWGe/jMPzczI9YzsQYqAGvvQ==
X-Received: by 2002:a05:6402:40f:b0:436:a6ba:360d with SMTP id q15-20020a056402040f00b00436a6ba360dmr4014547edv.371.1656071501718;
        Fri, 24 Jun 2022 04:51:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906a08200b006fed93bf71fsm1017039ejy.18.2022.06.24.04.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 04:51:40 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4hqd-001GoK-Pu;
        Fri, 24 Jun 2022 13:51:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 4/6] archive-tar: add internal gzip implementation
Date:   Fri, 24 Jun 2022 13:13:20 +0200
References: <pull.145.git.gitgitgadget@gmail.com>
 <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
 <1328fe72-1a27-b214-c226-d239099be673@web.de>
 <220615.86wndhwt9a.gmgdl@evledraar.gmail.com>
 <3ed80afd-34b3-afd8-5ffb-0187a4475ee1@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3ed80afd-34b3-afd8-5ffb-0187a4475ee1@web.de>
Message-ID: <220624.8635fujn3o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 16 2022, Ren=C3=A9 Scharfe wrote:

> Am 15.06.22 um 22:32 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> [...]
> Understandable, and you can set tar.tgz.command=3D'gzip -cn' to get the
> old behavior.  Saving energy is a better default, though.

I disagree with that in general, a big reason for why git won out over
other VCS's is that it wasn't as slow. I think we should primarily be
interested in the time a user might end up staring at the screen.

I understand the concern to have "git archive" just work, e.g. if you
uninstall gzip(1) (although that seems rather obscure, but perhaps this
is for more minimal setups).

I don't think saving energy is a virtue, *maybe* it is, but maybe your
computer is powered by hydro, solar or nuclear instead of coal, so even
if we're taking global energy policy into account for changes to git
it's highly context dependant.

In any case, this is also true for pretty much any other git command
that might spawn processes or threads, e.g. "git grep":

	$ hyperfine -w3 -L cpus 0,0-7 'taskset --cpu-list {cpus} ./git grep foo.*b=
ar' -r 10
	Benchmark 1: taskset --cpu-list 0 ./git grep foo.*bar
	  Time (mean =C2=B1 =CF=83):      39.3 ms =C2=B1   1.2 ms    [User: 20.0 m=
s, System: 18.6 ms]
	  Range (min =E2=80=A6 max):    38.2 ms =E2=80=A6  41.8 ms    10 runs
=09
	Benchmark 2: taskset --cpu-list 0-7 ./git grep foo.*bar
	  Time (mean =C2=B1 =CF=83):      28.1 ms =C2=B1   1.3 ms    [User: 43.5 m=
s, System: 51.0 ms]
	  Range (min =E2=80=A6 max):    26.6 ms =E2=80=A6  31.2 ms    10 runs
=09
	Summary
	  'taskset --cpu-list 0-7 ./git grep foo.*bar' ran
	    1.40 =C2=B1 0.08 times faster than 'taskset --cpu-list 0 ./git grep fo=
o.*bar'

Here we use less than 1/2 the user/system time when I pin it to 1 cpu,
but we're 40% slower.

So this is a bit of a digression, but this particular thing seems much
better left to the OS or your hardware's CPU throttling policy. To the
extent that we care perhaps more fitting would be to have a global
core.wrapper-cmd option or something, so you could pass all git commands
through "taskset" (or your local equivalent), or just use shell aliases.

> The runtime in the real world probably includes lots more I/O time.  The
> tests above are repeated and warmed up to get consistent measurements,
> but big repos are probably not fully kept in memory like that.
>
>> Can't we have our 6/6 cake much easier and eat it too by learning a
>> "fallback" mode, i.e. we try to invoke gzip, and if that doesn't work
>> use the "internal" one?
>
> Interesting idea, but I think the existing config option suffices.  E.g.
> a distro could set it in the system-wide config file if/when gzip is
> installed.

I think in practice distros are unlikely to have such triggers for
"package X is installed, let's set config Y". I mean, e.g. Debian can do
that with its packaging system, but it's expecting a lot. Why not flip
the default depending on if start_command() fails?

>> Re the "eco mode": I also wonder how much of the overhead you're seeing
>> for both that 17% and 2% would go away if you pin both processes to the
>> same CPU, I can't recall the command offhand, but IIRC taskset or
>> numactl can do that. I.e. is this really measuring IPC overhead, or
>> I-CPU overhead on your system?
>
> I'd expect that running git archive and gzip at the same CPU core takes
> more wall-clock time than using zlib because inflating the object files
> and deflating the archive are done sequentially in both scenarios.
> Can't test it on macOS because it doesn't offer a way to pin programs to
> a certain core, but e.g. someone with access to a Linux system can check
> that using taskset(1).

Here's a benchmark, this is your hyperfine command, just with taskset
added. It's an 8-core box, so 0-7 is "all CPUs" (I think...):

	hyperfine -w3 \
		-L cpus 0,0-7 \
		-L command 'gzip -cn','git archive gzip' \
		'taskset --cpu-list {cpus} ./git -c tar.tgz.command=3D"{command}" archive=
 --format=3Dtgz HEAD'

Which gives me:

	Benchmark 1: taskset --cpu-list 0 ./git -c tar.tgz.command=3D"gzip -cn" ar=
chive --format=3Dtgz HEAD
	  Time (mean =C2=B1 =CF=83):      1.561 s =C2=B1  0.029 s    [User: 1.503 =
s, System: 0.058 s]
	  Range (min =E2=80=A6 max):    1.522 s =E2=80=A6  1.622 s    10 runs
=09=20
	Benchmark 2: taskset --cpu-list 0-7 ./git -c tar.tgz.command=3D"gzip -cn" =
archive --format=3Dtgz HEAD
	  Time (mean =C2=B1 =CF=83):      1.337 s =C2=B1  0.029 s    [User: 1.535 =
s, System: 0.075 s]
	  Range (min =E2=80=A6 max):    1.298 s =E2=80=A6  1.388 s    10 runs
=09=20
	Benchmark 3: taskset --cpu-list 0 ./git -c tar.tgz.command=3D"git archive =
gzip" archive --format=3Dtgz HEAD
	  Time (mean =C2=B1 =CF=83):      1.493 s =C2=B1  0.032 s    [User: 1.453 =
s, System: 0.040 s]
	  Range (min =E2=80=A6 max):    1.462 s =E2=80=A6  1.572 s    10 runs
=09=20
	Benchmark 4: taskset --cpu-list 0-7 ./git -c tar.tgz.command=3D"git archiv=
e gzip" archive --format=3Dtgz HEAD
	  Time (mean =C2=B1 =CF=83):      1.503 s =C2=B1  0.026 s    [User: 1.466 =
s, System: 0.036 s]
	  Range (min =E2=80=A6 max):    1.469 s =E2=80=A6  1.542 s    10 runs
=09=20
	Summary
	  'taskset --cpu-list 0-7 ./git -c tar.tgz.command=3D"gzip -cn" archive --=
format=3Dtgz HEAD' ran
	    1.12 =C2=B1 0.03 times faster than 'taskset --cpu-list 0 ./git -c tar.=
tgz.command=3D"git archive gzip" archive --format=3Dtgz HEAD'
	    1.12 =C2=B1 0.03 times faster than 'taskset --cpu-list 0-7 ./git -c ta=
r.tgz.command=3D"git archive gzip" archive --format=3Dtgz HEAD'
	    1.17 =C2=B1 0.03 times faster than 'taskset --cpu-list 0 ./git -c tar.=
tgz.command=3D"gzip -cn" archive --format=3Dtgz HEAD'

Whic I think should control for the IPC overhead v.s. the advantage of
multicore. I.e. we're faster with "gzip -cn" on multicore, but the
internal implementation has an advantage when it comes to=20

I tried out the fallback method, memory leaks aside (needs to do a
proper cleanup) this seems to work. Most of the diff is moving the
existing code into a function:

diff --git a/archive-tar.c b/archive-tar.c
index 3d77e0f7509..a1b08812ee3 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -458,14 +458,36 @@ static void tgz_write_block(const void *data)
 	tgz_deflate(Z_NO_FLUSH);
 }
=20
+static const char default_gzip_command[] =3D "gzip -cn";
 static const char internal_gzip_command[] =3D "git archive gzip";
=20
-static int write_tar_filter_archive(const struct archiver *ar,
-				    struct archiver_args *args)
+static int do_internal_gzip(const struct archiver *ar,
+			    struct archiver_args *args)
 {
 #if ZLIB_VERNUM >=3D 0x1221
 	struct gz_header_s gzhead =3D { .os =3D 3 }; /* Unix, for reproducibility=
 */
 #endif
+	int r;
+
+	write_block =3D tgz_write_block;
+	git_deflate_init_gzip(&gzstream, args->compression_level);
+#if ZLIB_VERNUM >=3D 0x1221
+	if (deflateSetHeader(&gzstream.z, &gzhead) !=3D Z_OK)
+		BUG("deflateSetHeader() called too late");
+#endif
+	gzstream.next_out =3D outbuf;
+	gzstream.avail_out =3D sizeof(outbuf);
+
+	r =3D write_tar_archive(ar, args);
+
+	tgz_deflate(Z_FINISH);
+	git_deflate_end(&gzstream);
+	return r;
+}
+
+static int write_tar_filter_archive(const struct archiver *ar,
+				    struct archiver_args *args)
+{
 	struct strbuf cmd =3D STRBUF_INIT;
 	struct child_process filter =3D CHILD_PROCESS_INIT;
 	int r;
@@ -473,33 +495,24 @@ static int write_tar_filter_archive(const struct arch=
iver *ar,
 	if (!ar->filter_command)
 		BUG("tar-filter archiver called with no filter defined");
=20
-	if (!strcmp(ar->filter_command, internal_gzip_command)) {
-		write_block =3D tgz_write_block;
-		git_deflate_init_gzip(&gzstream, args->compression_level);
-#if ZLIB_VERNUM >=3D 0x1221
-		if (deflateSetHeader(&gzstream.z, &gzhead) !=3D Z_OK)
-			BUG("deflateSetHeader() called too late");
-#endif
-		gzstream.next_out =3D outbuf;
-		gzstream.avail_out =3D sizeof(outbuf);
-
-		r =3D write_tar_archive(ar, args);
-
-		tgz_deflate(Z_FINISH);
-		git_deflate_end(&gzstream);
-		return r;
-	}
+	if (!strcmp(ar->filter_command, internal_gzip_command))
+		return do_internal_gzip(ar, args);
=20
 	strbuf_addstr(&cmd, ar->filter_command);
 	if (args->compression_level >=3D 0)
 		strbuf_addf(&cmd, " -%d", args->compression_level);
=20
-	strvec_push(&filter.args, cmd.buf);
-	filter.use_shell =3D 1;
+	strvec_split(&filter.args, cmd.buf);
 	filter.in =3D -1;
=20
-	if (start_command(&filter) < 0)
+	if (start_command(&filter) < 0) {
+		if (!strcmp(ar->filter_command, default_gzip_command)) {
+			warning_errno(_("could not start '%s' filter, falling back to '%s'"),
+				      ar->filter_command, internal_gzip_command);
+			return do_internal_gzip(ar, args);
+		}
 		die_errno(_("unable to start '%s' filter"), cmd.buf);
+	}
 	close(1);
 	if (dup2(filter.in, 1) < 0)
 		die_errno(_("unable to redirect descriptor"));
