Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AB23BFA9
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034709; cv=none; b=n13UNujZGMFoPqduKfj7nHqk91pgU8FdqcEwpJt+oOclHa5AMLLpxIJHuRwR8ggOMAiMzwRzFmneTg2ku5w/bhPChxLMwdZ0yBVqNV/6HraqS/syqsbXPc9e5XPffxCEZks3BTkDfEHCxLmD5NrgS5A7vOiAKUhTLug/hK3pD24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034709; c=relaxed/simple;
	bh=CApzwVPf6Rb8CCzk0ScgcBEm9nsL32LKSDwuqqZAnRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UshUs8gLYYDjJjYLD6kbI+bhjjl2BI77NLguuWSttfQSM+HUl/HtwRawqtcq05k97DXsbtn2M4w0UrorIz+5J4MDdey9rFnDFsuAyTFZrrSVRZMXL2XOErg+A4TVnpTxiAFggTo7SxXMAyc/gqVRqUJPtaeFiUQaf6Co9YKsfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uD8O3o77; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRyYrrgV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uD8O3o77";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRyYrrgV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CEBAC11401A1;
	Mon,  3 Mar 2025 15:45:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 03 Mar 2025 15:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741034706; x=
	1741121106; bh=DW6M4pjmXeeQGOw0XTLc1eRhVkGqJFTCsp00m8rKaf4=; b=u
	D8O3o772vYw/Xi5KDVTSrn1gnf06afNU8gxDblk/B1FKItGakKtWN19mb9oPEcp5
	NkBGlwkVmMjv4g+qg0r1NTvX43xwaEyHieTcRrpv5zHVxAtfBFKi43Xlij8L3urj
	thdvGYx0nA+4LmKkJYvY4QnMKMxxeF6KhCjygJZcIJslesaYMhvtAg06ly9e3fWj
	/EnSy1EbHeNixqh89DBEfvEYDMAeHEX/Vaqwvi54romNuJ3qoNN2kw45gdTCB0y6
	6CkPEX691tVVOJOJXKNNOPryTtEl7L0EHS5hc1bs6HPDjSHzTczwGRnf+xJLAh86
	KkRRjXpgwTJk35UFa/0LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1741034706; x=1741121106; bh=D
	W6M4pjmXeeQGOw0XTLc1eRhVkGqJFTCsp00m8rKaf4=; b=gRyYrrgVZdXwUF7Uw
	K1PeMv6LT3JhgHhv97hqehvxLBkasbxJrLdxA9esUziRFBv7URu9yjJBeYMPZ4jr
	/flkggOS7YFAyfRV9q6QrOoYOh8FVBZcIgG2xqEmGHn237NtrisaAWz8Fq+megWK
	pOV4swXV53/Em0UV57JQmDBtF8m/3274yAjPT2vpE4ed+Fxmo5hykB/iZEeATUmE
	txPH4p6kFAqNHYnMdlvl9RO0xqtxCw3FWIrnV+74wwt0/G8upvom8n/O+ZjxA0RU
	b7s4i9JQCEdN7bpCvPEEKcJrDukcXKRTn5/je0tJZVnVWnYU7Ke8zTgEFEYUq5Ky
	Ab5hQ==
X-ME-Sender: <xms:0hTGZwcOKO1cCoilzCr8KuypSF4jO932LXLVRYGdi3aYn-lxb8jSyw>
    <xme:0hTGZyNfEj9kPgfeB0u9VyA8o4gkBfh0NVpgP9QGAoKQjetJHph5nbQhZO8Ve6uCY
    t_6v6apSybREziIdQ>
X-ME-Received: <xmr:0hTGZxhM8GFxNAOt2RmC5bDaLWHTZ0RsU-X1lcFM-VnRvRghtUKunDzwS35xdJCJLTuUFBi-jrzWlwUVCFGidvL7yR4>
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
X-ME-Proxy: <xmx:0hTGZ19isdLgZ_bGI5TZ2y4GBqXAk6Kx3bZRyYBaDI5h4eDQKJ9BBQ>
    <xmx:0hTGZ8sAwGFOcxAf-PFD5SsSRs25vZl_zC6voaUFb3XW_SL4LFI5XQ>
    <xmx:0hTGZ8FUgWUnrwHxSENXuXBtGmbJZ32hn_cDebq8TOf1YkdBqWXo_A>
    <xmx:0hTGZ7MNwFydNcNS9ahOHOVctpkBoBIocVMu3iDXAPLnhV21NNDCRw>
    <xmx:0hTGZ4Ix3W3cL2dZ_iN7bAgdgDhPbP4is6oKN3lawQC36uHXcm8Kt8xy>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 15:45:06 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 19/34] fsck.h: *.txt -> *.adoc fixes
Date: Mon,  3 Mar 2025 15:44:17 -0500
Message-ID: <20250303204443.360595-20-tmz@pobox.com>
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
 fsck.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index a44c231a5f..a95ae7eb84 100644
--- a/fsck.h
+++ b/fsck.h
@@ -15,7 +15,7 @@ enum fsck_msg_type {
 };
 
 /*
- * Documentation/fsck-msgids.txt documents these; when
+ * Documentation/fsck-msgids.adoc documents these; when
  * modifying this list in any way, make sure to keep the
  * two in sync.
  */
-- 
2.49.0.rc0

