Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3C30E851
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525879; cv=none; b=AuggsCofVejRM5m3C3jmsCNcv4ea5bi7Rs0OuqX6Haq9XJx7dX/MjxCfB1FBYCV9m7SXF8zv3sjbftQ4L/a5MgKXNGNnOLkdTOolTa40Mzq1j5vFDlDIGkwjzdAXAtD7to/mMgJAJ0GtkJeRJGTLJJnxTrr3bTkZjFoODnULIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525879; c=relaxed/simple;
	bh=kTn6v3L6Emg449li8SOcMw+Ekb8/vOi3c8NCWEOFeHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJ7e9/OVN7tfUyHuJXK32MIxkFonUZqopv+1f6+iA9hcnO+zDNZDPz969tz9Gm0OI6h/NXPng+2ju04PdfhiADwK9uK3ajlS3w6vvPg96KxkPkuCyy4IMi7a16/zCNbJkREbUm/Uqgp4+uGWZlzAIifj1/6biKt/SbpvbrC45oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SFn5GTsf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SFn5GTsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=kTn6v3L6Emg449li8SOcMw+Ekb8/vOi3c8NCWEOFeHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=SFn5GTsf4nN3/mo9O6BTUyec1DW9f5mbjgAeEz1xbRRd6gIJZrXlVbroNm2YzzSTS
	 o0vIN/e26qb2CYVJBJodkBJe8fbzOtiJexiaqTgaiVXdwx9cqSY60uL1n40TVNupXR
	 g0cKFmLKQkkvTFG11UtsO/l93wI/tMCMTk8i9wPyrxmrZ7tDWEJRj4b22lcxgOmu4G
	 suk+ahsTgviI77P1B951GF6HqbLf5KoawoO/j93AXlI4objAylXzV0wwQW0I2Xu7XX
	 A1b72+Fm5yL5SAgmoDE9aXBeVliV7qLHY2L/h34Td6wBSSb4jjVNGk87vIPLW/wxF+
	 Mp6lDiYhNS/c4wU72GpqGBzHi2PdpJCNa0+Rt0tccsQf4RbObUINqecILwBrSAF/4J
	 n/pxhUIokQXdbVm+Nevb5qSYoQCcrsTDF7RYu8XmgdyGLyIyT/dqE71SleJ9H2/FBU
	 9LnExXDj/tpRRB274wb0ip5fyV5Ql6OtLAmf0rd0/ob11K4F1Vn
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D2854231FD;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 10/14] rust: add a build.rs script for tests
Date: Mon, 27 Oct 2025 00:44:00 +0000
Message-ID: <20251027004404.2152927-11-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cargo uses the build.rs script to determine how to compile and link a
binary.  The only binary we're generating, however, is for our tests,
but in a future commit, we're going to link against libgit.a for some
functionality and we'll need to make sure the test binaries are
complete.

Add a build.rs file for this case and specify the files we're going to
be linking against.  Because we cannot specify different dependencies
when building our static library versus our tests, update the Makefile
to specify these dependencies for our static library to avoid race
conditions during build.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Makefile |  2 +-
 build.rs | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 build.rs

diff --git a/Makefile b/Makefile
index 7e5a735ca6..7c36302717 100644
--- a/Makefile
+++ b/Makefile
@@ -2948,7 +2948,7 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
+$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(XDIFF_LIB) $(LIB_FILE) $(REFTABLE_LIB)
 	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
 
 .PHONY: rust
diff --git a/build.rs b/build.rs
new file mode 100644
index 0000000000..136d58c35a
--- /dev/null
+++ b/build.rs
@@ -0,0 +1,21 @@
+// This program is free software; you can redistribute it and/or modify
+// it under the terms of the GNU General Public License as published by
+// the Free Software Foundation: version 2 of the License, dated June 1991.
+//
+// This program is distributed in the hope that it will be useful,
+// but WITHOUT ANY WARRANTY; without even the implied warranty of
+// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+// GNU General Public License for more details.
+//
+// You should have received a copy of the GNU General Public License along
+// with this program; if not, see <https://www.gnu.org/licenses/>.
+
+fn main() {
+    println!("cargo::rustc-link-search=.");
+    println!("cargo::rustc-link-search=reftable");
+    println!("cargo::rustc-link-search=xdiff");
+    println!("cargo::rustc-link-lib=git");
+    println!("cargo::rustc-link-lib=reftable");
+    println!("cargo::rustc-link-lib=z");
+    println!("cargo::rustc-link-lib=xdiff");
+}
