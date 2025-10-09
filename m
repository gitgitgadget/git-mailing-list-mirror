Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C35323536C
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760046998; cv=none; b=KZ1QMqtfXE/p424QahG+Gvt/kc0nOXRgB2CmO64//096SNlmIpkBMMBWCgBHCVujaRk16T2LjMCsHNP/OUpob2lLKkCY4uVbHS+QhzcDtow3o8ekQsTnXXroQeAYSe+D3imp+0yiLPTvp9m6KnzZu5v4i2iEizd7SIDRjxzCl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760046998; c=relaxed/simple;
	bh=WdN+n44coflDJLjvdgMepgw5sBSQYcr4haTfhi+ULCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f75UtWobxKqs2ZqCdx/81FQeaxAoDoPemKhinGEFYt96DwvSt5Kgcd4Zs39bCXPRaQAw5cB9+bFBTZg3XC8PfZ1XogGhD05nLX7X400BF7Oa44FnMomJ0eW2BI2cbnM4S6E2PM4MFvAEJq31JjP3lN5QXajmPxgc6x4QCy4VzYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=II0fzDnG; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="II0fzDnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760046989;
	bh=WdN+n44coflDJLjvdgMepgw5sBSQYcr4haTfhi+ULCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=II0fzDnGzL54KPIsUwQPdU5iPIUmjiBIHtDSI8AUjM9sUkKD3Zs3f0mroViByqp5Z
	 8tCmHnipFCGPITc2z3R4paLuaBdoDdfdus35cFSXFvmkaWMqh813+0eKn2BrZHB1uJ
	 rp6q1TERygmYmfHeOHJ4wQ1SJMwWR/MgUNb2b7+ylfUniu9wFhmXDA1W5lm+N+6fwr
	 oSlrIhvSsIRI45HHMrOId2xZEEcOarJg2CRmur2wgKUya0ZFPNJcCXh/tT0P21ztgL
	 fsgeX3XDZ+PqhAeQddL73V275DqMm0que9X1eyn63CS7qjvvTTcdyVjqs/01ZOK2eB
	 fkDXGiip3C1RvjGijr2kx4q5wi3BUTCialgrDVdIUspXa+1YupZGJ6Wb1NWMSAwdXT
	 nDtf4W+/MpTdN72g/FgvVIO1stJqFP7RdHpj14aohyuxk+jtvIF2VgeyhIDF55YUP6
	 z5oPp++jL4+4VgtBHJE9stgbmRkl3q57OHsCB79GZoUMv7BE3FQ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d7d2:5118:6dfb:100f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5D67C20114;
	Thu,  9 Oct 2025 21:56:29 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/9] SHA-1/SHA-256 interoperability, part 1
Date: Thu,  9 Oct 2025 21:56:17 +0000
Message-ID: <20251009215626.3089287-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
In-Reply-To: <20250919010911.649831-1-sandals@crustytoothpaste.net>
References: <20250919010911.649831-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the first of several series for SHA-1 and SHA-256
interoperability, all of which will hopefully land in Git 3.0.

The first set of commits here is documentation updates for documentation
which was incorrect, missing, or simply wrong.  I have spent more time
than I'd like in the pack code and felt our documentation there could be
more helpful.  I also am correcting some things about the
interoperability formats that I've found are not correct or efficient in
terms of implementation and thus I will be implementing differently.

The loose object documentation will be updated with the loose object
mapping in a future commit, but I felt I should send a basic loose
object document first, so here it is.

The remaining commits are for expected gpgsig headers in tags, which
causes some tests which use strict fsck to fail, as well as for
prerequisites for compatibility hashes in the testsuite.  Actually using
this configuration is not possible since the tests are still very broken
using it, but declaring these prerequisites allows me and others to send
in patches that use them and thus make our testsuite more resilient.

For example, in interoperability mode we cannot write objects that
are not valid since we cannot convert them into the other hash
algorithm.  Thus, when we're testing in a mode that has a compatibility
algorithm, we skip these tests.

The goal is to run the tests in a full compatibility mode where
everything is dual-hash as well as introduce some specific tests for
interoperability that run in all configurations of the tests.

Changes from v2:
* Improve the language slightly in the pack documentation.

Changes from v1:
* Squash the two test changes into one commit.
* Include a new commit showing the use of the BROKEN_OBJECTS prereq.
* Mention using main algorithm hash in pack index v3.
* Hopefully clarify signed tags.
* Improve text for pack format documentation.
* Wire up build of loose object documentation.
* Remove loose object map documentation.
* Rephrase text about loose objects.
* Remove needless RUST prerequisite.
* Wrap overly long line.
* Reject invalid signature algorithms in tag headers.
* Fix if/whether problem in test comment.

brian m. carlson (9):
  docs: update pack index v3 format
  docs: update offset order for pack index v3
  docs: reflect actual double signature for tags
  docs: improve ambiguous areas of pack format documentation
  docs: add documentation for loose objects
  rev-parse: allow printing compatibility hash
  fsck: consider gpgsig headers expected in tags
  t: allow specifying compatibility hash
  t1010: use BROKEN_OBJECTS prerequisite

 Documentation/Makefile                        |  1 +
 Documentation/fsck-msgids.adoc                |  6 +++
 Documentation/git-rev-parse.adoc              | 11 ++--
 Documentation/gitformat-loose.adoc            | 53 ++++++++++++++++++
 Documentation/gitformat-pack.adoc             | 19 +++++++
 Documentation/meson.build                     |  1 +
 .../technical/hash-function-transition.adoc   | 42 ++++++++-------
 builtin/rev-parse.c                           | 11 +++-
 fsck.c                                        | 18 +++++++
 fsck.h                                        |  2 +
 t/t1010-mktree.sh                             | 13 +++--
 t/t1450-fsck.sh                               | 54 +++++++++++++++++++
 t/t1500-rev-parse.sh                          | 34 ++++++++++++
 t/test-lib-functions.sh                       |  9 +++-
 t/test-lib.sh                                 | 13 +++++
 15 files changed, 255 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/gitformat-loose.adoc

