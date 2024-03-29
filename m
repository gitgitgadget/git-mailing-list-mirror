Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1801E28DC1
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711751371; cv=none; b=l3a0ZJtT6AwFe3gbdHWA9J7LO6ySpGUHPsvHegor5l8J/J5t4BNgF54nGzFY/SnR22V1f/nUs7G2wveubbW5yoyI5bUGARLFhvZtvogxcMc/S5FEm6uHjzkoCm4INv2A5II9I5os8QEPPd29mIHebRFxkiOcSAy5adJXrO8FhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711751371; c=relaxed/simple;
	bh=kyKVNXXA5MsJunHg5HwoWKNfpJVSlb/ZzxBsuCMMnUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SEq3746Tvmul5ddT1xzVUrz7Nw/mdXyplpZXMCrTM1BI0WnFZyzomOOuyNFGDpRqHlCGU24w6zby02jfwQN8rv4PzBl2A0mUQccZB4X3gQyGBFAH2vwq0rMsWWTo61cD8i6c3Y6It8qmyHJYsuv4zRgtPOL330uo2yKQ7n6ygS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=JsxJNwkN; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="JsxJNwkN"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id qKhArRNBQSZEIqKhTrUsPg; Fri, 29 Mar 2024 22:27:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1711751271;
	bh=kyKVNXXA5MsJunHg5HwoWKNfpJVSlb/ZzxBsuCMMnUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JsxJNwkNwamDLSmNuNO3N7IeullP2iXqGU1B74d3ZpqycDhNtjj1bXdIdIAoh49h8
	 yGHs/h1iDSrHVoDbbiFMUx41DTc9ONH1BAIw+JqOPdKddhTgnyaPpbzuWFEm8r24lC
	 ahgLcrK7wwDgRQAJrikk6+qnVcclh7tpQJ0+AhravpTpBOlHzOp4c5QutRN8PmkXIu
	 b471ypBebSWkxWK1tmfGmZzLqytPpWHPK43WSlUhZAdJs+J9Jf6ohVF7EOexST/AFv
	 hid4UT70BRXF4hEw3JlMTYyKeRwJb/BzxctgZ85J6W+XLsXCT/27z+vK+voEyHbeOa
	 pkGVVvTikdb5g==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=Zp7rKc7G c=1 sm=1 tr=0 ts=66074067
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=ybZZDoGAAAAA:8 a=VwQbUJbxAAAA:8 a=IpH8nPKj_4YZ0qYXs8QA:9
 a=jYKBPJSq9nmHKCndOPe9:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] test-lib: fix non-functioning GIT_TEST_MAINT_SCHEDULER fallback
Date: Fri, 29 Mar 2024 18:27:03 -0400
Message-ID: <20240329222703.9343-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <xmqqmsqhsvwk.fsf@gitster.g>
References: <xmqqmsqhsvwk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJnG4N1Q0n0I+PrAHjjydnHhBUYXOwWHgQ3FjKEgEHm0WWiYwUpJWE7VZW30/am95fZ3+8qX1uw8Tv8N+atvrl3W9TQikxjTWmP1fuf1qxItDStb5r28
 z6C98gomu4h2mTUDWAMRLWYjdssWBO7tf2e95qbkueZ7lZI0t0PiJQrx23jA3vSDrjD5nye/1Cc/JwN0Hd/xPAZ2loBKVOla/v1orAD6EEWzgGxkiIvlizW/
 SNO1DjTXHeZP3pbLm8BQKUvO5ho9Q1I2aSqVK6evSqk=

From: Eric Sunshine <sunshine@sunshineco.com>

When environment variable GIT_TEST_MAINT_SCHEDULER is set, `git
maintenance` invokes the command specified as the variable's value
rather than invoking the actual underlying platform-specific scheduler
management command. By setting GIT_TEST_MAINT_SCHEDULER to some suitable
value, test authors can therefore validate behavior of "destructive"
`git maintenance` commands without having to worry about clobbering the
user's own local scheduler configuration.

In order to protect an absent-minded test author from forgetting to set
GIT_TEST_MAINT_SCHEDULER in the local test script (and thus clobbering
his or her own scheduler configuration), t/test-lib.sh assigns an
"immediately error-out" value to GIT_TEST_MAINT_SCHEDULER by default
which should ensure that the problem will be caught and reported before
any damage can be done to the configuration of the person running the
tests.

Unfortunately, however, t/test-lib.sh neglects to export
GIT_TEST_MAINT_SCHEDULER, which renders the default "error-out"
assignment worthles. Fix this by exporting the variable as originally
intended.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-of-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a replacement for Junio's [1]. That attempt made it easier for a
test author to shoot him or herself in the foot. This replacement patch
instead fixes the foot-shooting guard.

[1]: https://lore.kernel.org/git/xmqqmsqhsvwk.fsf@gitster.g/

 t/test-lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c8af8dab79..79d3e0e7d9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1962,6 +1962,7 @@ test_lazy_prereq DEFAULT_REPO_FORMAT '
 # Tests that verify the scheduler integration must set this locally
 # to avoid errors.
 GIT_TEST_MAINT_SCHEDULER="none:exit 1"
+export GIT_TEST_MAINT_SCHEDULER
 
 # Does this platform support `git fsmonitor--daemon`
 #
-- 
2.44.0

