Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755062512EF
	for <git@vger.kernel.org>; Mon, 12 May 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747076598; cv=none; b=U3MHhJk/tJ54APcWMpBh2Wt5nDrpTAXyztwXfNwky8Zsct0kZj+r0jBK5607SKCEIlPkBMATYKRhlufkWlMcQ1Co6WYWMGn55WSP8Vok7rVvu7zJaHV26ZDtxSRSYM6fw4qB5gjXzj3mssPgWvbHeJxGfypD16LIbJ7aNB1/7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747076598; c=relaxed/simple;
	bh=KhYWOd5VccIncvH4EBwP5GSpxFOiToyqnb6goTe8sQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gB8SyWLymG5hNRyfOp+lx/+zTu90V0aaefRJhIq2XOwt7G63TO4X4dPXc/rTqrYeVYsnHljwVKM78nW8jhcwqNGo+KhgbDaWia6m2VYBm2539PyXuvNdUO7nrlcWCoBWTNv/q6UyePaZ+2Y0YRYBGLdiIhJ0JHIhqsobVkTxepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OTgsD8xm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crt9YE/C; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OTgsD8xm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crt9YE/C"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 8614A138011C;
	Mon, 12 May 2025 15:03:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 12 May 2025 15:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1747076595; x=
	1747162995; bh=WuDMIfw0LdPOGC9pGCivhtLgaZ9kZAAD4Ix+eh+53u8=; b=O
	TgsD8xmqdNUW/U3dubzm+3GMT9DkWOdzP29Sdsx60u+LPXwMMXeZYhzmiSMCnWnn
	ZaOtGhc1U8YoMPJtbKF09YY5pTR50tvN2Ff0DgmhprvI/OhmvpSbDEOTP1wOU3qD
	OdhfYyIKmCcJqr4gD++PPBrXq4QhbA4Jh1n8I++R+mfDWnMheFEve/VWAaQMQ7PL
	rIkx/R8pUufrvM33EImKyJqFo+GJ3dlaIN3cXcPYhAdovMsfoxN5IToLnI7hS8nr
	D1E3oSaGZ52SBbS8xr3h0APvFKR8nXSiI5Jk6M3e2SK0vmyfFsG8Yq2X8OkDb0Ct
	MvGslsSyOoS4UZhpnaUQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1747076595; x=1747162995; bh=W
	uDMIfw0LdPOGC9pGCivhtLgaZ9kZAAD4Ix+eh+53u8=; b=crt9YE/CvTdMvJVH4
	DohLpHjbH43a+Ty2HYwF7QNkT55pYrew0bgLF2uHUEAGXZ7zrhbBTwZPTq41MvDG
	aUZ9uq3DJ587Q4jamlupKLMIgwWbR6sDPzYfdzK4E3ZSrIk/pEPSLxRtPbuy7IE7
	+CwMg0VdktZ2XDs8EoVdfuq4Eb6nlZSqRtQzFgN1AwruJJftM2xYNWR3SdSV1zg6
	BLhdIdDe32fuq+w7Cs2+RMPUw81yyEGCx3mkeH+IeG/VwLqHyQsSPvv3Js7Vp/9O
	IHzROhuy4e2TNEbgAtDV9opgg99EDf581U/9+xR1oTLExPq5Q1/ScsmG2w7Dugtj
	uXLXQ==
X-ME-Sender: <xms:80UiaOoYA2yEDn8jkWEqANhwKjISi-1LS9yuJIdL07tiZ3nJEyKgxg>
    <xme:80UiaMrzYfHvtJO_yxoiamWCamM1oQKUg5DaS6WsFqdsBLTBU2rEFWuAnIoMXR6nn
    t2YITSTyGrvwxxaEg>
