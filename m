Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC6D30DED8
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761526437; cv=none; b=DF/4Dxa7dFpA233r9lglDV/2mMb3FKYK+5I+VahujWQbfKdjCQ2zMSiVJtvzZ3J6QmXuZ9IJWMvLAOw2L0JSnLtJkPhXfPKsVPMm9CttcwRpEVBLMHCLGBrWRLqNyF1dOOPRWsJo2NqoIdoG7bCgonxjQP/YZVECH4Iwo8MFeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761526437; c=relaxed/simple;
	bh=ZR+LX/KQFmf6QYzRWzZNY/xen0x312fcjt4C/TW7qNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvfpVDkOsVarWIU2rv0J7NTPK2CO8hgojb9DOgTRAj+K/jyt+R0draUwBAz6aMsQ+s6T+TArGbR6OBzKCeJBqWwXOFO1EOz+3qqhEP03X7VgmMZjjR6uh7PPOoly0hkecgoCCJqGt24VKrm7cV/956+OrRvtdc9/mn7J4KtyCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=mQCYrNaP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="mQCYrNaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1761525867;
	bh=ZR+LX/KQFmf6QYzRWzZNY/xen0x312fcjt4C/TW7qNM=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=mQCYrNaPl3oNjmOJnn+ibQUyz6YfNkCDcrffkzTzDR5WYQSQCDsYHxh7fuYq1gi53
	 JJQMQbfFS6L6QO0pkPFQB6HMgENypkjXUc5bFq26CooZIeliLPn0VaSRrwGKH3/F3H
	 lFdFwY93rGa9U3bOACZwZNuxmrc44VzMi8xL+bwIaynhHHRZ6vWr6vgIEYAZCukfkz
	 kp19QWgXXQD/E5ZSXUfTB3L5QRucgnNoEKSMk8GNqC3lbvJQKwyndugFCuEJr3fuho
	 0lp+GnuFG1tzitcHL87FTL+tFkz0V97Etb/Lo/g3bqV1Ca3Ucyjr2oECm/ltZZSCOX
	 xI0pVK3QxvA1hWDxGDI5HfsgdKRKwylTAzIaEP7OGT9ozkqoK0q0m2bOFZZNs4ArtR
	 E2Hk4/P9/1fRdup565LIl4W+pST/cC9AvIVnAOQRoviF1lMs5GUc2Q7vo4TC+bWIxC
	 mDWGinkkTL/sJo+AVoY8dJgL+KFHtbUDFzpesE/zZUP/bweXrlX
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5675:b769:afe:3fa2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 788EE20036;
	Mon, 27 Oct 2025 00:44:27 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
Date: Mon, 27 Oct 2025 00:43:50 +0000
Message-ID: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the second part of the SHA-1/SHA-256 interoperability work.  It
introduces our first major use of Rust code to implement a loose object
format as well as preparatory work to make that happen, including
changing types to more Rust-friendly ones.  Since Rust will be required
for the interoperability work, we require that in the testsuite.

We also verify that our object ID algorithm is valid when looking up
data in the hash map since the Rust code intentionally has no knowledge
about global mutable state like the_repository and so cannot default to
the main hash algorithm when we've zero-initialized a struct object_id.

The advantage to this Rust code is that it is comprehensively tested
with unit testing.  We can serialize our loose object map and then
verify that we can also load it again and perform various testing, such
as whether certain object IDs are found in the map and mapped correctly.
We can also test our slightly subtle custom binary search code
effectively and be confident that it works, since Rust doesn't provide a
way to binary search slices of variable length.

The new Rust files have adopted an approach that is slightly different
from some of our other files and placed a license notice at the top.
This is required because of DCO part (a): "I have the right to submit it
under the open source license indicated in the file".  It also avoids
ambiguity if the file is copied into a separate location (such as an LLM
training corpus).

brian m. carlson (14):
  repository: require Rust support for interoperability
  conversion: don't crash when no destination algo
  hash: use uint32_t for object_id algorithm
  rust: add a ObjectID struct
  rust: add a hash algorithm abstraction
  hash: add a function to look up hash algo structs
  csum-file: define hashwrite's count as a uint32_t
  write-or-die: add an fsync component for the loose object map
  hash: expose hash context functions to Rust
  rust: add a build.rs script for tests
  rust: add functionality to hash an object
  rust: add a new binary loose object map format
  rust: add a small wrapper around the hashfile code
  object-file-convert: always make sure object ID algo is valid

 Documentation/gitformat-loose.adoc | 104 ++++
 Makefile                           |   5 +-
 build.rs                           |  21 +
 csum-file.c                        |   2 +-
 csum-file.h                        |   2 +-
 hash.c                             |  46 +-
 hash.h                             |  38 +-
 object-file-convert.c              |  14 +-
 oidtree.c                          |   2 +-
 repository.c                       |  13 +-
 repository.h                       |   4 +-
 serve.c                            |   2 +-
 src/csum_file.rs                   |  81 +++
 src/hash.rs                        | 335 +++++++++++
 src/lib.rs                         |   3 +
 src/loose.rs                       | 912 +++++++++++++++++++++++++++++
 src/meson.build                    |   3 +
 t/t1006-cat-file.sh                |  82 ++-
 t/t1016-compatObjectFormat.sh      |   6 +
 t/t1500-rev-parse.sh               |   2 +-
 t/t9305-fast-import-signatures.sh  |   4 +-
 t/t9350-fast-export.sh             |   4 +-
 t/test-lib.sh                      |   4 +
 write-or-die.h                     |   4 +-
 24 files changed, 1619 insertions(+), 74 deletions(-)
 create mode 100644 build.rs
 create mode 100644 src/csum_file.rs
 create mode 100644 src/hash.rs
 create mode 100644 src/loose.rs

