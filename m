Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438AE1CA80
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729767; cv=none; b=lXpewq1EVcAp5qZSpwuywnKuVtMUoFoi+h5IJYh42QuG9e7moQssHAvDPiCW/yGDV7EXzeaH7VCSntkSNzt4MjNLoDow7oULPH80qy3aiFMYIJRaALN5rJy7YH9u4QMo4rgrTEK6tO9EGum+7LC1MkldHOAhIT9ADZ79VwhcNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729767; c=relaxed/simple;
	bh=2BsZaHszr4lb3JuTqUGMfOHaIOwgUEL7sA34rD0EWgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EaNR4DCjx4Wac5oMQ0RLoHKHCjB1Ivlm8gYkbpsksxs3xBsB1uhgYH5xbzc20IaAO/yfMesGbjiWSDQqCK2103xqqVYgei5NMFMMfe7FyQXBXjbBgxSQO5YXzSM7OYMQq9UYGPiZJij0vgrNB2DlDQaToDhgiyDMuvx/pXnfeqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVYGbhjd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVYGbhjd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D9072B313;
	Tue, 18 Jun 2024 12:56:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2BsZaHszr4lb3JuTqUGMfOHaIOwgUEL7sA34rD
	0EWgg=; b=kVYGbhjd7nna3M/wZSQb79SXAR5NAXOYhcA3tWa/rCimw92vY1nstf
	vYD/a14hwc56lTG4JqVWjgGg821zsDzgcInuzZr1oA/l7t0HmHW59cOwaS2gnrDS
	8HPHh8Q9NGaIGxIBVbX78OOfLLZVFyMpeH9luLT9slENw97m9KuWw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81C612B312;
	Tue, 18 Jun 2024 12:56:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BEF002B311;
	Tue, 18 Jun 2024 12:56:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Ghanshyam Thakkar
 <shyamthakkar001@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 09/20] global: introduce
 `USE_THE_REPOSITORY_VARIABLE` macro
In-Reply-To: <xmqqwmmm1bw6.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	18 Jun 2024 08:58:01 -0700")
References: <cover.1718106284.git.ps@pks.im> <cover.1718347699.git.ps@pks.im>
	<7e023a335f500658b09a0037aee48eff06c668f8.1718347699.git.ps@pks.im>
	<CAOLa=ZTq+sQAtSiQm9xmdLyn=T=u8Ck0oXEBFLnJvH+54O+AHA@mail.gmail.com>
	<ZnEYNzLue3OIK-Ul@framework>
	<CAOLa=ZRA6QDojbvP6btOGX5q1Pa0DivBZA_J1gojF1gJu9aENw@mail.gmail.com>
	<xmqqwmmm1bw6.fsf@gitster.g>
Date: Tue, 18 Jun 2024 09:56:00 -0700
Message-ID: <xmqqjzim197j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A5458C22-2D93-11EF-A836-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> We may want to eventually fix this, but we need to decide what the
> desirable layout is.  I am not sure if the indented version is
> easier to read and maintain, but one thing that is sure is that a
> mixed mess is harder than either.  In the above excerpt, you cannot
> tell if I quoted everything related to FLEX_ARRAY (in other words,
> if "#ifndef FLEX_ARRAY" is already closed in the excerpt) without
> carefully looking.

Here is how a patch to reindent (which is full of patch noise and
not enough value by itself) looks like.



----- >8 ---------- >8 ---------- >8 ---------- >8 -----
Subject: [PATCH] git-compat-util.h: reindent CPP directives

Karthik noticed that Patrick used a not-so-consistently-used
convention to indent the CPP directives inside #if/#else/#endif by
one extra space, which may look like a typo to an eye unfamiliar
with the convention.  Unlike compat/ with borrowed sources, we do
not use the convention very much, and even when it is used, we are
very inconsistent.

