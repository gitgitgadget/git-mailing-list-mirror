Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4542343BE
	for <git@vger.kernel.org>; Thu,  8 May 2025 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747913; cv=none; b=LVtGlJlU02RNs1SL0RAcNfJA3DknOR7Rx7xWtkXcD/qZQRPs/O6zzHSh7u8KWZDb6stjAf1569je9+nQq+iGhqEpoC0ArQlkL9sCpN2iHR87Alv932DmUaKmpllgqg60dQ7KcbBSkePtApHKtGgUYDWZLwwEMlDZ8UpEg7Xfupo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747913; c=relaxed/simple;
	bh=cP8y9h7DL6mYnUCyVB4NdaVWXyNlMxlVLZqScHX+tuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J2KHDq4YtPmcO/XVZN5r8dE2YopYqFvRBwBBHNGYA3Y6pEmime/Dv50Jke5AxkdobI4su31dvQxsL2/sq06v10lO76nwQrT8hymcfK0SdI8OvsKevGcu1mGbSRjS8w4qQlvbq9X6gKvydr+dw4L30FjtHoyZcsSqNbVvtOkS4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bn6/AbZj; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bn6/AbZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1746747903;
	bh=cP8y9h7DL6mYnUCyVB4NdaVWXyNlMxlVLZqScHX+tuA=;
	h=From:To:Cc:Subject:Date:Content-Type:From:Reply-To:Subject:Date:
	 To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
	 References:Content-Type:Content-Disposition;
	b=bn6/AbZjUDXNpDuU6gXbFK6KAb9+ZM41Ap4GBYrr0jo89xJLWk6CeOt/dApJc4VHJ
	 PVhRw3jO9U0Os2R9Ukk/terskytcNEFMAa1kew7Ddr+lMz1oNGMDBiCa5mBIuoSBSx
	 tOitGMj2737BRkXu1Jx1v0HERwMqRSAY5Oud89P/cNAyZnAkP8cAyLgo74t71tvcNE
	 qMtbDJuf+xjcEcWG+eDhB5ruoCcpFlj3D0P5hcy64e1a/m0HmlxEqYes7/g4HXrR3L
	 n4mK/Ep0QLNX8MbHP5cBuZ5wjm84BRjye0MGIaGvt5eDcdoCV6FNqv9R3i9x7bqFQZ
	 4QuqtTpY4PWMKWQhdIdsHVxoTvTMsPZBTljWAkPn47kHTJ5fFdudFw2STXZ3BKo6aS
	 AhC8hLKr0d4qcUXxpmzcwEALQhW/jXXa5FypfR22dWQAtu3b+vuPHruj1wczKfzd4G
	 4VMsWW+K7y+TNxQfTqTOAAqbyUlzpSiRQJId6/vielUULu3YvAl
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DC4CD2011E;
	Thu,  8 May 2025 23:45:03 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v5 0/4] Importing and exporting stashes to refs
Date: Thu,  8 May 2025 23:44:53 +0000
Message-ID: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Stashes are currently stored using the reflog in a given repository.
This is an interesting and novel way to handle them, but there is no way
to easily move a stash across machines.  For example, stashes cannot be
bundled, pushed, or fetched.

Let's solve this problem by allowing users to import and export stashes
to a chain of commits.  The commits used in a stash export contain two
parents: one which is the pointer to the next exported stash (or to an
empty commit with no parents if there are no more) and the second is the
stash commit that would normally be stored in the reflog.

Original thread at message-ID: <20220310173236.4165310-1-sandals@crustytoothpaste.net>

Changes from v4:
* Fix another use of oid_array.
* Fix various memory leaks.
* Fix a segfault which appeared after a rebase.
* Use strstr for commits since we don't need to worry about NUL.
* Added some additional tests.
* Verify the ident values we're using to avoid using bad values.
* Various other code cleanups.
* Rebase on `master`.

Changes from v3:
* Fix strbuf handling to avoid leaks and generally be more sensible.
* Make use of the error return code more often.
* Use oid_array.
* Tidy various parts of the code and fix long lines.
* Simplify tests using git tag.
* Shorten and tidy tests.
* Add an additional test covering the base commit OID and importing and
  exporting empty stashes.

Changes from v2:
* Fix uninitialized strbuf.
* Avoid C99-style initializations.

Changes from v1:
* Change storage format as suggested by Junio.
* Rename to GIT_OID_GENTLY.
* Remove unnecessary initializations.
* Use ALLOC_GROW_BY.
* Ensure completely reproducible exports.
* Avoid size_t.
* Various other code cleanups.

brian m. carlson (4):
  object-name: make get_oid quietly return an error
  builtin/stash: factor out revision parsing into a function
  builtin/stash: provide a way to export stashes to a ref
  builtin/stash: provide a way to import stashes from a ref

 Documentation/git-stash.adoc |  29 ++-
 builtin/stash.c              | 339 +++++++++++++++++++++++++++++++++--
 hash.h                       |   1 +
 object-name.c                |   6 +-
 t/t3903-stash.sh             |  78 ++++++++
 5 files changed, 440 insertions(+), 13 deletions(-)

