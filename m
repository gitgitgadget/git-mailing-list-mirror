Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC9523F29C
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034715; cv=none; b=R9qMT6I7YHfjneq/bYu6yyKJ441Za+DpYjDjqg+32h7FgZv8ZRFljrnwy/GJQRQAoBKN5Lwr7XKAV4CAAW/eGj5GM6fXxKE+c93b7SOsPZOXe9GD1+7fT7axTXr+KvW/hgsmS0ZENKxtKyoMSJbF2O0P0++UFj+KGGIAURzazVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034715; c=relaxed/simple;
	bh=fo0bX2gjdeanY3m1xBrw9kLUt1nGqXSjLoeEKWlfw/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/DmlyG4renhEdSJkkoaNYVS6Wd2+RZK6T1vB6XtdlWCXJ7K8FE0BdZiiptyk+kjhnud2r5AXrjTWgsaYfp5Q8DpMLQkJ/KuqMDJsQulJ0zwir3Xw7jGR8sn5bf+F0gU+UXjIqJdhSX3IJ9z8hsmEMkGatcXdyfBDMMam8WU960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uDaeIQlx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=po0uaaZu; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uDaeIQlx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="po0uaaZu"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE93411401B7;
	Mon,  3 Mar 2025 15:45:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 03 Mar 2025 15:45:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034713; x=
	1741121113; bh=pg+TXuU35gFoJ1Vp+oJ7vZM157ruig1Zo7SHRQmH+Ec=; b=u
	DaeIQlxEibOChpEikoeMLq4VC4NQj7RCFi1lxNdkXGJcmi7js7yv/uYwsMK6vkHD
	lejlvElQLMjCV/EpwCQrATOn7/3Deo4nP7OHQF2iv1FsMaazcVGFp8SpiovpxnSD
	DN+HzrNakyT6hO3eonsQVqqx2pojGMFZL2vP2mybH2zuD6sBpTiadI4IslPiI9ww
	4tm//yN11RiaS/9GFVeQnvaOKjdzHh988fsFXppIpVhfoZP47oRTFTBMBbEAAkb+
	HOlFBn+boon/LfPknyVV6w/oSKAdwNNmUjBcSTRRonjPA5lLBuDcAlVAGr23P8m4
	fb6/qYoGbVS7DhyMkKX9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034713; x=1741121113; bh=p
	g+TXuU35gFoJ1Vp+oJ7vZM157ruig1Zo7SHRQmH+Ec=; b=po0uaaZu0msNxTGwB
	WghP+a0in7Ubm5iZ0Q58dMj/zzjPGYIN0/bc+WGPadO+VaJ73RMUGvOgcQtEJg2U
	QIS1U1px2in7fZaOim47nreNhQk090Vbjd55dZOJ1qm9q5PbGUzaf2JbKHKU3dYr
	ifVkTFGUtNI+wglUeMMU/vH3qpU9xnDqpsqxI5yZuSGOXuPlyvcJ50QJWS/8s+XY
	GufrkbhB1XzBJPRFy6eC7P1WBV9CkbQ+dlQo6GMayYUzKQkYaIxfZr0fkHbgyuJ2
	QPF8vIOP+cD93fqij43cD2hQYnrKEAjCxvff/zppm+Z3xQzE5/8nLtrsdA0Plpre
	9OAyQ==
X-ME-Sender: <xms:2RTGZzN7mgpQoX2oZw2WYXq9qhnHAea738q_dee6Gn9UJA8wVVpg3w>
    <xme:2RTGZ99icGP095ogVyh2T2w7VoxzUb1V6NZYSRfuUEmN0EoQNMBJtJU7bCuRN-wq_
    w8xFjtyZSRLlVEwfg>
X-ME-Received: <xmr:2RTGZyTLos5zkD_mnmYHhISQBJ7La-0vlIxL2-rilDmpkrJcS73tkAjO8kkM16lKWnRMJYyzzTCJt7XiYskm_qwK_hk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefggf
    ehieeugeeuheevgfegudetheetuedvveeuueeileeuhfeigeefkeekieenucevlhhushht
    vghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtmhiisehpohgsohigrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:2RTGZ3tC5v9J0lR79WrvyLOuoTaAuzIyYWOvaw-H96Vaa7gr6h50PA>
    <xmx:2RTGZ7eUbARzKP7AQojpWK66X8che58Sl7CK-XE7jgw84r0LYUC_Lg>
    <xmx:2RTGZz1YcrusVP_cgVbC9vfsO-uxBFP0Q_L-kAxMR--66XAnqp2rmQ>
    <xmx:2RTGZ3_xzztkhVMMKah9OnbUif9L4bgpnjF3zN7uBAd_pgWClzWWbQ>
    <xmx:2RTGZ36oBLhbDhZdVYT-8KimQ6MjOVBKFdY_UuO-XtW4M2GBsYz64iP4>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:13 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 29/34] t6434: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:27 -0500
Message-ID: <20250303204443.360595-30-tmz@pobox.com>
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

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/t6434-merge-recursive-rename-options.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6434-merge-recursive-rename-options.sh b/t/t6434-merge-recursive-rename-options.sh
index a11707835b..6e913c30a1 100755
--- a/t/t6434-merge-recursive-rename-options.sh
+++ b/t/t6434-merge-recursive-rename-options.sh
@@ -22,7 +22,7 @@ R075    2-old   2-new
 R100    3-old   3-new
 
 Actual similarity indices are parsed from diff output. We rely on the fact that
-they are rounded down (see, e.g., Documentation/diff-generate-patch.txt, which
+they are rounded down (see, e.g., Documentation/diff-generate-patch.adoc, which
 mentions this in a different context).
 '
 
-- 
2.49.0.rc0

