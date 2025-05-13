Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517512BFC95
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164092; cv=none; b=nMTVGWRF8YWRlFB+Ca9O053EDjb7Y2Bkra0E17ZFV6iJnycrVTOKitNt9eE3zSciwvudbxUaSYuQpx4fFmd7o26AtQo/l+9V6RXWZ2/q9T+Pkn7ZSNAtfU8W8fEi6EvlCdPw5ha0YwcKo8fh1kLFahV1I9VAP0C2dITLqz2SroQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164092; c=relaxed/simple;
	bh=hLMC1tuxa1UTb5nIpGtihWd6Hj2ekUT+56vfgxCYF4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKwrh9h3h1pfa1sfSvbPFGt0EyoE7ZZoQkzaEVVHlq6CeBpleJgFWpZ6rePbmTix6K2dd6U9sUJgw8BaOtZZvhKsCUUuacbRt2cn0uYO6HiLNUNrCB4ug4IkeWT3GY7/WaqzxDk7RmuNS8kxbPqMtYKlNNSqTG8NKoUJM3zkIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ECmDaUv3; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ECmDaUv3"
Received: from localhost.localdomain ([80.189.83.109])
	by smtp with ESMTPA
	id Ev8Rub969aTZGEv92uZHsA; Tue, 13 May 2025 20:18:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747163908; bh=w/HnUrPK0Mtt9xN80wsZd6nYhcd2Pwn8/4JZ1Asyhqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ECmDaUv3GCwmhLKj0jiiDnY0t1ttMI6on3wwjNirChnOm30lY2KqfcHIyQVM2u++b
	 rS/GctXi3JAKrDnBcFVjZesuXTmobkJXX1nQRns8GI53oRN5/Bq6tKwuS8m7Jzzmge
	 2FqG76FLDU/fMXfe/YLdffuHSNu2YxRoKn7n0q7/Ati6FE/dQmV33Jn99cm7zKzTyF
	 GCSG4tAIoRMoVCTQcaDWZEg+jy10VinUVQawIYFmkkDbcwh+hbxJQB/kgvs2lhwbZw
	 gOXP87bv3Kf0vUoQBlJ5wkyTKRIuxy0x5Zo/Z0K2xI10cwTklBZdJqw0f7fSnI6DUV
	 o+d4DZ+kDTk0A==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=V9ne0vni c=1 sm=1 tr=0 ts=68239b04
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=EBOSESyhAAAA:8
 a=tAj7-kSf7k6-pbzrxKMA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: 'GIT Mailing-list ' <git@vger.kernel.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	=?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= <congdanhqx@gmail.com>
Subject: [PATCH v2 4/5] meson.build: correct setting of GIT_EXEC_PATH
Date: Tue, 13 May 2025 20:17:25 +0100
Message-ID: <20250513191739.1513460-5-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfI1Woaus6EGiFw6iWVXfFoGV1lCRB/dR2vb6Q/5UUu0eVBXPlcQhuMvaIzGWtP6iC3p/AZuaDobVbXK+RrgWe/pC0z2iLDr5qDSjCp9dYun0F4N2O1zR
 oAub/GxkxseXwOTM6BFCBfFZJjFSfRXUtbXrb2OaxZfrK0d7C6hihJFR7wUgbQ/VcFoN6ECGAYUU0hW/v2BEEMwyeBU0778EiXw=

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
index 7f811030bd..28276e5305 100644
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

