Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7A157A67
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487173; cv=none; b=PWv8vrYfQV3hb96UJlybxPoKQ01Sqweszgm2G9zqAuoMj/tYh0T5fY8C6j0sc1Qdqohx7Z29HK5fRMfDsL6uVpwyRqHw/rXK0UL/84Mjmgb1b4kCU0WdeeKvY6p0Y/J8ZuZj1aI7CgNCHIOHUZcUTxh8wawYVA9fsFXHnuE5tVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487173; c=relaxed/simple;
	bh=VIbR53GCIevmu8c6Q/etb5K252rsAKsDwwiMwQc9dj8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjBWdMOyBoAb7pa52uBbG3yZzujwdg9nntxpc+w7SBSOHQGYuaNNh7dgGcWatMFpLsXqp0wcsITG4rWOpTrs9m9sB5rYhW+cXGwnpeiB1MCwyG27iqOPJ5NZomWtvhI8XQAHz/F7CkVFHgi20oU0yMHyu2J1ycq8U7GhGFkUlE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TUFkxaj5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NQSDUPbr; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TUFkxaj5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NQSDUPbr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 97E9C13800B0
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 07:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487171; x=1726573571; bh=RZH/DuJ1pB
	dXdCIOqLvms8f66USJ0KoIIAewmYukAiA=; b=TUFkxaj5LQMuK8w5WBm2esdPTZ
	PD8Ra1Mo64HX/XnZz1rQJzkTqN5dDz0bP7fGU3z8P1Gm0XkUKeJb/XSQhSymPNVX
	F8HqqD9yhI7Uuwqqb0epBJB9JWcah3ks7C8bJMy4X0U51YrxAs2rtT+54va7xbab
	vEmSHAPHi3c+lGXznQAEUISDjuX8FcrNBrLyPvCW2BGTAuLuD96wwOkuYP75K2b1
	T4GwNjfGgZgUmgXG7Ea2J1WX/bdtmyFS6xofJo4WPHTl4+cepR9v+F/q7d57pXFa
	iwYtQ0HDLgmsRbrarhqiqeDclAh285qtjXF9ycrAPf3/d04spPbRW2tFQ45Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487171; x=1726573571; bh=RZH/DuJ1pBdXdCIOqLvms8f66USJ
	0KoIIAewmYukAiA=; b=NQSDUPbrEnhV360j6tjIUdA1LBKenIwdQBybs/Wbb7za
	3aRZZ1tQsEUAwVy8CyCs8J64wRU9xvlqxTyTzx2HZxJ+Ml/vGfotzW7hzp5YIgtw
	npbAWyulxq9S9TOsjl26bUJEtP187JfKFpNwjghOPg94U6aYvTnOLbMj8MpD73cZ
	9J8C1w2L/r2nyRBka+NS3xjFvQkgBETqQ741U0gJKG9SUsZwAsy5wKOvy3XuQtkW
	Zl6E8vVZzGgt2KpC+yIT2diE8cvP0UlsgNhDHf5ZbARVNusCq9WUnIT/fbGYP+ry
	CVK7UR+F1S2FykmOMD07Pi093Ls21BPU72VACCj0BQ==
X-ME-Sender: <xms:gxroZkoyX8ogibiF_L1d6ruVWQljU_1Tt_rGeXPfv6MLL59R3yrc7w>
    <xme:gxroZqoB5YEGdN6FaGBrSnh07e9_2lPZvZorcLTph31xuP1KQ7xPMww_bnz5P8kxH
    6W_r5SVNZjLp3_HBQ>
X-ME-Received: <xmr:gxroZpPJGPoMul9T2qszY9K6ah3xON2_3H5LSyx6iCCU1L1e-3yd_xrZ_3BSCvOTeNHyPbfgeeQuG5A1pe9QZhEqi73AvTrY216-gJirUy31EDgb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gxroZr5RD1Q5RqAerUG_Bp3icB-rJLOeFozfL4U6kV2ifqfU607DHQ>
    <xmx:gxroZj5GYumvEz2IDj5p7i-ZnScC8JL1POemOMFKRvJ5ntIBHBBVrw>
    <xmx:gxroZrg4ArBfmmSWaIJZMEjmfY5aAaMlBCkvRo9Gw3vPkLDM7bSRUQ>
    <xmx:gxroZt4HJTxQwXeAPn27gqiYaRyqiKzTRDKsK930atw9eAImBGCOYQ>
    <xmx:gxroZtSWi0c2VYKyj_9Jhmd-GaonubW4Lgc_km_QYoDbjvhGbiXvNmeb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07666f13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:54 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/23] trace2: destroy context stored in thread-local storage
Message-ID: <0fb3dc55e58559272cc79c69646be78aefd2f7ac.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

Each thread may have a specific context in the trace2 subsystem that we
set up via thread-local storage. We do not set up a destructor for this
data though, which means that the context data will leak.

Plug this leak by installing a destructor. This leak is exposed by
t7814, but plugging it alone does not make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 trace2/tr2_tls.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 4f75392952b..7b023c1bfc6 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -152,11 +152,19 @@ uint64_t tr2tls_absolute_elapsed(uint64_t us)
 	return us - tr2tls_us_start_process;
 }
 
+static void tr2tls_key_destructor(void *payload)
+{
+	struct tr2tls_thread_ctx *ctx = payload;
+	free((char *)ctx->thread_name);
+	free(ctx->array_us_start);
+	free(ctx);
+}
+
 void tr2tls_init(void)
 {
 	tr2tls_start_process_clock();
 
-	pthread_key_create(&tr2tls_key, NULL);
+	pthread_key_create(&tr2tls_key, tr2tls_key_destructor);
 	init_recursive_mutex(&tr2tls_mutex);
 
 	tr2tls_thread_main =
-- 
2.46.0.551.gc5ee8f2d1c.dirty

