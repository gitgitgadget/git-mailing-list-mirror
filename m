Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911241CBE98
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726702115; cv=none; b=Mxe49VZElWCwIXZs41yiY2MhEYN14yBKdelwNmk92RxQH3jV1GydQEJHo5CLbqiZnV3Kgd/OaaGLDQQIJ8mC0dHseOINdVAM5jdGbjGBdVAyO1Bxib4B72g7IBlMccm9KFkgrseo8gGoLSjNyYaukENo+tdLbW/ldxmDCzuJ0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726702115; c=relaxed/simple;
	bh=IuiQrjuk49fmsLjm6s6HxYX6aIbauH9jdYLW2RCl7sQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djlyNpsbxXlE8L/NMlgAW1z3G6uXgFyGZJfeRCVRSMxPg9YblKuePdB+EAwbsRyBNBGoKkL9elX0hI1oaBCKTlMx5Y9cq6Lc8XKzl4DeJGHmuA0WvFUOvg8lTu6KkxbXtRQbpb5UfKR8B40uFpRfznctuXnREAdDYslbdcWPplY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=L37aAjkl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L37aAjkl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 631901B717;
	Wed, 18 Sep 2024 19:28:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=IuiQrjuk49fmsLjm6s6HxYX6a
	IbauH9jdYLW2RCl7sQ=; b=L37aAjkl+YNadclEnImka13CmSla+N2r3LU1BkGWh
	mSXKXp/jyvUmZlMcYy9guYDImjSgvuCzU5CYZh0N1W6kGZPtPdJ8eaPwxPIjrtor
	Cb6aZzigTgdRCVgJJfSXQNxFFN1yHSv+OZmev12JeJfkqzf2TYyLw72aZvqcXupJ
	oY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BC781B716;
	Wed, 18 Sep 2024 19:28:32 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C08211B715;
	Wed, 18 Sep 2024 19:28:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/4] refs: remove NO_SYMLINK_HEAD
Date: Wed, 18 Sep 2024 16:28:24 -0700
Message-ID: <20240918232825.2627999-4-gitster@pobox.com>
X-Mailer: git-send-email 2.46.1-742-g4240f61078
In-Reply-To: <20240918232825.2627999-1-gitster@pobox.com>
References: <20240918232825.2627999-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 B792D2E8-7615-11EF-AA75-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

This step is for Git 3.0.

Remove the build-time setting NO_SYMLINK_HEAD that is used to
override the end-user supplied core.preferSymlinkRefs and force
use of textual symrefs, as core.preferSymlinkRefs is now gone
and we use textual symrefs only.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                            | 6 ------
 config.mak.uname                    | 3 ---
 configure.ac                        | 3 ---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 4 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 275a5ee3c9..029a468702 100644
--- a/Makefile
+++ b/Makefile
@@ -81,9 +81,6 @@ include shared.mak
 #
 # Define NO_SYS_SELECT_H if you don't have sys/select.h.
 #
-# Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic li=
nk.
-# Enable it on Windows.  By default, symrefs are still used.
-#
 # Define NO_SVN_TESTS if you want to skip time-consuming SVN interoperab=
ility
 # tests.  These tests take up a significant amount of the total test tim=
e
 # but are not needed unless you plan to talk to SVN repos.
@@ -1767,9 +1764,6 @@ ifdef OPEN_RETURNS_EINTR
 	COMPAT_CFLAGS +=3D -DOPEN_RETURNS_EINTR
 	COMPAT_OBJS +=3D compat/open.o
 endif
-ifdef NO_SYMLINK_HEAD
-	BASIC_CFLAGS +=3D -DNO_SYMLINK_HEAD
-endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS +=3D -DNO_GETTEXT
 	USE_GETTEXT_SCHEME ?=3D fallthrough
diff --git a/config.mak.uname b/config.mak.uname
index d5112168a4..a38b152312 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -238,7 +238,6 @@ ifeq ($(uname_O),Cygwin)
 		NO_D_TYPE_IN_DIRENT =3D YesPlease
 		NO_STRCASESTR =3D YesPlease
 		NO_MEMMEM =3D YesPlease
-		NO_SYMLINK_HEAD =3D YesPlease
 		NO_IPV6 =3D YesPlease
 		OLD_ICONV =3D UnfortunatelyYes
 		# There are conflicting reports about this.
@@ -446,7 +445,6 @@ ifeq ($(uname_S),Windows)
 	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
 	NO_LIBGEN_H =3D YesPlease
 	NO_POLL =3D YesPlease
-	NO_SYMLINK_HEAD =3D YesPlease
 	NO_IPV6 =3D YesPlease
 	NO_SETENV =3D YesPlease
 	NO_STRCASESTR =3D YesPlease
@@ -661,7 +659,6 @@ ifeq ($(uname_S),MINGW)
 	NEEDS_CRYPTO_WITH_SSL =3D YesPlease
 	NO_LIBGEN_H =3D YesPlease
 	NO_POLL =3D YesPlease
-	NO_SYMLINK_HEAD =3D YesPlease
 	NO_SETENV =3D YesPlease
 	NO_STRCASESTR =3D YesPlease
 	NO_STRLCPY =3D YesPlease
diff --git a/configure.ac b/configure.ac
index d1a96da14e..307349f323 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1195,9 +1195,6 @@ AC_COMPILE_IFELSE([BSD_SYSCTL_SRC],
 GIT_CONF_SUBST([HAVE_BSD_SYSCTL])
=20
 ## Other checks.
-# Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic li=
nk.
-# Enable it on Windows.  By default, symrefs are still used.
-#
 # Define NO_PTHREADS if we do not have pthreads.
 #
 # Define PTHREAD_LIBS to the linker flag used for Pthread support.
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/C=
MakeLists.txt
index 832f46b316..d6bce22d34 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -267,7 +267,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 	endif()
 	include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
 	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_U=
NIX_SOCKETS WIN32
-				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=3D".exe"  NO_SYMLINK_HEAD U=
NRELIABLE_FSTAT
+				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=3D".exe" UNRELIABLE_FSTAT
 				NOGDI OBJECT_CREATION_MODE=3D1 __USE_MINGW_ANSI_STDIO=3D0
 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMA=
P
 				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
--=20
2.46.1-742-g4240f61078

