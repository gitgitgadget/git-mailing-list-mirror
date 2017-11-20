Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E19C202A0
	for <e@80x24.org>; Mon, 20 Nov 2017 01:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdKTBB6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 20:01:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61262 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750952AbdKTBB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 20:01:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01AC0B558D;
        Sun, 19 Nov 2017 20:01:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PdOcaoBYSke7
        mJ7s5MacCqiMuYs=; b=V0A9zFDaiSwDDsZWFr09rCyd9E8BjhuM0dXkoKSFn13E
        zgZqhCTi1Wpid6S9eGNau0QYFGrqf6UAqZT9a64odaS9PDUZOJCFLcM1KIFO2W6B
        LK5N271ioQcXjavw9cRz8yIMDTrEwNO5TLVee3vsnQZggOVJ67VcogkY7Fz1Uwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rgT7yB
        +r56J288tGxwIsg7kaf/J98/vMfz68X1E58E9MFgJ0Gv6nweuCZR9gwVEkrVqtBt
        WWmai+TjRUo7zYGPRoityiMFkZIhn10bmUqcZNgJwfvBqVV4DkNKClGuIqiyf/Va
        7r0vgajuuUEmbka9NyrxkiaSP/5b+0wDNWimw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE40AB558C;
        Sun, 19 Nov 2017 20:01:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 483A6B558A;
        Sun, 19 Nov 2017 20:01:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] exec_cmd: RUNTIME_PREFIX on some POSIX systems
References: <20171119173141.4896-1-dnj@google.com>
        <20171119173141.4896-2-dnj@google.com>
Date:   Mon, 20 Nov 2017 10:01:54 +0900
In-Reply-To: <20171119173141.4896-2-dnj@google.com> (Dan Jacques's message of
        "Sun, 19 Nov 2017 12:31:41 -0500")
Message-ID: <xmqq60a5oj99.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 66E0222E-CD8E-11E7-84B4-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Jacques <dnj@google.com> writes:

> Enable Git to resolve its own binary location using a variety of
> OS-specific and generic methods, including:
>
> - procfs via "/proc/self/exe" (Linux)
> - _NSGetExecutablePath (Darwin)
> - KERN_PROC_PATHNAME sysctl on BSDs.
> - argv0, if absolute (all, including Windows).
>
> This is used to enable RUNTIME_PREFIX support for non-Windows systems,
> notably Linux and Darwin. When configured with RUNTIME_PREFIX, Git will
> do a best-effort resolution of its executable path and automatically us=
e
> this as its "exec_path" for relative helper and data lookups, unless
> explicitly overridden.
>
> Git's PERL tooling now responds to RUNTIME_PREFIX_PERL. When configured=
,
> Git's generated PERL scripts resolve the Git library location relative =
to
> their runtime paths instead of hard-coding them. Structural changes
> were made to Makefile to support selective PERL header generation.

