Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E621547C9
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751667991; cv=none; b=EpjlwmQzwnT1d686WnJzdcOpyGBc8ZYiButzIAN1D5szXLz6dQG+NgjwuobUj/YZL5KOzvTHqBOc40OnZqwzgQduPeXhsNniUfm1b3kOnZgqP+gDHaVXnYCidbxfdKMCWq9wqzpORSglWxzZSTkbM5b+KrImrmy2UnCoCn4PQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751667991; c=relaxed/simple;
	bh=/hbMcuKW7O/yqJAnv3Lm8I6Tc4V1Z+PmGJ2FeQMZKvM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fQc9k+C9QZcRXMgBMr8JsOc1d9MzUSdtkyro48RuCZ73mxTcpFYwZ9wGaw9XYhFYbraMmw6/3Voc1WXHI/ORtlurBYQTVFioJE7mG+gsi7Xz74TJIRIulPh2xFZznt7ztbw+uJ8LsSm3d34/Hi99P+DjqSZrGL2i8BfTMiqyOxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=BcTJDKJa; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="BcTJDKJa"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id XooJuHX7v2676XooLuXOUB; Fri, 04 Jul 2025 23:23:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1751667794; bh=IvrHk9E6gVr27MfB5a2NMhRNywgxQWNVh1MrHPR+XCM=;
	h=Date:To:Cc:From:Subject;
	b=BcTJDKJa1MTBAQmbqMlLsNTyxP0j+B7Wi2YEy1xfu69Au0u29S7W8NUv5ddJf01Li
	 Yb4wY0HGAlWYNgwhg4TaqGjdRG3JN17k3ZZ5BNs93FVY1xLQAYg85inOfmin1PDGPu
	 slJMLCglsq8lpw44Xobi5fhBXqPTFDb2i4YVk+TjoUjQdFZdHfhJ3npIIwnD6TLy3e
	 TvnHocr/wXIEABmA8rFtUWXl63GdP2x3YGgGF4fcMdpol1c8A3LRpQIkwM8J4+yskg
	 7Y8Vva+Re/kAPq9Jirvlg/nPkTu54/Su+AIldPvcI0dwmdGLgKQQGgwvqDUnCt9lRb
	 LIujtJLQG089w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=SeJUdeRu c=1 sm=1 tr=0 ts=68685452
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=6I5d2MoRAAAA:8 a=EBOSESyhAAAA:8 a=i7iwPn7RvGA3eeREyiIA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <e6a80163-47ef-436b-98a6-2ac39c477080@ramsayjones.plus.com>
Date: Fri, 4 Jul 2025 23:23:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Renato Botelho <garga@FreeBSD.org>, Eli Schwartz <eschwartz@gentoo.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] build: fix FreeBSD build when sysinfo compat library
 installed
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKrpmIuiWEbUwZeomTFgKt5AYE80VAwl5nMiCvE0xdE+aZ97V6l+xhqwOM9jE/Cyd++uJvDVaJYRDoMn4z2nnsbB3ZvmG0IxpaUJiu3YpLjE6LALYC9F
 5tftpCEigoLdJgX/PVdv/K5szl2e6iy81iXftaC0B5lI8XGklsMosn44dVhSZ6qLQ9MxvAy7sCbjp8hbRergiwCDYEnWZak8sTo=


Commit 50dec7c566 ("config.mak.uname: add sysinfo() configuration for
cygwin", 2025-04-17) and later commit 187ce0222f ("configure.ac: upgrade
to a compilation check for sysinfo", 2025-05-19) added a 'sysinfo()'
check to the autoconf build.

The FreeBSD system has an optional sysinfo compatibility library, used
to assist in porting software, which causes the build to fail when it
is installed. The reason for the failure is the lack of '-lsysinfo'
during the linking step.

Several solutions were considered:

  - add an 'linking' check to configure.ac in order to determine the
    need to link a separate library (-lsysinfo). (This would require
    a similar change to meson.build).

  - change the order of the preprocessor conditionals in the total_ram()
    function in 'builtin/gc.c', so that the *BSD sysctl() function
    (in the HAVE_BSD_SYSCTL block) takes priority over the sysinfo()
    function (in the HAVE_SYSINFO block).

  - suppress the setting of HAVE_SYSINFO when HAVE_BSD_SYSCTL has been
    defined (in both configure.ac and meson.build).

The first solution above, while simple, adds unnecessary code (the
sysinfo compat function is likely implemented using sysctl() anyway)
when git is happy to use sysctl() on *BSD systems.

The second solution would only be required by the autoconf and meson
build systems, the Makefile already sets the build variables to the
required values (since they are not 'auto-detected').

Here we opt for the final solution above, since it only requires that
we prioritise the 'auto-detected' build variables in the autoconf and
meson builds.

In order to fix the FreeBSD build, move the sysinfo() check after the
determination of the HAVE_BSD_SYSCTL build variable, suppressing the
setting of HAVE_SYSINFO if HAVE_BSD_SYSCTL is defined. Apply this logic
to both the configure.ac and meson.build file.

[Thanks go to Renato Botelho <garga@FreeBSD.org> for testing this patch
on FreeBSD.]

Tested-by: Renato Botelho <garga@FreeBSD.org>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 configure.ac | 61 ++++++++++++++++++++++++++++++----------------------
 meson.build  | 10 +++++----
 2 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/configure.ac b/configure.ac
index f6caab919a..bf710ac91a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1067,32 +1067,6 @@ AC_CHECK_LIB([iconv], [locale_charset],
                      [CHARSET_LIB=-lcharset])])
 GIT_CONF_SUBST([CHARSET_LIB])
 
