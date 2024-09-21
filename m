Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA767364AE
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726941977; cv=none; b=GOyScC4Zpw8CcwkvE0Sd8+9KhuPMrgWO7/4fNu3/qwZnCFnpak/jPHaYauDtIEGPSdSYOI9ABKhFsYBJ09UqE9J7xkyJUlGIgMH3zKIxTDlmt+2X44hX+s0yopz6MUwsgd+LTzSOVyEhdrwA0pWOr8+qr+0kStZU0+pkxS42AoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726941977; c=relaxed/simple;
	bh=Wnoda2sImDNwsM57xn7F+XfAlyf5+L0PQ8MHegSoMbs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=SpsJm0a8BMsOlALd1MqoNh6hMUCCz9k8o4+REybBuyC6ToDoYyUBPodli6EYDaSu9DEWuQYJ9UTZoT4sOIg14Ca2eBsJCUiZIR+XWWphzAmHveaKG1y9hK6TKFVaSoYMUdPoNPPEMJ9yUnAzj9fEuhcv1shVdveqajIsLHWBlFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie; spf=pass smtp.mailfrom=rjp.ie; dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b=gynXpFcq; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="gynXpFcq"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1726941970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mm5PYmd32Z9A6TRYeSG37DueVseIeTTJq/0AWsHzNcs=;
	b=gynXpFcqa6VnS14Ub8cNW/1Hfujnuzm1DoH3+B86W58hitcYFQz+gG8VGkHJfzhRs3AuEm
	REQrQCNhfMvz3Alo8iOrRo1cJ03QgJC0dTgMLvo2qvbV0qp+Oez2xDz3aZKQcgeFvUyHFO
	ZqaxgClocX7FjVYOcvwq66sCRPQElMg=
Date: Sat, 21 Sep 2024 18:06:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <9fdb9561bb0ad85e55ca3253cc4db9b098641e30@rjp.ie>
TLS-Required: No
Subject: Re: BUG: refs.c:1933: reference backend is unknown
To: "shejialuo" <shejialuo@gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <Zu7vpPs8fcqlMlNK@ArchLinux>
References: <1b9fb3f3fde62594b9ac999ffb69e6c4fb9f6fd6@rjp.ie>
 <Zu7vpPs8fcqlMlNK@ArchLinux>
X-Migadu-Flow: FLOW_OUT

September 21, 2024 at 9:09 AM, "shejialuo" <shejialuo@gmail.com> wrote:

> The "git-archive(1)" command must accept at least one parameter as
>=20
>=20"archive.c::parse_archive_args" shows:
>=20
>=20 static int parse_archive_args(...)
>=20
>=20 {
>=20
>=20 ...
>=20
>=20 if (argc < 1)
>=20
>=20 usage_with_options(archive_usage, opts);
>=20
>=20 }
>=20
>=20So, it will print the usage and exit the program. I guess you omit so=
me
>=20
>=20things for this bug report. Could you please give us more information=
 to
>=20
>=20let us dive into this?

The abort is reproducible exactly as written for me, but upon further
examination it may depend on my config. Here is a minimal reproducer:

  $ GIT_CONFIG_NOSYSTEM=3D1 GIT_CONFIG_GLOBAL=3D/dev/null git --git-dir=
=3Dnotexist -c 'includeif.onbranch:test/**.path=3D/dev/null' archive

> bt
#0  __pthread_kill_implementation (threadid=3D<optimized out>, signo=3Dsi=
gno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at pthread_kill.c:44
#1  0x00007ffff7d78463 in __pthread_kill_internal (threadid=3D<optimized =
out>, signo=3D6) at pthread_kill.c:78
#2  0x00007ffff7d1f120 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/=
posix/raise.c:26
#3  0x00007ffff7d064c3 in __GI_abort () at abort.c:79
#4  0x000055555585385a in BUG_vfl (file=3D<optimized out>, line=3D<optimi=
zed out>, fmt=3D0x555555905baf "reference backend is unknown", params=3D0=
x7fffffffd120) at /usr/src/debug/git/git-2.46.1/usage.c:317
#5  BUG_fl (file=3D<optimized out>, line=3D<optimized out>, fmt=3D0x55555=
5905baf "reference backend is unknown") at /usr/src/debug/git/git-2.46.1/=
usage.c:334
#6  0x00005555557ca9d2 in ref_store_init (repo=3D<optimized out>, format=
=3D<optimized out>, gitdir=3D<optimized out>, flags=3D<optimized out>) at=
 /usr/src/debug/git/git-2.46.1/refs.c:1933
