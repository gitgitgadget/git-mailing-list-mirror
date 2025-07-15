Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0E1B4F1F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622411; cv=none; b=Cy3NqKgN6L4XorL4uYPfJStGI5F8gq6a0ot6rxXx8/uAXzk9ae4EIazwzQghHXnyPcx/c86DpjPuNxGlmJb/V94zYcDC5Jo13pqqkE+On7Ews2ru7QUtyYR8SxaMLwM6tLbpA7bONV/9DQYDdJw0UEQ0xM5ORGM6SEloy6LEHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622411; c=relaxed/simple;
	bh=IjP/DwEOZUtFX/ixbxoLWiGCWl+4h/w80YmlT0e8AJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLHzumsYtwzJzmRH0VRKMX5fql5NVWR/a8fDQFbXusYRGdA4p8l+kLv+o2pU0dqoVPhslsaMuqje3i9cnHj0H5oof3F2yv6l8nXlzKd6a/X7KXQD0atdW80V7pri+3s4gg4xT81kp1zFCJQv/VBvSzqkcbRR0eSVR8LLZ7x/bUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Au4aQB9u; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Au4aQB9u"
Received: from satellite-LM22 ([80.189.83.109])
	by smtp with ESMTPA
	id bp8quChur7HMwbp9KuU8yb; Wed, 16 Jul 2025 00:33:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1752622408; bh=5Iq2UwahXG93SGnDsT98M1+yOiX95KPeIOsPA9Dl1qI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Au4aQB9u4HW7AM9Br5y3x7EmC2506V1byWcxUuPr1DDo/RwyQPeEKhm4DeFaWIyCe
	 aZ+1obgV1C2s6AIWJGJCAdZpNnb+nOcmLVkoeO0mF3wceVzZ8odck0ZPqvPDszVcX8
	 RVVxXpkoBg8sqW70r+TnE7EIVSo/Ir5+bjAQ3gPVHy2P7lORA3F1hbVTh2wLwO77lt
	 5dKX7E+CnQyuSfAGaTV/5P0Qyf2iZJ1xJiL3iO34jd/TUDWeXMDm10I3D/jiF6TE8H
	 ghRDbNAKNnmBJOfegtyYUluxgCZKwj+KtWRpLl1WFy10Ishxxcgi3NED5sNX8EHiHp
	 jB7nqUA4ArYNA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ZNB0mm7b c=1 sm=1 tr=0 ts=6876e548
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17 a=pGLkceISAAAA:8
 a=EBOSESyhAAAA:8 a=kAU6pVMHOiuGs6QmtrsA:9 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	irecca.kun@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 1/2] meson: fix installation when -Dlibexexdir is set
Date: Wed, 16 Jul 2025 00:32:38 +0100
Message-ID: <20250715233239.1539780-2-ramsay@ramsayjones.plus.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715233239.1539780-1-ramsay@ramsayjones.plus.com>
References: <f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
 <20250715233239.1539780-1-ramsay@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCrqKUkcIXO4fPyeResj2BA4dUc5KS42WVBQhIUjP8pwMQhYMFyAOZYVt+x9y35MizdHW5f1wfpyO1WgxjLo+ksmXl6IrD7H+ZKsCb2tI8gr+aMyD+bC
 Q6AOV6B8qxFpydugWbuNjsF6YYi12NhHmx2nfybCKfjJ3DyTWYIgCxHce2cWGWCVB6uSnji8Qckq9fGtM9I3j2PixQRfqafXZW0=

commit 837f637cf5 ("meson.build: correct setting of GIT_EXEC_PATH",
2025-05-19) corrected the GIT_EXEC_PATH build setting, but then forgot
to update the installation path for the library executables. This causes
a regression when attempting to execute commands, after installing to a
non-standard location (reported here[1]):

    $ meson -Dprefix=/tmp/git -Dlibexecdir=libexec-different build
    $ meson install
    $ /tmp/git/bin/git --exec-path
    /tmp/git/libexec-different
    $ /tmp/git/bin/git daemon
    git: 'daemon' is not a git command. See 'git --help'

In order to fix the issue, use the 'git_exec_path' variable (calculated
while processing -Dlibexecdir) as the 'install_dir' field during the
installation of the library executables.

[1]: <66fd343a-1351-4350-83eb-c797e47b7693@gmail.com>

