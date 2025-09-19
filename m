Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31B1C84B9
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758244185; cv=none; b=fK0GsAubzNt5tV29xegr6peJgFmeSK+yzjaP3ELFEnr879/lZ6eodOCy1d0xHuaVVjqXRDD2IsCPhQAiGr9rEmAI+2tghrwESYVP0OOkJ8CaRZLfXWTKczRGsoGgpDwiLshOuNae6CSw5fduUtPT6fQUE7Yp0/11I3xnka5xr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758244185; c=relaxed/simple;
	bh=sL6ibFQRvZAr4YD1fv/GsI+ia53gkcegPpfR7W4gVs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0j8tjsqIF8W089+Ot5DYMRqyjEOxLKinebtXGonoitEwnQpdmbQ1KEXt/DVcnBDyhq3Fc1Cxp+E7cQk3J4O+9/Xtu/GXXOZtuHpmPtx9ea2+8+VZpERgB2rR3ZKVby6XXHHLXoXs15xJbBxIVpRtFg0KbiDOaVZ/etlqZ61byY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=JL4oDKjf; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="JL4oDKjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1758244181;
	bh=sL6ibFQRvZAr4YD1fv/GsI+ia53gkcegPpfR7W4gVs4=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=JL4oDKjfueeizIdUpH727nSitVeBK4EZMzyRbp3dUG2wPp+vgQZLSvMzvVd0CC8BY
	 SetZwkdsQwy6695xhJiPzL9xj4clzPyMmfDErXgTCzRY9PfYgMCO7sBueIr7WcCKWC
	 d4z6vV1hRzWQsB3PNlQhN3UPlpVdnz6ys1aMF945XqO3mkCtDaz94evLfEgPBczWI5
	 rL3ea0heHxIzhRD1jDY0vLm7avL54V8dOPk8tHX5oLRr3CcI0ldlB7ocL3WVOylVlj
	 eEC/OFKvl8k5cEI/aaw+DuFYSambgjFNHme2v3zJXvPDQ5OdE0VhSgqbrXPGG620wL
	 CXM2FN48+kHPPu8CviSMJD80OdqYfH4rdavDitjs5IPj7Kthdy0hXe0cIuijlwe8GN
	 hiHI5IHNWIH7MBqoEtRo3RvaQHioBaIP8JxsqjWJSpn4X9TArep+jrOk/MUramyv96
	 rblkrIdIJ0nvm/IXkEgiunHdp2UM+Ibn3ja5VmdmbXsey3bW873
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ada0:faf8:3cb8:a81f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 182E720105;
	Fri, 19 Sep 2025 01:09:41 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 0/9] SHA-1/SHA-256 interoperability, part 1
Date: Fri, 19 Sep 2025 01:09:02 +0000
Message-ID: <20250919010911.649831-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
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

This series should be relatively boring and noncontroversial.  The more
substantive, interesting, and controversial patches (in that they
contain Rust code) will require `ps/rust-balloon` to hit master and will
follow as part 2.  You need not clutch your pearls yet.

brian m. carlson (9):
  docs: update pack index v3 format
  docs: update offset order for pack index v3
  docs: reflect actual double signature for tags
  docs: improve ambiguous areas of pack format documentation
  docs: add documentation for loose objects
  rev-parse: allow printing compatibility hash
  fsck: consider gpgsig headers expected in tags
  Allow specifying compatibility hash
  t: add a prerequisite for a compatibility hash

 Documentation/fsck-msgids.adoc                |  6 +++
 Documentation/git-rev-parse.adoc              | 11 ++--
 Documentation/gitformat-loose.adoc            | 49 +++++++++++++++++
 Documentation/gitformat-pack.adoc             | 18 +++++++
 .../technical/hash-function-transition.adoc   | 38 ++++++-------
 builtin/rev-parse.c                           | 11 +++-
 fsck.c                                        | 18 +++++++
 fsck.h                                        |  2 +
 t/t1450-fsck.sh                               | 54 +++++++++++++++++++
 t/t1500-rev-parse.sh                          | 34 ++++++++++++
 t/test-lib-functions.sh                       |  9 +++-
 t/test-lib.sh                                 | 13 +++++
 12 files changed, 236 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/gitformat-loose.adoc

