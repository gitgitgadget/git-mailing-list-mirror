Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1F2BF017
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984985; cv=none; b=YdUj935ssn/27eWP89AAK+5WPchsJsBf+76s7ahnAos8ntGXlJi8HG21VVPVRsJZSYKT0OaSKjzVsGuKOEVbkLnAK8Zh/9xh5oeKHEmuvYByvQDVME01EzofG4jFRzU2J0ym4ccH8CVks1/p2aWJ4dbdckKxdF56jgVpo9NE3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984985; c=relaxed/simple;
	bh=T0a0bJokfL4/kECu9hJQeY3Kf/ir4bzGVxXmseUdeEY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIjLcw5710Qdcxp1bV47ZLKFLQ0iFlkGyBJxISO7rrVjsFWKWgTIGTuu6Amtn18UqOwpPO0847UGBWrN34TqJRB6E63JWzFy7/t2sGXYcWPe/rkgglz3yF/ieimj6cAz6DmfF68figEJlday8NdPM0IVBFpL/WNz6ZzDESaXzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aI5Wmwst; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmxYs7qq; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aI5Wmwst";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmxYs7qq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 26DE51D000D0;
	Wed, 12 Nov 2025 17:03:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 12 Nov 2025 17:03:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984982; x=
	1763071382; bh=TL96IBl1ToQZNG6gnCk+mJGwjDop1J4AKREKz2fz65w=; b=a
	I5WmwstEdkT18DFX1Tl/C7lMwVoA21g9Jb6NdRCOCB+MwxlIQMFgb306+qzuIL6W
	9e6CXA7Yoe57VZa32JiZqlq1/nldMc2hE87d5SGN/mHQB2aoVbtotp7h89UG0s2g
	lJOEzzq5fr3HVd0wRJfUbdbls3UhLcGAk6wq+nqyBlVJCttrzJ4U3AhaiGK5HLaz
	BmuMsHXww2nNojUVSo0uWFOynnHY+DONJ/gzSIFWudpv4G4e+n7MxP7d+GlRk+ET
	FmFxJ3zerPJS0sbG+Ly2oJMG3jkEA6DyvvIsHPxZbJH9MlFWnHCkhICs3TCGBwrI
	segfcgTiliEZ6FyeL8PBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984982; x=1763071382; bh=TL96IBl1ToQZNG6gnCk+mJGwjDop
	1J4AKREKz2fz65w=; b=HmxYs7qqnpgXiaT3jnlsfiaGFQUDnUNQtj8Te4uTPxli
	5VTOnFcUXfMnvOjjPg7QHlXEuEdWd6KrkZ4JiQLxKFTGgyqq6fKgl1lKeBdsUWOH
	KI6pFhw7x+xsSeplE5wSlE47aEAUBDuDt7r/FR7VKNyiPrF9bxa8yIshWCsUyVKx
	WN+SE4qTGw7hXQ777+Y2XnMoa3PiRIO+9RWXebwgn8OE21yBFbTWiR4LvdUysTIq
	Y7q3qX1RHgWej5BpTxacz7LPI9RaYfAnuEpd+pBXkEc/eBPanE6hj/7rLi9I/zyx
	utLVUvFe0IBR7R5EkDT2gYr3Z0FMmwQQMSFwKXSTbg==
X-ME-Sender: <xms:FQQVaSHZ547wZ61VhaE3OMulWBrKJxIZoyl2Y1wkIIpBoxvImaOD1w>
    <xme:FQQVaZW4ysarTQVCgoz2QYh9O_u4_x3UlRNw9X8Ve4Q2tQejRMKPZ8NpAN0DYnaKc
    hr2tzpFQMUAmpfdoL6OHwj93ZHX1CQTbx6-n3q-vVuIrAROtqaYLA>
X-ME-Received: <xmr:FQQVaZxry1mmJamld-N9oBKAXFICb6woNTlNxcGu5cbnxB9qjY-UOJNCWJn1K9sVAOnajeu08-kxeLYg4SaL9DKQNSaBuwyN0sz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:FQQVaXNC9aGd9PQu9Cttz6bva0E8OvuPrvMdqLj05_1PL8BCLIoT7A>
    <xmx:FQQVaa4a6zSohusn_-P8xcn3lkaSvwzK1-YREEDoK2lTtzRqe4Mqgw>
    <xmx:FQQVaYObEtzLqnya49ZNFA1cWzpf6FqLeA7MAaKB9ZBuvXd46Sa9bw>
    <xmx:FQQVaYmb_D3_RuYgVuBU700tOA0Bau2umv3MNVp9K3Lo8sU3bjB0FQ>
    <xmx:FQQVadcLrdNO1KXba6MBDaTQXdQYY_dnrMwAsjJyDV8hE4GRBEL89GY7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 01/12] whitespace: correct bit assignment comments
