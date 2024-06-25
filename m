Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E322176AC2
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357172; cv=none; b=mwtSY18vxHr99+skueuMkqAhYyDLNkLIttsF8zsk/fDb8g0XTDWl3BHYKhPWzPT0s/bFyTPD10xyQ2WwfF1+tCINGxHeah86Tblk6Rs8zLE4xdcpnLcKSTyoaG7zdj/M0k1Ivrk2CvFDEZhSV2vJTYNLTnmoA3nGSkI1monyUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357172; c=relaxed/simple;
	bh=OJRaCc9+HQ0nPhQAAZW2PGi49Wh4KQCPv+FO2Ii5Pgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyOqc13vctygmmpF2DKeY1RM8HZj7buvgyl57DI9rqLvkPZPjf0zggNU+3BE5SEEAW/abxCJbf9AOgk85KEUp5KwxbyRgVY1oTzzRupJcgtbmySMThMoxDzqgAvv4NLrU3mxS2vxHAE9RpUX2Oq8R7B78hu+2qQmQcmufWXkHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gk0Oc3gB; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gk0Oc3gB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6639529574;
	Tue, 25 Jun 2024 19:12:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=OJRaCc9+HQ0nPhQAAZW2PGi49Wh4KQCPv+FO2Ii5Pgo=; b=gk0O
	c3gBE36aIIrGuRPJ7UJO3Sx1aw1TpoOb3kQSTijqhe9vumvnA40jHYyXhNGnwOfT
	tTZJOxkJoxPlaH2yLBaxPy07kOYDWCcaI4ytfFHeQj7KMdWdHYLVT5iXQVEVj1Ma
	ifex40LGZIORvYMJVUecsogTQMKPFNp55kJgNN8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E6E329573;
	Tue, 25 Jun 2024 19:12:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC27D29572;
	Tue, 25 Jun 2024 19:12:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Darcy Burke <acednes@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	"Randall S . Becker" <randall.becker@nexbridge.ca>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 0/2] Darcy's "date underflow fix" topic, final reroll
Date: Tue, 25 Jun 2024 16:12:46 -0700
Message-ID: <20240625231248.4070257-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-796-g2ef7a3d713
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 71041C7A-3348-11EF-93F1-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

So it has been some time since we discussed this topic.  Let's clean
up the messy "SQUASH???" patches I had to queue on top of the main
patch to keep the CI working and make them into a preliminary patch.

The tree at the end of the series is identical to what has been
queued in 'seen' for the past few weeks.  The only difference is
that we first lay groundwork to skip certain time-parsing tests on
32-bit systems first, and then use Darcy's patch with minimum
adjustments for 32-bit systems.


Darcy Burke (1):
  date: detect underflow/overflow when parsing dates with timezone offset

Junio C Hamano (1):
  t0006: simplify prerequisites

 date.c          | 12 +++++++++++-
 t/t0006-date.sh | 51 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 56 insertions(+), 7 deletions(-)

--=20
2.45.2-796-g2ef7a3d713

