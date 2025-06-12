Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2E14120B
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 01:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749690747; cv=none; b=kT8zpsiT4hbEu0iSDb3lxXUWGSfq230q5H8+EMpkFXWh5KkVtokNk48eMt1wKS+gdfiYm3Pt23F/fuPjiLVL8ZlpAb2RXwmEBTIgYAj7Mm29I0WnvIk3ruFzYm8iG1+4ferTT4bZA1cXBnxIQfxjU/5pyPT3P4TnsDKAdPR+G+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749690747; c=relaxed/simple;
	bh=qH3pFY8oLdwRq9YTJO85YHe6mDATHPBQc7jH7Ysm3CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwZoGhj4PJyzioergz0jwyWJ0z08ybTQiyuGJFHPbB7/SdPvSKLRbaGo4A7k/epp4sJ1KdAUn/unhJQSuxw92wz6GbF7AyndVb51A4CMaJhu4AvdGR4WAkM256eUtGdm59/mjClKsIOO6m06ecmJW9iF8iiZhBcUUcCpCQ4T+Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wtSHgstD; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wtSHgstD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749690743;
	bh=qH3pFY8oLdwRq9YTJO85YHe6mDATHPBQc7jH7Ysm3CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=wtSHgstDbAxiVV+AHB9fMqYOgAwyg73gf7pgUEYOCkuMQ+IKDyqFq+F0iXdH/OzMI
	 cycSK761CPyXTT5NFGLXXm5QVao4fMF3X4rX+/7+y8Aq31Rieopp/Jnj6ZGGRg6hkP
	 Ngru0I5/pqwcrODNh8H2FlCxQjbtJMKqeDhOBphw5Ju+1/9/MZArMJyXbYwRgpr0rW
	 FAnYlXnavqvub4RfGrXbosD3dZBaIJKmk1k6+HyLxwOZEQirtc0NLwTXyOzi3vXY5I
	 I09rrRV24MYI5feuQ7hdKygSQSE4nos5ra126pWcvT5eXxP52Pw6s761i1JiEHAHur
	 zXeyS/au+TAw04ntuK4esCRhCpA23Va1zpMiukSEsqocQuX4ykR/CuPEG9Xn+TRGF6
	 LK2eUGy+JNrmrntkmenvGekEQtKzOzKRDXrhGE3aequ4GhzNDCgGOTc3iUUJivoKoe
	 0fkX50BbxjooF4lu+Yur6yx16yYlu9oBZAPXk8UjltBoHlyj0Tt
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id CF54F200B0;
	Thu, 12 Jun 2025 01:12:23 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v8 0/4] Importing and exporting stashes to refs
Date: Thu, 12 Jun 2025 01:12:16 +0000
Message-ID: <20250612011221.4158484-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.rc0.567.gd817f1499f4
In-Reply-To: <20250601223225.464076-1-sandals@crustytoothpaste.net>
References: <20250601223225.464076-1-sandals@crustytoothpaste.net>
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
to easily move a set of stashes across machines.  For example, groups of
stashes cannot be bundled, pushed, or fetched.

Let's solve this problem by allowing users to import and export stashes
to a chain of commits.  The commits used in a stash export contain two
parents: one which is the pointer to the next exported stash (or to an
empty commit with no parents if there are no more) and the second is the
stash commit that would normally be stored in the reflog.

Original thread at message-ID: <20220310173236.4165310-1-sandals@crustytoothpaste.net>

Changes from v7:
* Rephrase the documentation to be slightly more explicit.
* Don't have `write_commit_with_parents` free its arguments, instead
  letting the caller (who allocated them) handle them.
* Handle invalid combinations of arguments to `export` and add tests for
  this case.

Changes from v6:
* Add Phillip's sign-off to the last patch.
* Use `commit_list` for tracking commits.
* Use reflog entry walker.
* Fix some commit messages for improved legibility.
* Rephrase some error messages for precision.
* Drop the patch that exposes `read_complete_reflog` since it is no longer necessary.

Changes from v5:
* Rename `parse_revision`.
* Remove extra call to `free_stash_info`.
* Fix parsing of existing commit.
* Add more validation of imported stash commits.
* Add more tests for improved validation of imported stash commits.
* Explicitly cast `items.nr` and make the iteration counter an `ssize_t`
  to avoid casting problems.
* Don't require a trailing `\n\n` in commit messages.
* Use `read_complete_reflog` to walk reflogs.
* Be more defensive when using `lookup_commit_reference`.
* Apply parts of Phillip's patches for improved robustness.
* Update commit message to explain additional use cases.
* Use `OPT_STRING` for `--to-ref`.

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
 builtin/stash.c              | 460 ++++++++++++++++++++++++++++++++++-
 hash.h                       |   1 +
 object-name.c                |   6 +-
 t/t3903-stash.sh             | 101 ++++++++
 5 files changed, 584 insertions(+), 13 deletions(-)