-#
-# Define HAVE_SYSINFO=YesPlease if sysinfo is available.
-#
-AC_DEFUN([HAVE_SYSINFO_SRC], [
-AC_LANG_PROGRAM([[
-#include <stdint.h>
-#include <sys/sysinfo.h>
-]], [[
-struct sysinfo si;
-uint64_t t = 0;
-if (!sysinfo(&si)) {
-	t = si.totalram;
-	if (si.mem_unit > 1)
-		t *= (uint64_t)si.mem_unit;
-}
-return t;
-]])])
-
-AC_MSG_CHECKING([for sysinfo])
-AC_COMPILE_IFELSE([HAVE_SYSINFO_SRC],
-	[AC_MSG_RESULT([yes])
-	HAVE_SYSINFO=YesPlease],
-	[AC_MSG_RESULT([no])
-	HAVE_SYSINFO=])
-GIT_CONF_SUBST([HAVE_SYSINFO])
-
 #
 # Define HAVE_CLOCK_GETTIME=YesPlease if clock_gettime is available.
 GIT_CHECK_FUNC(clock_gettime,
@@ -1221,6 +1195,41 @@ AC_COMPILE_IFELSE([BSD_SYSCTL_SRC],
 	HAVE_BSD_SYSCTL=])
 GIT_CONF_SUBST([HAVE_BSD_SYSCTL])
 
+#
+# Define HAVE_SYSINFO=YesPlease if sysinfo is available.
+#
+
+HAVE_SYSINFO=
+# on a *BSD system, sysctl() takes precedence over the
+# sysinfo() compatibility library (if installed).
+
+if test -z "$HAVE_BSD_SYSCTL"; then
+
+  AC_DEFUN([HAVE_SYSINFO_SRC], [
+  AC_LANG_PROGRAM([[
+  #include <stdint.h>
+  #include <sys/sysinfo.h>
+  ]], [[
+  struct sysinfo si;
+  uint64_t t = 0;
+  if (!sysinfo(&si)) {
+	t = si.totalram;
+	if (si.mem_unit > 1)
+		t *= (uint64_t)si.mem_unit;
+  }
+  return t;
+  ]])])
+
+  AC_MSG_CHECKING([for sysinfo])
+  AC_COMPILE_IFELSE([HAVE_SYSINFO_SRC],
+	[AC_MSG_RESULT([yes])
+	HAVE_SYSINFO=YesPlease],
+	[AC_MSG_RESULT([no])
+	HAVE_SYSINFO=])
+  GIT_CONF_SUBST([HAVE_SYSINFO])
+
+fi
+
 ## Other checks.
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
diff --git a/meson.build b/meson.build
index 7fea4a34d6..355cad730c 100644
--- a/meson.build
+++ b/meson.build
@@ -1331,10 +1331,6 @@ if host_machine.system() != 'windows'
   endif
 endif
 
-if compiler.has_member('struct sysinfo', 'totalram', prefix: '#include <sys/sysinfo.h>')
-  libgit_c_args += '-DHAVE_SYSINFO'
-endif
-
 if compiler.has_member('struct stat', 'st_mtimespec.tv_nsec', prefix: '#include <sys/stat.h>')
   libgit_c_args += '-DUSE_ST_TIMESPEC'
 elif not compiler.has_member('struct stat', 'st_mtim.tv_nsec', prefix: '#include <sys/stat.h>')
@@ -1449,6 +1445,12 @@ if compiler.has_header('sys/sysctl.h')
   endif
 endif
 
+if not has_bsd_sysctl
+  if compiler.has_member('struct sysinfo', 'totalram', prefix: '#include <sys/sysinfo.h>')
+    libgit_c_args += '-DHAVE_SYSINFO'
+  endif
+endif
+
 if not meson.is_cross_build() and compiler.run('''
   #include <stdio.h>
 
-- 
2.50.0
