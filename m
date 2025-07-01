Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EDC280303
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404966; cv=none; b=d91zMy53sn9rqEw4IOxr2AAHzggkxDjd34PSCMhIkLS5C6z+TsS5ccz+Y4mJ1mvV5VrjKK57LBd8VsZjl7wIEWy7LX+mfArX51SnLoX6AAwqj3LqFAk6bzu9aMxur/NRExHf0k2uxCdtglfrEjqPPH9M6nLe/h9cqjTE2vCyGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404966; c=relaxed/simple;
	bh=ntkBGqHcUTqQZO5dDLn5TxzoofWtvvQNXCfaEfbFKvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSO2LQ4xZ0I8tW53LozDC54jsNy7rGoZG8T5qQc+67j3YVfr5tABaxuTns/aWXTqmybZQkQEyGdCtZFK2UemRF9LA8x04i+/vgYkzC6KrxW7tGSDykVEiD9/1hN927XpWlqmZh5Sa9oIhw1UxgihMbeszf0l1B4ZfRLf3kQj2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fg7Btied; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fg7Btied"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751404962;
	bh=ntkBGqHcUTqQZO5dDLn5TxzoofWtvvQNXCfaEfbFKvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=fg7Btiedw99LVs/gcC2HJUkAUYED3prT6XzlmyhGANj7uWLulXYCiAHIdJXS+dFeP
	 Btn5X9pzyoiFQN8zcqfUgEQBckrr2lggDMD5e56YAGhai3sWHWhheKi1MTQfC2ECVS
	 uba+CBWl2wbF3Q8v1kwLDSRlORdKDQqWY0TWqNIaM7uu/RixyRJ8T0N7yRqojp8yDF
	 UBm5QRAHyGZ0c3VHZqd5UpkHkODQ76rXjdsyhQItF0E0nz6o6VRaXO550teEbWnDlV
	 u1PCGOddMVukEjM68/dVTmDmboeqj4r3Mvkcl6FkTywjcB4fUc1ZQpAnsE4uktLpwf
	 Nqly1ea3vEb7O5gwEJRYuep4Z67qscw4Qt3d3D3vTnnc6yYf7kAGmieuxVm8aGnmeL
	 mwrgeW9i0ZcDQinOIRWvHdbhI/vKB//YbeBL6jJj/alQspiVLo5F6qHZVMiPBtf3Dj
	 qLwu1E2ivYdTPI7XIvyfqFRsx6LNk40VyJNK1v9LDJY/bthWdGt
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:80e0:3dab:863b:d3a0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 343E22003B;
	Tue,  1 Jul 2025 21:22:42 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/11] Add SHA-256 by default as a breaking change
Date: Tue,  1 Jul 2025 21:22:26 +0000
Message-ID: <20250701212237.766774-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
In-Reply-To: <20250620011943.586596-1-sandals@crustytoothpaste.net>
References: <20250620011943.586596-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Our breaking changes document outlines that Git 3.0 will make SHA-256
the default hash algorithm, which is a sensible and prudent approach,
especially from a security perspective.  However, we haven't tested this
adequately and it would be helpful to allow users to test this behaviour
so their code and environments are ready for it.

Fortunately, c5bc9a7f94 (Makefile: wire up build option for deprecated
features, 2025-01-22) introduces a build option that we can use for
testing breaking changes: WITH_BREAKING_CHANGES.  This series introduces
functionality for SHA-256 by default in this mode so we can test it out.

Changes since v1:
* Add a build option for the default hash and use it in the tests.
* Rename GIT_HASH_ORIGINAL to GIT_HASH_SHA1_LEGACY.
* Improve some of the commit messages to better explain questions that
  have come up for review.
* Improve formatting of nested C preprocessor directives.

brian m. carlson (11):
  hash: add a constant for the default hash algorithm
  hash: add a constant for the legacy hash algorithm
  builtin: use default hash when outside a repository
  Use legacy hash for legacy formats
  setup: use the default algorithm to initialize repo format
  t: default to compile-time default hash if not set
  t1007: choose the built-in hash outside of a repo
  t4042: choose the built-in hash outside of a repo
  t5300: choose the built-in hash outside of a repo
  help: add a build option for default hash
  Enable SHA-256 by default in breaking changes mode

 builtin/apply.c                  |  2 +-
 builtin/diff.c                   |  2 +-
 builtin/hash-object.c            |  2 +-
 builtin/index-pack.c             |  2 +-
 builtin/ls-remote.c              |  2 +-
 builtin/patch-id.c               |  2 +-
 builtin/receive-pack.c           |  2 +-
 builtin/shortlog.c               |  2 +-
 builtin/show-index.c             |  2 +-
 bundle.c                         |  4 ++--
 connect.c                        |  6 +++---
 fetch-pack.c                     |  2 +-
 hash.h                           | 10 ++++++++++
 help.c                           |  1 +
 pkt-line.c                       |  2 +-
 remote-curl.c                    |  2 +-
 serve.c                          |  2 +-
 setup.c                          |  9 ++++++---
 setup.h                          |  2 +-
 t/t1007-hash-object.sh           |  4 ++--
 t/t4042-diff-textconv-caching.sh | 12 ++++++++++--
 t/t5300-pack-object.sh           |  6 +++---
 t/test-lib-functions.sh          |  5 ++++-
 t/test-lib.sh                    |  7 ++++++-
 transport.c                      |  2 +-
 25 files changed, 62 insertions(+), 32 deletions(-)

