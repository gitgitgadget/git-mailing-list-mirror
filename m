Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FAF28A1CF
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595516; cv=none; b=fns1vlmTbXR12lO/4udLetsBZgJyXbzXZv98nADsL+QeIuf77RPNyxGekL8Kx0Xg3a+219iaoMoO/iApOgTU7qnR0Xj4KeIp8MLEQctZucfLqeqZ4OWvebc5Lkj1rWRw6C5JwZCNsGNvVRsd0du1PpmcPWXBFiPXptjdTuxyjHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595516; c=relaxed/simple;
	bh=pVad7BxgXte/cEvJiTxOUc8qnf13rS7MgIXwKpAai2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnLaYPtC3O9t2yIGSlQeQovPR0jhWEJVdJuCZPv30HAEBpSXw0YNO6cCbqVaD/AoOiawYkUUc+6SQq9KTukFihf+O6gtRrgJAh95WfdsBGj1z7sLGZ+OYbHgig15vL+AtGFI65kS+b6w+FgK1j7KR5oflLWXEPMF4agziPuivGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oyg5GhW9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oxi5yr9r; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oyg5GhW9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oxi5yr9r"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3753F114021F;
	Fri, 25 Apr 2025 11:38:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 25 Apr 2025 11:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1745595513; x=
	1745681913; bh=nQux5zSL06VIEOP+BOzLk384XI3G3dZEnuxeOfQDtl8=; b=O
	yg5GhW9ioZKznrP9tcUaVC7M+ewq9YJanKT6N8rPobxST6JZwUBW7brkLFIecI/1
	ys3U8oxwPyvUXBf101aRchoJhmohbcXz86y/22JGpM/SP35X9lLs/nK2LtVmlTHF
	2OyYPOTbKQnGqZckaPO0hai9zC/SPLYVP7ENov4QWorPvWT9WYn3WjFYhs4/9QgU
	Ke4AYwPRh/Kj/RSl2bySIFCyZ6iAhFIaIwPkjC4abO+FBQnE7ljbULjR7WL6KMDg
	EiCzu9BMwmplQUi5+IPNZF6L4CEK7YXvHqniwPM97Pxu++BVh2Aoa/yEzBn5Bz0T
	F6RP7y36usbU23kHjCR6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1745595513; x=1745681913; bh=n
	Qux5zSL06VIEOP+BOzLk384XI3G3dZEnuxeOfQDtl8=; b=oxi5yr9rc90cKNPf5
	cBfKD+lvZAr8ifSyh9aly2cCCLbRPeN1MiDdgQjsz1VYVb0elcc9Jm2yqeLeeciT
	LITVzMrHMdNJiXkwmgpZ/97hcDW+QYK+rcavEN0ehoHao9XcIpBnRTURyzy+c84/
	3VVLPGZj+Oq209uVgZmmvAQp6FEyGR5V7r4AEHyKdWgYkIt7NX+CN4XLxmnWpIDt
	fGCF9ea4ln/df9xqBc/hslDC96loRgoHN/S5wyBW8y+/JpY3Gj4DTqYLIKTU/G6W
	xHLHpHDR2KG45EpxGZleC6JBYTeMlRkDgacS/3H1yb6xEGPWn6+9xH48vCzHpT3y
	lrfwg==
X-ME-Sender: <xms:eKwLaLGkydEV_tRhZcyFpVaD4RmDfRJ2W6Z25yoq9_wUQ7Wv6RZH-g>
    <xme:eKwLaIVB9BXR4CBZL9x6apvPatHI_uAgvZ_KLI2oE_Ieqi8lrrWbS2FASLU6j963-
    BB6vd_x59fhgV6wIw>
X-ME-Received: <xmr:eKwLaNK72X_fmbSnakj1FSZsp4768DimE4Oc6t5yfWeOdGMIoNcztxf2D-qoBREO08HJChIdle3DgBwaF6Yn5pQaCoc_GwmLW9di>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedvjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdejuddtudekffehieduteevhfdvhfel
    geejteduffehhfegleeftdejfeejvdejnecuffhomhgrihhnpegvtghlihhpshgvrdhorh
    hgpdhpvghrfhhorhgtvgdrtghomhdpghhithhhuhgsrdgtohhmpddvtddvfeduuddvledu
    geehtddqrhdrshhhpdhmrghvvghnrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhi
    nhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:eKwLaJEQ75RmKYod2HuJnqKCv8Ne7Z2pKUkbtaiCaiZwTo9hzPHt2A>
    <xmx:eawLaBUYnHLgR8XZ1ZaRylLDN6m7qD4mjK4wAC3ABa9x1wOLqQvw-Q>
    <xmx:eawLaEO7W_SYdT_mcP0Pg_1q7RgGydowcxezDVDPpXVSJ_eaJK0I5Q>
    <xmx:eawLaA1_rqN8bdyBtGlCh_HoPWlARhL4ZQ0Pt8YlW-YeVsCtdHNjhQ>
    <xmx:eawLaGKX16woGPhj_08L3oz6bG57HsyVejQR9GMIRpdufjFe8sAJPdmr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 11:38:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] ci: download JGit from maven, not eclipse.org
Date: Fri, 25 Apr 2025 08:38:27 -0700
Message-ID: <20250425153827.147585-3-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-564-g9a5a794ec8
In-Reply-To: <20250425153827.147585-1-gitster@pobox.com>
References: <xmqqr01guwuq.fsf@gitster.g>
 <20250425153827.147585-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Matthias Sohn, JGit maintainer, recommends, update the JGit
download link from repo.eclipse.org to a one in maven.org

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index be20271d3c..d9004ab24f 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -9,7 +9,7 @@ begin_group "Install dependencies"
 
 P4WHENCE=https://cdist2.perforce.com/perforce/r23.2
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
-JGITWHENCE=https://repo.eclipse.org/content/groups/releases//org/eclipse/jgit/org.eclipse.jgit.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.202311291450-r.sh
+JGITWHENCE=https://repo1.maven.org/maven2/org/eclipse/jgit/org.eclipse.jgit.pgm/6.8.0.202311291450-r/org.eclipse.jgit.pgm-6.8.0.202311291450-r.sh
 
 # Make sudo a no-op and execute the command directly when running as root.
 # While using sudo would be fine on most platforms when we are root already,
-- 
2.49.0-564-g9a5a794ec8

