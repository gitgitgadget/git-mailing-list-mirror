Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB5DF58
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748817168; cv=none; b=LAwAdu51x0Z2y21vNbAnGZAEMLLdyLsuvNOjeMuURY/w990twJDaKZApov2Zaw2nF0EqaPHJFSJucRQ193ZYJFhOyGwtPWMYB+fGDFJaWH7WSqFoRnNXf8j9OChWScJeJZOAbi9tRM55skPirmqNwiMZf7PRBLYZNBEzIsMkovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748817168; c=relaxed/simple;
	bh=u5c3JMi6tnD57CeN8B0aoFeSIHUsEQd38Ds057MN+90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJg6IZncTUSBtHgXXngDclBfvUTsPQmYUCuMs4eG+wmaIDao0TdHZjLz7rUvHmjpkg8Y1ytJyVyiKaL4NddLVjm4XdY3hHCHOkvznOtsjvXt5I31UFraCi8diYcu2oJecPmmHvYBbiWj+PrOF8fJZLhGmRgpM5ksCCK1iGgk0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=vc5DvkOl; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="vc5DvkOl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1748817157;
	bh=u5c3JMi6tnD57CeN8B0aoFeSIHUsEQd38Ds057MN+90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=vc5DvkOlKu0GwQabY+gpibi58PTXjPVXM3gRqcswMY+wWJA1uU+nnGUb5zPnssXc+
	 /peMGFfiUuybfEFHTlCGAyOqQn+1GK4iU1YVw49clIi7WOETKZX7eHQVSt7lBSjmEO
	 w0RvhWofTu3/oDMJItqD9FO23ApYC0xlzPdbjLChpXG1VJZEJ2h42onCJwI8aPW2km
	 IHnHy2CIftk/F57MZi3dFaycaY7pi5eCQCohKs6YYpwF3ETBGba/1KBp1qGvEaeDNF
	 qvRVfuNcpbT0EmMIr/JIOmUuF4ugV+7Z7nK1aaG/kiJYGDaDjg7+NPWRL0093a/Rtg
	 ozsHyfcDhZmX4CXAbd40p21G5ZMcx+5iQjdRxz/Wg2l/dFlVrVk7IYH8svuLVi/3/F
	 WsvnPVB6cq9MrEQ2Rl9nLZzOW69MIonewjVmTSfEuOWfxAGIcq0qRYJAio2GMtxvfk
	 HfFniXCcNWyqQXVnD0E96LMrQE2blbTzVd4P4oiZ9LClXwihQum
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B900A20039;
	Sun,  1 Jun 2025 22:32:37 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v7 0/4] Importing and exporting stashes to refs
Date: Sun,  1 Jun 2025 22:32:21 +0000
Message-ID: <20250601223225.464076-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.rc0.567.gd817f1499f4
In-Reply-To: <20250522185524.18398-2-sandals@crustytoothpaste.net>
References: <20250522185524.18398-2-sandals@crustytoothpaste.net>
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
 t/t3903-stash.sh             |  94 +++++++
 5 files changed, 577 insertions(+), 13 deletions(-)