#7  ref_store_init (repo=3D0x5555559759a0 <the_repo.lto_priv>, format=3D<=
optimized out>, gitdir=3D<optimized out>, flags=3D15) at /usr/src/debug/g=
it/git-2.46.1/refs.c:1923
#8  get_main_ref_store (r=3D0x5555559759a0 <the_repo.lto_priv>) at /usr/s=
rc/debug/git/git-2.46.1/refs.c:1953
#9  0x00005555556dcdf6 in include_by_branch (cond=3D0x55555599f503 "test/=
**.path", cond_len=3D7) at /usr/src/debug/git/git-2.46.1/config.c:309
#10 include_condition_is_true (kvi=3D<optimized out>, inc=3D0x7fffffffd46=
0, cond=3D0x55555599f503 "test/**.path", cond_len=3D7) at /usr/src/debug/=
git/git-2.46.1/config.c:409
#11 git_config_include (var=3Dvar@entry=3D0x55555599f4f0 "includeif.onbra=
nch:test/**.path", value=3Dvalue@entry=3D0x55555599fa62 "/dev/null", ctx=
=3Dctx@entry=3D0x7fffffffd368, data=3Ddata@entry=3D0x7fffffffd460) at /us=
r/src/debug/git/git-2.46.1/config.c:439
#12 0x00005555556d8753 in config_parse_pair (key=3D<optimized out>, value=
=3D0x55555599fa62 "/dev/null", kvi=3Dkvi@entry=3D0x7fffffffd4a0, fn=3Dfn@=
entry=3D0x5555556dcad0 <git_config_include>, data=3Ddata@entry=3D0x7fffff=
ffd460) at /usr/src/debug/git/git-2.46.1/config.c:617
#13 0x00005555556dc437 in parse_config_env_list (env=3D0x55555599fa40 "in=
cludeif.onbranch:test/**.path", kvi=3D0x7fffffffd4a0, fn=3D0x5555556dcad0=
 <git_config_include>, data=3D0x7fffffffd460) at /usr/src/debug/git/git-2=
.46.1/config.c:700
#14 git_config_from_parameters (fn=3D0x5555556dcad0 <git_config_include>,=
 data=3D0x7fffffffd460) at /usr/src/debug/git/git-2.46.1/config.c:773
#15 do_git_config_sequence (opts=3D0x7fffffffd4b0, repo=3D0x0, fn=3D0x555=
5556dcad0 <git_config_include>, data=3D0x7fffffffd460) at /usr/src/debug/=
git/git-2.46.1/config.c:2131
#16 config_with_options (fn=3D0x5555556dcad0 <git_config_include>, fn@ent=
ry=3D0x555555790940 <pager_command_config>, data=3D0x7fffffffd460, data@e=
ntry=3D0x7fffffffd7a0, config_source=3Dconfig_source@entry=3D0x0, repo=3D=
repo@entry=3D0x0, opts=3Dopts@entry=3D0x7fffffffd660) at /usr/src/debug/g=
it/git-2.46.1/config.c:2174
#17 0x00005555556dd110 in read_early_config (cb=3D0x555555790940 <pager_c=
ommand_config>, data=3D0x7fffffffd7a0) at /usr/src/debug/git/git-2.46.1/c=
onfig.c:2229
#18 0x000055555555ea58 in check_pager_config (cmd=3D<optimized out>) at /=
usr/src/debug/git/git-2.46.1/pager.c:261
#19 run_builtin (p=3D0x555555966a00 <commands.lto_priv+96>, argc=3D1, arg=
v=3D0x7fffffffdd78) at /usr/src/debug/git/git-2.46.1/git.c:461
#20 handle_builtin (argc=3D1, argv=3D0x7fffffffdd78) at /usr/src/debug/gi=
t/git-2.46.1/git.c:732
#21 0x000055555555eaf9 in run_argv (argcp=3D0x7fffffffdb0c, argv=3D0x7fff=
ffffdb30) at /usr/src/debug/git/git-2.46.1/git.c:796
#22 0x00005555555597eb in cmd_main (argc=3D<optimized out>, argv=3D<optim=
ized out>) at /usr/src/debug/git/git-2.46.1/git.c:931
#23 main (argc=3D<optimized out>, argv=3D<optimized out>) at /usr/src/deb=
ug/git/git-2.46.1/common-main.c:64

Cheers,

Ronan
