Received: from tortuga.telka.sk (tortuga.telka.sk [185.14.234.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567C5A0E1
	for <git@vger.kernel.org>; Fri, 17 May 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.14.234.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954932; cv=none; b=Qf05fOVkFBK8nTSzvS4WyQV0Jy0SqMXl1U01x8G7ExciV0i05R8l0Cx6w/9bdJMv265yB9JZye4Di4pxIdTM5RvEs8MhPhLNUqHLpUEpCQ5IAKrTaS4aBuqKSlIsXvfMWdcTEJldGPrZpecpYHdztzdOtF7AeY0ycrPqm3yq/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954932; c=relaxed/simple;
	bh=biCyx8DGI7GVI2l1780pe0BNhO+IerfMc5nbZVa54Zk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z9utW5udom0r2hSAMwq5ORkjxD2YqC6FC6z6X+y71GNkJqVYB231LwTBcs5C3cmiUq1qM5+oKQ0PgMzE5g+ndxiJa+Lk/5VU+uiHvU+DD2qtRdJ2psxH/fp0Isbu8im5sLhJlmZS/FqgQrdPcSpLT4Au+3dhKXXqopcCwWI7/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk; spf=pass smtp.mailfrom=telka.sk; arc=none smtp.client-ip=185.14.234.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telka.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telka.sk
Received: (qmail 16574 invoked from network); 17 May 2024 14:08:46 -0000
Received: from telcontar.in.telka.sk (HELO telcontar) (marcel@10.0.0.10)
  by tortuga.telka.sk with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted); 17 May 2024 14:08:46 -0000
Date: Fri, 17 May 2024 16:08:45 +0200
From: Marcel Telka <marcel@telka.sk>
To: git@vger.kernel.org
Subject: [PATCH] t/t9902-completion.sh: backslashes in echo
Message-ID: <Zkdk7R9GIfsyQjkc@telcontar>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The usage of backslashes in echo is not portable.  Since some tests
tries to output strings containing '\b' it is safer to use printf
here.  The usage of printf instead of echo is also preferred by POSIX.

Signed-off-by: Marcel Telka <marcel@telka.sk>
---
 t/t9902-completion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 963f865f27..ed3d03367e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -73,7 +73,7 @@ _get_comp_words_by_ref ()
 print_comp ()
 {
 	local IFS=$'\n'
-	echo "${COMPREPLY[*]}" > out
+	printf '%s\n' "${COMPREPLY[*]}" > out
 }
 
 run_completion ()
