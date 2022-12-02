Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0903C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 11:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbiLBLlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 06:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiLBLla (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 06:41:30 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E120D4246
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 03:41:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ml11so10946017ejb.6
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 03:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A8UQn7TbV6PVUhpFLg64D5Yjn988Ti+EgcO3Q9zl6aY=;
        b=m2DZdaEhKK59Ot8mI5eQQeZ+8pULlgcv9Zv64lKUYHssXpN22jVn5SPa7D2kGsaibO
         XzPSZ7FXvzTwNuw/g+7g9lbX9/9uDwH98gLXvKUeuy1dD0EVwHjcN8cM7zmwsv+tBCU3
         g7+1alodJ7kcouuQxZQqCT+JvxNi/BNVIXMv8tzsSyMDxEFB/T+BzefJoJDQBIcLH7ie
         Y/W147H/F8jP5QVPo4vKtG/i3APtKiEmpXGjvtcHKZ7Dx/fSUbHPUxBV3XbKz4TvB4RW
         6GQr+M4hfvruAdqdg8kfxpdtodax1uzua/nT0vQDQgt/m3pm14oMjophstha8HrYmqmr
         3K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A8UQn7TbV6PVUhpFLg64D5Yjn988Ti+EgcO3Q9zl6aY=;
        b=04qD0oTHRulUqmkNg7iS4qdVyq0XbhWMhF4Z494x9K9OCfRvJV/pvejE04tl63I0aS
         wg9WttyqaU2OxwgVFLn8E6GHZ78hFs8A20tHyKx/34LsOOcEPSlK7pjfv2wIrO0xv19T
         b/CUQEUrKEC1wzfseMVIBepd6MlIvfj8cXDyeXAs9L0DdqSgcHRgKKaxkbWBti8u073Z
         DyuwBOTjdBpkrOjJYCQgi57G/yiBN7uRRV+Ep2/7W0EvEEZOouD1OEXyE5hiOrzuhCIS
         eY8JkMDPPRpTBhJlenMMvhFCEtEXk02/KvfYXXGTBpbRHOzLPamp/42/E/V9H3FzSwJJ
         4n6g==
X-Gm-Message-State: ANoB5pk3rixjdp+V9V528//7++x2PwvsRAGD4Jd9vcUGfmfFWR2ZEb2O
        tzeWjbI6kz7TOfyjtijxQdA=
X-Google-Smtp-Source: AA0mqf63PzEKaMhjrlGz64pZIVKphdIBUxQgu5zllHcQrlLpOmqHDBZUs4BS/EcMnjhxGk7osnWYZw==
X-Received: by 2002:a17:907:a505:b0:7bb:129e:8a4c with SMTP id vr5-20020a170907a50500b007bb129e8a4cmr25817815ejc.300.1669981288017;
        Fri, 02 Dec 2022 03:41:28 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906314e00b007aee7ca1199sm2976460eje.10.2022.12.02.03.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 03:41:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p14Q2-002cmR-2k;
        Fri, 02 Dec 2022 12:41:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid redefining system function names
Date:   Fri, 02 Dec 2022 12:31:32 +0100
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
 <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
Message-ID: <221202.86wn7af2xl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 30 2022, Jeff King wrote:

> On Mon, Nov 28, 2022 at 12:01:35AM -0500, Jeff King wrote:
>
>> All this points to 15b52a44e0 being a bit too loose with its
>> assumptions. It is assuming that if the posix flag is not defined, we
>> are free to use those system names. But here's an example where that is
>> not true. And the only way around it is with a macro, which is what we
>> had before that commit.
>>=20
>> So I think we'd want to revert the flockfile() bits of that commit. And
>> I'd guess setitimer is in the same boat (the system may declare it, but
>> for whatever reason somebody may choose not to use it by feeding
>> NO_SETITIMER to make, at which point the compiler will complain about
>> the duplicate declaration.
>
> After sleeping on this, here's a best-of-both-worlds solution.
>
> Junio: this is perhaps maint material in the long run, but the breakage
> goes back to v2.29.0, so definitely not urgent for the release period.
> Note that if you go farther back than what will become maint-2.39,
> there's a minor textual conflict around the UNUSED markers.
>
> -- >8 --
> Subject: [PATCH] git-compat-util: avoid redefining system function names
>
> Our git-compat-util header defines a few noop wrappers for system
> functions if they are not available. This was originally done with a
> macro, but in 15b52a44e0 (compat-util: type-check parameters of no-op
> replacement functions, 2020-08-06) we switched to inline functions,
> because it gives us basic type-checking.
>
> This can cause compilation failures when the system _does_ declare those
> functions but we choose not to use them, since the compiler will
> complain about the redeclaration. This was seen in the real world when
> compiling against certain builds of uclibc, which may leave
> _POSIX_THREAD_SAFE_FUNCTIONS unset, but still declare flockfile() and
> funlockfile().
>
> It can also be seen on any platform that has setitimer() if you choose
> to compile without it (which plausibly could happen if the system
> implementation is buggy). E.g., on Linux:
>
>   $ make NO_SETITIMER=3DIWouldPreferNotTo git.o
>       CC git.o
>   In file included from builtin.h:4,
>                    from git.c:1:
>   git-compat-util.h:344:19: error: conflicting types for =E2=80=98setitim=
er=E2=80=99; have =E2=80=98int(int,  const struct itimerval *, struct itime=
rval *)=E2=80=99
>     344 | static inline int setitimer(int which UNUSED,
>         |                   ^~~~~~~~~
>   In file included from git-compat-util.h:234:
>   /usr/include/x86_64-linux-gnu/sys/time.h:155:12: note: previous declara=
tion of =E2=80=98setitimer=E2=80=99 with type =E2=80=98int(__itimer_which_t=
,  const struct itimerval * restrict,  struct itimerval * restrict)=E2=80=99
>     155 | extern int setitimer (__itimer_which_t __which,
>         |            ^~~~~~~~~
>   make: *** [Makefile:2714: git.o] Error 1
>
> Here I think the compiler is complaining about the lack of "restrict"
> annotations in our version, but even if we matched it completely (and
> there is no way to match all platforms anyway), it would still complain
> about a static declaration following a non-static one. Using macros
> doesn't have this problem, because the C preprocessor rewrites the name
> in our code before we hit this level of compilation.

...

> One way to fix this would just be to revert most of 15b52a44e0. What we
> really cared about there was catching build problems with
> precompose_argv(), which most platforms _don't_ build, and which is our
> custom function. So we could just switch the system wrappers back to
> macros; most people build the real versions anyway, and they don't
> change. So the extra type-checking isn't likely to catch bugs.
>
> But with a little work, we can have our cake and eat it, too. If we
> define the type-checking wrappers with a unique name, and then redirect
> the system names to them with macros, we still get our type checking,
> but without redeclaring the system function names.

This looks good to me. The only thing I'd like to note is that while the
above explanation might read as though this is something novel, it's
really just doing exactly what we're already doing for
e.g. git_vsnprintf:
=09
	$ git -P grep git_snprintf
	compat/snprintf.c:int git_snprintf(char *str, size_t maxsize, const char *=
format, ...)
	git-compat-util.h:#define snprintf git_snprintf
	git-compat-util.h:int git_snprintf(char *str, size_t maxsize,

Now, that's not a downside here but an upside, plain old boring and
using existing precedence is a goood thing. Except that....

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I confirmed that this builds on Linux with NO_SETITIMER, and still
> catches type problems if you intentionally break one of the callers.
>
> Technically these should probably all have "#undef flockfile" and so on,
> but we've never done that, and we haven't seen an actual platform that
> complains. So I didn't include that here. I don't mind if somebody wants
> to, but it should be a separate patch on top.
>
>  git-compat-util.h | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index a76d0526f7..83ec7b7941 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -341,11 +341,12 @@ struct itimerval {
>  #endif
>=20=20
>  #ifdef NO_SETITIMER
> -static inline int setitimer(int which UNUSED,
> -			    const struct itimerval *value UNUSED,
> -			    struct itimerval *newvalue UNUSED) {
> +static inline int git_setitimer(int which UNUSED,
> +				const struct itimerval *value UNUSED,
> +				struct itimerval *newvalue UNUSED) {
>  	return 0; /* pretend success */
>  }
> +#define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)

...this part is where we differ from the existing pattern. I don't think
it matters except for the redundant verbosity, but as we're not
re-arranging the parameters here, why not simply:

	#define setitimer git_setitimer

?

> +#define flockfile(fh) git_flockfile(fh)
> +#define funlockfile(fh) git_funlockfile(fh)
>  #define getc_unlocked(fh) getc(fh)
>  #endif

Ditto.

I went looking a bit more, and we also have existing examples of these
sort of macros, but could probably have this on top of "next" if we care
to make these consistent.

This leaves only the /git.*\(/ macros whose parameters we need to alter
as defining parameters:

diff --git a/git-compat-util.h b/git-compat-util.h
index 83ec7b7941e..87a16d8cfcd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -346,7 +346,7 @@ static inline int git_setitimer(int which UNUSED,
 				struct itimerval *newvalue UNUSED) {
 	return 0; /* pretend success */
 }
-#define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
+#define setitimer git_setitimer
 #endif
=20
 #ifndef NO_LIBGEN_H
@@ -546,7 +546,7 @@ static inline int git_has_dir_sep(const char *path)
 {
 	return !!strchr(path, '/');
 }
-#define has_dir_sep(path) git_has_dir_sep(path)
+#define has_dir_sep git_has_dir_sep
 #endif
=20
 #ifndef query_user_email
@@ -831,17 +831,17 @@ int git_munmap(void *start, size_t length);
 #ifdef stat
 #undef stat
 #endif
-#define stat(path, buf) git_stat(path, buf)
+#define stat git_stat
 int git_stat(const char *, struct stat *);
 #ifdef fstat
 #undef fstat
 #endif
-#define fstat(fd, buf) git_fstat(fd, buf)
+#define fstat git_fstat
 int git_fstat(int, struct stat *);
 #ifdef lstat
 #undef lstat
 #endif
-#define lstat(path, buf) git_lstat(path, buf)
+#define lstat git_lstat
 int git_lstat(const char *, struct stat *);
 #endif
=20
@@ -923,7 +923,7 @@ char *gitstrdup(const char *s);
 #  ifdef fopen
 #   undef fopen
 #  endif
-#  define fopen(a,b) git_fopen(a,b)
+#  define fopen git_fopen
 # endif
 FILE *git_fopen(const char*, const char*);
 #endif
@@ -1480,16 +1480,16 @@ static inline void git_funlockfile(FILE *fh UNUSED)
 {
 	; /* nothing */
 }
-#define flockfile(fh) git_flockfile(fh)
-#define funlockfile(fh) git_funlockfile(fh)
-#define getc_unlocked(fh) getc(fh)
+#define flockfile git_flockfile
+#define funlockfile git_funlockfile
+#define getc_unlocked getc
 #endif
=20
 #ifdef FILENO_IS_A_MACRO
 int git_fileno(FILE *stream);
 # ifndef COMPAT_CODE_FILENO
 #  undef fileno
-#  define fileno(p) git_fileno(p)
+#  define fileno git_fileno
 # endif
 #endif
=20
@@ -1499,7 +1499,7 @@ int git_access(const char *path, int mode);
 #  ifdef access
 #  undef access
 #  endif
-#  define access(path, mode) git_access(path, mode)
+#  define access git_access
 # endif
 #endif
=20