Date: Wed, 12 Nov 2025 14:02:47 -0800
Message-ID: <20251112220258.1009253-2-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment in diff.c claimed that bits up to 12th (counting from 0th)
are whitespace rules, and 13th thru 15th are for new/old/context,
but it turns out it was miscounting.  Correct them, and clarify
where the whitespace rule bits come from in the comment.  Extend bit
assignment comments to cover bits used for color-moved, which
weren't described.

Also update the way these bit constants are defined to use (1 << N)
notation, instead of octal constants, as it tends to make it easier
to notice a breakage like this.

Sprinkle a few blank lines between logically distinct groups of CPP
macro definitions to make them easier to read.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |  7 +++++--
 diff.h |  6 +++---
 ws.h   | 25 ++++++++++++++-----------
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index a74e701806..74261b332a 100644
--- a/diff.c
+++ b/diff.c
@@ -801,16 +801,19 @@ enum diff_symbol {
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
+
 /*
  * Flags for content lines:
- * 0..12 are whitespace rules
- * 13-15 are WSEH_NEW | WSEH_OLD | WSEH_CONTEXT
+ * 0..11 are whitespace rules (see ws.h)
+ * 12..14 are WSEH_NEW | WSEH_CONTEXT | WSEH_OLD
  * 16 is marking if the line is blank at EOF
+ * 17..19 are used for color-moved.
  */
 #define DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF	(1<<16)
 #define DIFF_SYMBOL_MOVED_LINE			(1<<17)
 #define DIFF_SYMBOL_MOVED_LINE_ALT		(1<<18)
 #define DIFF_SYMBOL_MOVED_LINE_UNINTERESTING	(1<<19)
+
 #define DIFF_SYMBOL_CONTENT_WS_MASK (WSEH_NEW | WSEH_OLD | WSEH_CONTEXT | WS_RULE_MASK)
 
 /*
diff --git a/diff.h b/diff.h
index 2fa256c3ef..cbd355cf50 100644
--- a/diff.h
+++ b/diff.h
@@ -331,9 +331,9 @@ struct diff_options {
 
 	int ita_invisible_in_index;
 /* white-space error highlighting */
-#define WSEH_NEW (1<<12)
-#define WSEH_CONTEXT (1<<13)
-#define WSEH_OLD (1<<14)
+#define WSEH_NEW        (1<<12)
+#define WSEH_CONTEXT    (1<<13)
+#define WSEH_OLD        (1<<14)
 	unsigned ws_error_highlight;
 	const char *prefix;
 	int prefix_length;
diff --git a/ws.h b/ws.h
index 5ba676c559..23708efb73 100644
--- a/ws.h
+++ b/ws.h
@@ -7,19 +7,22 @@ struct strbuf;
 /*
  * whitespace rules.
  * used by both diff and apply
- * last two digits are tab width
+ * last two octal-digits are tab width (we support only up to 63).
  */
-#define WS_BLANK_AT_EOL         0100
-#define WS_SPACE_BEFORE_TAB     0200
-#define WS_INDENT_WITH_NON_TAB  0400
-#define WS_CR_AT_EOL           01000
-#define WS_BLANK_AT_EOF        02000
-#define WS_TAB_IN_INDENT       04000
-#define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
+#define WS_BLANK_AT_EOL         (1<<6)
+#define WS_SPACE_BEFORE_TAB     (1<<7)
+#define WS_INDENT_WITH_NON_TAB  (1<<8)
+#define WS_CR_AT_EOL            (1<<9)
+#define WS_BLANK_AT_EOF         (1<<10)
+#define WS_TAB_IN_INDENT        (1<<11)
+
+#define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
 #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
-#define WS_TAB_WIDTH_MASK        077
-/* All WS_* -- when extended, adapt diff.c emit_symbol */
-#define WS_RULE_MASK           07777
+#define WS_TAB_WIDTH_MASK       ((1<<6)-1)
+
+/* All WS_* -- when extended, adapt constants defined after diff.c:diff_symbol */
+#define WS_RULE_MASK            ((1<<12)-1)
+
 extern unsigned whitespace_rule_cfg;
 unsigned whitespace_rule(struct index_state *, const char *);
 unsigned parse_whitespace_rule(const char *);
-- 
2.52.0-rc2-441-g030905368a

