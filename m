Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68E2C46467
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 12:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLQMpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 07:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQMpw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 07:45:52 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDD78FEF
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 04:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671281145; bh=KBDDRS/3QTQYpXIGhT4fKLOMYfAAFyHILi4KIAY27Gc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=F21nTOJCuBf3nud1VhTKzeJGoMUNLSqGVpQg/qjy6JTGJ80eTtEj+Z+Wx2pie8j9G
         r/H2kiIclTGW1kYvJktSnR05smd/S0ut1cA4VseVn7HzDRTzypPVGm4zLjG02RcWPH
         bGAOp26q9gjaclcYagiGVyQgZTIni7hAUGJbYOOWIs2YcLpd4bQcrZVtAq5TbheoaG
         EBSy5WvClndH4E/vG3zgs8LsYqzpnDielcAFtw60415OoLSe6+T7fvvHZy/BlR+2fR
         ZKaV9nfo5GF2JyTnIGYGZn1T9lyLI1dYASpFhaqdD8qdqv4ut5KxVEbuHWH0WXVHCE
         HjBxpFcHEr/7g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j5k-1p0S1a440g-007gRR; Sat, 17
 Dec 2022 13:45:45 +0100
Message-ID: <d22fb47a-3f01-6b17-6abb-fdcfde4a55dc@web.de>
Date:   Sat, 17 Dec 2022 13:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 0/5] strvec: add a "nodup" mode, fix memory leaks
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <221214.86ilie48cv.gmgdl@evledraar.gmail.com>
 <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <RFC-cover-0.5-00000000000-20221215T090226Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gIae+4QVjYsP0tOXmDD+Tldh/0Vt41QcfgNBuddfnmNAXX6qmQH
 5HVnKDsGn12lfT1XGEtx7+2ZfgdpJ+JrXxcJM46nGnhiKhT7EHipdVuhCOGtFRJkfodZG4P
 dsYprYiSVZQ0PYGwO8DGQJUmm7R+x62w4SnW8TbdbA+eTp1tZM5U4LPYOyg0jahzUQ+lyJm
 Nzg6gUY48vhpbqcq+mzgw==
UI-OutboundReport: notjunk:1;M01:P0:n+iqcu1l97U=;P2f7k7ZSLu/8jJpDbiVxl+I8gTG
 N3Jox2KwNg4Lkd9iB2OV+HcVOFdb6y8lsmoMPu9gQJ1PF7kf4bk7Fqbg6gAQNIIlWqyYjAGne
 E9kb1aBG9BIyA3Z4W+gFX7UpZHJe7pXLkLV7hQ87ixpq1TwMn7iiibDxT4ptg+Pw8Fi/8B1SB
 EaaZgyRxZRNUapffc2ldZidX8EUlFo1AJlk90PfFUexvesXtDWX/1bRGWGR6CG1MFflmVe5bg
 lmwxQ6Q9Doj3igkPLZCQzYheOy+73Gw0Jpu/av6jesl4xuJLNDlX9tX8CHTj+ruSOioDJgC6x
 uO+mfiavklD96hTp13nruswQc0tpugACKfR0Z9viM7mFqFTPVAEN690PrHo+LzueQRe2CIEke
 g1nX7Z5u6Wy988PRJhRYklJOQhJgjdGCXYQZ/gsoaNXwaQhUgCFikHJITh7sI+qkwy/8jl0Kx
 Rx4omGSlOy1OgQPORhF/mQZfDL0Y0RIrtCtMbYQg58an247JVccwExe8lm4x1Ztp0MvBxZqP6
 GDDcc4tuC8evzz0TxVGi14v2KGiSZeV/maoreD4jgRKK1g1gud6PPpg4A+iaEUGHKwMtPLnNc
 7ge2HpMWADIaVs9DLUwuPssSJ+/EzJjFcgtKcSgUMv6vkrlIJsO1EzA/47BBOgOuL1nJ7kU1v
 fDkitTSNj5AmHwBSoCBnFuXwcrg0MMlrOnbJNMECx9mwLfENYQb587rKNwOIPUpRbiwk91e37
 t3BVgLcPs4RNtHZNSciVMCNNeV5kKz0cjV7DLguWUh0nCiMKe4zZdyL3Eji1K0sZs4WREc9jX
 GQMv/6az/D879YahQW6ioA9xTR6RyLjwDLvVGiKGzMaJKsKHwcqYfLmxrAg+lc4olKzuHzUJQ
 zzgaveW4r5l6cn5B9MTO867OlDGYfTlWJqEbPnV04gyGUDSIY2E4/Lh1u5d3xlGVSfyguRjzY
 604FdXTq4yCULSzADt23EBe8R9s=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.12.22 um 10:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> This is an alternative to Ren=C3=A9's [1], his already fixes a leak in "=
