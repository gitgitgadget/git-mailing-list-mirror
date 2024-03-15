Received: from mail-gateway-shared03.cyon.net (mail-gateway-shared03.cyon.net [194.126.200.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5E535AC
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532016; cv=none; b=X1ts1wTd2CNKJ9JhYx4xqgFW6p4rd5Bk1/DM4waRYlKVlpuOza47t1F15zn+MVtqqXO/5h05g2mxjgQky5D8qvhQF5p+tGqoSLSduL6RQ3yVkMC8PweNJMe+ySCU8Irf/NbioRnuf8EcsNngGhdKNp36jsM/WxWBD1NVjM2j1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532016; c=relaxed/simple;
	bh=T2rlWkZRvk88WPmyYUMhc6a8x+L+IwxMEMnTVvd4zF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZXeg4ECUJCAUszPX2T/rUAf+wr0Nx5IsEC18iHoOnzjvJTTxhwTvfE1ls1mV+lL6SJqi54A4gEyFWsnQisD1gCBD1nBOvISO3wzKCVG2oYVnofoS/pMSkSZLRBk03jnzgzcr/iKBuTsCxovdpxexbQuNid6zbVpu7p7Ekjqweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared03.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVx-000000002FB-3FYY
	for git@vger.kernel.org;
	Fri, 15 Mar 2024 20:46:50 +0100
Received: from [10.20.10.231] (port=11634 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rlDVw-006aqY-29;
	Fri, 15 Mar 2024 20:46:48 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id 5C7A11800FD;
	Fri, 15 Mar 2024 20:46:47 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Fri, 15 Mar 2024 20:46:47 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 16/22] t/t3*: merge a "grep | awk" pipeline
Date: Fri, 15 Mar 2024 20:46:13 +0100
Message-ID: <20240315194620.10713-17-dev+git@drbeat.li>
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
 t/t3920-crlf-messages.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 5eed640a6825..50ae222f0842 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -97,7 +97,7 @@ test_expect_success 'branch: --verbose works with messages using CRLF' '
 	git branch -v >tmp &&
 	# Remove first two columns, and the line for the currently checked out branch
 	current=$(git branch --show-current) &&
-	grep -v $current <tmp | awk "{\$1=\$2=\"\"}1"  >actual &&
+	awk "/$current/ { next } { \$1 = \$2 = \"\" } 1" <tmp >actual &&
 	test_cmp expect actual
 '
 
-- 
2.44.0

