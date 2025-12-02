Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BD4594A
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639979; cv=none; b=WhSfrdnq1L5ZRTV4WyIweXFfImXjRZH7jGbIVvld8QPQU4VETi0M/b25NDSVec3hR4gYC9YMf2V0qNDlgQuM4F64NJSQ9wmS0DpS37F0ktZOmQ1je0HpGNMOylLef979KqhNgovaHWTvQC7np+9YZ8Cm700BowTfWwBgqOk8Nnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639979; c=relaxed/simple;
	bh=aK6HWLOQ2oUXf/h8V3fNev1Z7ExDvQ3h9pcS+wtOnBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwb7xyDk0an3tYJkQPenA6EidNjtXQ+iJL4H4hDKPv55JZymGusZ8GfFKJsUIqVU8Mflqw5piVhcYrGbCeszhG4CwsvmcrddmaNUJG/+gWi6sHkZ2kKcmhdUmDP9YqkzRngdVEw+xH5YHVm+aUDxXqE2UDrLkNofOSJLGKjkTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YLA2vB1t; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YLA2vB1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764639969;
	bh=aK6HWLOQ2oUXf/h8V3fNev1Z7ExDvQ3h9pcS+wtOnBE=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YLA2vB1t9cIXTCZNo6HkN5atnKuJaVBaM00Y6dce2ePayQ/LFaLrCb4Z/DHZBRlRY
	 /hgC7z+sZMTaEB9/qsHXObCOKaqmdvV2Cll+tlM4bEnO8P98cETAm45ooDGqd/oACH
	 +FklXazzZ4lKv+PxS+884Nd5XEVaAExu1adC/uApB4cmUlXzoBPgy8Y5NlO/2ajQKf
	 XHKdI0lZfEV33LvNjqWLHzrGBME885BgNQ8rIiogV75/R9fbAGaTL7tDRB1hpVOcZa
	 B5f/zdO+zWbIfVAhl7zl5UTVFN1vYd3VekUtDuMEhGJYQkNwiOefdGLrJ0/5j3kiMM
	 rzlTaKw0n0SUsZm9RzOHh8XBF4KRYM1QcfcpsT3E5gzK36HFM6lNwIemUKZd2wefUN
	 Xe2UEE3hUurNHpTrfCPqy+8+3V2zWv5Rlu8dFiX8SoMWOF4tuNgLUgZaaNdpIPsyCf
	 zeaMp43pjOHo7MKcbVJKPXEjecRw5DBPXmWaFZdjv+3xUWK20bz
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:eb0a:dd97:4aaa:b0f9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B25032003B;
	Tue,  2 Dec 2025 01:46:09 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] Fix doc default hash algorithm in WITH_BREAKING_CHANGES mode
Date: Tue,  2 Dec 2025 01:46:01 +0000
Message-ID: <20251202014605.52110-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When WITH_BREAKING_CHANGES is defined, the default hash algorithm is not
SHA-1, but SHA-256.  However, our documentation was never updated to
reflect this, and as a result, we end up misinforming users.

This series fixes four places where we indicate a default hash algorithm
in our documentation such that they conditionally say that either SHA-1
or SHA-256 is the default, based on the the with-breaking-changes
attribute.  This both improves accuracy now and also makes it less
likely that we'll forget to update these places when we hit Git 3.0.

brian m. carlson (4):
  docs: update git hash algorithm for breaking changes mode
  docs: update index-pack hash algorithm for breaking changes mode
  docs: update init hash algorithm for breaking changes mode
  docs: update show-index hash algorithm for breaking changes mode

 Documentation/git-index-pack.adoc | 14 +++++++++++---
 Documentation/git-init.adoc       |  8 +++++++-
 Documentation/git-show-index.adoc | 14 +++++++++++---
 Documentation/git.adoc            |  8 +++++++-
 4 files changed, 36 insertions(+), 8 deletions(-)

