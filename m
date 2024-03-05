Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F2912BEA3
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673996; cv=none; b=dVZ3wUYOVi6HYtg9beXeVMdgNGy7L+AzQHk63CjyzrcJzTWZ1lUPZ9ISbxhuAFUg62xc7nBRdOpEdlng9sYhZi7g+eED6Wa+d6JruLBL0U5TXJriDL25zHWZsDzlcwy/gB0Vx0Gz2JaADLH8NzLESnIeHIR+LpQbnDiXhY07Td4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673996; c=relaxed/simple;
	bh=n+VW9olPmiDPnqzGmqm+lcCHo/bvpWFh/wizfy1/1EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9bxvLarMQWICyUxsQkuFqICiSNgT69IBnm8+jErnyWb1FvN/IEfeptPWN4Z+w5KJ29K4lbnSXcvR6PMrYN4DD5rC+7TqiwksAOr2O6eqB++FXn1+X8uQsBWDug52zTihqqnYsXwmdVQ7GZUpt1tr3u1irib64rs8R7ellTCErU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIy-000000002Q2-02CM
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:32 +0100
Received: from [10.20.10.233] (port=49178 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIw-006Kb5-2v;
	Tue, 05 Mar 2024 22:26:30 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 9FDBA180036;
	Tue,  5 Mar 2024 22:26:29 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:29 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 05/22] t/perf: avoid redundant use of cat
Date: Tue,  5 Mar 2024 22:25:04 +0100
Message-ID: <20240305212533.12947-6-dev+git@drbeat.li>
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