=C3=86var and Dscho Cc'ed for input on Perl and also for the following
piece from the cover letter of the previous iteration (which is not
in the cover for this iteration--because there ought to be no impact
to Windows unless the new RUNTIME_PREFIX_PERL is used):

    Please note that this patch affects Windows Git builds, since
    the Windows Git project uses RUNTIME_PREFIX to support arbitrary
    installation paths.  Notably, PERL scripts are now always
    installed without MakeMaker (if they weren't before), and
    EXEC_PATH_ENVIRONMENT is preferred by tools instead of
    re-resolving argv[0]. Chromium uses the stock redistributable
    Windows Git package, so I haven't had an opportunity to test
    this patch on that platform.

The rest of the patch kept for reference but I not yet have any
comment on it yet.

Thanks.

> Small incidental formatting cleanup of "exec_cmd.c".
>
> Signed-off-by: Dan Jacques <dnj@google.com>
> ---
>  .gitignore       |   1 +
>  Makefile         |  88 +++++++++++++++++---
>  cache.h          |   1 +
>  common-main.c    |   4 +-
>  config.mak.uname |   7 ++
>  exec_cmd.c       | 239 +++++++++++++++++++++++++++++++++++++++++++++++=
--------
>  exec_cmd.h       |   4 +-
>  gettext.c        |   8 +-
>  git.c            |   2 +-
>  9 files changed, 304 insertions(+), 50 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 833ef3b0b..89bd7bd8a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -3,6 +3,7 @@
>  /GIT-LDFLAGS
>  /GIT-PREFIX
>  /GIT-PERL-DEFINES
> +/GIT-PERL-HEADER
>  /GIT-PYTHON-VARS
>  /GIT-SCRIPT-DEFINES
>  /GIT-USER-AGENT
> diff --git a/Makefile b/Makefile
> index ee9d5eb11..6fddb8b8f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -296,7 +296,8 @@ all::
>  # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/p=
erl).
>  #
>  # Define NO_PERL_MAKEMAKER if you cannot use Makefiles generated by pe=
rl's
> -# MakeMaker (e.g. using ActiveState under Cygwin).
> +# MakeMaker (e.g. using ActiveState under Cygwin). NO_PERL_MAKEMAKER i=
s
> +# automatically enabled when using RUNTIME_PREFIX_PERL.
>  #
>  # Define NO_PERL if you do not want Perl scripts or libraries at all.
>  #
> @@ -416,6 +417,16 @@ all::
>  #
>  # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl =
function.
>  #
> +# Define HAVE_BSD_KERN_PROC_SYSCTL if your platform supports the KERN_=
PROC BSD
> +# sysctl function.
> +#
> +# Define PROCFS_EXECUTABLE_PATH if your platform mounts a "procfs" fil=
esystem
> +# capable of resolving the path of the current executable. If defined,=
 this
> +# must be the canonical path for the "procfs" current executable path.
> +#
> +# Define HAVE_NS_GET_EXECUTABLE_PATH if your platform supports calling
> +# _NSGetExecutablePath to retrieve the path of the running executable.
> +#
>  # Define HAVE_GETDELIM if your system has the getdelim() function.
>  #
>  # Define PAGER_ENV to a SP separated VAR=3DVAL pairs to define
> @@ -425,6 +436,16 @@ all::
>  #
>  # to say "export LESS=3DFRX (and LV=3D-c) if the environment variable
>  # LESS (and LV) is not set, respectively".
> +#
> +# Define RUNTIME_PREFIX to configure Git to resolve its ancillary tool=
ing and
> +# support files relative to the location of the runtime binary, rather=
 than
