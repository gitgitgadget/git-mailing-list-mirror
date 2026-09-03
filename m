Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB76384CF0
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461005; cv=none; b=oZtoxumBuhv9E8dU+8/aru/Z4CYdUE531h8ZNPOW1vET49ZfRNjlRv31RhcQNGGp0QNQ6U/Si1rG69jwRhhIW4oHxTrFUyyVXWhwY9lf7bOaIOPjJsKpJRFn7jqUGvFxVgOUC43OHoemyL1x9vdTL88SY+JedLTReRJKyhlE/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461005; c=relaxed/simple;
	bh=wMLiyLYZc1BunwxwL7WRHD9dRuKbKKuxKaahiN7o98M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZaezdG8HdZkWw/JqP5lBguAmIdznuf69jBnBu3YlKzkQLCaS2MyHqqnYYfEHMmxqFh/O+wZxMvbI2iNcGQu6ELEo09LENT4YAv0zmaJIpPUd+SoeH/oyM7bi9okvmRPtndydPV2GXEMuhjGTEqV//xe8JhVsAClSqz9t0gXFafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=fdvkroCf; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="fdvkroCf"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hbT4l2sDFzKv7c;
	Thu, 03 Sep 2026 20:43:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788460999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjB3oDJtPDGAmct+GbqVPf2YfiEEcXMQ1AuCKciUF3k=;
	b=fdvkroCfMSxL+QzGbHh9inCfe+cibMfdtX3QxV70uJGKtFSSWGFjkjb0Ds6la6N9NEFGM3
	jphvCB7wKLYedZwLJ+pdQbb3GE6+wcVZF4/lHWVjrTqJ0f/ivqy7KO/HULrv3Y/rKalCbb
	aDqWSNtrKcvnXC2eYxX7txAYZpsJX+5oCUXmSB/Ln54IAhPJCg+I8Xp9JAgJgomtB9AZit
	3TIy27FcRrNsT5/E/xKmyEFoXO4BM1Krv2QgIYUJT5xFfVoWpWBRH0bDPwjyVo6GRSre2T
	jqHi5DN4mZV9CdpsMG++dyW0A+jk7aFwP3HMNv1NA2OxGsTj6gcJkce7sl1X/w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=dev@ytausch.de
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3 0/3] dir: fix pathspec prefixes with exclusions
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
Date: Thu, 3 Sep 2026 20:43:05 +0200
Cc: Junio C Hamano <gitster@pobox.com>,
 dc@diogocastro.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <887D6D84-F76E-4DCB-9633-CD78DA02BCC5@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
To: git@vger.kernel.org
X-Rspamd-Queue-Id: 4hbT4l2sDFzKv7c

Pathspec prefix optimization must account for exclude items separately.
The prefix is derived from non-exclude items, so applying it while =
matching
an exclude item can compare the wrong portions of the paths. Conversely, =
an
exclude item at the start of the pathspec currently prevents finding a =
common
prefix among the remaining items.

The first patch, authored by Junio, marks the immutable strings in a =
pathspec
item as const. The second patch matches exclude items against the full
pathname. The third patch finds the common prefix starting with the =
first
non-exclude item and returns both the prefix length and the string from =
which
it was derived.

Changes since v2:

* Add Junio's preparatory const-correctness patch, which also fixes the =
unit
  test build with DEVELOPER=3D1.
* Keep the two pathspec prefix fixes unchanged.

Junio C Hamano (1):
  pathspec: match and original in pathspec_item are const

Yannik Tausch (2):
  dir: do not apply prefix to negative pathspecs
  dir: find common prefix among non-exclude pathspec items

 dir.c                       | 39 +++++++++++++++++++++----------------
 pathspec.c                  |  4 ++--
 pathspec.h                  |  4 ++--
 t/t6132-pathspec-exclude.sh |  9 +++++++++
 t/unit-tests/u-dir.c        | 28 ++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 21 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  a257ce081e pathspec: match and original in =
pathspec_item are const
1:  c8a2f1e22e =3D 2:  16c6df5080 dir: do not apply prefix to negative =
pathspecs
2:  d0e08fdb96 =3D 3:  b05b77f399 dir: find common prefix among =
non-exclude pathspec items
--=20
2.55.0

