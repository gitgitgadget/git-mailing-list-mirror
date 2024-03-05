Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E945E12AAD1
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673998; cv=none; b=N/DQnC3Ay4t5no7orgYGj4hEWeYAsgkBaAtGIiTxZgsHFTVwuRD0CvYi8TTP2aW8mwe8mz/mnqEcF0hK+hzQiVp/XDM5xCGkG3GscJzcFrPE9vkitrlaUbeZQMwIL+Z8EgHmmSxVoMjARSgTpwNt8XO2xfJxQDoG8fxdT0wzbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673998; c=relaxed/simple;
	bh=3Hmr5W/p8/eAxujN7qAv/x8HCoZJgIIlMUpVDJfttCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qbfa8+nIs8E0XBlOwRdTIbge4jjOlzMEt2KINro3RMF+IUdf7B51enQryjPKKWGm3EuB2IZmckltcGIo6cUTrVBbufDG4jIGBIGNoLB5clC2Da/mm6JrLN5rdpvzoJHjht8B1nQVbagBNAIYlGrM893RXiy7z/iPOrPGKg4iF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ0-000000002Qg-1Byz
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:34 +0100
Received: from [10.20.10.230] (port=28996 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcIz-006Kbr-0P;
	Tue, 05 Mar 2024 22:26:33 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id CA8C3180036;
	Tue,  5 Mar 2024 22:26:31 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:31 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 07/22] t/t1*: avoid redundant uses of cat
Date: Tue,  5 Mar 2024 22:25:06 +0100
Message-ID: <20240305212533.12947-8-dev+git@drbeat.li>
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
 t/t1007-hash-object.sh             | 6 +++---
 t/t1091-sparse-checkout-builtin.sh | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index ac3d173767ae..64aea3848606 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -124,8 +124,8 @@ test_expect_success 'check that appropriate filter is invoke when --path is used
 	path0_sha=$(git hash-object --path=file0 file1) &&
 	test "$file0_sha" = "$path0_sha" &&
 	test "$file1_sha" = "$path1_sha" &&
-	path1_sha=$(cat file0 | git hash-object --path=file1 --stdin) &&
-	path0_sha=$(cat file1 | git hash-object --path=file0 --stdin) &&
+	path1_sha=$(git hash-object --path=file1 --stdin <file0) &&
+	path0_sha=$(git hash-object --path=file0 --stdin <file1) &&
 	test "$file0_sha" = "$path0_sha" &&
 	test "$file1_sha" = "$path1_sha"
 '
@@ -154,7 +154,7 @@ test_expect_success '--path works in a subdirectory' '
 test_expect_success 'check that --no-filters option works' '
 	nofilters_file1=$(git hash-object --no-filters file1) &&
 	test "$file0_sha" = "$nofilters_file1" &&
-	nofilters_file1=$(cat file1 | git hash-object --stdin) &&
+	nofilters_file1=$(git hash-object --stdin <file1) &&
 	test "$file0_sha" = "$nofilters_file1"
 '
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e49b8024ac53..ab3a105ffff2 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -968,7 +968,7 @@ test_expect_success 'check-rules non-cone mode' '
 	git -C bare sparse-checkout check-rules --no-cone --rules-file ../rules\
 		>check-rules-file <all-files &&
 
-	cat rules | git -C repo sparse-checkout set --no-cone --stdin &&
+	git -C repo sparse-checkout set --no-cone --stdin <rules &&
 	git -C repo ls-files -t >out &&
 	sed -n "/^S /!s/^. //p" out >ls-files &&
 
-- 
2.44.0