Taking git-compat-util.h as an example, here is how a "normalized"
version of that file would look like.  It makes it immediately
obvious that an unindented CPP directive (like #define and #include)
is in effect for any and all architectures, so there might be a
readability value in such a change, even though the one-time patch
noise is a bit annoying.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

use strict;
use warnings;

my $level = 0;

my %levelchange = (
	if => [0, 1],
	ifdef => [0, 1],
	ifndef => [0, 1],
	else => [-1, 0],
	elif => [-1, 0],
	endif => [-1, -1],
);

my $file_name = undef;

while (<>) {
	if (!defined $file_name || $ARGV ne $file_name) {
		$. = 0;
		$file_name = $ARGV;
		# Special case for the header files
		if ($file_name =~ /\.h$/) {
			# cause early part of a header file
			# #ifndef FILENAME_H
			# #define FILENAME_H
			# and the corresponding #endif at the end
			# not to be indented.
			$level = -1;
		} else {
			$level = 0;
		}
	}

	# Not a CPP directive? copy it out.
	if (!/^\s*#\s*(\S+)(.*)/) {
		print;
		next;
	}

	#
	my ($what, $rest) = ($1, $2);
	my $thislevel = $level;

	if (exists $levelchange{$what}) {
		$thislevel = $level + $levelchange{$what}[0];
		$level = $level + $levelchange{$what}[1];
	}

	if ($thislevel < 0) {
		$thislevel = 0;
	}
	print "#", " " x $thislevel, "$what$rest\n";
}
---
 git-compat-util.h | 528 +++++++++++++++++++++++-----------------------
 1 file changed, 264 insertions(+), 264 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index ca7678a379..dd9edb30e1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,7 +11,7 @@
  * directive, but please report the details of your system to
  * git@vger.kernel.org.
  */
-#error "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."
+# error "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."
 #endif
 
 #ifdef USE_MSVC_CRTDBG
@@ -19,8 +19,8 @@
  * For these to work they must appear very early in each
  * file -- before most of the standard header files.
  */
-#include <stdlib.h>
-#include <crtdbg.h>
+# include <stdlib.h>
+# include <crtdbg.h>
 #endif
 
 struct strbuf;
@@ -41,7 +41,7 @@ struct strbuf;
 # define GIT_GNUC_PREREQ(maj, min) \
 	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
 #else
- #define GIT_GNUC_PREREQ(maj, min) 0
+# define GIT_GNUC_PREREQ(maj, min) 0
 #endif
 
 
@@ -57,23 +57,23 @@ struct strbuf;
  * here, we can fall back to use the "safer but a bit wasteful" one
  * later.
  */
-#if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
-#elif defined(__GNUC__)
-# if (__GNUC__ >= 3)
+# if defined(__SUNPRO_C) && (__SUNPRO_C <= 0x580)
+# elif defined(__GNUC__)
+#  if (__GNUC__ >= 3)
+#   define FLEX_ARRAY /* empty */
+#  else
+#   define FLEX_ARRAY 0 /* older GNU extension */
+#  endif
+# elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
 #  define FLEX_ARRAY /* empty */
-# else
-#  define FLEX_ARRAY 0 /* older GNU extension */
 # endif
-#elif defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L)
-# define FLEX_ARRAY /* empty */
-#endif
 
 /*
  * Otherwise, default to safer but a bit wasteful traditional style
  */
-#ifndef FLEX_ARRAY
-# define FLEX_ARRAY 1
-#endif
+# ifndef FLEX_ARRAY
+#  define FLEX_ARRAY 1
+# endif
 #endif
 
 
@@ -153,9 +153,9 @@ struct strbuf;
      (a) > maximum_unsigned_value_of_type(a) >> (shift))
 
 #ifdef __GNUC__
-#define TYPEOF(x) (__typeof__(x))
+# define TYPEOF(x) (__typeof__(x))
 #else
-#define TYPEOF(x)
+# define TYPEOF(x)
 #endif
 
 #define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (bitsizeof(x) - (bits))))
@@ -167,7 +167,7 @@ struct strbuf;
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
 #ifdef __MINGW64__
-#define _POSIX_C_SOURCE 1
+# define _POSIX_C_SOURCE 1
 #elif defined(__sun__)
  /*
   * On Solaris, when _XOPEN_EXTENDED is set, its header file
@@ -177,16 +177,16 @@ struct strbuf;
   * non XPG6 programs must be compiled with a pre-c99 compiler.
   */
 # if __STDC_VERSION__ - 0 >= 199901L
-# define _XOPEN_SOURCE 600
+#  define _XOPEN_SOURCE 600
 # else
-# define _XOPEN_SOURCE 500
+#  define _XOPEN_SOURCE 500
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) && \
       !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
       !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
       !defined(__CYGWIN__)
-#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
-#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
+# define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+# define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
 #define _ALL_SOURCE 1
 #define _GNU_SOURCE 1
@@ -196,38 +196,38 @@ struct strbuf;
 #define _SGI_SOURCE 1
 
 #if GIT_GNUC_PREREQ(4, 5)
-#define UNUSED __attribute__((unused)) \
+# define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated ("parameter declared as UNUSED")))
 #elif defined(__GNUC__)
-#define UNUSED __attribute__((unused)) \
+# define UNUSED __attribute__((unused)) \
 	__attribute__((deprecated))
 #else
-#define UNUSED
+# define UNUSED
 #endif
 
 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */
 # if !defined(_WIN32_WINNT)
 #  define _WIN32_WINNT 0x0600
 # endif
-#define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
-#include <winsock2.h>
-#ifndef NO_UNIX_SOCKETS
-#include <afunix.h>
-#endif
-#include <windows.h>
-#define GIT_WINDOWS_NATIVE
+# define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
+# include <winsock2.h>
+# ifndef NO_UNIX_SOCKETS
+#  include <afunix.h>
+# endif
+# include <windows.h>
+# define GIT_WINDOWS_NATIVE
 #endif
 
 #if defined(NO_UNIX_SOCKETS) || !defined(GIT_WINDOWS_NATIVE)
 static inline int _have_unix_sockets(void)
 {
-#if defined(NO_UNIX_SOCKETS)
+# if defined(NO_UNIX_SOCKETS)
 	return 0;
-#else
+# else
 	return 1;
-#endif
+# endif
 }
