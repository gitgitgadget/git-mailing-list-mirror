Received: from impout008.msg.chrl.nc.charter.net (impout008aa.msg.chrl.nc.charter.net [47.43.20.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361741BC3F
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631694; cv=none; b=d2Fsx7eOqLUo7nBv4c5hSBLvNN9+OAKIl9SynKVhioSPfWoSi1LB+lPswGI+nFh+Hva9JWpQLgUjw6pHFUDa1cNh0k9Xs9VxUBIKmvAktGxVDc8irm/n4a+SRcU9mTMyqkLP6TPDFW0AgCtCyVi2eoxIk3yQNxXEvLr0sCay658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631694; c=relaxed/simple;
	bh=QLeeY7EoYlJ+Ru+Ng+lPV7m07XU9llrKuAXizF1uq1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOjqa3B6pRPqM32twrXEecfKWt83bNpecOBeJj0B8Z6hTxNUsFFuM/12r2fNFzvNXaoZ4Bs44FmY7xgSwelQMjS2x94Yoc0hsCprXJ4jnV4AQn3QI9zfeIh31NjE4qeOZGq32gca5/GcScDMglcDon76dd7memUHhMU+nNYBCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=Vvddad8y; arc=none smtp.client-ip=47.43.20.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="Vvddad8y"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Vn1PsPWKO6kyQVn1WsyVio; Mon, 22 Jul 2024 06:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1721631594;
	bh=QLeeY7EoYlJ+Ru+Ng+lPV7m07XU9llrKuAXizF1uq1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vvddad8yNaWSZbYf3mXZgoK98Ctr8BBHuDuP0UbyVJwVJ4Kv51eHGpdOACy4f0GNx
	 i4D/QDUVG0ACTYohWSeHgyuMAF28sd88QDS8UTgc+iIruinSRS9v6gnAuYOlGSc/gl
	 gxBcg6CIpIpUx36GwYikh7P+x47FOpZ/a441JSZA3jEnflcKVPc2QL4bth0oh9y5Gx
	 83tpfeeazp4Q7hGiW6pz138KQWQsmNCx7QWC9aXI+9Ez7BP4zz1gjIHIvg6TVRgZqv
	 oQAqLl+g3gbBDqXrThfWZJahVkXEAEubxFdu5PEXNW5U0/s2ko7sR1DNM5keDlDQKa
	 RGuyRL8pXALCQ==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=bKkQIu+Z c=1 sm=1 tr=0 ts=669e036a
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=A1X0JdhQAAAA:8 a=XRQI_hbnlHMHZBUsm7oA:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=Df3jFdWbhGDLdZNm0fyq:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/4] t3430: modernize one-shot "VAR=val shell-func" invocation
Date: Mon, 22 Jul 2024 02:59:11 -0400
Message-ID: <20240722065915.80760-2-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722065915.80760-1-ericsunshine@charter.net>
References: <20240722065915.80760-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJwrnF6cpF/Rj557ejoMhU3bvAdfl2R/9zhDR144l0NPN+KmCnUzHiSChEn4t0dN53xbwtB/u65B3HDOV00PYLAzWb8E9tD43W89Ckd4FZAmBdjNwvUx
 ZORQyFKFOpNWxtLLd304N6e2JJ+LFu+Xu3vRZRzZi5zuvKEZS5AI72Zzi4HUhDXZVT2ujYDJs2BtZlOGcz9rpl0zre15nwkdsr1uBEbgM3PdLyCULfcPiYl3
 8eQLNqYicB/YKdMcOOVl6Q2bsksSJbCoNtY69GcgEtvuDAqNDYFMsvltMgiAwDTT

From: Eric Sunshine <sunshine@sunshineco.com>

Unlike "VAR=val cmd" one-shot environment variable assignments which
exist only for the invocation of 'cmd', those assigned by "VAR=val
shell-func" exist within the running shell and continue to do so until
the process exits (or are explicitly unset). check-non-portable-shell.pl
warns when it detects such usage since, more often than not, the author
who writes such an invocation is unaware of the undesirable behavior.

A common way to work around the problem is to wrap a subshell around the
variable assignments and function call, thus ensuring that the
assignments are short-lived. However, these days, a more ergonomic
approach is to employ test_env() which is tailor-made for this specific
use-case.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3430-rebase-merges.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 36ca126bcd..e851ede4f9 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -392,8 +392,8 @@ test_expect_success 'refuse to merge ancestors of HEAD' '
 
 test_expect_success 'root commits' '
 	git checkout --orphan unrelated &&
-	(GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
-	 test_commit second-root) &&
+	test_env GIT_AUTHOR_NAME="Parsnip" GIT_AUTHOR_EMAIL="root@example.com" \
+		test_commit second-root &&
 	test_commit third-root &&
 	cat >script-from-scratch <<-\EOF &&
 	pick third-root
-- 
2.45.2

