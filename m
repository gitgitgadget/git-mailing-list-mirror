Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB033B95E
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494706; cv=none; b=WlnpSFMSBGxJHE00hoohcd7Hw49VhK9L8dE2Kb4fLzprwZlssKCwjuJ+S+uip5PJlUpyL5Ka0NvKpOe2uNjGcQxtNEkneaZ/GRvz/MLCIWM12em7CRicjI4uuSF79cea7UrDu01jH/rQVRBNbVVcK7fbxwRBUfDeqrRs7KV7/Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494706; c=relaxed/simple;
	bh=ct6Tp291y6CnyhkXGRBYRXsx5ybPKQ8d81Q01ce2UaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOJuP1FBIvTl3m2NFQeR/OMjDRfzpiHX/ckIrIxBoP6g6e9EMEHBgxiOfXYT2TEWaZxKcHXJWkBJdV/yTxvD+ArWO4m2PsEAv+fZPF6V6O0phqpsh/YP8q0WTweWwrlaZwwcOMl52lYFAd/qlzbsGt7d5f0SLkcJKHLry4nYiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=OyLzk72B; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="OyLzk72B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=ct6Tp291y6CnyhkXGRBYRXsx5ybPKQ8d81Q01ce2UaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=OyLzk72BSWt45l4tY4piQLpkurGjt06zMHsMK0D6ngwwfxNShajCEZ2LXh+eaKGQD
	 rEBEg3OL7SwLTv5F7FrMQ6FpB1Do9UxZVC7RTFsMnbm2qOTTctkGtrPzzUNZyZlhVh
	 Um7BKnfXtniBiV6wESIuE0q09iFUB/sIEskyMVYiiXbRvLKfDSux6Sl4Ftb0vT6jbr
	 cjYlLMXtaaTzLLO1Gqu6ZedSCtePRDGmdHZn6md9ljj1va8qviFfrcZnoT7tjyTLH/
	 SpCS/ilXzA/hNUUvy8h3dsZ/4tlq54D8ily19WXUXlrSOI28jWKaOpJfaJN+Kye61j
	 3hqJA4EuB01/obaLwj3dtMzanBuVR/gaRSbZZPXe6urgQkxLKN0WLjMFdaxqfObdTZ
	 UWH68qf/nlKWJgF3A8q1+1sNgwAe01YLABKL/SuKWz42UiDpaCeB9nUVOIIh1Q6WnZ
	 XFe8TjJUCe7YpJOcvw64eMIdFBcGSEIXTkWFXeZVD4+0M+0O9Wm
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CEF84243E7;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 12/16] rust: add a build.rs script for tests
Date: Sat,  7 Feb 2026 20:04:42 +0000
Message-ID: <20260207200446.2837699-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
References: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
 <20260207200446.2837699-1-sandals@crustytoothpaste.net>
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
index 88ae4c4b2f..c51a020b6c 100644
--- a/Makefile
+++ b/Makefile
@@ -3008,7 +3008,7 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
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