-#define have_unix_sockets _have_unix_sockets
+# define have_unix_sockets _have_unix_sockets
 #endif
 
 #include <unistd.h>
@@ -240,13 +240,13 @@ static inline int _have_unix_sockets(void)
 #include <stdbool.h>
 #include <string.h>
 #ifdef HAVE_STRINGS_H
-#include <strings.h> /* for strcasecmp() */
+# include <strings.h> /* for strcasecmp() */
 #endif
 #include <errno.h>
 #include <limits.h>
 #include <locale.h>
 #ifdef NEEDS_SYS_PARAM_H
-#include <sys/param.h>
+# include <sys/param.h>
 #endif
 #include <sys/types.h>
 #include <dirent.h>
@@ -258,15 +258,15 @@ static inline int _have_unix_sockets(void)
 #include <utime.h>
 #include <syslog.h>
 #if !defined(NO_POLL_H)
-#include <poll.h>
+# include <poll.h>
 #elif !defined(NO_SYS_POLL_H)
-#include <sys/poll.h>
+# include <sys/poll.h>
 #else
 /* Pull the compat stuff */
-#include <poll.h>
+# include <poll.h>
 #endif
 #ifdef HAVE_BSD_SYSCTL
-#include <sys/sysctl.h>
+# include <sys/sysctl.h>
 #endif
 
 /* Used by compat/win32/path-utils.h, and more */
@@ -276,44 +276,44 @@ static inline int is_xplatform_dir_sep(int c)
 }
 
 #if defined(__CYGWIN__)
-#include "compat/win32/path-utils.h"
+# include "compat/win32/path-utils.h"
 #endif
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
-#include "compat/win32/path-utils.h"
-#include "compat/mingw.h"
+# include "compat/win32/path-utils.h"
+# include "compat/mingw.h"
 #elif defined(_MSC_VER)
-#include "compat/win32/path-utils.h"
-#include "compat/msvc.h"
-#else
-#include <sys/utsname.h>
-#include <sys/wait.h>
-#include <sys/resource.h>
-#include <sys/socket.h>
-#include <sys/ioctl.h>
-#include <sys/statvfs.h>
-#include <termios.h>
-#ifndef NO_SYS_SELECT_H
-#include <sys/select.h>
-#endif
-#include <netinet/in.h>
-#include <netinet/tcp.h>
-#include <arpa/inet.h>
-#include <netdb.h>
-#include <pwd.h>
-#include <sys/un.h>
-#ifndef NO_INTTYPES_H
-#include <inttypes.h>
+# include "compat/win32/path-utils.h"
+# include "compat/msvc.h"
 #else
-#include <stdint.h>
-#endif
-#ifdef HAVE_ARC4RANDOM_LIBBSD
-#include <bsd/stdlib.h>
-#endif
-#ifdef HAVE_GETRANDOM
-#include <sys/random.h>
-#endif
-#ifdef NO_INTPTR_T
+# include <sys/utsname.h>
+# include <sys/wait.h>
+# include <sys/resource.h>
+# include <sys/socket.h>
+# include <sys/ioctl.h>
+# include <sys/statvfs.h>
+# include <termios.h>
+# ifndef NO_SYS_SELECT_H
+#  include <sys/select.h>
+# endif
+# include <netinet/in.h>
+# include <netinet/tcp.h>
+# include <arpa/inet.h>
+# include <netdb.h>
+# include <pwd.h>
+# include <sys/un.h>
+# ifndef NO_INTTYPES_H
+#  include <inttypes.h>
+# else
+#  include <stdint.h>
+# endif
+# ifdef HAVE_ARC4RANDOM_LIBBSD
+#  include <bsd/stdlib.h>
+# endif
+# ifdef HAVE_GETRANDOM
+#  include <sys/random.h>
+# endif
+# ifdef NO_INTPTR_T
 /*
  * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
  * on LLP86, IL33LLP64 and P64 it needs to be "long long",
@@ -323,15 +323,15 @@ static inline int is_xplatform_dir_sep(int c)
  */
 typedef long intptr_t;
 typedef unsigned long uintptr_t;
-#endif
-#undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
-#include <grp.h>
-#define _ALL_SOURCE 1
+# endif
+# undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
+# include <grp.h>
+# define _ALL_SOURCE 1
 #endif
 
 /* used on Mac OS X */
 #ifdef PRECOMPOSE_UNICODE
-#include "compat/precompose_utf8.h"
+# include "compat/precompose_utf8.h"
 #else
 static inline const char *precompose_argv_prefix(int argc UNUSED,
 						 const char **argv UNUSED,
@@ -344,16 +344,16 @@ static inline const char *precompose_string_if_needed(const char *in)
 	return in;
 }
 
-#define probe_utf8_pathname_composition()
+# define probe_utf8_pathname_composition()
 #endif
 
 #ifdef MKDIR_WO_TRAILING_SLASH
-#define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
+# define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
 int compat_mkdir_wo_trailing_slash(const char*, mode_t);
 #endif
 
 #ifdef time
