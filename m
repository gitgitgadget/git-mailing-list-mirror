Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ACA12DD90
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674007; cv=none; b=XrppzidahvHHVdnT1xH8q+AavwfM36lHWgVTp1sE7GoSQE1VY7C8p+8pQF6H3kSyzypOrQ8GLsTeu1k3bCDM7vvcyxlxxwujw+XapyGVS1qmDFTLiQqzVFWNVmHNdAkLAUfxhUabhIFSPsQOdyLVG36Qw0DEj2Iud9z5LsxVCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674007; c=relaxed/simple;
	bh=27ALFgTOAWR2LJua3O7BbqlGpiD5jfxgf2P/MpRiJyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+rRkRT26DW8DMsk+MN7Bh0ggdny/jnT4E4CUerJthK3iPz0bZxopuW8/j+QMvS4T5IVWFwOZoHo5vxZWQiYtTZ9Isvpk5fU4HmWkFqKD3SfQ/57qvVIOYhPbadoumZYoFoIW8yZdoKjZZS31NXcM5j5t4/fB2e2gORzuw3DQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ8-000000002Sv-41Wi
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:43 +0100
Received: from [10.20.10.232] (port=34836 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ7-006Kfw-2j;
	Tue, 05 Mar 2024 22:26:41 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 87DC2180036;
	Tue,  5 Mar 2024 22:26:40 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:40 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 15/22] t/t1*: merge a "grep | sed" pipeline
Date: Tue,  5 Mar 2024 22:25:14 +0100
Message-ID: <20240305212533.12947-16-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305212533.12947-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/t1509/prepare-chroot.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1509/prepare-chroot.sh b/t/t1509/prepare-chroot.sh
index 6d47e2c725f7..dc997e0a6437 100755
--- a/t/t1509/prepare-chroot.sh
+++ b/t/t1509/prepare-chroot.sh
@@ -43,7 +43,7 @@ rsync --exclude-from t/t1509/excludes -Ha . "$R$(pwd)"
 # env might slip through, see test-lib.sh, unset.*PERL_PATH
 sed 's|^PERL_PATH=.*|PERL_PATH=/bin/true|' GIT-BUILD-OPTIONS > "$R$(pwd)/GIT-BUILD-OPTIONS"
 for cmd in git $BB;do 
-	ldd $cmd | grep '/' | sed 's,.*\s\(/[^ ]*\).*,\1,' | while read i; do
+	ldd $cmd | sed -n '/\//s,.*\s\(/[^ ]*\).*,\1,p' | while read i; do
 		mkdir -p "$R$(dirname $i)"
 		cp "$i" "$R/$i"
 	done
-- 
2.44.0

