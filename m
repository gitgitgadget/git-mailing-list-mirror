Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7AE15B0EF
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736307773; cv=none; b=eA8qEZNDnFwqn0la2gHUpij3UQy9jk4LNMyn/yjpARFpi9RIQH04dXK+Ud0oC31SSe8055q5swJg//5khw3L1NuCVI3rMEIW2VAMJhrHA/OslZOME6ABCDm0uN+qODj19X0IFWccfH1SqOQqbrdhLu4YOP/QF8Z/sbBY7kF8yMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736307773; c=relaxed/simple;
	bh=S6AwH8uKUD1Ler/mm/A0e5IG0bqDaFzcGIryhLhyRfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwVAHoNad7qn2kOXf5s+D564ZXn2YlDgQ6dmcPUvhqJknKGJDYtTowGQTNTbP9iVpx2UknVsgNkTef2WsNlf2buDsPPOpLfkyEM+QGrLWLYN0f0k0N574G4q2eAU4foxcg17ELxvCkqPQxJ4ma+cJIuWoA4Via60sWyeaokV24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Sam James <sam@gentoo.org>
Subject: [PATCH] meson: fix perl dependencies
Date: Wed,  8 Jan 2025 03:42:37 +0000
Message-ID: <371571630df201b0b0c680f6437decc6c60ecd3b.1736307757.git.sam@gentoo.org>
X-Mailer: git-send-email 2.48.0.rc2.29.g7bab57bd98
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`generate_perl_command` needs `depends: [git_version_file]` and the uses
in top-level meson.build were fine, but the ones in perl/ weren't, causing
parallel build failures in some cases as GIT-BUILD-OPTIONS wasn't yet
available.

Signed-off-by: Sam James <sam@gentoo.org>
---
 perl/FromCPAN/Mail/meson.build     | 1 +
 perl/FromCPAN/meson.build          | 1 +
 perl/Git/LoadCPAN/Mail/meson.build | 1 +
 perl/Git/LoadCPAN/meson.build      | 1 +
 perl/Git/SVN/Memoize/meson.build   | 1 +
 perl/Git/SVN/meson.build           | 1 +
 perl/Git/meson.build               | 1 +
 perl/meson.build                   | 1 +
 8 files changed, 8 insertions(+)

diff --git a/perl/FromCPAN/Mail/meson.build b/perl/FromCPAN/Mail/meson.build
index 129cff161c..b4ff2fc0b2 100644
--- a/perl/FromCPAN/Mail/meson.build
+++ b/perl/FromCPAN/Mail/meson.build
@@ -4,4 +4,5 @@ test_dependencies += custom_target(
   command: generate_perl_command,
   install: true,
   install_dir: get_option('datadir') / 'perl5/FromCPAN/Mail',
+  depends: [git_version_file],
 )
diff --git a/perl/FromCPAN/meson.build b/perl/FromCPAN/meson.build
index 4e7ea909df..1f9ea6ce8e 100644
--- a/perl/FromCPAN/meson.build
+++ b/perl/FromCPAN/meson.build
@@ -4,6 +4,7 @@ test_dependencies += custom_target(
   command: generate_perl_command,
   install: true,
   install_dir: get_option('datadir') / 'perl5/FromCPAN',
+  depends: [git_version_file],
 )
 
 subdir('Mail')
diff --git a/perl/Git/LoadCPAN/Mail/meson.build b/perl/Git/LoadCPAN/Mail/meson.build
index 7da5b37adb..89cde56be8 100644
--- a/perl/Git/LoadCPAN/Mail/meson.build
+++ b/perl/Git/LoadCPAN/Mail/meson.build
@@ -4,4 +4,5 @@ test_dependencies += custom_target(
   command: generate_perl_command,
   install: true,
   install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN/Mail',
+  depends: [git_version_file],
 )
diff --git a/perl/Git/LoadCPAN/meson.build b/perl/Git/LoadCPAN/meson.build
index 9468c073ae..1ee915c650 100644
--- a/perl/Git/LoadCPAN/meson.build
+++ b/perl/Git/LoadCPAN/meson.build
@@ -4,6 +4,7 @@ test_dependencies += custom_target(
   command: generate_perl_command,
   install: true,
   install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN',
+  depends: [git_version_file],
 )
 
 subdir('Mail')
diff --git a/perl/Git/SVN/Memoize/meson.build b/perl/Git/SVN/Memoize/meson.build
index 515ab3dd92..233ec670d7 100644
--- a/perl/Git/SVN/Memoize/meson.build
+++ b/perl/Git/SVN/Memoize/meson.build
@@ -4,4 +4,5 @@ test_dependencies += custom_target(
   command: generate_perl_command,
   install: true,
   install_dir: get_option('datadir') / 'perl5/Git/SVN',
+  depends: [git_version_file],
 )
diff --git a/perl/Git/SVN/meson.build b/perl/Git/SVN/meson.build
index 8338531041..44abaf42b7 100644
--- a/perl/Git/SVN/meson.build
+++ b/perl/Git/SVN/meson.build
@@ -14,6 +14,7 @@ foreach source : [
     command: generate_perl_command,
     install: true,
     install_dir: get_option('datadir') / 'perl5/Git/SVN',
+    depends: [git_version_file],
   )
 endforeach
 
diff --git a/perl/Git/meson.build b/perl/Git/meson.build
index 259209d730..b21fa5591e 100644
--- a/perl/Git/meson.build
+++ b/perl/Git/meson.build
@@ -11,6 +11,7 @@ foreach source : [
     command: generate_perl_command,
     install: true,
     install_dir: get_option('datadir') / 'perl5/Git',
+    depends: [git_version_file],
   )
 endforeach
 
diff --git a/perl/meson.build b/perl/meson.build
index c22d6f8a1a..2d4ab1c4a9 100644
--- a/perl/meson.build
+++ b/perl/meson.build
@@ -4,6 +4,7 @@ test_dependencies += custom_target(
   command: generate_perl_command,
   install: true,
   install_dir: get_option('datadir') / 'perl5',
+  depends: [git_version_file],
 )
 
 subdir('Git')
-- 
2.48.0.rc2.29.g7bab57bd98