-#undef time
+# undef time
 #endif
 static inline time_t git_time(time_t *tloc)
 {
@@ -384,34 +384,34 @@ static inline int git_setitimer(int which UNUSED,
 				struct itimerval *newvalue UNUSED) {
 	return 0; /* pretend success */
 }
-#undef setitimer
-#define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
+# undef setitimer
+# define setitimer(which,value,ovalue) git_setitimer(which,value,ovalue)
 #endif
 
 #ifndef NO_LIBGEN_H
-#include <libgen.h>
+# include <libgen.h>
 #else
-#define basename gitbasename
+# define basename gitbasename
 char *gitbasename(char *);
-#define dirname gitdirname
+# define dirname gitdirname
 char *gitdirname(char *);
 #endif
 
 #ifndef NO_ICONV
-#include <iconv.h>
+# include <iconv.h>
 #endif
 
 #ifndef NO_OPENSSL
-#ifdef __APPLE__
-#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
-#define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
-#include <AvailabilityMacros.h>
-#undef DEPRECATED_ATTRIBUTE
-#define DEPRECATED_ATTRIBUTE
-#undef __AVAILABILITY_MACROS_USES_AVAILABILITY
-#endif
-#include <openssl/ssl.h>
-#include <openssl/err.h>
+# ifdef __APPLE__
+#  undef __AVAILABILITY_MACROS_USES_AVAILABILITY
+#  define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
+#  include <AvailabilityMacros.h>
+#  undef DEPRECATED_ATTRIBUTE
+#  define DEPRECATED_ATTRIBUTE
+#  undef __AVAILABILITY_MACROS_USES_AVAILABILITY
+# endif
+# include <openssl/ssl.h>
+# include <openssl/err.h>
 #endif
 
 #ifdef HAVE_SYSINFO
@@ -422,22 +422,22 @@ char *gitdirname(char *);
  * not on some systems (e.g. z/OS).
  */
 #ifndef NI_MAXHOST
-#define NI_MAXHOST 1025
+# define NI_MAXHOST 1025
 #endif
 
 #ifndef NI_MAXSERV
-#define NI_MAXSERV 32
+# define NI_MAXSERV 32
 #endif
 
 /* On most systems <limits.h> would have given us this, but
  * not on some systems (e.g. GNU/Hurd).
  */
 #ifndef PATH_MAX
-#define PATH_MAX 4096
+# define PATH_MAX 4096
 #endif
 
 #ifndef NAME_MAX
-#define NAME_MAX 255
+# define NAME_MAX 255
 #endif
 
 typedef uintmax_t timestamp_t;
@@ -447,14 +447,14 @@ typedef uintmax_t timestamp_t;
 #define TIME_MIN 0
 
 #ifndef PATH_SEP
-#define PATH_SEP ':'
+# define PATH_SEP ':'
 #endif
 
 #ifdef HAVE_PATHS_H
-#include <paths.h>
+# include <paths.h>
 #endif
 #ifndef _PATH_DEFPATH
-#define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
+# define _PATH_DEFPATH "/usr/local/bin:/usr/bin:/bin"
 #endif
 
 #ifndef platform_core_config
@@ -466,12 +466,12 @@ static inline int noop_core_config(const char *var UNUSED,
 {
 	return 0;
 }
-#define platform_core_config noop_core_config
+# define platform_core_config noop_core_config
 #endif
 
 int lstat_cache_aware_rmdir(const char *path);
 #if !defined(__MINGW32__) && !defined(_MSC_VER)
-#define rmdir lstat_cache_aware_rmdir
+# define rmdir lstat_cache_aware_rmdir
 #endif
 
 #ifndef has_dos_drive_prefix
@@ -479,7 +479,7 @@ static inline int git_has_dos_drive_prefix(const char *path UNUSED)
 {
 	return 0;
 }
-#define has_dos_drive_prefix git_has_dos_drive_prefix
+# define has_dos_drive_prefix git_has_dos_drive_prefix
 #endif
 
 #ifndef skip_dos_drive_prefix
@@ -487,7 +487,7 @@ static inline int git_skip_dos_drive_prefix(char **path UNUSED)
 {
 	return 0;
 }
-#define skip_dos_drive_prefix git_skip_dos_drive_prefix
+# define skip_dos_drive_prefix git_skip_dos_drive_prefix
 #endif
 
 static inline int git_is_dir_sep(int c)
@@ -495,7 +495,7 @@ static inline int git_is_dir_sep(int c)
 	return c == '/';
 }
 #ifndef is_dir_sep
-#define is_dir_sep git_is_dir_sep
+# define is_dir_sep git_is_dir_sep
 #endif
 
 #ifndef offset_1st_component
@@ -503,20 +503,20 @@ static inline int git_offset_1st_component(const char *path)
 {
 	return is_dir_sep(path[0]);
 }
-#define offset_1st_component git_offset_1st_component
+# define offset_1st_component git_offset_1st_component
 #endif
 
 #ifndef is_valid_path
-#define is_valid_path(path) 1
+# define is_valid_path(path) 1
 #endif
 
 #ifndef is_path_owned_by_current_user
 
-#ifdef __TANDEM
-#define ROOT_UID 65535
-#else
-#define ROOT_UID 0
-#endif
+# ifdef __TANDEM
+#  define ROOT_UID 65535
+# else
+#  define ROOT_UID 0
+# endif
 
 /*
  * Do not use this function when
@@ -576,7 +576,7 @@ static inline int is_path_owned_by_current_uid(const char *path,
 	return st.st_uid == euid;
 }
 
-#define is_path_owned_by_current_user is_path_owned_by_current_uid
+# define is_path_owned_by_current_user is_path_owned_by_current_uid
 #endif
 
 #ifndef find_last_dir_sep
@@ -584,7 +584,7 @@ static inline char *git_find_last_dir_sep(const char *path)
 {
 	return strrchr(path, '/');
 }
-#define find_last_dir_sep git_find_last_dir_sep
+# define find_last_dir_sep git_find_last_dir_sep
 #endif
 
 #ifndef has_dir_sep
@@ -592,53 +592,53 @@ static inline int git_has_dir_sep(const char *path)
 {
 	return !!strchr(path, '/');
 }
-#define has_dir_sep(path) git_has_dir_sep(path)
+# define has_dir_sep(path) git_has_dir_sep(path)
 #endif
 
 #ifndef query_user_email
-#define query_user_email() NULL
+# define query_user_email() NULL
 #endif
 
 #ifdef __TANDEM
-#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
-#include <floss.h(floss_getpwuid)>
-#ifndef NSIG
+# include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
+# include <floss.h(floss_getpwuid)>
+# ifndef NSIG
 /*
  * NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the highest
  * known, by detective work using kill -l as a list is all signals
  * instead of signal.h where it should be.
  */
-# define NSIG 100
-#endif
+#  define NSIG 100
+# endif
 #endif
 
 #if defined(__HP_cc) && (__HP_cc >= 61000)
-#define NORETURN __attribute__((noreturn))
-#define NORETURN_PTR
+# define NORETURN __attribute__((noreturn))
+# define NORETURN_PTR
 #elif defined(__GNUC__) && !defined(NO_NORETURN)
-#define NORETURN __attribute__((__noreturn__))
-#define NORETURN_PTR __attribute__((__noreturn__))
+# define NORETURN __attribute__((__noreturn__))
+# define NORETURN_PTR __attribute__((__noreturn__))
 #elif defined(_MSC_VER)
-#define NORETURN __declspec(noreturn)
-#define NORETURN_PTR
+# define NORETURN __declspec(noreturn)
+# define NORETURN_PTR
 #else
-#define NORETURN
-#define NORETURN_PTR
-#ifndef __GNUC__
-#ifndef __attribute__
-#define __attribute__(x)
-#endif
-#endif
+# define NORETURN
+# define NORETURN_PTR
+# ifndef __GNUC__
+#  ifndef __attribute__
+#   define __attribute__(x)
+#  endif
+# endif
 #endif
 
 /* The sentinel attribute is valid from gcc version 4.0 */
 #if defined(__GNUC__) && (__GNUC__ >= 4)
-#define LAST_ARG_MUST_BE_NULL __attribute__((sentinel))
+# define LAST_ARG_MUST_BE_NULL __attribute__((sentinel))
 /* warn_unused_result exists as of gcc 3.4.0, but be lazy and check 4.0 */
-#define RESULT_MUST_BE_USED __attribute__ ((warn_unused_result))
+# define RESULT_MUST_BE_USED __attribute__ ((warn_unused_result))
 #else
-#define LAST_ARG_MUST_BE_NULL
-#define RESULT_MUST_BE_USED
+# define LAST_ARG_MUST_BE_NULL
+# define RESULT_MUST_BE_USED
 #endif
 
 #define MAYBE_UNUSED __attribute__((__unused__))
@@ -660,17 +660,17 @@ void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 #ifndef NO_OPENSSL
-#ifdef APPLE_COMMON_CRYPTO
-#include "compat/apple-common-crypto.h"
-#else
-#include <openssl/evp.h>
-#include <openssl/hmac.h>
-#endif /* APPLE_COMMON_CRYPTO */
-#include <openssl/x509v3.h>
+# ifdef APPLE_COMMON_CRYPTO
+#  include "compat/apple-common-crypto.h"
+# else
+#  include <openssl/evp.h>
+#  include <openssl/hmac.h>
+# endif /* APPLE_COMMON_CRYPTO */
+# include <openssl/x509v3.h>
 #endif /* NO_OPENSSL */
 
 #ifdef HAVE_OPENSSL_CSPRNG
-#include <openssl/rand.h>
+# include <openssl/rand.h>
 #endif
 
 /*
@@ -683,8 +683,8 @@ static inline int const_error(void)
 {
 	return -1;
 }
-#define error(...) (error(__VA_ARGS__), const_error())
-#define error_errno(...) (error_errno(__VA_ARGS__), const_error())
+# define error(...) (error(__VA_ARGS__), const_error())
+# define error_errno(...) (error_errno(__VA_ARGS__), const_error())
 #endif
 
 typedef void (*report_fn)(const char *, va_list params);
@@ -782,32 +782,32 @@ static inline bool strip_suffix(const char *str, const char *suffix,
 
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
 
-#ifndef PROT_READ
-#define PROT_READ 1
-#define PROT_WRITE 2
-#define MAP_PRIVATE 1
-#endif
+# ifndef PROT_READ
+#  define PROT_READ 1
+#  define PROT_WRITE 2
+#  define MAP_PRIVATE 1
+# endif
 
-#define mmap git_mmap
-#define munmap git_munmap
+# define mmap git_mmap
+# define munmap git_munmap
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 int git_munmap(void *start, size_t length);
 
 #else /* NO_MMAP || USE_WIN32_MMAP */
 
-#include <sys/mman.h>
+# include <sys/mman.h>
 
 #endif /* NO_MMAP || USE_WIN32_MMAP */
 
 #ifdef NO_MMAP
 
 /* This value must be multiple of (pagesize * 2) */
-#define DEFAULT_PACKED_GIT_WINDOW_SIZE (1 * 1024 * 1024)
+# define DEFAULT_PACKED_GIT_WINDOW_SIZE (1 * 1024 * 1024)
 
 #else /* NO_MMAP */
 
 /* This value must be multiple of (pagesize * 2) */
-#define DEFAULT_PACKED_GIT_WINDOW_SIZE \
+# define DEFAULT_PACKED_GIT_WINDOW_SIZE \
 	(sizeof(void*) >= 8 \
 		?  1 * 1024 * 1024 * 1024 \
 		: 32 * 1024 * 1024)
@@ -815,46 +815,46 @@ int git_munmap(void *start, size_t length);
 #endif /* NO_MMAP */
 
 #ifndef MAP_FAILED
-#define MAP_FAILED ((void *)-1)
+# define MAP_FAILED ((void *)-1)
 #endif
 
 #ifdef NO_ST_BLOCKS_IN_STRUCT_STAT
-#define on_disk_bytes(st) ((st).st_size)
+# define on_disk_bytes(st) ((st).st_size)
 #else
-#define on_disk_bytes(st) ((st).st_blocks * 512)
+# define on_disk_bytes(st) ((st).st_blocks * 512)
 #endif
 
 #ifdef NEEDS_MODE_TRANSLATION
-#undef S_IFMT
-#undef S_IFREG
-#undef S_IFDIR
-#undef S_IFLNK
-#undef S_IFBLK
-#undef S_IFCHR
-#undef S_IFIFO
-#undef S_IFSOCK
-#define S_IFMT   0170000
-#define S_IFREG  0100000
-#define S_IFDIR  0040000
-#define S_IFLNK  0120000
-#define S_IFBLK  0060000
-#define S_IFCHR  0020000
-#define S_IFIFO  0010000
-#define S_IFSOCK 0140000
-#ifdef stat
-#undef stat
-#endif
-#define stat(path, buf) git_stat(path, buf)
+# undef S_IFMT
+# undef S_IFREG
+# undef S_IFDIR
+# undef S_IFLNK
+# undef S_IFBLK
+# undef S_IFCHR
+# undef S_IFIFO
+# undef S_IFSOCK
+# define S_IFMT   0170000
+# define S_IFREG  0100000
+# define S_IFDIR  0040000
+# define S_IFLNK  0120000
+# define S_IFBLK  0060000
+# define S_IFCHR  0020000
+# define S_IFIFO  0010000
+# define S_IFSOCK 0140000
+# ifdef stat
+#  undef stat
+# endif
+# define stat(path, buf) git_stat(path, buf)
 int git_stat(const char *, struct stat *);
-#ifdef fstat
-#undef fstat
-#endif
-#define fstat(fd, buf) git_fstat(fd, buf)
+# ifdef fstat
+#  undef fstat
+# endif
+# define fstat(fd, buf) git_fstat(fd, buf)
 int git_fstat(int, struct stat *);
-#ifdef lstat
-#undef lstat
-#endif
-#define lstat(path, buf) git_lstat(path, buf)
+# ifdef lstat
+#  undef lstat
+# endif
+# define lstat(path, buf) git_lstat(path, buf)
 int git_lstat(const char *, struct stat *);
 #endif
 
@@ -862,67 +862,67 @@ int git_lstat(const char *, struct stat *);
 	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? (32 * 1024L * 1024L) : 256))
 
 #ifdef NO_PREAD
