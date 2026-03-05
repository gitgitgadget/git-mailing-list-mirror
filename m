Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B535AC23
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755000; cv=none; b=PC9gM4f0+hYiuN2g7ZLS7Bzo7ywCOPLtQjmclGzTKWh5293jtc11R/HSf93r8QKWahr0qlM84CCMZs/FSIGRarhflysDVox7eW5G27y24lGNiIUi2UwLVg5e50M8bCOSYLuqt2C/4wpQ42UjuFwqyHZh39Q+9sLFaUmymLdptSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755000; c=relaxed/simple;
	bh=98nENN6bTthtHqUD6lz5DF0MgkjtrAuPft3Qy/jId3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5HjFG/ebXmhW7FUVLDyePcnki5W4qAIZkBOououmRGYmLHuiibk96JQywUJX7uGhUoJ0AVML4MwW289rYkUqOMxCRsGEARCbiKRm12udXHwiK4rqsSmaP5yKJJQg1SLbyGXyy+rGavqEeBvroRP7ZEYycfkz6HRNdVCy1C60V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=NYR4Q9tq; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="NYR4Q9tq"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vyIYW-00EYPs-6I; Fri, 06 Mar 2026 00:56:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=D9m8ZYdohe0FPFNpyZDx6I6X3mARKmrWgix/FbR9sEQ=; b=NYR4Q9tqfgf8s8Q0dqTJO3IdsJ
	waMLem977/SVegrW8gBVBOm0gfzQnc0lX4Gr0Okhl5oELe2+ft97l+JjNS7ulJjgum3oSSYH5wxIV
	Yo/79VJ60nqUeqwCFJTsAyZ1axrGL7am9riQacDNybgyuONk73ctivBmuDpapDue2ZgzxJ77iuhtO
	Bfw/GJo0inzPdpd9wVUzHsUlA380Mo4WXD/+eMWYJOAxvh8Yg0hkRTDWQ8viEK3OideIZht4/82aj
	Y4TIT9ta7A/U7ZinFVY2grCvEgupMopGV9/li3V5VFtLR2KPD493bhnD/ZbrV5vzrAdSlqyAOE8U9
	H5eG4XJw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vyIYV-0005pd-Cg; Fri, 06 Mar 2026 00:56:35 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vyIYM-000JoT-FJ; Fri, 06 Mar 2026 00:56:26 +0100
From: Colin Stagner <ask+git@howdoi.land>
Date: Thu, 05 Mar 2026 17:55:47 -0600
Subject: [PATCH v2 1/3] contrib/subtree: reduce function side-effects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-cs-subtree-split-recursion-v2-1-7266be870ba9@howdoi.land>
References: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
In-Reply-To: <20260305-cs-subtree-split-recursion-v2-0-7266be870ba9@howdoi.land>
To: git@vger.kernel.org, Christian Heusel <christian@heusel.eu>, 
 george@mail.dietrich.pub
Cc: Christian Hesse <list@eworm.de>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Junio C Hamano <gitster@pobox.com>, Colin Stagner <ask+git@howdoi.land>
X-Mailer: b4 0.15-dev

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
index 791fd8260c..bae5d9170b 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -373,6 +373,10 @@ try_remove_previous () {
 }
 
 # Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITORY]
+#
+# Parse SPLIT_HASH as a commit. If the commit is not found, fetches
+# REPOSITORY and tries again. If found, prints full commit hash.
+# Otherwise, dies.
 process_subtree_split_trailer () {
 	assert test $# -ge 2
 	assert test $# -le 3
@@ -400,6 +404,7 @@ process_subtree_split_trailer () {
 			die "$fail_msg"
 		fi
 	fi
+	echo "${sub}"
 }
 
 # Usage: find_latest_squash DIR [REPOSITORY]
@@ -432,7 +437,7 @@ find_latest_squash () {
 			main="$b"
 			;;
 		git-subtree-split:)
-			process_subtree_split_trailer "$b" "$sq" "$repository"
+			sub="$(process_subtree_split_trailer "$b" "$sq" "$repository")" || exit 1
 			;;
 		END)
 			if test -n "$sub"
@@ -489,7 +494,7 @@ find_existing_splits () {
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