> +# hard-coding them into the binary. Git installations built with RUNTI=
ME_PREFIX
> +# can be moved to arbitrary filesystem locations. Users may want to en=
able
> +# RUNTIME_PREFIX_PERL as well (see below).
> +#
> +# Define RUNTIME_PREFIX_PERL to configure Git's PERL commands to locat=
e Git
> +# support libraries relative to their filesystem path instead of hard-=
coding
> +# it. RUNTIME_PREFIX_PERL also sets NO_PERL_MAKEMAKER.
> =20
>  GIT-VERSION-FILE: FORCE
>  	@$(SHELL_PATH) ./GIT-VERSION-GEN
> @@ -462,6 +483,7 @@ ARFLAGS =3D rcs
>  #   mandir
>  #   infodir
>  #   htmldir
> +#   localedir
>  # This can help installing the suite in a relocatable way.
> =20
>  prefix =3D $(HOME)
> @@ -485,6 +507,7 @@ pathsep =3D :
>  mandir_relative =3D $(patsubst $(prefix)/%,%,$(mandir))
>  infodir_relative =3D $(patsubst $(prefix)/%,%,$(infodir))
>  htmldir_relative =3D $(patsubst $(prefix)/%,%,$(htmldir))
> +localedir_relative =3D $(patsubst $(prefix)/%,%,$(localedir))
> =20
>  export prefix bindir sharedir sysconfdir gitwebdir localedir
> =20
> @@ -1522,9 +1545,6 @@ ifdef SHA1_MAX_BLOCK_SIZE
>  	LIB_OBJS +=3D compat/sha1-chunked.o
>  	BASIC_CFLAGS +=3D -DSHA1_MAX_BLOCK_SIZE=3D"$(SHA1_MAX_BLOCK_SIZE)"
>  endif
> -ifdef NO_PERL_MAKEMAKER
> -	export NO_PERL_MAKEMAKER
> -endif
>  ifdef NO_HSTRERROR
>  	COMPAT_CFLAGS +=3D -DNO_HSTRERROR
>  	COMPAT_OBJS +=3D compat/hstrerror.o
> @@ -1549,6 +1569,15 @@ ifdef RUNTIME_PREFIX
>  	COMPAT_CFLAGS +=3D -DRUNTIME_PREFIX
>  endif
> =20
> +ifdef RUNTIME_PREFIX_PERL
> +	# Control PERL library location so its paths and contents are not dep=
endent on
> +	# the host's PERL version. See perl/Makefile for more information.
> +	NO_PERL_MAKEMAKER =3D YesPlease
> +endif
> +ifdef NO_PERL_MAKEMAKER
> +	export NO_PERL_MAKEMAKER
> +endif
> +
>  ifdef NO_PTHREADS
>  	BASIC_CFLAGS +=3D -DNO_PTHREADS
>  else
> @@ -1628,10 +1657,23 @@ ifdef HAVE_BSD_SYSCTL
>  	BASIC_CFLAGS +=3D -DHAVE_BSD_SYSCTL
>  endif
> =20
> +ifdef HAVE_BSD_KERN_PROC_SYSCTL
> +	BASIC_CFLAGS +=3D -DHAVE_BSD_KERN_PROC_SYSCTL
> +endif
> +
>  ifdef HAVE_GETDELIM
>  	BASIC_CFLAGS +=3D -DHAVE_GETDELIM
>  endif
> =20
> +ifneq ($(PROCFS_EXECUTABLE_PATH),)
> +	procfs_executable_path_SQ =3D $(subst ','\'',$(PROCFS_EXECUTABLE_PATH=
))
> +	BASIC_CFLAGS +=3D '-DPROCFS_EXECUTABLE_PATH=3D"$(procfs_executable_pa=
th_SQ)"'
> +endif
> +
> +ifdef HAVE_NS_GET_EXECUTABLE_PATH
> +	BASIC_CFLAGS +=3D -DHAVE_NS_GET_EXECUTABLE_PATH
> +endif
> +
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK =3D NoThanks
>  endif
> @@ -1714,6 +1756,7 @@ bindir_relative_SQ =3D $(subst ','\'',$(bindir_re=
lative))
>  mandir_relative_SQ =3D $(subst ','\'',$(mandir_relative))
>  infodir_relative_SQ =3D $(subst ','\'',$(infodir_relative))
>  localedir_SQ =3D $(subst ','\'',$(localedir))
> +localedir_relative_SQ =3D $(subst ','\'',$(localedir_relative))
>  gitexecdir_SQ =3D $(subst ','\'',$(gitexecdir))
>  template_dir_SQ =3D $(subst ','\'',$(template_dir))
>  htmldir_relative_SQ =3D $(subst ','\'',$(htmldir_relative))
> @@ -1962,17 +2005,16 @@ perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makef=
ile perl/Makefile.PL
>  	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH=3D'$(PERL_PATH_SQ)' p=
refix=3D'$(prefix_SQ)' $(@F)
> =20
>  PERL_DEFINES =3D $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
> -$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERS=
ION-FILE
> +
> +$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-PERL=
-HEADER GIT-VERSION-FILE
>  	$(QUIET_GEN)$(RM) $@ $@+ && \
>  	INSTLIBDIR=3D`MAKEFLAGS=3D $(MAKE) -C perl -s --no-print-directory in=
stlibdir` && \
>  	INSTLIBDIR_EXTRA=3D'$(PERLLIB_EXTRA_SQ)' && \
>  	INSTLIBDIR=3D"$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" =
&& \
>  	sed -e '1{' \
>  	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
> -	    -e '	h' \
> -	    -e '	s=3D.*=3Duse lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "=
'"$$INSTLIBDIR"'"));=3D' \
> -	    -e '	H' \
> -	    -e '	x' \
> +	    -e '	rGIT-PERL-HEADER' \
> +	    -e '	G' \
>  	    -e '}' \
>  	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>  	    $< >$@+ && \
> @@ -1986,6 +2028,29 @@ GIT-PERL-DEFINES: FORCE
>  		echo "$$FLAGS" >$@; \
>  	    fi
> =20
> +GIT-PERL-HEADER: perl/perl.mak GIT-PERL-DEFINES FORCE
> +ifndef RUNTIME_PREFIX_PERL
> +	# Hardcode the runtime path.
> +	INSTLIBDIR=3D`MAKEFLAGS=3D $(MAKE) -C perl -s --no-print-directory in=
stlibdir` && \
> +	INSTLIBDIR_EXTRA=3D'$(PERLLIB_EXTRA_SQ)' && \
> +	echo \
> +	  'use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"=
'"));' \
> +	  >$@
> +else
> +	# Probe the runtime path relative to the PERL script. RUNTIME_PREFIX_=
PERL
> +	# automatically sets NO_PERL_MAKEMAKER, causing PERL scripts to be in=
stalled
> +	# to "$(prefix)/lib" (see "perl/Makefile"). This expectation is hard-=
coded
> +	# into the generated code below.
> +	GITEXECDIR=3D'$(gitexecdir_SQ)' && \
> +	echo \
> +	  'sub _get_git_lib{'\
> +	  'use FindBin;'\
> +	  '(my $$p=3D$$FindBin::Bin)=3D~s=3D/'$${GITEXECDIR}'$$=3D=3D;'\
> +		'return File::Spec->catdir($$p,"'"lib"'");' \
> +	  '};' \
> +	  'use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB}||_get_git_lib()));'=
\
> +	  >$@
> +endif
> =20
>  .PHONY: gitweb
>  gitweb:
> @@ -2130,6 +2195,7 @@ endif
>  exec_cmd.sp exec_cmd.s exec_cmd.o: GIT-PREFIX
>  exec_cmd.sp exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS =3D \
>  	'-DGIT_EXEC_PATH=3D"$(gitexecdir_SQ)"' \
> +	'-DGIT_LOCALE_PATH=3D"$(localedir_relative_SQ)"' \
>  	'-DBINDIR=3D"$(bindir_relative_SQ)"' \
>  	'-DPREFIX=3D"$(prefix_SQ)"'
> =20
> @@ -2147,7 +2213,7 @@ attr.sp attr.s attr.o: EXTRA_CPPFLAGS =3D \
> =20
>  gettext.sp gettext.s gettext.o: GIT-PREFIX
>  gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS =3D \
> -	-DGIT_LOCALE_PATH=3D'"$(localedir_SQ)"'
> +	-DGIT_LOCALE_PATH=3D'"$(localedir_relative_SQ)"'
> =20
>  http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SPARS=
E_FLAGS +=3D \
>  	-DCURL_DISABLE_TYPECHECK
> @@ -2704,7 +2770,7 @@ ifndef NO_TCLTK
>  endif
>  	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
>  	$(RM) GIT-USER-AGENT GIT-PREFIX
> -	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PYTHON-VARS
> +	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PERL-HEADER GIT-PYTHON-=
VARS
> =20
>  .PHONY: all install profile-clean clean strip
>  .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_moder=
n_shell
> diff --git a/cache.h b/cache.h
> index cb7fb7c00..fb7795410 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -445,6 +445,7 @@ static inline enum object_type object_type(unsigned=
 int mode)