-#define pread git_pread
+# define pread git_pread
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
 
 #ifdef NO_SETENV
-#define setenv gitsetenv
+# define setenv gitsetenv
 int gitsetenv(const char *, const char *, int);
 #endif
 
 #ifdef NO_MKDTEMP
-#define mkdtemp gitmkdtemp
+# define mkdtemp gitmkdtemp
 char *gitmkdtemp(char *);
 #endif
 
 #ifdef NO_UNSETENV
-#define unsetenv gitunsetenv
+# define unsetenv gitunsetenv
 int gitunsetenv(const char *);
 #endif
 
 #ifdef NO_STRCASESTR
-#define strcasestr gitstrcasestr
+# define strcasestr gitstrcasestr
 char *gitstrcasestr(const char *haystack, const char *needle);
 #endif
 
 #ifdef NO_STRLCPY
-#define strlcpy gitstrlcpy
+# define strlcpy gitstrlcpy
 size_t gitstrlcpy(char *, const char *, size_t);
 #endif
 
 #ifdef NO_STRTOUMAX
-#define strtoumax gitstrtoumax
+# define strtoumax gitstrtoumax
 uintmax_t gitstrtoumax(const char *, char **, int);
-#define strtoimax gitstrtoimax
+# define strtoimax gitstrtoimax
 intmax_t gitstrtoimax(const char *, char **, int);
 #endif
 
 #ifdef NO_HSTRERROR
