Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1C129A99
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673994; cv=none; b=nbDLoHB31+jYyft95lf1290UklWFZyoatsERIRGE3k9mA/+CSOag1U+tdIbDgvd5VfpGCeeVf9DIiMfjGkq4IOm/Ai5pD5xwxGIPIZyulIZzn+QtZr3YFBItuwOw15qT8xrSY0DFF+/ijKDZW8CbiPwpUwMAO/oGTSBMbTPHe84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673994; c=relaxed/simple;
	bh=xR+QIoXcuCkFMZo5dOZTZhD8mUNnJl1WrNy1JgNe8OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQYtePFwvvIgNfYz6inn/mM3GfRG4TJ/uhr4Q5d7HlcpkmBCJYS8UD4jOKRcC3WFvmZdHgl9S/NZ9PUXu1TTRYwURYNxxZ2szTGAIXKh6ht2j8YoOhQAS/JA8BnDfbnqyZO5sQYSFj8icz5cyxMBWpjYiSzY/DiTevWqCdDhJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIt-000000002P3-2qzE
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:28 +0100
Received: from [10.20.10.231] (port=45192 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIs-006KZM-1r;
	Tue, 05 Mar 2024 22:26:26 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 49C3E180036;
	Tue,  5 Mar 2024 22:26:25 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:25 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 01/22] doc: avoid redundant use of cat
Date: Tue,  5 Mar 2024 22:25:00 +0100
Message-ID: <20240305212533.12947-2-dev+git@drbeat.li>
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

The update-hook-example.txt script uses this anti-pattern twice. Call grep
with the input file name directy. While at it, merge the two consecutive
grep calls.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 Documentation/howto/update-hook-example.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index 151ee84cebce..4e727deedd21 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -100,7 +100,7 @@ info "The user is: '$username'"
 
 if test -f "$allowed_users_file"
 then
-  rc=$(cat $allowed_users_file | grep -v '^#' | grep -v '^$' |
+  rc=$(grep -Ev '^(#|$)' $allowed_users_file |
     while read heads user_patterns
     do
       # does this rule apply to us?
@@ -138,7 +138,7 @@ info "'$groups'"
 
 if test -f "$allowed_groups_file"
 then
-  rc=$(cat $allowed_groups_file | grep -v '^#' | grep -v '^$' |
+  rc=$(grep -Ev '^(#|$)' $allowed_groups_file |
     while read heads group_patterns
     do
       # does this rule apply to us?
-- 
2.44.0

