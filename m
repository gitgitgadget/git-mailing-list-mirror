Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54014CA768
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811200; cv=none; b=dafdqC6Mf1YIAWcbOjxhfhASjy7DqEsd3dCHD7luPAaUxUsNbbxsW1cG8zpu3FbQjMywZ1yGTPx63Xr80YFAlRZJGba1xGis7kiEq2Q3n6xGFd9O6nk+KBBXNgXa1Btm2ytD15RFZktsfTbXQcux4Av6pbGkmeSuqLZvXtxVy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811200; c=relaxed/simple;
	bh=V+a7TEC5LG41KwfCsr2ROEm4+nGI16BvRpaTgIe3HCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWPewuxkh5UC7xEs4aB6p3NCsw2KqRc+a/G0dLM061CJYMCNGFwKYNbPM0sXFXXe1MfaMjGD80QT4tjXdxkahWeS/an7uAC7OB71iS1tNuEAGMa1cGP1dZ6GZ1vPvgp/NxVU6D6sjMOL/W6Z3rsWs0zzfe4ZNpMAALdta54V5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=FBq3xzg5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="FBq3xzg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788811198;
	bh=V+a7TEC5LG41KwfCsr2ROEm4+nGI16BvRpaTgIe3HCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=FBq3xzg5YDEjY/g6ThSmXBoIfcWTenmacvCqL9WgaFtVwYk8SkGVUk1cu9SSadVPw
	 wM2Cyd5+u+mNJqcpjcfupXaV6vwVZB1L2xMQT2Ou0SfuRbJFo7/rvurVwHAx1BXq5v
	 s5i6+lVoSCxjnA5YCWR5n0xdAEpsQmibXoRJXXurlVqAeEXGuR2D/JWM6S+2BY06np
	 w6RtRolXoCUS+kuvNRS2whGJUS9/3OPDuG0l2C1Tmj78TcHa8oP70Qnpc3m7Wy+Dyv
	 wDkakf8XnKAIHYW7UcA84QkgRsNVZZUS4cNe5OYJHsIBX1mM6kV8znPenJQVBjXGd8
	 y6xzr98cuBE55zH7vt+UcrS7ER0yw3ZC7Mt5CWfU9ik69FvT0kIo2vEFMd2/fdqkxt
	 jjbBfwl9Ck8+Lj0HOwAMFc5mOWXvu+HFqR7WKUYb/B56dawASVT24B5/j3/2skNInE
	 FWFD5nU5ZZcs/Hm1241GiQnUtqHNubq8lehk481KiXG93bPzPgF
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7b23:2dc:c9d2:f0e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0109E20033;
	Mon,  7 Sep 2026 19:59:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 0/7] Git 3.0: restrict hex object IDs to lowercase only
Date: Mon,  7 Sep 2026 19:59:33 +0000
Message-ID: <20260907195941.1024289-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.53.0.697.g625c4fb2daa
In-Reply-To: <20260729233215.398654-1-sandals@crustytoothpaste.net>
References: <20260729233215.398654-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As far as I can tell, Git has always emitted hex object IDs in
lowercase, but our object ID parser accepts both uppercase and
lowercase.  This leads to much software relying on hex object IDs being
broken because it doesn't handle uppercase object IDs and this can even
lead to security problems when people assume that an object ID has a
unique hex form.

This series removes the ability to use uppercase hex in
object IDs in Git 3.0.

Changes from v1:

* Fix incorrect hex range in comment.
* Update commit messages.
* Move t5324 fixes to a separate commit and expand commit message.
* Restore lowercasing in parse_oid_prefix.
* Possibly other miscellaneous changes which I have forgotten.

brian m. carlson (7):
  hex: add functionality for lowercase-only hex
  hex: allow specifying hex type with hex2chr
  hex: make hex_to_bytes accept kind of hex to use
  hex: label usages of hex parsing for object IDs
  object-name: use hexval
  t5324: adjust tests for corrupt commit-graph
  hex: allow only lowercase object IDs in breaking changes mode

 Documentation/BreakingChanges.adoc |  5 ++++
 builtin/index-pack.c               |  2 +-
 color.c                            |  2 +-
 diagnose.c                         |  2 +-
 hex-ll.c                           | 39 ++++++++++++++++++++++++++++--
 hex-ll.h                           | 24 +++++++++++++-----
 hex.c                              |  2 +-
 http-push.c                        |  5 ++--
 mailinfo.c                         |  2 +-
 notes.c                            |  5 ++--
 object-file.c                      |  2 +-
 object-name.c                      | 15 +++---------
 pkt-line.c                         |  8 +++---
 ref-filter.c                       |  2 +-
 strbuf.c                           |  2 +-
 t/t1503-rev-parse-verify.sh        |  5 ++++
 t/t5324-split-commit-graph.sh      |  4 +--
 url.c                              |  2 +-
 urlmatch.c                         |  2 +-
 19 files changed, 91 insertions(+), 39 deletions(-)

