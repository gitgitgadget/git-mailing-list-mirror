Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC70D2AD16
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382398; cv=none; b=WR2ikJ2Ahsk99NmBdLrnuyqEzjcv7vOgLHA6q1mR/IjplEcpaXwzcLoSHnzhnuWgOlQ3Ag+Vd24iC4oyqJtEgcD56BsTv/tcDg7KnSwdUYrw6rku+/pPA+r5+wQ5Cd1lp7UTUB45htQSVzL2y2csCZgh9FbwKA/3VzxhWkiuw70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382398; c=relaxed/simple;
	bh=B4/UQIK4moUZ22sHo1CtGB7OtY7LZtG/rgD4ZG0HlYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcAe0yITvtfPAE3xi2tlEfL3Xzhf+LITMDaN+GSW2K8VL6oofMgvvr2EKusgtsG3PExS7HDtIjT8zOk1t6AHw51gZ6kT/lSGcDO63bRkEBLASA1RD7Z6mi6RgHtCnHcaCcG0jlIWQVIT+IXhDKZSemJDvrNu6/TNPnGBj10InJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=xSehjw3G; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="xSehjw3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1750382394;
	bh=B4/UQIK4moUZ22sHo1CtGB7OtY7LZtG/rgD4ZG0HlYE=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=xSehjw3GQIqARejLwRIA485Cx+30rIqv+h0HApdFl++egwhNWG8n4rew36OYK3zc+
	 nQU8e04C90eACIhiAPEg7vtVDE4oIFaN81HGWXWy/a/ondKyz62RSDbBxNHNDKmJ1X
	 UKK3iBzzPkaGJNg10D3olWUZ2VypimcwQlMhIPvGyd0UV0T2Mtx+zFTi7Uf/M3iNl3
	 SZ289DQ1twZIIH+K4PajRCbMUiJaVOSmXqNYHtsWk+WZ4r9wSO/rM+N/zlh0JMQtMc
	 vXjkwLdU7cEYIrMwN3203rIL0oB51IU1qJKRvFd6uuuTvYucTIAppV2zbpfdU3ZfEE
	 qOSKuU83P0HHCnAyhAKtLfvh/eyUsLHlmzcR36T4UtoqwWqwCIJrX90ZPwWKvtDn/F
	 4VUD1nyL3lLmtPEe6kww9wGQPJUQuDtyrIiTNBAGJuZc6VmalBYhAG23jrUoQXTMlt
	 Gm783wi6E5gYlMFvOQ2TJfNkYDAyQCpf6+Vx6de6kjvYInBgAoy
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f445:674a:9eb4:f272])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id AE30F20065;
	Fri, 20 Jun 2025 01:19:54 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] Add SHA-256 by default as a breaking change
Date: Fri, 20 Jun 2025 01:19:32 +0000
Message-ID: <20250620011943.586596-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our breaking changes document outlines that Git 3.0 will make SHA-256
the default hash algorithm, which is a sensible and prudent approach,
especially from a security perspective.  However, we haven't tested this
adequately and it would be helpful to allow users to test this behaviour
so their code and environments are ready for it.

Fortunately, c5bc9a7f94 (Makefile: wire up build option for deprecated
features, 2025-01-22) introduces a build option that we can use for
testing breaking changes: WITH_BREAKING_CHANGES.

This series first introduces two new hash constants: one for the default
hash algorithm and one for the original algorithm (SHA-1).  The utility
of the former should be obvious; the latter[0] exists to allow us to
clearly document those places in the code that we are using SHA-1
because older versions of Git did not support SHA-1 and we are
maintaining backward compatibility, as opposed to those where SHA-1 is
an intentional and deliberate choice (such as when a file format allows
the user specify an algorithm).  We then have several patches that use
these constants throughout our code; fortunately, the need for them is
limited due to provident design decisions.

There is then a small amount of code to adjust the setup code to use the
default hash and adjust fallbacks to SHA-1 where necessary.

We then set up the testsuite to support a default algorithm.  It is
called the built-in algorithm since "default" is already used for the
algorithm we're running in the testsuite.  There are then a few tests
that need fixing.  Again, there aren't too many thanks to good decisions
on the part of contributors.

Finally, we wire up SHA-256 by default when WITH_BREAKING_CHANGES is
set with a rather anticlimactic amount of code.  All in all, this series
was far less work and far smaller than I expected.  Many thanks to
everyone who contributed to that being the case.

I have tested this series not only on CI but three different ways on my
local machine: without any GIT_TEST_DEFAULT_HASH, with that option set
to "sha256", and with that option set to "sha1".  It passed in every
case and all three options were useful in finding bugs in this series.

There was some discussion about adding support for SHA-256
interoperability for Git 3.0 as well.  Since my talk on that for Git
Merge was accepted, I've started on some of that work so the talk can
have more concrete and less handwavy content.

Over the past week, I've gotten down from 133 to 96 failing tests in
compatibility mode, which is definitely an improvement.  To be clear: I
am not committing to finishing that work 100%[1], but I am at least
working on it right now and it is at least mostly functional if you
ignore submodules, partial clone, and shallow clone.  My incentive to
work on it has also been helped by a new Framework 13 laptop that can
run the testsuite with -j12 in 65-70 seconds without making the
remainder of the system laggy, so testing is less painful and the
feedback loop is much shorter.

[0] This is, in my view, the most controversial part of the series, but
I think it's nice for documentary purposes.  If people really hate it,
we can drop it.
[1] I had previously said I wasn't going to do it at all, and clearly I
lied, but since this is in my free time, I may decide to do something
else instead at some point.  I'll make the code available for people to
work with if I don't get a chance to send all of the patches.

brian m. carlson (10):
  hash: add a constant for the default hash algorithm
  hash: add a constant for the original hash algorithm
  builtin: use default hash when outside a repository
  Use original hash for legacy formats
  setup: use the default algorithm to initialize repo format
  t: default to compile-time default hash if not set
  t1007: choose the built-in hash outside of a repo
  t4042: choose the built-in hash outside of a repo
  t5300: choose the built-in hash outside of a repo
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
 pkt-line.c                       |  2 +-
 remote-curl.c                    |  2 +-
 serve.c                          |  2 +-
 setup.c                          |  9 ++++++---
 setup.h                          |  2 +-
 t/t1007-hash-object.sh           |  4 ++--
 t/t4042-diff-textconv-caching.sh | 12 ++++++++++--
 t/t5300-pack-object.sh           |  6 +++---
 t/test-lib-functions.sh          |  5 ++++-
 t/test-lib.sh                    | 12 +++++++++++-
 transport.c                      |  2 +-
 24 files changed, 66 insertions(+), 32 deletions(-)