>  #define GIT_ICASE_PATHSPECS_ENVIRONMENT "GIT_ICASE_PATHSPECS"
>  #define GIT_QUARANTINE_ENVIRONMENT "GIT_QUARANTINE_PATH"
>  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
> +#define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
> =20
>  /*
>   * This environment variable is expected to contain a boolean indicati=
ng
> diff --git a/common-main.c b/common-main.c
> index 6a689007e..6516a1f89 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -32,12 +32,12 @@ int main(int argc, const char **argv)
>  	 */
>  	sanitize_stdfds();
> =20
> +	git_resolve_executable_dir(argv[0]);
> +
>  	git_setup_gettext();
> =20
>  	attr_start();
> =20
> -	git_extract_argv0_path(argv[0]);
> -
>  	restore_sigpipe_to_default();
> =20
>  	return cmd_main(argc, argv);
> diff --git a/config.mak.uname b/config.mak.uname
> index 685a80d13..58fd62b4d 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
>  	HAVE_GETDELIM =3D YesPlease
>  	SANE_TEXT_GREP=3D-a
>  	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
> +	PROCFS_EXECUTABLE_PATH =3D /proc/self/exe
>  endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>  	HAVE_ALLOCA_H =3D YesPlease
> @@ -111,6 +112,7 @@ ifeq ($(uname_S),Darwin)
>  	BASIC_CFLAGS +=3D -DPROTECT_HFS_DEFAULT=3D1
>  	HAVE_BSD_SYSCTL =3D YesPlease
>  	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
> +	HAVE_NS_GET_EXECUTABLE_PATH =3D YesPlease
>  endif
>  ifeq ($(uname_S),SunOS)
>  	NEEDS_SOCKET =3D YesPlease
> @@ -206,6 +208,7 @@ ifeq ($(uname_S),FreeBSD)
>  	HAVE_PATHS_H =3D YesPlease
>  	GMTIME_UNRELIABLE_ERRORS =3D UnfortunatelyYes
>  	HAVE_BSD_SYSCTL =3D YesPlease
> +	HAVE_BSD_KERN_PROC_SYSCTL =3D YesPlease
>  	PAGER_ENV =3D LESS=3DFRX LV=3D-c MORE=3DFRX
>  	FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
>  endif
> @@ -218,6 +221,8 @@ ifeq ($(uname_S),OpenBSD)
>  	BASIC_LDFLAGS +=3D -L/usr/local/lib
>  	HAVE_PATHS_H =3D YesPlease
>  	HAVE_BSD_SYSCTL =3D YesPlease
> +	HAVE_BSD_KERN_PROC_SYSCTL =3D YesPlease
> +	PROCFS_EXECUTABLE_PATH =3D /proc/curproc/file
>  endif
>  ifeq ($(uname_S),MirBSD)
>  	NO_STRCASESTR =3D YesPlease
> @@ -236,6 +241,8 @@ ifeq ($(uname_S),NetBSD)
>  	USE_ST_TIMESPEC =3D YesPlease
>  	HAVE_PATHS_H =3D YesPlease
>  	HAVE_BSD_SYSCTL =3D YesPlease
> +	HAVE_BSD_KERN_PROC_SYSCTL =3D YesPlease
> +	PROCFS_EXECUTABLE_PATH =3D /proc/curproc/exe
>  endif
>  ifeq ($(uname_S),AIX)
>  	DEFAULT_PAGER =3D more
> diff --git a/exec_cmd.c b/exec_cmd.c
> index ce192a2d6..c9006c4c9 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -2,53 +2,232 @@
>  #include "exec_cmd.h"
>  #include "quote.h"
>  #include "argv-array.h"
> -#define MAX_ARGS	32
> =20
> -static const char *argv_exec_path;
> +#if defined(RUNTIME_PREFIX)
> +
> +#if defined(HAVE_NS_GET_EXECUTABLE_PATH)
> +#include <mach-o/dyld.h>
> +#endif
> +
> +#if defined(HAVE_BSD_KERN_PROC_SYSCTL)
> +#include <sys/param.h>
> +#include <sys/types.h>
> +#include <sys/sysctl.h>
> +#endif
> +
> +#endif /* RUNTIME_PREFIX */
> +
> +#define MAX_ARGS 32
> +
> +static const char *system_prefix(void);
> =20
>  #ifdef RUNTIME_PREFIX
> -static const char *argv0_path;
> +
> +/**
> + * When using a runtime prefix, Git dynamically resolves paths relativ=
e to its
> + * executable.
> + *
> + * The method for determining the path of the executable is highly
> + * platform-specific.
> + */
> +
> +/**
> + * Path to the current Git executable. Resolved on startup by
> + * 'git_resolve_executable_dir'.
> + */
> +static const char *executable_dirname;
> =20
>  static const char *system_prefix(void)
>  {
>  	static const char *prefix;
> =20
> -	assert(argv0_path);
> -	assert(is_absolute_path(argv0_path));
> +	assert(executable_dirname);
> +	assert(is_absolute_path(executable_dirname));
> =20
>  	if (!prefix &&
> -	    !(prefix =3D strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
> -	    !(prefix =3D strip_path_suffix(argv0_path, BINDIR)) &&
> -	    !(prefix =3D strip_path_suffix(argv0_path, "git"))) {
> +	    !(prefix =3D strip_path_suffix(executable_dirname, GIT_EXEC_PATH)=
) &&
> +	    !(prefix =3D strip_path_suffix(executable_dirname, BINDIR)) &&
> +	    !(prefix =3D strip_path_suffix(executable_dirname, "git"))) {
>  		prefix =3D PREFIX;
>  		trace_printf("RUNTIME_PREFIX requested, "
> -				"but prefix computation failed.  "
> -				"Using static fallback '%s'.\n", prefix);
> +			     "but prefix computation failed.  "
> +			     "Using static fallback '%s'.\n",
> +			     prefix);
>  	}
>  	return prefix;
>  }
> =20
> -void git_extract_argv0_path(const char *argv0)
> +/*
> + * Resolves the executable path from argv[0], only if it is absolute.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int git_get_exec_path_from_argv0(struct strbuf *buf, const char=
 *argv0)
>  {
>  	const char *slash;
> =20
>  	if (!argv0 || !*argv0)
> -		return;
> +		return -1;
> =20
>  	slash =3D find_last_dir_sep(argv0);
> +	if (slash) {
> +		trace_printf("trace: resolved executable path from argv0: %s\n",
> +			     argv0);
> +		strbuf_add_absolute_path(buf, argv0);
> +		return 0;
> +	}
> +	return -1;
> +}
> +
> +#ifdef PROCFS_EXECUTABLE_PATH
> +/*
> + * Resolves the executable path by examining a procfs symlink.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int git_get_exec_path_procfs(struct strbuf *buf)
> +{
> +	if (strbuf_realpath(buf, PROCFS_EXECUTABLE_PATH, 0)) {
> +		trace_printf(
> +			"trace: resolved executable path from procfs: %s\n",
> +			buf->buf);
> +		return 0;
> +	}
> +	return -1;
> +}
> +#endif /* PROCFS_EXECUTABLE_PATH */
> +
> +#ifdef HAVE_BSD_KERN_PROC_SYSCTL
> +/*
> + * Resolves the executable path using KERN_PROC_PATHNAME BSD sysctl.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int git_get_exec_path_bsd_sysctl(struct strbuf *buf)
> +{
> +	int mib[4];
> +	char path[MAXPATHLEN];
> +	size_t cb =3D sizeof(path);
> +
> +	mib[0] =3D CTL_KERN;
> +	mib[1] =3D KERN_PROC;
> +	mib[2] =3D KERN_PROC_PATHNAME;
> +	mib[3] =3D -1;
> +	if (!sysctl(mib, 4, path, &cb, NULL, 0)) {
> +		trace_printf(
> +			"trace: resolved executable path from sysctl: %s\n",
> +			path);
> +		strbuf_addstr(buf, path);
> +		return 0;
> +	}
> +	return -1;
> +}
> +#endif /* HAVE_BSD_KERN_PROC_SYSCTL */
> +
> +#ifdef HAVE_NS_GET_EXECUTABLE_PATH
> +/*
> + * Resolves the executable path by querying Darwin applicaton stack.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int git_get_exec_path_darwin(struct strbuf *buf)
> +{
> +	char path[PATH_MAX];
> +	uint32_t size =3D sizeof(path);
> +	if (!_NSGetExecutablePath(path, &size)) {
> +		trace_printf(
> +			"trace: resolved executable path from Darwin stack: %s\n",
> +			path);
> +		strbuf_addstr(buf, path);
> +		return 0;
> +	}
> +	return -1;
> +}
> +#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
> +
> +/*
> + * Resolves the absolute path of the current executable.
> + *
> + * Returns 0 on success, -1 on failure.
> + */
> +static int git_get_exec_path(struct strbuf *buf, const char *argv0)
> +{
> +	/*
> +	 * Identifying the executable path is operating system specific.
> +	 * Selectively employ all available methods in order of preference,
> +	 * preferring highly-available authoratative methods over
> +	 * selectively-available or non- authoratative methods.
> +	 *
> +	 * All cases fall back on resolving against argv[0] if there isn't a
> +	 * better functional method. However, note that argv[0] can be
> +	 * used-supplied on many operating sysetems, and is not authoratative
> +	 * in those cases.
> +	 *
> +	 * Each of these functions returns 0 on success, so evaluation will s=
top
> +	 * after the first successful method.
> +	 */
> +	if (
> +#ifdef HAVE_BSD_KERN_PROC_SYSCTL
> +		git_get_exec_path_bsd_sysctl(buf) &&
> +#endif /* HAVE_BSD_KERN_PROC_SYSCTL */
> +
> +#ifdef HAVE_NS_GET_EXECUTABLE_PATH
> +		git_get_exec_path_darwin(buf) &&
> +#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
> +
> +#ifdef PROCFS_EXECUTABLE_PATH
> +		git_get_exec_path_procfs(buf) &&
> +#endif /* PROCFS_EXECUTABLE_PATH */
> +
> +		git_get_exec_path_from_argv0(buf, argv0)) {
> +		return -1;
> +	}
> =20
> +	if (strbuf_normalize_path(buf)) {
> +		trace_printf("trace: could not normalize path: %s\n", buf->buf);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +void git_resolve_executable_dir(const char *argv0)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	char *resolved;
> +	const char *slash;
> +
> +	if (git_get_exec_path(&buf, argv0)) {
> +		trace_printf(
> +			"trace: could not determine executable path from: %s\n",
> +			argv0);
> +		strbuf_release(&buf);
> +		return;
> +	}
> +
> +	resolved =3D strbuf_detach(&buf, NULL);
> +	slash =3D find_last_dir_sep(resolved);
>  	if (slash)
> -		argv0_path =3D xstrndup(argv0, slash - argv0);
> +		resolved[slash - resolved] =3D '\0';
> +
> +	executable_dirname =3D resolved;
> +	trace_printf("trace: resolved executable dir: %s\n",
> +		     executable_dirname);
>  }
> =20
>  #else
> =20
> +/**
> + * When not using a runtime prefix, Git uses a hard-coded path, and th=
ere is
> + * nothing to resolve.
> + */
> +
>  static const char *system_prefix(void)
>  {
>  	return PREFIX;
>  }
> =20
> -void git_extract_argv0_path(const char *argv0)
> +void git_resolve_executable_dir(const char *argv0)
>  {
>  }
> =20
> @@ -65,32 +244,28 @@ char *system_path(const char *path)
>  	return strbuf_detach(&d, NULL);
>  }
> =20
> -void git_set_argv_exec_path(const char *exec_path)
> +static const char *exec_path_value;
> +
> +void git_set_exec_path(const char *exec_path)
>  {
> -	argv_exec_path =3D exec_path;
> +	exec_path_value =3D exec_path;
>  	/*
>  	 * Propagate this setting to external programs.
>  	 */
>  	setenv(EXEC_PATH_ENVIRONMENT, exec_path, 1);
>  }
> =20
> -
> -/* Returns the highest-priority, location to look for git programs. */
> +/* Returns the highest-priority location to look for git programs. */
>  const char *git_exec_path(void)
>  {
> -	static char *cached_exec_path;
> -
> -	if (argv_exec_path)
> -		return argv_exec_path;
> -
> -	if (!cached_exec_path) {
> +	if (!exec_path_value) {
>  		const char *env =3D getenv(EXEC_PATH_ENVIRONMENT);
>  		if (env && *env)
> -			cached_exec_path =3D xstrdup(env);
> +			exec_path_value =3D xstrdup(env);
>  		else
> -			cached_exec_path =3D system_path(GIT_EXEC_PATH);
> +			exec_path_value =3D system_path(GIT_EXEC_PATH);
>  	}
> -	return cached_exec_path;
> +	return exec_path_value;
>  }
> =20
>  static void add_path(struct strbuf *out, const char *path)
> @@ -103,10 +278,12 @@ static void add_path(struct strbuf *out, const ch=
ar *path)
> =20
>  void setup_path(void)
>  {
> +	const char *exec_path =3D git_exec_path();
>  	const char *old_path =3D getenv("PATH");
>  	struct strbuf new_path =3D STRBUF_INIT;
> =20
> -	add_path(&new_path, git_exec_path());
> +	git_set_exec_path(exec_path);
> +	add_path(&new_path, exec_path);
> =20
>  	if (old_path)
>  		strbuf_addstr(&new_path, old_path);
> @@ -125,7 +302,8 @@ const char **prepare_git_cmd(struct argv_array *out=
, const char **argv)
>  	return out->argv;
>  }
> =20
> -int execv_git_cmd(const char **argv) {
> +int execv_git_cmd(const char **argv)
> +{
>  	struct argv_array nargv =3D ARGV_ARRAY_INIT;
> =20
>  	prepare_git_cmd(&nargv, argv);
> @@ -140,8 +318,7 @@ int execv_git_cmd(const char **argv) {
>  	return -1;
>  }
> =20
> -
> -int execl_git_cmd(const char *cmd,...)
> +int execl_git_cmd(const char *cmd, ...)
>  {
>  	int argc;
>  	const char *argv[MAX_ARGS + 1];
> diff --git a/exec_cmd.h b/exec_cmd.h
> index ff0b48048..2522453cd 100644
> --- a/exec_cmd.h
> +++ b/exec_cmd.h
> @@ -3,8 +3,8 @@
> =20
>  struct argv_array;
> =20
> -extern void git_set_argv_exec_path(const char *exec_path);
> -extern void git_extract_argv0_path(const char *path);
> +extern void git_set_exec_path(const char *exec_path);
> +extern void git_resolve_executable_dir(const char *path);
>  extern const char *git_exec_path(void);
>  extern void setup_path(void);
>  extern const char **prepare_git_cmd(struct argv_array *out, const char=
 **argv);
> diff --git a/gettext.c b/gettext.c
> index db727ea02..6b64d5c2e 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -2,7 +2,8 @@
>   * Copyright (c) 2010 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>   */
> =20
> -#include "git-compat-util.h"
> +#include "cache.h"
> +#include "exec_cmd.h"
>  #include "gettext.h"
>  #include "strbuf.h"
>  #include "utf8.h"
> @@ -157,10 +158,11 @@ static void init_gettext_charset(const char *doma=
in)
> =20
>  void git_setup_gettext(void)
>  {
> -	const char *podir =3D getenv("GIT_TEXTDOMAINDIR");
> +	const char *podir =3D getenv(GIT_TEXT_DOMAIN_DIR_ENVIRONMENT);
> =20
>  	if (!podir)
> -		podir =3D GIT_LOCALE_PATH;
> +		podir =3D system_path(GIT_LOCALE_PATH);
> +
>  	bindtextdomain("git", podir);
>  	setlocale(LC_MESSAGES, "");
>  	setlocale(LC_TIME, "");
> diff --git a/git.c b/git.c
> index 9e96dd409..dc4cc1419 100644
> --- a/git.c
> +++ b/git.c
> @@ -65,7 +65,7 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
>  		 */
>  		if (skip_prefix(cmd, "--exec-path", &cmd)) {
>  			if (*cmd =3D=3D '=3D')
> -				git_set_argv_exec_path(cmd + 1);
> +				git_set_exec_path(cmd + 1);
>  			else {
>  				puts(git_exec_path());
>  				exit(0);
