Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE762FB0B4
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770494704; cv=none; b=Z7FlkHrFpedwjWKz8jV5danDdbguo7+jYxgb8OgqL/NoqzewJQda8nzMBxbsMUYdqWRgTfN7PJSyd+9OTxeUUMLfzgvVRkkq/P3becs3DlmMHo1vXW8124razOkwU0Ho+iTd2x3OZAp1cMLdud7lNSPcieV653sI+NrEEEyRJwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770494704; c=relaxed/simple;
	bh=2dmQuf1SMGkCP+RFnTWhXj5Rqqo3KcXW+7zvrZ6fjs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ7pedMT49l/hY8lR1qKphy3Pk0w3X+ZqLk6CINf7IrgbrFwYgJpoIBaHaNN8N+nFcwS9UiPZ5DBem6eofli9jaLzWmoAJ+pDLAX3OKIOJT/tiAVBtuSVaUxxw4DTVTDWlmXLfCyGeF89JrZ0gLXZAgkLGPUlQfiKUBxuD1AY5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bnyT+dO0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bnyT+dO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1770494697;
	bh=2dmQuf1SMGkCP+RFnTWhXj5Rqqo3KcXW+7zvrZ6fjs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=bnyT+dO0YAmRPIRup++bmCy0OeMLL1PEtHTTBJxrx8oWnIykINxPOUsbgXTOGkYEV
	 lLd2IoEw7eV5XGIf11u7HVEUOEpVazQUKBj3ls215vNsl9qsWtinj1yh19hh550ZM2
	 UWQhSTwxV0dHEDtJRK1kbE+C7OU6CWYVqD9MGEeG/RZzlEWVjmMRsTBFQDJcv7gD/7
	 wQeSFo05AadIweTCYmiSg5UkIKbW1X9+dyh4MWO+hD/qJK8A+YP2ByaCWMeKCJdfZ6
	 6RTKXYiH2o815/vDkQBv2LxdUB+NZf+yLZU/D9WEHyEhvj96Bk1eKSc3KMd8L0CJrE
	 fSw96BFIH6V+qUYTCJixNaiigkXXlcCuQqzCkPBLy50iZJIOPlh+XQebculRgt9Inu
	 ZeIlEHbXNk4rkJ2tNfB4S2bI/KgOzcUrjE2EeEFr6OdZ/MNzLKYjUA5wmfvvEfOE1o
	 xtqp3OEopIXBmdaxGH3FhLdQ1FHnpBOw65kXGE0HlpGN/PI9Nbw
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9a58:ad83:8db9:6f4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 506AE200BE;
	Sat,  7 Feb 2026 20:04:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/16] SHA-1/SHA-256 interoperability, part 2
Date: Sat,  7 Feb 2026 20:04:30 +0000
Message-ID: <20260207200446.2837699-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
References: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the second part of the SHA-1/SHA-256 interoperability work.  It
introduces our first major use of Rust code to implement a object map
format as well as preparatory work to make that happen, including
changing types to more Rust-friendly ones.  Since Rust will be required
for the interoperability work, we require that in the testsuite.

We also verify that our object ID algorithm is valid when looking up
data in the hash map since the Rust code intentionally has no knowledge
about global mutable state like the_repository and so cannot default to
the main hash algorithm when we've zero-initialized a struct object_id.

The advantage to this Rust code is that it is comprehensively tested
with unit testing.  We can serialize our object map and then verify that
we can also load it again and perform various testing, such as whether
certain object IDs are found in the map and mapped correctly. We can
also test our slightly subtle custom binary search code effectively and
be confident that it works, since Rust doesn't provide a way to binary
search slices of variable length.

Changes since v2:

* Rebase on `master`.
* Fix CI failure on Windows by adjusting path.

Changes since v1:

* Use `MAYBE_UNUSED` instead of casting.
* Explain reason for `ObjectID` structure.
* Switch to `Result` in hash algorithm abstraction.
* Add some additional helpers to `ObjectID`.
* Rename function to `hash_algo_ptr_by_number`.
* Switch to `xmalloc`.
* Fix `build.rs` to use syntax compatible with Rust 1.63.
* Remove unneeded libraries from `build.rs`.
* Improve Rust documentation.
* Explain that safe hashing is about untrusted data, not memory safety.
* Add a trait for hashing to allow for future unsafe (trusted data) hashing.
* Rename `Hasher` to `CryptoHasher`.
* Remove description of legacy loose object map.
* Rename loose object map to object map.
* Update documentation for object map to be clearer about padding, alignment, and endianness.
* Explain which hash algorithm is used in object map.
* Remove mention of chunks in object map in favour of generic "additional data".
* Fix indentation in object map documentation.
* Generally clarify object map documentation.
* Fix clippy warnings in Rust code.

brian m. carlson (16):
  repository: require Rust support for interoperability
  conversion: don't crash when no destination algo
  hash: use uint32_t for object_id algorithm
  rust: add a ObjectID struct
  rust: add a hash algorithm abstraction
  hash: add a function to look up hash algo structs
  rust: add additional helpers for ObjectID
  csum-file: define hashwrite's count as a uint32_t
  write-or-die: add an fsync component for the object map
  hash: expose hash context functions to Rust
  rust: fix linking binaries with cargo
  rust: add a build.rs script for tests
  rust: add functionality to hash an object
  rust: add a new binary object map format
  rust: add a small wrapper around the hashfile code
  object-file-convert: always make sure object ID algo is valid

 Documentation/gitformat-loose.adoc |  78 +++
 Makefile                           |   5 +-
 build.rs                           |  17 +
 csum-file.c                        |   2 +-
 csum-file.h                        |   2 +-
 hash.c                             |  48 +-
 hash.h                             |  38 +-
 object-file-convert.c              |  14 +-
 oidtree.c                          |   2 +-
 repository.c                       |  12 +-
 repository.h                       |   4 +-
 serve.c                            |   2 +-
 src/cargo-meson.sh                 |  19 +-
 src/csum_file.rs                   |  81 +++
 src/hash.rs                        | 466 +++++++++++++++
 src/lib.rs                         |   3 +
 src/loose.rs                       | 913 +++++++++++++++++++++++++++++
 src/meson.build                    |   3 +
 t/t1006-cat-file.sh                |  82 ++-
 t/t1016-compatObjectFormat.sh      |   6 +
 t/t1500-rev-parse.sh               |   2 +-
 t/t9305-fast-import-signatures.sh  |   4 +-
 t/t9350-fast-export.sh             |   4 +-
 t/test-lib.sh                      |   4 +
 write-or-die.h                     |   4 +-
 25 files changed, 1734 insertions(+), 81 deletions(-)
 create mode 100644 build.rs
 create mode 100644 src/csum_file.rs
 create mode 100644 src/hash.rs
 create mode 100644 src/loose.rs