-#define hstrerror githstrerror
+# define hstrerror githstrerror
 const char *githstrerror(int herror);
 #endif
 
 #ifdef NO_MEMMEM
-#define memmem gitmemmem
+# define memmem gitmemmem
 void *gitmemmem(const void *haystack, size_t haystacklen,
 		const void *needle, size_t needlelen);
 #endif
 
 #ifdef OVERRIDE_STRDUP
-#ifdef strdup
-#undef strdup
-#endif
-#define strdup gitstrdup
+# ifdef strdup
+#  undef strdup
+# endif
+# define strdup gitstrdup
 char *gitstrdup(const char *s);
 #endif
 
 #ifdef NO_GETPAGESIZE
-#define getpagesize() sysconf(_SC_PAGESIZE)
+# define getpagesize() sysconf(_SC_PAGESIZE)
 #endif
 
 #ifndef O_CLOEXEC
-#define O_CLOEXEC 0
+# define O_CLOEXEC 0
 #endif
 
 #ifdef FREAD_READS_DIRECTORIES
@@ -936,34 +936,34 @@ FILE *git_fopen(const char*, const char*);
 #endif
 
 #ifdef SNPRINTF_RETURNS_BOGUS
-#ifdef snprintf
-#undef snprintf
-#endif
-#define snprintf git_snprintf
+# ifdef snprintf
+#  undef snprintf
+# endif
+# define snprintf git_snprintf
 int git_snprintf(char *str, size_t maxsize,
 		 const char *format, ...);
