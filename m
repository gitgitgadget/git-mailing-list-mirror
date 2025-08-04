Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37E45009
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754292632; cv=none; b=LQsqTtnZOvo6iJDU6RNyRp/PfkqgQTciCuZ7o25HTLB7KpugSUBjbuwiGtwNMtJJ598STKpHiFKCtp/wl4hpWnARWLhvTROACIVqnAmlOF4I3K9cIAYx3R7hKfraPhOCZFksiVgNRoLpEmtmjPt+j/PejAAobFXfR539irVznW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754292632; c=relaxed/simple;
	bh=dNaZKJhQcBmlzzWWTDJhuNSd7F9FEzbMF8toXAZSrzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmUlENZure6oW644dU+0AYvQiMHy48qwxWdQStQ2mUpVNn+ABYknBTiX0HVgfBwPrH1qlcOclwQxfxloAS2FHNx5wGTb0ZLyAxmF6gsl0MmT26NqFPuJcy35WAA6yVUDXHXD1N0As8Y4I2cwQqiPkkNIUHFkLXqRY8kaaJfSbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Y2O5zX6T; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Y2O5zX6T"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1754292625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1j9bY4QSYnrPcWCH9mvAGqu5vqS7W8fNefe6M319MT0=;
	b=Y2O5zX6TNNGK193TCT5k4ypbL3Nl1xDB8RJFqgtFSyxp+x4H8cbuZqAKqzMf9q4s++Ebby
	9n6y08x4qv/Ob2l7x5OSlN574Ir6G6/rNvQreMahpr0XOtRao96dy1icpqOSpF8vgt6XVK
	CyYOBdO4ECIZlCWESB6/DDjwZuXxP2c=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH] t0450: fix test for out-of-tree builds
Date: Mon,  4 Aug 2025 09:30:02 +0200
Message-ID: <20250804073002.1586332-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When using Meson, builds are out-of-tree and $GIT_BUILD_DIR gets set to
the path where the build output is landing. To locate the Documentation
sources, test 't0450' was using that path.

Modify test 't0450' to use `$GIT_SOURCE_DIR/Documentation` to find the
documentation sources.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 t/t0450-txt-doc-vs-help.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index 2f7504ae7e..da2d0af5b0 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -41,7 +41,7 @@ help_to_synopsis () {
 }
 
 builtin_to_adoc () {
-       echo "$GIT_BUILD_DIR/Documentation/git-$1.adoc"
+       echo "$GIT_SOURCE_DIR/Documentation/git-$1.adoc"
 }
 
 adoc_to_synopsis () {
-- 
2.50.1.327.g047016eb4a

