Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22B31354B
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444879; cv=pass; b=sQR9SlIj7N1GFrwQN9PnAkTKhS4BLXUE71ZVV8+P4sJRXnAIVN6XIzjf2kTBCaYP9Iy0wbF1XXuXZ+oPuFcYBTud7Tdw9BmUou7lzYvvcdUNJLItfHnL45T+1i9Pz/uibNS4OKlvmjL98Guw8yrzlrHZVssnvJgCe2WyRaRIrWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444879; c=relaxed/simple;
	bh=fajZvQVnIIBWT2+xqsdTG95mJToCFiLH1IPIjOXlP8Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCqJ23UEM99+oYb6eau/T63oJrPugXhJ4R3kBOubr/blC0QuS/LNbbcvtay9gwZN/ogHiRk6a62Q2A2k+5gEPUI/nXpcA8anqZoua6B5e27O1LkwmnROXzmeu5M0xDlaujSGoQ8+hMhzAQR/yfw29B8jlYoEFds9T/uwvDgTlOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=XfF9iSdx; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="XfF9iSdx"
ARC-Seal: i=1; a=rsa-sha256; t=1760444754; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DzFJbIlaksM7NZ7s18JB4Oi1hofplcV6m5hIXhH4kUKTr4X+S0UldEyuzSeVpRPwSJxkOh/EnP6U3Db6PXrwCW66GGfonogDQMSDYBshczH4Nv0BW4AVmVQB+fD9EQLQKwB0VWmkErpAQwMqjCGr1YlE+h3kWpfMhBkW9SYQzSg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444754; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Mzczi8K7D2I06v4+KEO5s5vH7sUZU9ZZveHQc+eX6LM=; 
	b=Lascfmktw96qsldwwNGncMXVR4gzPVZOUvzJgbXG0MLrFe56Q07OfcW9r9JHTjQucQdH99BcyZM+2adUXWtTkhfmsjLCgFES1j1jFaTFkM8BJZ0DrjqBrDjId0HrzQP+SRaiF1AajlFROmj0DQXsD+gX8nUIrsnOWeJj8B5sBx0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444754;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Mzczi8K7D2I06v4+KEO5s5vH7sUZU9ZZveHQc+eX6LM=;
	b=XfF9iSdx8pgCigJStYpniPO9nVKe/Z7yxlThWAThH+g7G35OsX/RIBS1ncE61hGa
	UdEOH6tt1hlBbesIeM1Cd/MvmbP33OzMsjslaiQ/h8CGnwTwHVLBFpKhVg3T6m/89qd
	HHmBFkfAPYp+YcFytPUbfPbczJlJoeMJxuwSMzSg=
Received: by mx.zohomail.com with SMTPS id 1760444752438208.42181511545016;
	Tue, 14 Oct 2025 05:25:52 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 18/29] tests: t3440: check apply backend error includes option
Date: Tue, 14 Oct 2025 20:24:31 +0800
Message-ID: <20251014122452.1851103-19-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Updated the rebase trailer test to assert that
the apply-backend error explicitly includes the
--trailer option in its message while retaining
the existing backend check.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 t/t3440-rebase-trailer.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
index 0c0185d058..6f1a062e8f 100755
--- a/t/t3440-rebase-trailer.sh
+++ b/t/t3440-rebase-trailer.sh
@@ -34,7 +34,7 @@ test_expect_success 'apply backend is rejected with --trailer' '
 	test_expect_code 128 \
 	git rebase --apply --trailer "Reviewed-by: Dev <dev@example.com>" \
 				HEAD^ 2>err &&
-	test_grep "requires the merge backend" err &&
+	test_grep "fatal: --trailer requires the merge backend" err &&
 	test_cmp_rev HEAD $head_before
 '
 
-- 
2.51.0