-#ifdef vsnprintf
-#undef vsnprintf
-#endif
-#define vsnprintf git_vsnprintf
+# ifdef vsnprintf
+#  undef vsnprintf
+# endif
+# define vsnprintf git_vsnprintf
 int git_vsnprintf(char *str, size_t maxsize,
 		  const char *format, va_list ap);
 #endif
 
 #ifdef OPEN_RETURNS_EINTR
-#undef open
-#define open git_open_with_retry
+# undef open
+# define open git_open_with_retry
 int git_open_with_retry(const char *path, int flag, ...);
 #endif
 
 #ifdef __GLIBC_PREREQ
-#if __GLIBC_PREREQ(2, 1)
-#define HAVE_STRCHRNUL
-#endif
+# if __GLIBC_PREREQ(2, 1)
+#  define HAVE_STRCHRNUL
+# endif
 #endif
 
 #ifndef HAVE_STRCHRNUL
-#define strchrnul gitstrchrnul
+# define strchrnul gitstrchrnul
 static inline char *gitstrchrnul(const char *s, int c)
 {
 	while (*s && *s != c)
@@ -981,7 +981,7 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 #endif
 
 #ifdef NO_PTHREADS
-#define atexit git_atexit
+# define atexit git_atexit
 int git_atexit(void (*handler)(void));
 #endif
 
@@ -1252,7 +1252,7 @@ static inline size_t xsize_t(off_t len)
 }
 
 #ifndef HOST_NAME_MAX
-#define HOST_NAME_MAX 256
+# define HOST_NAME_MAX 256
 #endif
 
 #include "sane-ctype.h"
@@ -1325,7 +1325,7 @@ static inline int strtol_i(char const *s, int base, int *result)
 void git_stable_qsort(void *base, size_t nmemb, size_t size,
 		      int(*compar)(const void *, const void *));
 #ifdef INTERNAL_QSORT
-#define qsort git_stable_qsort
+# define qsort git_stable_qsort
 #endif
 
 #define QSORT(base, n, compar) sane_qsort((base), (n), sizeof(*(base)), compar)
@@ -1342,7 +1342,7 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
 #ifndef HAVE_ISO_QSORT_S
 int git_qsort_s(void *base, size_t nmemb, size_t size,
 		int (*compar)(const void *, const void *, void *), void *ctx);
-#define qsort_s git_qsort_s
+# define qsort_s git_qsort_s
 #endif
 
 #define QSORT_S(base, n, compar, ctx) do {			\
@@ -1351,7 +1351,7 @@ int git_qsort_s(void *base, size_t nmemb, size_t size,
 } while (0)
 
 #ifndef REG_STARTEND
