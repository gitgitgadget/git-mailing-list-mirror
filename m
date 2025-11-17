Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551C34D4F6
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417793; cv=none; b=rjS77MOXQkOWspX2AGb/aI1bLnXjV5YeyCPCuxXSWBHz2lHgx0RkGehDf0QEsHmYO6BMOT9ID8mpUKzgnxD/GxBknuP9vjwwMx86p/MI5bTMYLe3rQ7N0K8+oNX/FN+FlLgEsgyv97qKGn5VT7jP7fSFwRE7qL9i3VYV4GxGeAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417793; c=relaxed/simple;
	bh=BvdI/TmDR1zNOuu7WMM2Jw+7DDaUqJPqCzjFeiLiRJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nw2ylz9+0zNlnaJJrzN/UF8y1ehqA2teY11ttfVQ4U3R2ftPb644qkyd2bbzesSX9C9zeJBixE3CIQj1udpRXHtApLdEse8PjEkETUK4YdkdQ4UWaz97DKM2wfDLgajUXdlezNkzBFpEsAH8BjZ3qNXFTu/qW2kXUlU74u0NY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=IxhPhmjt; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IxhPhmjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417786;
	bh=BvdI/TmDR1zNOuu7WMM2Jw+7DDaUqJPqCzjFeiLiRJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=IxhPhmjtkkEVM5uoZQD9poD9Qk45IQDLMObiWNpjuMh8psxdTE/EnDrT1b9ztUfti
	 2Oo2yvw1C8o55+F+QOnY6Fl60xJiZcxJHml8kw+TmtF84ZVYEhTO1JGoHgD0vbmKir
	 bFUoYiJuqkyunXaNq/JrMqR/kgiEkECcZnQR/1uZeU2ccXLY8g6gxHYu0mUP4fIwQg
	 mAt5aveuffnbP1+cohFbsFhrLVjReWN/f4DiMFSWW4MAfsC9TqfxRHlx/TtiIosGvn
	 N8AHIy5QeuCBLQf0hFgOjrfzOuaUdQpwP52hYa9LGyHQw4RiwTmH8YQ9cXgPYM0j6y
	 YAJGy8GfFiooRz9ipAnH1Raa9Sg7lU8W5id9Gf2dJ9535DSH3e4+zg8l9/zdw51CZN
	 bWoZ0cvYS8fee2i3biBAR/xwPnu/Ox2p/7rDDiDDGhWktQYbQ8ak1GdhQofdfQT5Aq
	 29OnDP0QLfCCeaHPAHbYe84eSEfgfp1P3ETm4e+IETOTvx/Gmts
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 48EA525541;
	Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 11/15] rust: add a build.rs script for tests
Date: Mon, 17 Nov 2025 22:16:17 +0000
Message-ID: <20251117221621.2863243-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251117221621.2863243-1-sandals@crustytoothpaste.net>
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
 build.rs | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 build.rs

diff --git a/Makefile b/Makefile
index e1d0ae3691..4211d7622a 100644
--- a/Makefile
+++ b/Makefile
@@ -2964,7 +2964,7 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
+$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
 	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
 
 .PHONY: rust
diff --git a/build.rs b/build.rs
new file mode 100644
index 0000000000..3724b3a930
--- /dev/null
+++ b/build.rs
@@ -0,0 +1,17 @@
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
+    println!("cargo:rustc-link-search=.");
+    println!("cargo:rustc-link-lib=git");
+    println!("cargo:rustc-link-lib=z");
+}
