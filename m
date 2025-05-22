Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFBD1E0B9C
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940178; cv=none; b=WMWYrrZbM91waAfsGCUS1pr7QwAtBJFu+dOZowr+o60v2S8QvMx27CoBZ+yfW+0XH7Hi1RrrPMv5CaC+dmaWWAsv30+w938+7tT4VoOUERZy/9RGVArJyEQp6J10oK4Pr0BnmPnX45QY0ubNeOCixCA57FmIZz5FZLNOQmUiy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940178; c=relaxed/simple;
	bh=t4xBtxt2QlcbvG8geT38QUX7KCBXjs8fYqQjZG4ancU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFH03SAEvjb8QMBLhvZ4Aa54lU2+nvq2Y0IoyXC39Amip6foLW/mIS59kQa1s2zn3FsbtI0V0Fk3Al7AgSq6skOZsx7B4IsKQ37ctEcbJNszDYwhcG6Hp2XV1Znuf5Hx/vjmPAly9eRkuVe4kPvOhuqM295Gi/CIKWYHuhmcxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=K4xtKAy4; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="K4xtKAy4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747940174;
	bh=t4xBtxt2QlcbvG8geT38QUX7KCBXjs8fYqQjZG4ancU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=K4xtKAy472wrCtqtv+d+6gP4xM3LkdrWdfPI9jKpJfhjfUQaQX/V8luGispf3MYsK
	 uqxRZHBurWXD4+Q3pp9BmduJP/HzcIgi4gDZdvHFaTa53wa19mYQ6e5C3vmVVKKiP/
	 8xEw29B8lqGoYJfNxVswvRVR+/SzlqepodL0GMYZDxJasQAuAQuDa8uRfGzlLxv3kY
	 MPbg3ABMic2AQeQM9UMG6cvEfgA7nGujqDt9igVvFsbEOFAzOm8/kdXMQieuJ3DnRe
	 VgFquWcqMIA9dV4mWj9o4hfnKHibLVW8pjAJyq9vaDBjAGCfxtxJ6awucBwpFjFnwn
	 pZ9wcu9lGytlQ8rERL/yGqFGOCYvnXswyQoHl/kqP11AlToDGUHrupSsP1WMLN13pL
	 aE0Sp6g7My349Q0EBbpufQDgxKN8rN866m6v6F5StXnJTgnc6gdTUYr4i+ZvC26oHV
	 Qr5mK2W0eJruEHrpvV+BDVzGGqmi2HfFNvKxS9cbw5SOc8r2/FH
Received: from tapette.. (unknown [104.129.158.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 267E02018A;
	Thu, 22 May 2025 18:56:14 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	pwodd,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v6 0/5] Importing and exporting stashes to refs
Date: Thu, 22 May 2025 18:55:19 +0000
Message-ID: <20250522185524.18398-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
In-Reply-To: <20250522185524.18398-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
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

I will need Phillip's sign-off for the last patch, since his fixup patch
didn't include it.

Original thread at message-ID: <20220310173236.4165310-1-sandals@crustytoothpaste.net>

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

brian m. carlson (5):
  object-name: make get_oid quietly return an error
  reflog-walk: expose read_complete_reflog
  builtin/stash: factor out revision parsing into a function
  builtin/stash: provide a way to export stashes to a ref
  builtin/stash: provide a way to import stashes from a ref

 Documentation/git-stash.adoc |  29 ++-
 builtin/stash.c              | 450 ++++++++++++++++++++++++++++++++++-
 hash.h                       |   1 +
 object-name.c                |   6 +-
 reflog-walk.c                |  17 +-
 reflog-walk.h                |  18 ++
 t/t3903-stash.sh             |  94 ++++++++
 7 files changed, 587 insertions(+), 28 deletions(-)

