Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9270F548EE
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532008; cv=none; b=ObSjgPZMJLp+AHadUaCT+xfcGIA9lXKOM7DYIO3Zx0B82ev3M4YbUKprojQOsyhG1lPqHjV8NA8VS3+4894/ZAu69h44JWTBDhlSDWlimCrDT5amy6lnmtAXaxyOuT1idHqRROnmvzmRwqQ4jUILp8kJ6utYyDoWhVdCUdsHQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532008; c=relaxed/simple;
	bh=n+VW9olPmiDPnqzGmqm+lcCHo/bvpWFh/wizfy1/1EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LfBEhhdTM/Nk0P07dyoMl9puj1iv0wUb2+/1vrMrSY3w9L7wzPNsORp4EZJDlW3N2yO4rXYcHqIXcLL904ayqFFGPWZcxZ3jP27dxBaxaMS1q0ciJS/PNAVkickg7JvDsUES2ALlrW37FALxcAh77UqF1G++KfMMivAWCt+ggLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVl-000000002Ay-36ab
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:38 +0100
Received: from [10.20.10.230] (port=56668 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVk-006akE-24;
	Fri, 15 Mar 2024 20:46:36 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 50DC8180130;
	Fri, 15 Mar 2024 20:46:35 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:35 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 05/22] t/perf: avoid redundant use of cat
Date: Fri, 15 Mar 2024 20:46:02 +0100
Message-ID: <20240315194620.10713-6-dev+git@drbeat.li>
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

Take care to redirect stdin, otherwise the output of wc would also contain
the file name.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 t/perf/repos/inflate-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/repos/inflate-repo.sh b/t/perf/repos/inflate-repo.sh
index fcfc992b5b02..412e4b450b16 100755
--- a/t/perf/repos/inflate-repo.sh
+++ b/t/perf/repos/inflate-repo.sh
@@ -33,7 +33,7 @@ do
 done
 
 git ls-tree -r HEAD >GEN_src_list
-nr_src_files=$(cat GEN_src_list | wc -l)
+nr_src_files=$(wc -l <GEN_src_list)
 
 src_branch=$(git symbolic-ref --short HEAD)
 
-- 
2.44.0

