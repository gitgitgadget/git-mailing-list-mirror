Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DED12D208
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674000; cv=none; b=aMUWPFqW0k4BO+qUqCR+Amhro0J8R9ni9xenQ6iy6daObrlyUdNXVzd4WwTOdbr/CCxOTZdRrsxrGq3DwCSORAOKmXZYbbzdu+kBlR6HtD3Okkwnwp/h2xRW+k9GBp3JUQpE0ZwgFPHkNJtsJZvCAV5l0zuzDxUKmICS6A032cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674000; c=relaxed/simple;
	bh=Ik93UwLT6PJDlx/oQ+5BFA5BdY/8gSGQnBEpKQbRwvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiLYk3GWGv7X+23CycEqHC4oFPsrtm27cuftatHTl/BiNoven6u3yNnlWWliOlU4BmgLe0C7UedqjvOtmQ8mL1SCg8HNoh7PKKJ6/veGy07fHEfkG4LDag/9aNMzKNM4qDArR1j9LG9Ma6U20T9M6/M3l/1Y9xUsuCJWm+pQiR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ1-000000002Qv-1HWs
	for git@vger.kernel.org;
	Tue, 05 Mar 2024 22:26:35 +0100
Received: from [10.20.10.233] (port=50562 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.96.2)
	(envelope-from <bb@drbeat.li>)
	id 1rhcJ0-006KcG-0e;
	Tue, 05 Mar 2024 22:26:34 +0100
Received: from minibeat.bolli (minibeat.bolli [192.168.11.3])
	by drbeat.li (Postfix) with SMTP id E005418012F;
	Tue,  5 Mar 2024 22:26:32 +0100 (CET)
Received: by minibeat.bolli (sSMTP sendmail emulation); Tue, 05 Mar 2024 22:26:32 +0100
From: "Beat Bolli" <bb@drbeat.li>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 08/22] t/t3*: avoid redundant uses of cat
Date: Tue,  5 Mar 2024 22:25:07 +0100
Message-ID: <20240305212533.12947-9-dev+git@drbeat.li>
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
 t/t3200-branch.sh           | 2 +-
 t/t3321-notes-stripspace.sh | 8 ++++----
 t/t3920-crlf-messages.sh    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e36f4d15f2dd..c394273527cb 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -579,7 +579,7 @@ EOF
 
 	# ...and that the comments for those sections are also
 	# preserved.
-	cat config.branch | sed "s/\"source\"/\"dest\"/" >expect &&
+	sed "s/\"source\"/\"dest\"/" config.branch >expect &&
 	sed -n -e "/Note the lack/,\$p" .git/config >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
index 088a852dd47a..beca34605672 100755
--- a/t/t3321-notes-stripspace.sh
+++ b/t/t3321-notes-stripspace.sh
@@ -442,7 +442,7 @@ test_expect_success 'add note by specifying "-C", "--no-stripspace" is the defau
 	${LF}
 	EOF
 
-	cat expect | git hash-object -w --stdin >blob &&
+	git hash-object -w --stdin <expect >blob &&
 	git notes add -C $(cat blob) &&
 	git notes show >actual &&
 	test_cmp expect actual &&
@@ -468,7 +468,7 @@ test_expect_success 'reuse note by specifying "-C" and "--stripspace"' '
 	second-line
 	EOF
 
-	cat data | git hash-object -w --stdin >blob &&
+	git hash-object -w --stdin <data >blob &&
 	git notes add --stripspace -C $(cat blob) &&
 	git notes show >actual &&
 	test_cmp expect actual
@@ -492,7 +492,7 @@ test_expect_success 'reuse with "-C" and add note with "-m", "-m" will stripspac
 	third-line
 	EOF
 
-	cat data | git hash-object -w --stdin >blob &&
+	git hash-object -w --stdin <data >blob &&
 	git notes add -C $(cat blob) -m "third-line" &&
 	git notes show >actual &&
 	test_cmp expect actual
@@ -511,7 +511,7 @@ test_expect_success 'add note with "-m" and reuse note with "-C", "-C" will not
 	second-line
 	EOF
 
-	cat data | git hash-object -w --stdin >blob &&
+	git hash-object -w --stdin <data >blob &&
 	git notes add -m "first-line" -C $(cat blob)  &&
 	git notes show >actual &&
 	test_cmp expect actual
diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 67fd2345affd..5eed640a6825 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -10,7 +10,7 @@ LIB_CRLF_BRANCHES=""
 create_crlf_ref () {
 	branch="$1" &&
 	cat >.crlf-orig-$branch.txt &&
-	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&
+	append_cr <.crlf-orig-$branch.txt >.crlf-message-$branch.txt &&
 	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' | tr -d '\n' >.crlf-subject-$branch.txt &&
 	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt &&
 	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}" &&
-- 
2.44.0

