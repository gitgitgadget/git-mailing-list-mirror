Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F811E231B
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730418944; cv=none; b=fXUKhcU+LicZ4AMoq8PwvfOv+AyHimb96jlnBDZOTNW6OwGDhbSoAQ5Zfocfk8wIuhkVvYNHBonif92JmnQDDN0r+P6AJh4R0CwkdBgov1S2sQHTlsfg06/qhNkFgrIdNmsV81UH8yq85zsRRXS+zm1gBTl8M8HDp3zccivHbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730418944; c=relaxed/simple;
	bh=3qDsvh6GP9RTlfwsVzgRvuFSNUjW8IlaBILzWfvjWsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4mfixS6LHtHJQuoMfkWGVolUd8hIE6ub8Vytg/r5AbjzvNXwE6sdkOSFvgn2EJXuipkWO2Y1LizAUs81ihwh+XfFySaHSglUWuInonPrrFv2RgKyan/btofKkga6Hzrnal6vja8Lx+tAmdIfuNNIPaC8cjx1R1oYYt8RsQnhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=gbbU+T1X; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="gbbU+T1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1730418579;
	bh=3qDsvh6GP9RTlfwsVzgRvuFSNUjW8IlaBILzWfvjWsU=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=gbbU+T1XWa1+N6EgU37rzbwr/6jCqYnhGH4KXzm3DF2MNREDxuTrrSOzvCWCfTvMs
	 CK8Zciyf0p/eMyJEcyDPp2jfqMLqfnzeCBk81y7C7lmbaZzhJPH7PXxUtH3D4Bu+a1
	 s1fT9qDWteNV5MYwUjDNVvXYksHQZQ+CW83bnlBo012d35pQQbGzOKTVL7T0fKOxMk
	 KTSVXWqsMF48xKc9JSYyvsql9XiTS7hLL8MEUnVd4KBAcEPCSSpYILZmllkOc8SvD8
	 bMtNZaJBUuh+wo1BhYmbdU+bZW6zHbVYppLaJR6Kl9rIWxuf9jl48Tpe/s8iq0uJC0
	 cdym34hmAQiLto175ZLlbj3rdvhwV2Tp7C6S+hxtbM9dexuC8GOnEdYNTY7TR+jE5U
	 Sk3nW6bdkKf+EumiyB74tzBKhUnw4g5CNQuZL6BO5TgseJVBXJ4x+MAm64kq0adysh
	 EG2XSmK3xZUV+JJwTj61JMXvNkEypgqniicPETU6ToyknAyljOM
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D52A9200B7;
	Thu, 31 Oct 2024 23:49:39 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] Improve CI testing of older systems
Date: Thu, 31 Oct 2024 23:49:31 +0000
Message-ID: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In many cases, we're not testing some of the older Linux distributions
that we support.  However, we _are_ testing some old Linux distributions
that we _don't_ support.  That means that it's presently difficult for
us to make sure our code works on all the systems we want it to and that
we're not accidentally requiring newer versions of dependencies than we
claim to support.

The first patch removes Ubuntu 16.04, which is out of regular LTS
support.  The second removes the clause in the CI job for that OS.  The
third adds several new CI jobs to make sure we're adequately supporting
older Debian and RHEL-compatible distros, and documents the dates at
which they lose support (so it's easy to know if we need to update
them).

brian m. carlson (3):
  gitlab-ci: switch from Ubuntu 16.04 to 20.04
  ci: remove clause for Ubuntu 16.04
  Add additional CI jobs to avoid accidental breakage

 .github/workflows/main.yml |  9 +++++++++
 .gitlab-ci.yml             |  2 +-
 ci/install-dependencies.sh | 19 ++++++++++---------
 3 files changed, 20 insertions(+), 10 deletions(-)

