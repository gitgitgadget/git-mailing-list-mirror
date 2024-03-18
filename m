Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F850249
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775077; cv=none; b=s09ncG/EbVrPFrxvCrpRaGitZ4bQnGfqu0zIF9GMhV/P5lRlfQDkrOcK4UQVCNZF5xLeGxJKySP9Zr3aSZ/ZxSsgvp+XCjxKMHSuM7TPOeMWj+rYD2YF86ZHOdxkc82jwN+AKB6Xx+0vi+oCNTlPc2YkgRKLEysx3CelQu9ubpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775077; c=relaxed/simple;
	bh=Zgf9TjZBXz90VbT4PjK0EYxYjjsyXTqxReI1a7hd6ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeZoFYkoZ004rUB+Ql9KdaW7s16usREjjKPI6NUH1/J0jajHGYlUtOP596gnlqPTRuyiM2SPjuCL6GiFvqJetyo+1uPNhuTcak6QA/DBJBMqo/dxzs6ec+bjgmVsk8Oz6jO/tnw6U9yqYTkXL32p1M80x2rMIqPLtjU+fxF00PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=f0SrQw6Y; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="f0SrQw6Y"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:fc9:9524:11d1:7aa4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id BF4F4602BD;
	Mon, 18 Mar 2024 16:17:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1710775069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=79Y8p58BN7UgijTeitJ6k+H+iUyLmmD/AC2uZd04frk=;
	b=f0SrQw6Ym4cuMF0Fbe4TtgxmlbBJSIiv4BoMJJ+wjUXuS+XmeUEwG3sXDciwUVdZys76h1
	1s4ExvsPkj0Rb+eX30fBl32qvITGKxkqLoRCEWuC+Q/Qc3S6SkM5VB6bbUxz15p63V8ovY
	MtPdnZD5X13FVeZa7dXH2aGVHIuhaNDPg47XR857sOXpzyxcUHx5y9aPTn6owTHoLfQlgf
	dxxLNWHHmU4G+xKwgh5fxayUBHEuitC9rAtNacWA3vM0RLRXSpIO+psXosHrGEv0NJE61+
	nzN/a/QiZCZ8zhFKZg9eOmoLGLytXlCnpwkgM+Dg3CWiNC78jJvJH0pV6ldMkA==
From: Max Gautier <mg@max.gautier.name>
To: git@vger.kernel.org
Cc: =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>,
	Max Gautier <mg@max.gautier.name>
Subject: [RFC PATCH 1/5] maintenance: package systemd units
Date: Mon, 18 Mar 2024 16:07:19 +0100
Message-ID: <20240318151701.26644-3-mg@max.gautier.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318151701.26644-2-mg@max.gautier.name>
References: <20240318151701.26644-2-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Max Gautier <mg@max.gautier.name>
---
 Makefile                              |  4 ++++
 systemd/user/git-maintenance@.service | 16 ++++++++++++++++
 systemd/user/git-maintenance@.timer   |  9 +++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 systemd/user/git-maintenance@.service
 create mode 100644 systemd/user/git-maintenance@.timer

diff --git a/Makefile b/Makefile
index 4e255c81f2..276b4373c6 100644
--- a/Makefile
+++ b/Makefile
@@ -619,6 +619,7 @@ htmldir = $(prefix)/share/doc/git-doc
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
 ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
 lib = lib
+libdir = $(prefix)/lib
 # DESTDIR =
 pathsep = :
 
@@ -1328,6 +1329,8 @@ BUILTIN_OBJS += builtin/verify-tag.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
+SYSTEMD_USER_UNITS := $(wildcard systemd/user/*)
+
 # THIRD_PARTY_SOURCES is a list of patterns compatible with the
 # $(filter) and $(filter-out) family of functions. They specify source
 # files which are taken from some third-party source where we want to be
@@ -3469,6 +3472,7 @@ install: all
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) -Dm 644 -t '$(DESTDIR_SQ)$(libdir)/systemd/user' $(SYSTEMD_USER_UNITS)
 
 ifdef MSVC
 	# We DO NOT install the individual foo.o.pdb files because they
diff --git a/systemd/user/git-maintenance@.service b/systemd/user/git-maintenance@.service
new file mode 100644
index 0000000000..87ac0c86e6
--- /dev/null
+++ b/systemd/user/git-maintenance@.service
@@ -0,0 +1,16 @@
+[Unit]
+Description=Optimize Git repositories data
+
+[Service]
+Type=oneshot
+ExecStart=git for-each-repo --config=maintenance.repo \
+          maintenance run --schedule=%i
+LockPersonality=yes
+MemoryDenyWriteExecute=yes
+NoNewPrivileges=yes
+RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6 AF_VSOCK
+RestrictNamespaces=yes
+RestrictRealtime=yes
+RestrictSUIDSGID=yes
+SystemCallArchitectures=native
+SystemCallFilter=@system-service
diff --git a/systemd/user/git-maintenance@.timer b/systemd/user/git-maintenance@.timer
new file mode 100644
index 0000000000..40fbc77a62
--- /dev/null
+++ b/systemd/user/git-maintenance@.timer
@@ -0,0 +1,9 @@
+[Unit]
+Description=Optimize Git repositories data
+
+[Timer]
+OnCalendar=%i
+Persistent=true
+
+[Install]
+WantedBy=timers.target
-- 
2.44.0

