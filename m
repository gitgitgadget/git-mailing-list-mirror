Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 906F41F453
	for <e@80x24.org>; Sat, 27 Apr 2019 17:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfD0RkB (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 13:40:01 -0400
Received: from mout.web.de ([212.227.17.12]:56253 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0RkB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 13:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1556386785;
        bh=65I/4AVxKVEDwxu6vMAEvoemvlgG6ss8ciLou4stFuk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=jNVpaFXcP4pvg0IsZQNhPz6LzeCprUROkJL0tEutSWhGmeIltGFfPVo7qglwG8DmD
         M87K44jlVO72tFBUWOQhmMzrzGk56zLt2X69IMYlU1+UYGLV8r6bHdov8s/yX+iB/F
         kRP3UIg5o1XpWSYUiIW2Yw8ONG0UjZYo8cm1w0J4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.17.75]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MJCSM-1hNCBv2Cza-002nUJ; Sat, 27
 Apr 2019 19:39:45 +0200
Subject: Re: [PATCH 2/2] archive: avoid spawning `gzip`
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
References: <pull.145.git.gitgitgadget@gmail.com>
 <44d5371ae6808ec40e8f52c3dc258a85c878b27e.1555110278.git.gitgitgadget@gmail.com>
 <20190413015102.GC2040@sigill.intra.peff.net>
 <8ef2164c-1d44-33bf-ea8a-49fa0b5c8abf@web.de>
 <20190415213556.GB28128@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1904261047560.45@tvgsbejvaqbjf.bet>
 <f6f32bc0-109c-e0eb-f7d2-9e46647f260c@web.de>
Message-ID: <45afd432-9e45-ea76-aa1b-e8cd1264e3a0@web.de>
Date:   Sat, 27 Apr 2019 19:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f6f32bc0-109c-e0eb-f7d2-9e46647f260c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SOgnko7pHcR0giL4OYIMuckyfT3NczPAGP3x60PaObhWybLgdrl
 0I1uptotorsCC4E9KHa8steBD8KuyAvbJb07r2Xju2M/AnGXUOJuuEz7pyLZaSl8KQmmzV/
 UmB0FL0CyEZT6XQPRzwSK9TbmaSKNpN0hhzBrofbo496eCE/Q+ejtrWLYELSVnQy0kp/5LN
 gsOwt34KLHBByK2uKOv8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N+JOmTr2mOc=:mLa5XWJi7NgJM465D4t0XC
 4AiDtNYUqwQfRmvVv3TLPYzwImdJDIBi9w45Ze+CR9Dwj2wHvpTGnnEyt1oaw5HQMbu0iW4wt
 DzZtZ8/FxqZYjUOlecL2cF1CQmE4Vd4BJMoiL9i1T/YQ8bg631XzWSyStz4dhbh5zoiJzbKf5
 qyRqjY2CabKZD6WZty/QHv32bqDtUOzFlojqqyjj6qpQJjs4QeQRppJIV6PK20di6GP/z1FNm
 YGOqVWjOeoDWmItRUO8TTssv8UPSNOf79q83SfM/j3b6eGOG0gARIwBnJa4OKgi/NNAKG2acY
 MWb24vESu/b7c6DsUvXhI4+0MxkJjCYryyaZY44uWLDC0LLTUZyOBOgNl5CymdjQNdOn6Gerb
 KXCGKuU6jQfkwBMC88aCid1QrsmsSbNcSGn14+No9fJ7BzIxVIZqgHJ98j1odma24NLvNu65m
 EaSfswBYYmEa6zAzQ7kF5yVPYghkKgy8ySsz3OoLB7om0UaBp+XrhnoCx01hcsWR69lcENBHg
 SKRdbPiql1TyJlFGJb6XlOhgaTOJjuGt6Q1FPcoS80n/QrxIsXS89zmC1xf6fnzaQoUjc0j3R
 JA+sc4tLv1jsVwFzDKLNx/ZUjxRfd+gsU1FpznUCK+EnLOIJEw9isolcVhZrQUK8WOTspZdN9
 YWTEHrsiqDmceEfBpdFtFH35QpXxt/wb9aQJUR5gHHzLlDIomKogQlaLSgJSPFMOGfYtw+7A9
 rEtXcMFuiga9cgCjEPv4WYRb/4DyUpSRJC2fhuwGQ8NTFkYke5hT0YlQOIXZly1FL4UYZX2VG
 o+x/nLJW3KX0NHX5D/qP1xd+pPcdlW+hUjzc0o4lUGP/kiAW+AYdKsYlyfSg+F8vaMfdhusGS
 ToezYkgcMWIwDu7GH1J1eziZFffG8LQo+lHf88X7UPbOKNAUMSkJYnlFGpHkw1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.19 um 11:59 schrieb Ren=C3=A9 Scharfe:> Am 26.04.19 um 16:51 schr=
ieb Johannes Schindelin:
>>
>> On Mon, 15 Apr 2019, Jeff King wrote:
>>
>>> On Sun, Apr 14, 2019 at 12:01:10AM +0200, Ren=C3=A9 Scharfe wrote:
>>>
>>>> Doing compression in its own thread may be a good idea.
>>>
>>> Yeah. It might even make the patch simpler, since I'd expect it to be
>>> implemented with start_async() and a descriptor, making it look just
>>> like a gzip pipe to the caller. :)
>>
>> Sadly, it does not really look like it is simpler.
>
> I have to agree -- at least I was unable to pull off the stdout
> plumbing trick.

The simplest solution is of course to not touch the archive code.  The
patch below makes that possible:

