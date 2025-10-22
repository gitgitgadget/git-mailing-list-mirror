Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32B32EDD45
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111837; cv=pass; b=MY06lXMQjX9kVCy8vhxmKCXA8YKnr/hDVTmKCvQXNsqPuNymfYJ9t0Yr8kaOTO2SqoX0QjdCHISbe5MJUAIIXzdlODby0NnCwiSnJNCJYWFT4LaJfId9sVLM3bv1lJ1vAnOl0BEWsGwXW+mrGYWuHZHt1peP8ZuMEndP47IX0x4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111837; c=relaxed/simple;
	bh=qfVBYGpX/qgST3h85/m7+l+JT+pCFt/cP47Kt3CENEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJPMz9eBz1T/ED8k9qnOLsMJcLHFEN7/dIRytp3u7UCXxJZ0AFbQa37eVMzmq9DjtTwKoc4FLs7CFHdmgRhLvz5bIrtKuB6WxTYhKAVSPEjewlbd41pZCfvf4EsP95NGqkjrsQsnboGX7L47Uk7AL9QO8sSDoL1nEk3KlMd+mb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=fPJx2Wcn; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="fPJx2Wcn"
ARC-Seal: i=1; a=rsa-sha256; t=1761111641; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iWfEY04dYBRcXh8sxuI90/kdcJ9Jwy7x2yys4D98gupL2Apf+Urv92+pAkhCouHlrVcQnJSKtlUYAcePPvUu3XAq1l2rvrDpJrLKgeCPj/Lhms4iVdshBw1k29M3Z28ia8Yv9yTHtAw0XzofRxkXSoSLXzd5BjEHpL+zI1tlOp8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111641; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=CTEOBndA0vHY+lfpdtAXEEZnfdYAjd9QdidJyOuy32k=; 
	b=Ew3TDCpfLT3XaXEfOF7CEjbQU0crkummLUtZWFOYUDXXskgiPefQtk7KTQ4lUoQydXH1CuvwFeu6e7n6nohI5hQfHH+8nPmplJ/2PGr+H881odFUjOqx1SGjIcwS5RUq2HmP6E8IZM88Hb4vzj/53+Tbg9kazX/HP8NT0cph1fs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111641;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=CTEOBndA0vHY+lfpdtAXEEZnfdYAjd9QdidJyOuy32k=;
	b=fPJx2WcnyyBzuQ8slsSJEFyEhz0we2XpfAphgAhhQBBsDQZiP7pcRdSnWS3eyvjI
	r+coN73vIiXT+xodFxrjOP++bgjtmUwFOYdtsZJv/SwWy7ifPvBCEBbNhLv2txXI6YP
	/Bck9+m7PdixI1gjfSpwkiHuDt6bjGh5eIUtaK8s=
Received: by mx.zohomail.com with SMTPS id 1761111638861235.99031141999455;
	Tue, 21 Oct 2025 22:40:38 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 21/29] t3440: assert trailer on HEAD after conflict rebase
Date: Wed, 22 Oct 2025 13:39:41 +0800
Message-ID: <20251022053951.602605-22-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Switch the test to check the trailer on HEAD (not HEAD~2) and build the
expected message for "third", matching the rebased tip after conflicts.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 504bdd86fc..fbc6f209f1 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -73,14 +73,14 @@ test_expect_success 'multiple Signed-off-by trailers all preserved' '
 '
 
 test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
-	create_expect file2-signed "file-2" &&
+	create_expect third-signed "third" &&
 	test_must_fail git rebase -m \
 		--trailer "Reviewed-by: Dev <dev@example.com>" \
 		second third &&
 	git checkout --theirs file &&
 	git add file &&
 	git rebase --continue &&
-	test_commit_message HEAD~2 file2-signed
+	test_commit_message HEAD third-signed
 '
 
 test_expect_success 'rebase --root --trailer updates every commit' '
-- 
2.51.0