-#error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
+# error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
 #endif
 
 static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
@@ -1365,7 +1365,7 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 
 #ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 int git_regcomp(regex_t *preg, const char *pattern, int cflags);
-#define regcomp git_regcomp
+# define regcomp git_regcomp
 #endif
 
 #ifndef DIR_HAS_BSD_GROUP_SEMANTICS
@@ -1375,23 +1375,23 @@ int git_regcomp(regex_t *preg, const char *pattern, int cflags);
 #endif
 
 #ifdef NO_NSEC
-#undef USE_NSEC
-#define ST_CTIME_NSEC(st) 0
-#define ST_MTIME_NSEC(st) 0
+# undef USE_NSEC
+# define ST_CTIME_NSEC(st) 0
+# define ST_MTIME_NSEC(st) 0
 #else
-#ifdef USE_ST_TIMESPEC
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
-#else
-#define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
-#define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
-#endif
+# ifdef USE_ST_TIMESPEC
+#  define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctimespec.tv_nsec))
+#  define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtimespec.tv_nsec))
+# else
+#  define ST_CTIME_NSEC(st) ((unsigned int)((st).st_ctim.tv_nsec))
+#  define ST_MTIME_NSEC(st) ((unsigned int)((st).st_mtim.tv_nsec))
+# endif
 #endif
 
 #ifdef UNRELIABLE_FSTAT
-#define fstat_is_reliable() 0
+# define fstat_is_reliable() 0
 #else
-#define fstat_is_reliable() 1
+# define fstat_is_reliable() 1
 #endif
 
 #ifndef va_copy
@@ -1400,11 +1400,11 @@ int git_regcomp(regex_t *preg, const char *pattern, int cflags);
  * pointer into the stack frame, a simple assignment will work on
  * many systems.  But let's try to be more portable.
  */
-#ifdef __va_copy
-#define va_copy(dst, src) __va_copy(dst, src)
-#else
-#define va_copy(dst, src) ((dst) = (src))
-#endif
+# ifdef __va_copy
+#  define va_copy(dst, src) __va_copy(dst, src)
+# else
+#  define va_copy(dst, src) ((dst) = (src))
+# endif
 #endif
 
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
@@ -1425,11 +1425,11 @@ void bug_fl(const char *file, int line, const char *fmt, ...);
 } while (0)
 
 #ifndef FSYNC_METHOD_DEFAULT
-#ifdef __APPLE__
-#define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
-#else
-#define FSYNC_METHOD_DEFAULT FSYNC_METHOD_FSYNC
-#endif
+# ifdef __APPLE__
+#  define FSYNC_METHOD_DEFAULT FSYNC_METHOD_WRITEOUT_ONLY
+# else
+#  define FSYNC_METHOD_DEFAULT FSYNC_METHOD_FSYNC
+# endif
 #endif
 
 #ifndef SHELL_PATH
@@ -1445,12 +1445,12 @@ static inline void git_funlockfile(FILE *fh UNUSED)
 {
 	; /* nothing */
 }
-#undef flockfile
-#undef funlockfile
-#undef getc_unlocked
-#define flockfile(fh) git_flockfile(fh)
-#define funlockfile(fh) git_funlockfile(fh)
-#define getc_unlocked(fh) getc(fh)
+# undef flockfile
+# undef funlockfile
+# undef getc_unlocked
+# define flockfile(fh) git_flockfile(fh)
+# define funlockfile(fh) git_funlockfile(fh)
+# define getc_unlocked(fh) getc(fh)
 #endif
 
 #ifdef FILENO_IS_A_MACRO
@@ -1465,7 +1465,7 @@ int git_fileno(FILE *stream);
 int git_access(const char *path, int mode);
 # ifndef COMPAT_CODE_ACCESS
 #  ifdef access
-#  undef access
+#   undef access
 #  endif
 #  define access(path, mode) git_access(path, mode)
 # endif
@@ -1510,9 +1510,9 @@ int common_exit(const char *file, int line, int code);
  */
 #ifdef SUPPRESS_ANNOTATED_LEAKS
 void unleak_memory(const void *ptr, size_t len);
-#define UNLEAK(var) unleak_memory(&(var), sizeof(var))
+# define UNLEAK(var) unleak_memory(&(var), sizeof(var))
 #else
-#define UNLEAK(var) do {} while (0)
+# define UNLEAK(var) do {} while (0)
 #endif
 
 #define z_const
@@ -1565,9 +1565,9 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
  * everywhere.
  */
 #if defined(__GNUC__) /* clang sets this, too */
-#define OFFSETOF_VAR(ptr, member) offsetof(__typeof__(*ptr), member)
+# define OFFSETOF_VAR(ptr, member) offsetof(__typeof__(*ptr), member)
 #else /* !__GNUC__ */
-#define OFFSETOF_VAR(ptr, member) \
+# define OFFSETOF_VAR(ptr, member) \
 	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
 #endif /* !__GNUC__ */
 
-- 
2.45.2-709-g1ffe7c8bd7