git
> am", and this could be done later, so I'm submitting it as RFC, but it
> could also replace it.
>
> I think as this series shows extending the "strvec" API to get a
> feature that works like the existing "strdup_strings" that the "struct
> string_list" has can make memory management much simpler.
>
> The 4/5 here shows cases where we were leaking because our "v" was
> clobbered, but where all the strings we were pushing to the "strvec"
> were fixed strings, so we could skip xstrdup()-ing them.
>
> The 5/5 then shows more complex cases where we have mixed-use,
> i.e. most strings are fixed, but some are not. For those we use a
> "struct string_list to_free =3D STRING_LIST_INIT_DUP", which we then
> push to the "to_free" list with "string_list_append_nodup()".
>
> This does make the API slightly more dangerous to use, as it's no
> longer guaranteed that it owns all the members it points to. But as
> the "struct string_list" has shown this isn't an issue in practice,
> and e.g. SANITIZE=3Daddress et al are good about finding double-frees,
> or frees of fixed strings.
>
> A branch & CI for this are found at [2].
>
> 1. https://lore.kernel.org/git/baf93e4a-7f05-857c-e551-09675496c03c@web.=
de/
> 2. https://github.com/avar/git/tree/avar/add-and-use-strvec-init-nodup
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (5):
>   builtin/annotate.c: simplify for strvec API
>   various: add missing strvec_clear()
>   strvec API: add a "STRVEC_INIT_NODUP"
>   strvec API users: fix leaks by using "STRVEC_INIT_NODUP"
>   strvec API users: fix more leaks by using "STRVEC_INIT_NODUP"
>
>  builtin/am.c                  |  2 +-
>  builtin/annotate.c            | 17 ++++++++---------
>  builtin/describe.c            | 28 +++++++++++++++++++++-------
>  builtin/stash.c               |  8 ++++++--
>  builtin/upload-archive.c      | 16 ++++++++++++----
>  strvec.c                      | 20 ++++++++++++++++++--
>  strvec.h                      | 30 +++++++++++++++++++++++++++++-
>  t/t0023-crlf-am.sh            |  1 +
>  t/t4152-am-subjects.sh        |  2 ++
>  t/t4254-am-corrupt.sh         |  2 ++
>  t/t4256-am-format-flowed.sh   |  1 +
>  t/t4257-am-interactive.sh     |  2 ++
>  t/t5003-archive-zip.sh        |  1 +
>  t/t5403-post-checkout-hook.sh |  1 +
>  14 files changed, 105 insertions(+), 26 deletions(-)
>

This complicates strvec to gain functionality that we basically already
have with REALLOC_ARRAY.  It allows for nice conversions in some cases
(patch 4), but places that require some kind of double accounting become
quite nasty (patch 5).  I'd prefer to keep strvec simple.  Avoiding
allocations isn't necessary because the number of options to parse is
low -- we just need to keep track of and release them at the end.

The problem here is that parse_options() takes a string list in the form
of an int paired with a const char ** and modifies this list in place.
That's fine if we don't care about the memory ownership of the list and
its elements, e.g. because we get it from the OS (main() style) or
accept leakage.

It's not compatible with the list being a strvec that we don't want to
leak, though.  What we need is something that translates from strvec to
the argc/argv convention.  If we allow leaks this is trivial: Just use
the .v member directly.  If we don't then it is still simple: Make a
shallow copy of the .v member, release it after use.  Demo patch below.

 builtin/am.c             |  5 ++++-
 builtin/annotate.c       |  9 ++++++++-
 builtin/describe.c       |  8 +++++++-
 builtin/stash.c          | 10 +++++++++-
 builtin/upload-archive.c | 11 +++++++++--
 strvec.c                 |  9 +++++++++
 strvec.h                 |  7 +++++++
 7 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 30c9b3a9cd..a80d40f4be 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -1476,14 +1476,16 @@ static int run_apply(const struct am_state *state,=
 const char *index_file)
 	int res, opts_left;
 	int force_apply =3D 0;
 	int options =3D 0;
+	const char **apply_argv;

 	if (init_apply_state(&apply_state, the_repository, NULL))
 		BUG("init_apply_state() failed");

 	strvec_push(&apply_opts, "apply");
 	strvec_pushv(&apply_opts, state->git_apply_opts.v);
+	apply_argv =3D strvec_clone_nodup(&apply_opts);

