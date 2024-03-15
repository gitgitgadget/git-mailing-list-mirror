Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E426A56B7F
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532015; cv=none; b=qThJPLvS46Li5wDKbcU2qjoXEYd9Dpe5nMm/KYVQcddD0G7zy7owqvUOGNPqoE4vscc64dI2TL3iVKVuVLoLvB61bepsQOKkSLVb+gXFXklQqF3MAxp0FyLasyvylojmDunL4szyaf9eZfElg5EjvkNC7bvaBSDSZswD55dnc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532015; c=relaxed/simple;
	bh=27ALFgTOAWR2LJua3O7BbqlGpiD5jfxgf2P/MpRiJyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKygWgwelXVMt1Dtq3Gd9dLaswzSQ7dyUJ6v8hVp4sDeBgS8oxpa652HiVzFX8KkWa3/7D5211JtPlRD5UZtvLwA6wktRdsbGTstQQe/9M3jq3HSW9/fYzn6FodZ2cHflGIFSgtoLPSRNZsQ5PIi3MGZodPaUSIrwuX5TiJgNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVw-000000002Eb-2umb
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:49 +0100
Received: from [10.20.10.231] (port=10986 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVv-006apv-1u;
	Fri, 15 Mar 2024 20:46:47 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 45D96180130;
	Fri, 15 Mar 2024 20:46:46 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:46 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 15/22] t/t1*: merge a "grep | sed" pipeline
Date: Fri, 15 Mar 2024 20:46:12 +0100
Message-ID: <20240315194620.10713-16-dev+git@drbeat.li>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315194620.10713-1-dev+git@drbeat.li>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
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