X-ME-Received: <xmr:80UiaDOhVKmuDdsC4B5wSbDiDJPJ6koXdUXHc8CRevQsKNcMK2E5UryBZrkL2ViyklNcsMFT5BxZYhnjjJxI16y00DIhDRqWvUy4Gjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepvdfflefhueetgfektedthfduleffudet
    leefieeulefhvdduieeukefhtddvudeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:80UiaN7gwztebbuy1XhHTJvYWNIZYl6-K3inmPWtpj6oCNvDtkRJsg>
    <xmx:80UiaN72WXvHr2v-u3DceaCjAk8FLoRpQmFzL6eM5XTjPiWUMRdglA>
    <xmx:80UiaNgsqPJLOSJYo05fgY1JOWpQ2hPzqqRhdv-pHxNnr21jq3Bskw>
    <xmx:80UiaH65ooPqDZmvoxW60fStqVzhxBvv1cK42kadOn45B5jxOtJsyg>
    <xmx:80UiaAVArps4asluaQdnXFYUVr1P7dWdzoMudU3t2yv46KX5vbKDmH_e>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 15:03:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 1/6] you-still-use-that??: help deprecating commands for removal
Date: Mon, 12 May 2025 12:03:06 -0700
Message-ID: <20250512190311.1451556-2-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-674-gc1e4f99c0b
In-Reply-To: <20250512190311.1451556-1-gitster@pobox.com>
References: <20250503005814.3030099-1-gitster@pobox.com>
 <20250512190311.1451556-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commands slated for removal like "git pack-redundant" now require
an explicit "--i-still-use-this" option to run.  This is to
discourage casual use and surface their pending deprecation to
users.

The warning message is long, so factor it into a helper function
you_still_use_that() to simplify reuse by other commands.

Also add a missing test to ensure this enforcement works for
"pack-redundant".

Helped-by: Elijah Newren <newren@gmail.com>
[en: log message]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/pack-redundant.c  | 10 ++--------
 git-compat-util.h         |  2 ++
 t/t5323-pack-redundant.sh |  5 +++++
 usage.c                   | 12 ++++++++++++
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3febe732f8..6dc9e020c7 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -625,14 +625,8 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 			break;
 	}
 
-	if (!i_still_use_this) {
-		fputs(_("'git pack-redundant' is nominated for removal.\n"
-			"If you still use this command, please add an extra\n"
-			"option, '--i-still-use-this', on the command line\n"
-			"and let us know you still use it by sending an e-mail\n"
-			"to <git@vger.kernel.org>.  Thanks.\n"), stderr);
-		die(_("refusing to run without --i-still-use-this"));
-	}
+	if (!i_still_use_this)
+		you_still_use_that("git pack-redundant");
 
 	if (load_all_packs)
 		load_all();
diff --git a/git-compat-util.h b/git-compat-util.h
index e123288e8f..21cab99567 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -703,6 +703,8 @@ void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 void show_usage_if_asked(int ac, const char **av, const char *err);
 
+NORETURN void you_still_use_that(const char *command_name);
+
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
 #include "compat/apple-common-crypto.h"
diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 688cd9706c..f2f20cfa40 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -45,6 +45,11 @@ fi
 main_repo=main.git
 shared_repo=shared.git
 
+test_expect_success 'pack-redundant needs --i-still-use-this' '
+	test_must_fail git pack-redundant >message 2>&1 &&
+	test_grep "nominated for removal" message
+'
+
 git_pack_redundant='git pack-redundant --i-still-use-this'
 
 # Create commits in <repo> and assign each commit's oid to shell variables
diff --git a/usage.c b/usage.c
index 38b46bbbfe..4aaad2b553 100644
--- a/usage.c
+++ b/usage.c
@@ -372,3 +372,15 @@ void bug_fl(const char *file, int line, const char *fmt, ...)
 	trace2_cmd_error_va(fmt, ap);
 	va_end(ap);
 }
+
+NORETURN void you_still_use_that(const char *command_name)
+{
+	fprintf(stderr,
+		_("'%s' is nominated for removal.\n"
+		  "If you still use this command, please add an extra\n"
+		  "option, '--i-still-use-this', on the command line\n"
+		  "and let us know you still use it by sending an e-mail\n"
+		  "to <git@vger.kernel.org>.  Thanks.\n"),
+		command_name);
+	die(_("refusing to run without --i-still-use-this"));
+}
-- 
2.49.0-674-gc1e4f99c0b

