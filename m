Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C07E574
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908478; cv=none; b=gG3NMV/6JH3Ez1V0lAQfkh2n5Wi5fi6OYNJvO2pZ7NMfXf5w0pW/OTOZ2IEo/3Bb995zDeiO8JbrDQg970OGpYyguy89mxXakKSt9PDZKN7HlupkkmuweKPPW9grwvz6KTdmNp1kW44BM/ItLvs8T+kD3SCVKG/bmrDE93ka1N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908478; c=relaxed/simple;
	bh=iKmrLQRVVsEhCTsGdrJbpztx+GOdzebsoGOf3FwpsVE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qit3eR/s9phRVaF8bf2HZnPKKnzv/3LTkDf02pQUG2ufizmezVieRnk8pA1ImyrrbyEPjeHjg20sRPIZ0/CvZcy7bncMCZAsXn+jWU7A1lReF9R9c81O2qoU7opI6f8Z6+QZEeAseIa+lsu2afrHO5X90Wf7gvlWugXBqvoeF6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z90EJERf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPh600Y1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z90EJERf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPh600Y1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id C548C1380245
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 14 Oct 2024 08:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728908475; x=1728994875; bh=Q4S26CdTUg
	z6BN257Y5acwJXJifXMrjZ9HYKT7fqt3w=; b=Z90EJERfJv23Fz6oSY3z0QNw19
	0zATep82E3+YG9EjQIM9oEhk/yzIewbD026yqOESBmtBk3ZL1rdIa3EWFjMqZzDv
	kWPUvICwcllgo3PDKXYn/FjY+vresvrHnzbeWfWc1CPLVn+1BRouCXr6yMPrLeSS
	2TJBlEimqZVVIp63GaDKybcvFXMQSjIJU9eioHFjbQyxU4kpRmX0LmJAcrSpje93
	jK4TXgY22SkeydX9zQQUrN8dgCJiKuuyZrMSYRecDg7sVDIBcAlshmKJEx29MNWR
	acjZDTMuqxsScy4Ux6idmPlCK097KODYGZtyLH+YD77+Yccg4QDyOMO0H7sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728908475; x=1728994875; bh=Q4S26CdTUgz6BN257Y5acwJXJifX
	MrjZ9HYKT7fqt3w=; b=MPh600Y1qiwY5hyakes9Jqf1rmTJbxedI77GKloedS56
	2IMMiBUnq973KRCQFa4Uv2M2B+TTXv5HXMw+qCj7+f10tAR+WnHGZHn0iUvMmmdB
	L5/cwMFoMth1Q1RDhXWbT6GusNBR8LEROXF+sSXVF/ZKX0OW9MX7o4M/Im1AVi08
	vSXLLRcqWBdvZp6DVbFeiVfATvJvBpoG5XMV2U2nlGePCkV/l1WH8WOXpeEsrtz8
	wZuGRUPywexpWlT35TNZXoFS5Ec6rH/9nOdiDxYwGaHhCs5nXHeUfvTu5gUnyEFz
	LTN1pxnoz40MnXa9dwP6BD5rZHAkqTWyzNpDgiji8w==
X-ME-Sender: <xms:uwwNZ9HK0W3fYmN2OIvqcl-9aPOmnzUJQUdAkpJF-AJ4CEM_nuRHzw>
    <xme:uwwNZyU9Lb3U2sdqt8Qa8M1pboA7tg4mahXZDMIDp6SBFVGa8U_x8WIp6d4nnSOKN
    2Uysmvefmis5eHmWw>
X-ME-Received: <xmr:uwwNZ_Kerpz08jv2t5akXyvhX8n89R1_JProakn7HX7fIU_n0mxug7OziWTV6nIr40Q4CkY9nx9etQofjC_al0-JOGd5Iy2GOeounNpTmfxBZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uwwNZzGFIkGKoSYjLofGviA69sm8mYckC1-cWa9vOeUtQBOdhvoJcg>
    <xmx:uwwNZzWAzEIp84CxKZSmFAMjKKsNAepW_077ZbNA1j8dLdEfz76v_A>
    <xmx:uwwNZ-PQBNQGpvYQgIBx_KxQY60xpG1g9JW3a8NPCsDi8vYyK-oJAw>
    <xmx:uwwNZy10mnfo5rRhMQ0r4sRh1mdf64Ibsp3-5eUEOKmdZ9UjzLxkbQ>
    <xmx:uwwNZ6elmKBewCsrugQjB5XTu6YBsPeVoQOgNW24hTvX_lOolZUi8HgP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9828dad4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:20:01 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/10] t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
Message-ID: <601670912eeb80cc599c0e7af4ea87c370ae831d.1728906490.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

When assembling our LSAN_OPTIONS that configure the leak sanitizer we
end up prepending the string with various different colon-separated
options via calls to `prepend_var`. One of the settings we add is the
path where the sanitizer should store logs, which can be an arbitrary
filesystem path.

Naturally, filesystem paths may contain whitespace characters. And while
it does seem as if we were quoting the value, we use escaped quotes and
consequently split up the value if it does contain spaces. This leads to
the following error in t0000 when having a value with whitespaces:

    .../t/test-lib.sh: eval: line 64: unexpected EOF while looking for matching `"'
    ++ return 1
    error: last command exited with $?=1
    not ok 5 - subtest: 3 passing tests

The error itself is a bit puzzling at first. The basic problem is that
the code sees the leading escaped quote during eval, but because we
truncate everything after the space character it doesn't see the
trailing escaped quote and thus fails to parse the string.

Properly quote the value to fix the issue while using single-quotes to
quote the inner value passed to eval. The issue can be reproduced by
t0000 with such a path that contains spaces.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index b1a8ee5c002..241198ba95f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1572,7 +1572,7 @@ then
 
 	prepend_var LSAN_OPTIONS : dedup_token_length=9999
 	prepend_var LSAN_OPTIONS : log_exe_name=1
-	prepend_var LSAN_OPTIONS : log_path=\"$TEST_RESULTS_SAN_FILE\"
+	prepend_var LSAN_OPTIONS : log_path="'$TEST_RESULTS_SAN_FILE'"
 	export LSAN_OPTIONS
 
 elif test "$GIT_TEST_PASSING_SANITIZE_LEAK" = "check" ||
-- 
2.47.0.dirty

