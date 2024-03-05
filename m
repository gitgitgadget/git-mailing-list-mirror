Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBBF12F594
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674014; cv=none; b=JVQzMNgSDJJ0z4Au5EL6FHZjAVf1n0cMWSVV2T8LcB1/d8D+HqpB/EVTeYhv7ccD+morkvqHKoDFJeHqWgiaRdqDxmsBli5nyhxDXZpRYDxKJH7nyeHat5JWYZMr9FV1v0AE01PrG9Sa6QDV0y7Tql6LipFudUIKsnG/Pnnj9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674014; c=relaxed/simple;
	bh=dNPRDkkM4IUwytFXl8H1utciOM4OELyXwXUoSQgllzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgtoXw0P3YIqwEaFELgsctYL49v74OdVTlqKejbYHWNwE0fjKVMmRqAGx8KiK6auPVE6EpW7ggz+sJ2+jKjtCaaj/924BJ8D1rUzfMZ42gi73hzPbxJTfMexuhF7nFGX23Z//ZH6iLkhnYwBXEWWPe4/15blrEIDT/OE84mkUp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJG-000000002V1-2Ovi
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:51 +0100
Received: from [10.20.10.230] (port=37856 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJF-006Kjy-1V;
	Tue, 05 Mar 2024 22:26:49 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 2AE6118012F;
	Tue,  5 Mar 2024 22:26:48 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:48 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 22/22] git-quiltimport: avoid an unnecessary subshell
Date: Tue,  5 Mar 2024 22:25:21 +0100
Message-ID: <20240305212533.12947-23-dev+git@drbeat.li>
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

Use braces for the compound command.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 git-quiltimport.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index e3d390974331..eb34cda4092a 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -148,7 +148,7 @@ do
 	if [ -z "$dry_run" ] ; then
 		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
 		tree=$(git write-tree) &&
-		commit=$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tree $tree -p $commit) &&
+		commit=$( { echo "$SUBJECT"; echo; cat "$tmp_msg"; } | git commit-tree $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
 done 3<"$QUILT_SERIES"
-- 
2.44.0

