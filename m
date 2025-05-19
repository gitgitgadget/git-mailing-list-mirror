Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE351DF273
	for <git@vger.kernel.org>; Mon, 19 May 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672154; cv=none; b=tV64ssqEshSY7dR+8zGa8fx0ahsXpKxoSpa06VcesLZZxMtqbPCKcXZybv1060e56e03QYGl4AxspOUmCVI0Wqqgov5mK5dfULIDAUdgwRtP7oTZMQPMDDci2hFFIEqnPxHCoiUp0ns5xEt1eRX6s1/7dm5UzaFOMZPSZlGai+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672154; c=relaxed/simple;
	bh=77LDRwZCGFK03HkDJFOW3fbsVmYdBmra66B4Y9Sr+ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN4giFnUSa+ftutHCB/We2LGx6K+ZyzWwCohTkFwTov9fi6+XQSQDm/YjLArdKGAuRA3m9wDZNahenLsxfcEci/ieHbGZ4NWHWxstRIazCrJ/iu6fTd+dKvJ1SPDfu0DtMTWrhKbOERbS/T6zHOBhxwRh+2GuWvWL296IFBEtL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=B/SQHXLZ; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="B/SQHXLZ"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id H3J4um35fEe7cH3JbuD0BV; Mon, 19 May 2025 17:26:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747671972; bh=QWeFmqE2mDGXQ7oUcjq9OKW+cO+YDJPK1IrTZvJijPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/SQHXLZXtT+lByUnkP7JUty40z40ULu3FxwsgcjS/S2yEhTcyb+ezhKwA+xMXjIQ
	 pwAIGVv5mX0T6GureBFk2/QKEU822EL2OsxMC491mQz7CoQaYu2sDPRbErk8fSy88z
	 iw/+a0WciKAQvKSZuI+ODSivbmcvo8rDUhGKGXzNlHjz7RpX0eek1hz0BFyK6yoJCa
	 NZPuZ53+PMM4J8uEAbu/3Qe48XJgl3C8d9DrdvWppt2qiEbGMSOz8XLhto/gIDK2Xz
	 4m7smcT5Rb3zvH87gFz5DexXMy4tONdb9D2YeKODfky2Kn5FphJXKj6yP9fN//CflK
	 B30RthaeLf5kw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=BeN70at2 c=1 sm=1 tr=0 ts=682b5ba4
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=oT9sOl9EXadLr-pDyssA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v4 4/5] meson.build: correct setting of GIT_EXEC_PATH
Date: Mon, 19 May 2025 17:25:22 +0100
Message-ID: <20250519162523.1001478-5-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
References: <20250516184843.1524925-1-ramsay@ramsayjones.plus.com>
 <20250519162523.1001478-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfM5gB4z1REC4Dcr1OAQYPuGp9L1BnnP4879SsvSF6vmSthYH8TQlYh6fQEhi0wJGBKFZ6Fh0fw3GFAxT36XdicVmzJBilMyF+1mQLmJHyJ3ZPsEx3EPi
 0VgHpMj2E260zGT2IXHsjUbUns2kos36Pe8ovbnIbkMPcF3+tV+diqprn4/YU2EKcwttX3JU3Uy5dYAIj7l8fyP6pIFSXF+8m5o=

For the non-'runtime prefix' case, the meson build sets the GIT_EXEC_PATH
build variable to an absolute path equivalent to <prefix>/libexec/git-core.
In comparison, the default make build sets it to a relative path equivalent
to 'libexec/git-core'. Indeed, the make build requires the use of some
means outside of the Makefile (eg. config.mak[.*] or the command-line)
to set GIT_EXEC_PATH to anything other than 'libexec/git-core'.

For example, the make invocation:

  $ make gitexecdir=/some/other/bin all install

will build git with GIT_EXEC_PATH set to '/some/other/bin' and install
the 'library' executables to that location. However, without setting the
'gitexecdir' make variable, irrespective of the 'runtime prefix' setting,
the GIT_EXEC_PATH is always set to 'libexec/git-core'.

The meson built-in 'libexecdir' option can be used to provide a similar
configurability. The default value for the option is 'libexec'. Attempting
to set the option to '' on the command-line, will reset it to the '.'
string, presumably to ensure a relative path value.

This commit allows the meson build, similar to the above, to configure the
project like:

  $ meson setup --buildtype=debugoptimized -Dprefix=$HOME -Dpcre2=disabled \
      -Dlibexecdir=/some/other/bin build

so that the GIT_EXEC_PATH is set to '/some/other/bin'. Absent the
-Dlibexecdir argument, the GIT_EXEC_PATH is set to 'libexec/git-core'.

In order to correct the value of GIT_EXEC_PATH, default the value to the
static string value 'libexec/git-core', and only override if the value
of the 'libexecdir' option has a value different to 'libexec' or '.'.
Also, like the Makefile, add a check for an absolute path when the
runtime prefix option is true (and if so, error out).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 8e8f228a37..bd14bc15a1 100644
--- a/meson.build
+++ b/meson.build
@@ -1592,10 +1592,19 @@ else
   error('Unsupported CSPRNG backend: ' + csprng_backend)
 endif
 
+git_exec_path = 'libexec/git-core'
+libexec = get_option('libexecdir')
+if libexec != 'libexec' and libexec != '.'
+  git_exec_path = libexec
+endif
+
 if get_option('runtime_prefix')
   libgit_c_args += '-DRUNTIME_PREFIX'
   build_options_config.set('RUNTIME_PREFIX', 'true')
-  git_exec_path = get_option('libexecdir') / 'git-core'
+
+  if git_exec_path.startswith('/')
+    error('runtime_prefix requires a relative libexecdir not:', libexec)
+  endif
 
   if compiler.has_header('mach-o/dyld.h')
     libgit_c_args += '-DHAVE_NS_GET_EXECUTABLE_PATH'
@@ -1632,7 +1641,6 @@ if get_option('runtime_prefix')
   endif
 else
   build_options_config.set('RUNTIME_PREFIX', 'false')
-  git_exec_path = get_option('prefix') / get_option('libexecdir') / 'git-core'
 endif
 libgit_c_args += '-DGIT_EXEC_PATH="' + git_exec_path + '"'
 
-- 
2.49.0

