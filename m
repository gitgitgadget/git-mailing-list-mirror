Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF72356AB
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034697; cv=none; b=N5NFQRht0WOjnTcMAPcS/cdUU7+korZfALgamecu/kCkzf1kgV8oumNJsszIPsTVE6096xnnjBRqrDViykW6jEBr3oGmVf9r/u/BIGEsuZDxws3o1nljYHp0rY858CYjHNRJV50553edvwz1E5BlfZ70pBZZ5YJOxmDg3NwPJiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034697; c=relaxed/simple;
	bh=wXJExSYHu7n0WrmCFxLVCoUazYq/nqFuthp+pD9369s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQ3NAHdw+M86ChxfiI2tTtuAWXt1W02+iZ35MpR/r6w0R6wZ4LJK0fnfdWfDlvt3Vx5qvBEFmpJbBVAz8eAIcVf3TzpUaiYkVfaQgxh6asUvdddp7FLMgB3Dm4TqQGy24QUHyYHpvL5QrULEbnmbho3tgqTVOF5yDD839yQU0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ztnMTucX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1jl26qAn; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ztnMTucX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1jl26qAn"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 1FC591382C57;
	Mon,  3 Mar 2025 15:44:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 03 Mar 2025 15:44:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034695; x=
	1741121095; bh=a6lYl+TWSkqHAsF2focvFnd+OfwO/rTfl9yjzvP9bCE=; b=z
	tnMTucXefPF/w6BOsC0YzkWIEbawwUyPYZJUCgJ2E1F0BSMkdhxaDVIVipLbZJnG
	zxCgEqYTKiGdcJUCqGsUyA7/60hArS4sBFzAdmx3rbk9GSan1mp2jSzJmZsaBFbr
	sZUQJcPUYeyHkHgGUQeBLJBCSPF0vINC4A1ns0u+ZBqHi3aaHhized2bW2p93F82
	q1TCNJwfJEl/x9kOETRnF1oo9PVtXp/mZ2nHhgVEjcuFkG7s7fnOr7kmxpMh6xeI
	wXaQZ/PfRbEJFs/ntExDVmA7G61taVzYUt1Z7YQbpkY7ryV9pYPbPLuxAgE9UCTy
	Jw2fPaU1J6yr4RP7/3JUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034695; x=1741121095; bh=a
	6lYl+TWSkqHAsF2focvFnd+OfwO/rTfl9yjzvP9bCE=; b=1jl26qAn15Jx7oUfI
	w/XSe/zv7n2NMjDlZNbJuDOU3NH/eJitWFQc/m3tQQ4X/aTVAPy2FbPXwVtn58Er
	x3tzlWr7tBsGjSp4pW0st9bjAXe4T+xuiSYHgqVOhvqckVBwv5tjYcv3SLNxm7Wp
	zJKKdsDenWaIwt/52tf0qjWSZgJXAEYa5IrhgF7dXfrsi5wfGl0orzTqEutvrfky
	1hBP8eM9P+hJOjopc2JZ+OEcZX7UDqaP4O+9pUUJCInNdkolZzEepIIrdb6IpsQy
	4d63BsyzFwruojfeoLDe1oUTdNYgPuc6DsoyE5tO/pObh50oG8ehmQJIMa7TFIy2
	fDUKQ==
X-ME-Sender: <xms:xhTGZ_Y-f7z7IDmKZif4ek_iZBxmACc6cJIpa5AbmII_y-d-iS8_9Q>
    <xme:xhTGZ-bufDtAWscxXfAUVSJmOECF9_MtXD0Y2vZmWsr5MOxYhll5SEcnmNXbCkOcw
    L0DPCbo215B3XVnqA>
X-ME-Received: <xmr:xhTGZx-0PDoDFDXMmzFzu6Rk-AUesXi2kKSeQYxVCtPJYTp7o9mrEdeMK-ieUterMEAW_hXUD0U1APXLItR5kPiFAG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:xhTGZ1r3I4mNconDhlzGz380J74RnJC1lRSsnxNyE1EdzznOhqBfkA>
    <xmx:xhTGZ6rxxgO97N9RZQHnTkowCfIJ7jYbspBFVFTqeywGa2s60IWwxg>
    <xmx:xhTGZ7Q9cg5xaH-VhBFz50gZjQXGujAPIDtfDJ7t96Dh_FNwnXL6jg>
    <xmx:xhTGZyqPoTa1Lb4YkufdqxQeJxa1e4QBB76NkBMidMp2PMPx4XVfbg>
    <xmx:xxTGZ9UluW0ncjAT0j-3SUUGuybNwMXSkgqhAX5YcSokvTxVbk-oDPbh>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:44:54 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 02/34] .gitattributes: more *.txt -> *.adoc updates
Date: Mon,  3 Mar 2025 15:44:00 -0500
Message-ID: <20250303204443.360595-3-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250303204443.360595-1-tmz@pobox.com>
References: <20250303204443.360595-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Documentation files now end in .adoc.  Update the entries for
git-merge.adoc, gitk.adoc, and user-manual.adoc to properly set the
conflict-marker-size attribute.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 .gitattributes | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 43fa883a84..c6a0b35116 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -12,7 +12,7 @@ CODE_OF_CONDUCT.md -whitespace
 /GIT-VERSION-GEN text eol=lf
 /mergetools/* text eol=lf
 /t/oid-info/* text eol=lf
-/Documentation/git-merge.txt conflict-marker-size=32
-/Documentation/gitk.txt conflict-marker-size=32
-/Documentation/user-manual.txt conflict-marker-size=32
+/Documentation/git-merge.adoc conflict-marker-size=32
+/Documentation/gitk.adoc conflict-marker-size=32
+/Documentation/user-manual.adoc conflict-marker-size=32
 /t/t????-*.sh conflict-marker-size=32
-- 
2.49.0.rc0

