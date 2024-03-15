Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7554745
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532004; cv=none; b=jmc7wlixcGuh87E0qehsLi1kqIycikwGbneTMFOJH8bZc6QfQ4ACSVd2drIBaj26GfQUhN/UQV9Q16h0Nr9geKRG4uSblMoqwfZ9yLeP+nJOqGRolS3u8mWhViaz1fYq7lUS/aAYwDRLDpFGeI8lxPPinKSaU79/7QVSqksdEXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532004; c=relaxed/simple;
	bh=xR+QIoXcuCkFMZo5dOZTZhD8mUNnJl1WrNy1JgNe8OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktff0oTrJU6Jhgb6YAFefL+GPEmKWUttk9xSaNNay2gfXEE96M8ZLBNPATuu1f/4aUjiSPfQL80iP3WzFRKnzlATE1fYFmOZO6Iw9GU20WFde82ynUUYJNgCpJt8aR5KTxTuaRiYzqOnJRbcMW0F/TP4mSp/pfqhxWzcXsOSPbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVh-0000000029O-1h0q
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:33 +0100
Received: from [10.20.10.231] (port=4902 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVg-006aiH-0x;
	Fri, 15 Mar 2024 20:46:32 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id F1BED180130;
	Fri, 15 Mar 2024 20:46:30 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:30 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 01/22] doc: avoid redundant use of cat
Date: Fri, 15 Mar 2024 20:45:58 +0100
Message-ID: <20240315194620.10713-2-dev+git@drbeat.li>
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