-	opts_left =3D apply_parse_options(apply_opts.nr, apply_opts.v,
+	opts_left =3D apply_parse_options(apply_opts.nr, apply_argv,
 					&apply_state, &force_apply, &options,
 					NULL);

@@ -1513,6 +1515,7 @@ static int run_apply(const struct am_state *state, c=
onst char *index_file)
 	strvec_clear(&apply_paths);
 	strvec_clear(&apply_opts);
 	clear_apply_state(&apply_state);
+	free(apply_argv);

 	if (res)
 		return res;
diff --git a/builtin/annotate.c b/builtin/annotate.c
index 58ff977a23..7e75f0f48d 100644
=2D-- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -10,6 +10,8 @@
 int cmd_annotate(int argc, const char **argv, const char *prefix)
 {
 	struct strvec args =3D STRVEC_INIT;
+	const char **blame_argv;
+	int ret;
 	int i;

 	strvec_pushl(&args, "annotate", "-c", NULL);
@@ -17,6 +19,11 @@ int cmd_annotate(int argc, const char **argv, const cha=
r *prefix)
 	for (i =3D 1; i < argc; i++) {
 		strvec_push(&args, argv[i]);
 	}
+	blame_argv =3D strvec_clone_nodup(&args);

-	return cmd_blame(args.nr, args.v, prefix);
+	ret =3D cmd_blame(args.nr, blame_argv, prefix);
+
+	strvec_clear(&args);
+	free(blame_argv);
+	return ret;
 }
diff --git a/builtin/describe.c b/builtin/describe.c
index eea1e330c0..2ef2fbc0d4 100644
=2D-- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -598,6 +598,8 @@ int cmd_describe(int argc, const char **argv, const ch=
ar *prefix)
 	if (contains) {
 		struct string_list_item *item;
 		struct strvec args;
+		const char **name_rev_argv;
+		int ret;

 		strvec_init(&args);
 		strvec_pushl(&args, "name-rev",
@@ -616,7 +618,11 @@ int cmd_describe(int argc, const char **argv, const c=
har *prefix)
 			strvec_pushv(&args, argv);
 		else
 			strvec_push(&args, "HEAD");
-		return cmd_name_rev(args.nr, args.v, prefix);
+		name_rev_argv =3D strvec_clone_nodup(&args);
+		ret =3D cmd_name_rev(args.nr, name_rev_argv, prefix);
+		strvec_clear(&args);
+		free(name_rev_argv);
+		return ret;
 	}

 	hashmap_init(&names, commit_name_neq, NULL, 0);
diff --git a/builtin/stash.c b/builtin/stash.c
index bb0fd86143..864b7c573a 100644
=2D-- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1820,6 +1820,8 @@ static int save_stash(int argc, const char **argv, c=
onst char *prefix)

 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
+	int ret;
+	const char **push_stash_argv;
 	pid_t pid =3D getpid();
 	const char *index_file;
 	struct strvec args =3D STRVEC_INIT;
@@ -1861,5 +1863,11 @@ int cmd_stash(int argc, const char **argv, const ch=
ar *prefix)
 	/* Assume 'stash push' */
 	strvec_push(&args, "push");
 	strvec_pushv(&args, argv);
-	return !!push_stash(args.nr, args.v, prefix, 1);
+	push_stash_argv =3D strvec_clone_nodup(&args);
+
+	ret =3D !!push_stash(args.nr, push_stash_argv, prefix, 1);
+
+	strvec_clear(&args);
+	free(push_stash_argv);
+	return ret;
 }
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 945ee2b412..36ed85e10a 100644
=2D-- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -19,6 +19,8 @@ static const char deadchild[] =3D

 int cmd_upload_archive_writer(int argc, const char **argv, const char *pr=
efix)
 {
+	int ret;
+	const char **upload_archive_argv;
 	struct strvec sent_argv =3D STRVEC_INIT;
 	const char *arg_cmd =3D "argument ";

@@ -43,10 +45,15 @@ int cmd_upload_archive_writer(int argc, const char **a=
rgv, const char *prefix)
 			die("'argument' token or flush expected");
 		strvec_push(&sent_argv, buf + strlen(arg_cmd));
 	}
+	upload_archive_argv =3D strvec_clone_nodup(&sent_argv);

 	/* parse all options sent by the client */
-	return write_archive(sent_argv.nr, sent_argv.v, prefix,
-			     the_repository, NULL, 1);
+	ret =3D write_archive(sent_argv.nr, upload_archive_argv, prefix,
+			    the_repository, NULL, 1);
+
+	strvec_clear(&sent_argv);
+	free(upload_archive_argv);
+	return ret;
 }

 __attribute__((format (printf, 1, 2)))
diff --git a/strvec.c b/strvec.c
index 61a76ce6cb..5c41c8c506 100644
=2D-- a/strvec.c
+++ b/strvec.c
@@ -106,3 +106,12 @@ const char **strvec_detach(struct strvec *array)
 		return ret;
 	}
 }
+
+const char **strvec_clone_nodup(const struct strvec *sv)
+{
+	const char **ret;
+
+	CALLOC_ARRAY(ret, sv->nr + 1);
+	COPY_ARRAY(ret, sv->v, sv->nr);
+	return ret;
+}
diff --git a/strvec.h b/strvec.h
index 9f55c8766b..6234634b00 100644
=2D-- a/strvec.h
+++ b/strvec.h
@@ -88,4 +88,11 @@ void strvec_clear(struct strvec *);
  */
 const char **strvec_detach(struct strvec *);

+/**
+ * Create a copy of the array that references the original strings.
+ * The caller is responsible for freeing the memory of that copy,
+ * but must not free the individual strings.
+ */
+const char **strvec_clone_nodup(const struct strvec *);
+
 #endif /* STRVEC_H */
