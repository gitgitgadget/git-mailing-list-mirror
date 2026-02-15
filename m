Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5F17A30A
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186724; cv=none; b=Cmp562lQXzJLC8PnB/yHboqCV06wM+i5UrBDvd2muL9SzUGg1bsW6L14mCqUrFr50plVUzqQq6GYRWIoC7PL2WnRmesljJKPq5HgDbDTkDHzJkIyvcJwu4hZj0BG2Di3r+RA2mZyp+HSwGjU8MbXHkwAEm53H2rpiVb6cu2F6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186724; c=relaxed/simple;
	bh=qcZaLMRr9hflpdJ/J8aWf/B2jtmjYtgkyoVPHZXRJRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjyjS0qX6EV+/QecmE65IGCXcudm0Y1H+S8doCzipdrQAMOtLBvoIdvaWYJ1jU9W0WYwDGzbwVIeIlu2Zrew07I17YPOPX0UfZUMv13WvrgqrcJRTTviM1thAZzhTfeRmLZEluZFLGPXySoJBRW7u3mHiXhENFkrHxgme4IKFdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=Qcv8Ilvm; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="Qcv8Ilvm"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriZc-008B8t-Ep; Sun, 15 Feb 2026 21:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=F9wjyN4B9NCa/93utTBseWYxdA+i0AzszdvA3IHEx6Y=; b=Qcv8IlvmInLnkuLmE6oxMNe+Hm
	yTDFZUF6lEdevpBHggfqGrVki+YwrmhKQnKr1FAm4/R0+A4FfB7NXOsWgvxXZtlbRblP0x1Eowemx
	B2Xh2beK+k/bPGi2CKQUeoX3rWYM3Nq2LnnqpsbiyKVRbwdaqdfsx6rj5DcNRllQp+k4BsuxoC6IW
	+iXDWxNm0ZSuyfnMpvCzdNG5OVOdtv36PwV+9+HW7Yf8Aaf/WDbtth0Nqks6INHmQv1boYOx7EQyF
	zgh33PzfLiRWEk8Vv4EsKNn2BsDRr0/yuYyKY67vvrJhqBzJc9Nduq626KjKw4Nn+51Fz5c8QC3uJ
	UXOqwyAA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriZb-0005hx-0S; Sun, 15 Feb 2026 21:18:31 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vriZS-00E3Gq-Pk; Sun, 15 Feb 2026 21:18:23 +0100
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org,
	Christian Heusel <christian@heusel.eu>,
	george@mail.dietrich.pub
Cc: Colin Stagner <ask+git@howdoi.land>,
	Christian Hesse <list@eworm.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] contrib/subtree: reduce function side-effects
Date: Sun, 15 Feb 2026 14:17:43 -0600
Message-ID: <20260215201748.889866-2-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215201748.889866-1-ask+git@howdoi.land>
References: <20260215201748.889866-1-ask+git@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`process_subtree_split_trailer()` communicates its return value
to the caller by setting a variable (`sub`) that is also defined
by the calling function. This is both unclear and encourages
side-effects.

Invoke this function in a sub-shell instead.

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
 contrib/subtree/git-subtree.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 17106d1a72..1cdf39a481 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -370,6 +370,10 @@ try_remove_previous () {
 }
 
 # Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITORY]
+#
+# Parse SPLIT_HASH as a commit. If the commit is not found, fetches
+# REPOSITORY and tries again. If found, prints full commit hash.
+# Otherwise, dies.
 process_subtree_split_trailer () {
 	assert test $# -ge 2
 	assert test $# -le 3
@@ -397,6 +401,7 @@ process_subtree_split_trailer () {
 			die "$fail_msg"
 		fi
 	fi
+	echo "${sub}"
 }
 
 # Usage: find_latest_squash DIR [REPOSITORY]
@@ -429,7 +434,7 @@ find_latest_squash () {
 			main="$b"
 			;;
 		git-subtree-split:)
-			process_subtree_split_trailer "$b" "$sq" "$repository"
+			sub="$(process_subtree_split_trailer "$b" "$sq" "$repository")" || exit 1
 			;;
 		END)
 			if test -n "$sub"
@@ -486,7 +491,7 @@ find_existing_splits () {
 			main="$b"
 			;;
 		git-subtree-split:)
-			process_subtree_split_trailer "$b" "$sq" "$repository"
+			sub="$(process_subtree_split_trailer "$b" "$sq" "$repository")" || exit 1
 			;;
 		END)
 			debug "Main is: '$main'"
-- 
2.43.0