Reported-by: irecca.kun@gmail.com
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 meson.build | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index 7fea4a34d6..26b12c4592 100644
--- a/meson.build
+++ b/meson.build
@@ -1744,7 +1744,7 @@ git_builtin = executable('git',
   sources: builtin_sources + 'git.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 bin_wrappers += git_builtin
 
@@ -1752,35 +1752,35 @@ test_dependencies += executable('git-daemon',
   sources: 'daemon.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 test_dependencies += executable('git-sh-i18n--envsubst',
   sources: 'sh-i18n--envsubst.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 bin_wrappers += executable('git-shell',
   sources: 'shell.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 test_dependencies += executable('git-http-backend',
   sources: 'http-backend.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 bin_wrappers += executable('scalar',
   sources: 'scalar.c',
   dependencies: [libgit_commonmain],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 if curl.found()
@@ -1796,14 +1796,14 @@ if curl.found()
     sources: 'remote-curl.c',
     dependencies: [libgit_curl],
     install: true,
-    install_dir: get_option('libexecdir') / 'git-core',
+    install_dir: git_exec_path,
   )
 
   test_dependencies += executable('git-http-fetch',
     sources: 'http-fetch.c',
     dependencies: [libgit_curl],
     install: true,
-    install_dir: get_option('libexecdir') / 'git-core',
+    install_dir: git_exec_path,
   )
 
   if expat.found()
@@ -1811,7 +1811,7 @@ if curl.found()
       sources: 'http-push.c',
       dependencies: [libgit_curl],
       install: true,
-      install_dir: get_option('libexecdir') / 'git-core',
+      install_dir: git_exec_path,
     )
   endif
 
@@ -1822,7 +1822,7 @@ if curl.found()
     )
 
     install_symlink(alias + executable_suffix,
-      install_dir: get_option('libexecdir') / 'git-core',
+      install_dir: git_exec_path,
       pointing_to: 'git-remote-http',
     )
   endforeach
@@ -1832,7 +1832,7 @@ test_dependencies += executable('git-imap-send',
   sources: 'imap-send.c',
   dependencies: [ use_curl_for_imap_send ? libgit_curl : libgit_commonmain ],
   install: true,
-  install_dir: get_option('libexecdir') / 'git-core',
+  install_dir: git_exec_path,
 )
 
 foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
@@ -1842,7 +1842,7 @@ foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
   )
 
   install_symlink(alias + executable_suffix,
-    install_dir: get_option('libexecdir') / 'git-core',
+    install_dir: git_exec_path,
     pointing_to: 'git',
   )
 endforeach
@@ -1856,9 +1856,9 @@ foreach symlink : [
   'scalar',
 ]
   if meson.version().version_compare('>=1.3.0')
-    pointing_to = fs.relative_to(get_option('libexecdir') / 'git-core' / symlink, get_option('bindir'))
+    pointing_to = fs.relative_to(git_exec_path / symlink, get_option('bindir'))
   else
-    pointing_to = '../libexec/git-core' / symlink
+    pointing_to = '..' / git_exec_path / symlink
   endif
 
   install_symlink(symlink,
@@ -1898,7 +1898,7 @@ foreach script : scripts_sh
       meson.project_build_root() / 'GIT-BUILD-OPTIONS',
     ],
     install: true,
-    install_dir: get_option('libexecdir') / 'git-core',
+    install_dir: git_exec_path,
   )
 endforeach
 
@@ -1931,7 +1931,7 @@ if perl_features_enabled
     input: perl_header_template,
     output: 'GIT-PERL-HEADER',
     configuration: {
-      'GITEXECDIR_REL': get_option('libexecdir') / 'git-core',
+      'GITEXECDIR_REL': git_exec_path,
       'PERLLIBDIR_REL': perllibdir,
       'LOCALEDIR_REL': get_option('datadir') / 'locale',
       'INSTLIBDIR': perllibdir,
@@ -1955,7 +1955,7 @@ if perl_features_enabled
       output: fs.stem(script),
       command: generate_perl_command,
       install: true,
-      install_dir: get_option('libexecdir') / 'git-core',
+      install_dir: git_exec_path,
       depends: [git_version_file],
     )
     test_dependencies += generated_script
@@ -1964,9 +1964,9 @@ if perl_features_enabled
       bin_wrappers += generated_script
 
       if meson.version().version_compare('>=1.3.0')
-        pointing_to = fs.relative_to(get_option('libexecdir') / 'git-core' / fs.stem(script), get_option('bindir'))
+        pointing_to = fs.relative_to(git_exec_path / fs.stem(script), get_option('bindir'))
       else
-        pointing_to = '../libexec/git-core' / fs.stem(script)
+        pointing_to = '..' / git_exec_path / fs.stem(script)
       endif
 
       install_symlink(fs.stem(script),
@@ -1996,7 +1996,7 @@ if python.found()
         '@OUTPUT@',
       ],
       install: true,
-      install_dir: get_option('libexecdir') / 'git-core',
+      install_dir: git_exec_path,
     )
     test_dependencies += generated_python
   endforeach
@@ -2030,7 +2030,7 @@ mergetools = [
 ]
 
 foreach mergetool : mergetools
-  install_data(mergetool, install_dir: get_option('libexecdir') / 'git-core' / 'mergetools')
+  install_data(mergetool, install_dir: git_exec_path / 'mergetools')
 endforeach
 
 if intl.found()
-- 
2.50.0

