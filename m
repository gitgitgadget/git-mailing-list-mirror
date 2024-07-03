Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B726018306E
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021085; cv=none; b=jumKFv2Aw9nX9j0HyvNUmfKeegPqrWTE1AI0w8O8Xj/4DSLMh01w9OMYHHGwG/cAXaD40fsdeopKfN4g0IWRMVppiwsmUXSlszOqfI2003p8UoAUi8R052plgcNUc85Gyp3NXz3uiu6xZW5OztR7vVmFqucJdBO0srAmtdDbFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021085; c=relaxed/simple;
	bh=Ti3b9nDkKuxBMMAN2PE8PP7MIzZwwGG8zYkEXWHUVhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXpxq9PHip45UizfQxu7OXQRFgMnYip5DzC/UFwZDI5P2gAIiPOLdIdolbhd9+IkQRQ9Wc4IB7cPioDE8+MLzOTRIjrUyWYpgZGTd8lis76uHOFpABvf4snvhF8ptsfk9krE0FHnIrJBj6RgmH9MJtPyEsMr1cv45K3eTrm5xik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LovcLCRx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LovcLCRx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3323E2E051;
	Wed,  3 Jul 2024 11:38:03 -0400 (EDT)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=Ti3b9nDkKuxBMMAN2PE8PP7MIzZwwGG8zYkEXWHUVhY=; b=Lovc
	LCRxFan1/i1Afp+C1BXubtU829GIv8yj+yizO4jXcK+4BffO/TbMzxxX4Wd4qwkl
	0s2YtN7lutiJ9jeamZISpnAK5nD7LT0M/6DK+yPkUIfH1yveO2sH8thNvVkJ2r4n
	6Tl9QO5zfFDkRkrTA1MQehce/32SLbijr7N+XFA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B82F2E050;
	Wed,  3 Jul 2024 11:38:03 -0400 (EDT)
	(envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7A3F42E04C;
	Wed,  3 Jul 2024 11:37:58 -0400 (EDT)
	(envelope-from tmz@pobox.com)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Kousik Sanagavarapu <five231003@gmail.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH 0/2] t/lib-gpg: ensure GNUPGHOME is created as needed
Date: Wed,  3 Jul 2024 11:37:30 -0400
Message-ID: <20240703153738.916469-1-tmz@pobox.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 39965946-3952-11EF-9DD1-C38742FD603B-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Hi,

While reviewing my local build logs, I noticed a number of tests being
skipped unintentionally.  I had not done so with any of the 2.45.0
releases, unfortunately, which is when this began.

92 of the 202 tests in t1016-compatObjectFormat.sh are skipped due to
the GNUPGHOME directory missing, e.g.:

    ok 5 # SKIP create a sha1 signed commit (missing GPG2)
    ok 6 # SKIP create a sha1 signed tag (missing GPG2)
    ok 8 # SKIP create another sha1 signed tag (missing GPG2)
    ok 9 # SKIP merge the sha1 branches together (missing GPG2)

With these changes, they are all run (successfully). :)

I presume that they have been skipped in the Github CI runs as well,
but I don't know that the logs show enough detail to confirm that.

Thanks,
Todd


Todd Zullinger (2):
  t/lib-gpg: add prepare_gnupghome() to create GNUPGHOME dir
  t/lib-gpg: call prepare_gnupghome() in GPG2 prereq

 t/lib-gpg.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--=20
2.45.2

