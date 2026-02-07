Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0633B97E
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494706; cv=none; b=WQOsG6EIbtDYdaCH3vxWUgva03OmfktRCpRh8HD8He06lToh7QASWE6sUziMKuasr/iWQ2u1iu9iKeoHArbhslutVUM/QlmctT05cHDPnhIWPonrLdYMsm0watplrdelrEP5cwH4HKRHDqnT/BYzFDwlo4pHG/JYO5vDXr/iRLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494706; c=relaxed/simple;
	bh=msibDcX0KIUKydgw9oOTJERE49dOGfjiKXGY73h8WNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEDg4bxlgINaKiAPXJlM/8bveBSOpAnOB3HNthXYwlsclEG4lumuC0hVewxMia06D/Pk3+BPnREt6xcZq5V0UsR/fFseM8tCqjsD5YPSqaWjEzP+5WLigvvYuY2NPj2gduKhKc1IicaaLBpvLAuCpB0MZmermwkkajjyBhlTn3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=raeFV5XV; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="raeFV5XV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=msibDcX0KIUKydgw9oOTJERE49dOGfjiKXGY73h8WNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=raeFV5XVGvZJUz7lNM+W97A4c7tjLvTMVfY7SGlztYio6/TIJmorzL+LqSn+Dn7wi
	 vZncmjdK7rdhHGbxGIKHN/QKVBd6njmUQe/lSu0I4/1W4HND7s7pqqy8B+YaddIquX
	 v7qyL2yC4UrEGGxnaov+SL3HSR+rrasy492KZjM3AyAcybqCmeQcxqRoWWtEATkFdK
	 qfFNKXJMyXFb5QHn4uffew1pQ/IcDPQGE/Gmg3aNaApI1sVhts+YNi1Qsez9f9tnb2
	 YPQZjlr7NtzAy+bT2W2B8MJYBk7l+b6VHL1Y98bNek0gSgZt2qbJAKhfkRSK376etb
	 ZcZvKwHwFzrVzB+cR8JDhZ3TYD7Ca3gVX+78I9fEtk24OdfQdOaDxykcx0Q9mjz9kp
	 rFbHmlWpZV5ps5U1deZ22EbdbitYRGOVpUS3iKrOi2XM+R81Co+ad27oPj2aDkcFRp
	 zeKbnlmxJfLEtS76nkfS45Y+Y1XUmRYxvLavrhVYCFwRJbp8dYf
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C62B2243CB;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 11/16] rust: fix linking binaries with cargo
Date: Sat,  7 Feb 2026 20:04:41 +0000
Message-ID: <20260207200446.2837699-12-sandals@crustytoothpaste.net>
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

From: "brian m. carlson" <bk2204@github.com>

When Cargo links binaries with MSVC, it uses the link.exe linker from
PATH to do so.  However, when running under a shell from MSYS, such as
when building with the Git for Windows SDK, which we do in CI, the
/ming64/bin and /usr/bin entries are first in PATH.  That means that the
Unix link binary shows up first, which obviously does not work for
linking binaries in any useful way.

To solve this problem, adjust PATH to place those binaries at the end of
the list instead of the beginning.  This allows access to the normal
Unix tools, but link.exe will be the compiler's linker.  Make sure to
export PATH explicitly: while this should be the default, it's more
robust to not rely on the shell operating in a certain way.

The reason this has not shown up before is that we typically link our
binaries from the C compiler.  However, now that we're about to
introduce a Rust build script (build.rs file), Rust will end up linking
that script to further drive Cargo, in which case we'll invoke the
linker from it.  There are other solutions, such as using LLD, but this
one is simple and reliable and is most likely to work with existing
systems.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
Signed-off-by: brian m. carlson <bk2204@github.com>
---
 src/cargo-meson.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
index 38728a3711..75f3cd1265 100755
--- a/src/cargo-meson.sh
+++ b/src/cargo-meson.sh
@@ -19,6 +19,18 @@ do
 	esac
 done
 
+case "$(cargo -vV | sed -n 's/^host: \(.*\)$/\1/p')" in
+	*-windows-msvc)
+		LIBNAME=gitcore.lib
+		PATH="$(echo "$PATH" | tr ':' '\n' | grep -Ev "^(/mingw64/bin|/usr/bin)$" | paste -sd: -):/mingw64/bin:/usr/bin"
+		export PATH
+		;;
+	*-windows-*)
+		LIBNAME=gitcore.lib;;
+	*)
+		LIBNAME=libgitcore.a;;
+esac
+
 cargo build --lib --quiet --manifest-path="$SOURCE_DIR/Cargo.toml" --target-dir="$BUILD_DIR" "$@"
 RET=$?
 if test $RET -ne 0
@@ -26,13 +38,6 @@ then
 	exit $RET
 fi
 
-case "$(cargo -vV | sed -n 's/^host: \(.*\)$/\1/p')" in
-	*-windows-*)
-		LIBNAME=gitcore.lib;;
-	*)
-		LIBNAME=libgitcore.a;;
-esac
-
 if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
 then
 	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
