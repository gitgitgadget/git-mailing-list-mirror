Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FAE1E487
	for <git@vger.kernel.org>; Tue, 14 May 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710608; cv=none; b=rWym9DV7g9nsDbj25rsU39VCjieEk+dTHpFnolngYcs2Jc373OFDslSzDeqAsZsj9vC+PCK7o8ZHIFkiTDTG4qBiz/++yNqt7AAvGFj0QmxI0v28hIT/JTCcbLSIpzhYFwaOEZlWqWr65LhRuYS4VSIWmvUDiV0Dn0UnIHj4g84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710608; c=relaxed/simple;
	bh=v7iSwG4NspREoUXausA6ZxYuObzlgRH7mFpX+sp4GHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDDlzxlG7PxNQeP0gzsTh+dn4Kd4KNIsr6rQVVTeLvO6rF9HOmCZm8M9GrKpLtrO6fgMHYNp9yctUtfHQ6Wrgdr/pN8TBXm3qAcpeLiunw0XzGaJ1RjhUZLO1FjYf8TPGR7QYDHcvYnPaHEIilKglGnzOstDeauVBpexDOZrp5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SIEaExQE; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SIEaExQE"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9B96B5DA87;
	Tue, 14 May 2024 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1715710605;
	bh=v7iSwG4NspREoUXausA6ZxYuObzlgRH7mFpX+sp4GHk=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SIEaExQEUX9aaNKb8qDklu722pvYvaC02Ps0Tl4m7zTiCLQBxsEZEBrgj4jpgvSl9
	 ZJbWOO3x7M7mWhVH67o9SodTrPM4dgAferY2DgB9sxgVPlBImPrZrMOUpUdSPfjdH1
	 VHJSff6dJHaaG00R1OwgqVrROC107fkbxISUTOs9QkIYg4pWVDtf5Bwk4SgPmS/9d+
	 zo/0rDTjF4OFg+HJH8fhEjqgTLQbT3fbd6RFSocTPi7vfvFJfnlMVK9qJozCYq1n3a
	 9bOk47R8ocjMjx9Vi1U5HaLu12Qwudiqi+YLenxdlacLWAbCr8wgKaEB8660wMc8wE
	 Mjuzwg/23+QNwmDFIhZk1TBnjf+R7QvJT/rxUBI7GbBV7Cr/FgoLeUJqLcHrXtP1t4
	 WeaUo2ldq3G/ZGHytEMZifmCpVJU4svo2EKjvSnGmv066am9i5U+y5y3Gzd2sitXvv
	 T7q34ns4fRY8hLM07tMjko6mF5+3rHlI6w9v1ZmVCrG4Z0WTpei
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] Revert defense-in-depth patches breaking Git LFS
Date: Tue, 14 May 2024 18:16:39 +0000
Message-ID: <20240514181641.150112-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent defense-in-depth patches to restrict hooks while cloning
broke Git LFS because it installs necessary hooks when it is invoked by
Git's smudge filter.  This means that currently, anyone with Git LFS
installed who attempts to clone a repository with at least one LFS file
will see a message like the following (fictitious example):

----
$ git clone https://github.com/octocat/xyzzy.git
Cloning into 'pull-bug'...
remote: Enumerating objects: 1275, done.
remote: Counting objects: 100% (343/343), done.
remote: Compressing objects: 100% (136/136), done.
remote: Total 1275 (delta 221), reused 327 (delta 206), pack-reused 932
Receiving objects: 100% (1275/1275), 290.78 KiB | 2.88 MiB/s, done.
Resolving deltas: 100% (226/226), done.
Filtering content: 100% (504/504), 1.86 KiB | 0 bytes/s, done.
fatal: active `post-checkout` hook found during `git clone`:
        /home/octocat/xyzzy/.git/hooks/post-checkout
For security reasons, this is disallowed by default.
If this is intentional and the hook should actually be run, please
run the command again with `GIT_CLONE_PROTECTION_ACTIVE=false`
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry with 'git restore --source=HEAD :/'
----

This causes most CI systems to be broken in such a case, as well as a
confusing message for the user.

It's not really possible to avoid the need to install the hooks at this
location because the post-checkout hook must be ready during the
checkout that's part of the clone in order to properly adjust
permissions on files.  Thus, we'll need to revert the changes to
restrict hooks while cloning, which this series does.

brian m. carlson (2):
  Revert "clone: prevent hooks from running during a clone"
  Revert "core.hooksPath: add some protection while cloning"

 builtin/clone.c  |  5 -----
 config.c         | 13 +-----------
 hook.c           | 32 ------------------------------
 t/t1800-hook.sh  | 15 --------------
 t/t5601-clone.sh | 51 ------------------------------------------------
 5 files changed, 1 insertion(+), 115 deletions(-)

