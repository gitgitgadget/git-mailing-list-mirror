Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367430103D
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417789; cv=none; b=O73pCUf1/ZakzLrkgRU4qMwaDGtEG7Hrt+EMz7liHGyj3H1OXLvw61BjWIDawq72Wut2hNFrwAUwAnbKbvvLZBa4xpjP8/5jqLJriQDfdUES5j4mytxrX8xtRGv0Ajaq4tAKq9hOWRf79Zo4RRWWSEgQglCgwJll+/DhDIQNLV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417789; c=relaxed/simple;
	bh=aq69tl4g3kmR/3Wd8IMeiJpFjK+VeusFhu3fwkARu0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZOD8hhVdkreY3GEjHuyGrZ6G6gDjQiKmqH0wq1nJfhvM4OdspOxg11gF0MrP/T/q7tTMQ3tJSLFDc3SMIGywm9/iZE/5HAMORBNHfn2bVuOlpI3D76cxQKFWTcU8mmcjaLau9FcqURJAUfJ2/VWlmWQuakhkpekcwtj0QOG8xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ip+ZRBcG; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ip+ZRBcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763417785;
	bh=aq69tl4g3kmR/3Wd8IMeiJpFjK+VeusFhu3fwkARu0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=ip+ZRBcGa12tvuZZyXphL009+kqufUECRdJLvxlwWvfgCh0gOwCbSrVBTr1ifWoK4
	 iRJSRQqYmCA305szHLBoa0sXf5FoqwJiyB06s5sdHB/bIpiXt+TFWzOQH9F+5b6+u8
	 LXLHag08UisYHyV6Yo7+QVfHmiN2xiwC+nLz3rS3yBgl/yoncYaK5cf+OEWi+n4RG+
	 LfruM+2ZjzywYt2Ag0B0yOaPAOn+eGtmlWE06pul6Nqv5oEC5WhZyFIsKxJJ5TCZUO
	 9c9G9c4NDoRMPgltnPm+qn+CLA34B8evnbQpsDMxfuA7Nv43rPwbKOx1fo2TDm7kcP
	 FPIQt9CFqehg8E95/5gi9Iui9TxcvNWQobUcRtvfPOvrWrVGk7PWkHo9pO0bjY9rNm
	 A0DBzJLibLtnjTHxS0Tl7GoRhqulPbC5R8C7PC7bObgPTzFqEctsHhRub4ZSCz8ZnS
	 HIrXD+6Pr2Oon/S8jfhmbwM9fVfiQohOPyTTlG1scFFA71jsePH
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b6c6:bf88:c872:dae4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E7EB120065;
	Mon, 17 Nov 2025 22:16:25 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH v2 00/15] SHA-1/SHA-256 interoperability, part 2
Date: Mon, 17 Nov 2025 22:16:06 +0000
Message-ID: <20251117221621.2863243-1-sandals@crustytoothpaste.net>
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

I have opted not to use an enum type for our hash algorithm and have
preserved the use of uint32_t from v1.  A C enum type would not map
one-to-one with the Rust type (since the C version would use
GIT_HASH_UNKNOWN for unknown values and Rust would use None instead), so
to avoid problems as we generate more of the integration code with
bindgen and cbindgen, I've chosen to leave it as it is.

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

brian m. carlson (15):
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
 24 files changed, 1722 insertions(+), 74 deletions(-)
 create mode 100644 build.rs
 create mode 100644 src/csum_file.rs
 create mode 100644 src/hash.rs
 create mode 100644 src/loose.rs