Benchmark #1: ~/src/git/git -c tar.tgz.command=3D~/src/git/git-gzip archiv=
=65 --format=3Dtgz HEAD >/dev/null
  Time (mean =C2=B1 =CF=83):     17.256 s =C2=B1  0.299 s    [User: 20.380=
 s, System: 0.294 s]
  Range (min =E2=80=A6 max):   16.940 s =E2=80=A6 17.804 s    10 runs

Curious to see how it looks like on other systems and platforms.

And perhaps the buffer size needs to be tuned.

=2D- >8 --
Subject: [PATCH] add git gzip

Add a cheap gzip lookalike based on zlib for systems that don't have
(or want) the real thing.  It can be used e.g. to generate tgz files
using git archive and its configuration options tar.tgz.command and
tar.tar.gz.command, without any other external dependency.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
=2D--
 .gitignore       |  1 +
 Makefile         |  1 +
 builtin.h        |  1 +
 builtin/gzip.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
 command-list.txt |  1 +
 git.c            |  1 +
 6 files changed, 69 insertions(+)
 create mode 100644 builtin/gzip.c

diff --git a/.gitignore b/.gitignore
index 44c74402c8..e550868219 100644
=2D-- a/.gitignore
+++ b/.gitignore
@@ -71,6 +71,7 @@
 /git-gc
 /git-get-tar-commit-id
 /git-grep
+/git-gzip
 /git-hash-object
 /git-help
 /git-http-backend
diff --git a/Makefile b/Makefile
index 9f1b6e8926..2b34f1a4aa 100644
=2D-- a/Makefile
+++ b/Makefile
@@ -1075,6 +1075,7 @@ BUILTIN_OBJS +=3D builtin/fsck.o
 BUILTIN_OBJS +=3D builtin/gc.o
 BUILTIN_OBJS +=3D builtin/get-tar-commit-id.o
 BUILTIN_OBJS +=3D builtin/grep.o
+BUILTIN_OBJS +=3D builtin/gzip.o
 BUILTIN_OBJS +=3D builtin/hash-object.o
 BUILTIN_OBJS +=3D builtin/help.o
 BUILTIN_OBJS +=3D builtin/index-pack.o
diff --git a/builtin.h b/builtin.h
index b78ab6e30b..abc34cc9d0 100644
=2D-- a/builtin.h
+++ b/builtin.h
@@ -170,6 +170,7 @@ extern int cmd_fsck(int argc, const char **argv, const=
 char *prefix);
 extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char =
*prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
+extern int cmd_gzip(int argc, const char **argv, const char *prefix);
 extern int cmd_hash_object(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_help(int argc, const char **argv, const char *prefix);
 extern int cmd_index_pack(int argc, const char **argv, const char *prefix=
);
diff --git a/builtin/gzip.c b/builtin/gzip.c
new file mode 100644
index 0000000000..90a98c44ce
=2D-- /dev/null
+++ b/builtin/gzip.c
@@ -0,0 +1,64 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+
+static const char * const gzip_usage[] =3D {
+	N_("git gzip [-NUM]"),
+	NULL
+};
+
+static int level_callback(const struct option *opt, const char *arg, int =
unset)
+{
+	int *levelp =3D opt->value;
+	int value;
+	const char *endp;
+
+	if (unset)
+		BUG("switch -NUM cannot be negated");
+
+	value =3D strtol(arg, (char **)&endp, 10);
+	if (*endp)
+		BUG("switch -NUM cannot be non-numeric");
+
+	*levelp =3D value;
+	return 0;
+}
+
+#define BUFFERSIZE (64 * 1024)
+
+int cmd_gzip(int argc, const char **argv, const char *prefix)
+{
+	gzFile gz;
+	int level =3D Z_DEFAULT_COMPRESSION;
+	struct option options[] =3D {
+		OPT_NUMBER_CALLBACK(&level, N_("compression level"),
+				    level_callback),
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, prefix, options, gzip_usage, 0);
+	if (argc > 0)
+		usage_with_options(gzip_usage, options);
+
+	gz =3D gzdopen(1, "wb");
+	if (!gz)
+		die(_("unable to gzdopen stdout"));
+
+	if (gzsetparams(gz, level, Z_DEFAULT_STRATEGY) !=3D Z_OK)
+		die(_("unable to set compression level %d"), level);
+
+	for (;;) {
+		char buf[BUFFERSIZE];
+		ssize_t read_bytes =3D xread(0, buf, sizeof(buf));
+		if (read_bytes < 0)
+			die_errno(_("unable to read from stdin"));
+		if (read_bytes =3D=3D 0)
+			break;
+		if (gzwrite(gz, buf, read_bytes) !=3D read_bytes)
+			die(_("gzwrite failed"));
+	}
+
+	if (gzclose(gz) !=3D Z_OK)
+		die(_("gzclose failed"));
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index 3a9af104b5..755848842c 100644
=2D-- a/command-list.txt
+++ b/command-list.txt
@@ -99,6 +99,7 @@ git-gc                                  mainporcelain
 git-get-tar-commit-id                   plumbinginterrogators
 git-grep                                mainporcelain           info
 git-gui                                 mainporcelain
+git-gzip                                purehelpers
 git-hash-object                         plumbingmanipulators
 git-help                                ancillaryinterrogators          c=
omplete
 git-http-backend                        synchingrepositories
diff --git a/git.c b/git.c
index 50da125c60..48f7fc6c56 100644
=2D-- a/git.c
+++ b/git.c
@@ -510,6 +510,7 @@ static struct cmd_struct commands[] =3D {
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
+	{ "gzip", cmd_gzip },
 	{ "hash-object", cmd_hash_object },
 	{ "help", cmd_help },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
=2D-
2.21.0
