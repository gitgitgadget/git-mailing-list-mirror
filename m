Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D2E6E61D
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447484; cv=none; b=r3NO1FEnlAx9BiyUu21Ryw37F53LL2Yp8DLP277JB2qcvtbsd8mbKCIfY0FDpjcTfVp2QbOyu9Kr1BwyJGUmOKbHI1QPE+KC9GySc6yLJ/4uZ3y1vgso+n2ynVAbv36btdYa94U2FLyjM1d1EnHxnRXNWwc0G0SfByGHqb57OTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447484; c=relaxed/simple;
	bh=pZbjGNomhE+w5LBIe48By/Y6Tk9855ZokIAZAtvhMuE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=BJBa9/maZS1hID6T1OxgGNF9DthQr5ogzdXeGzl5IVJwQ8J6OOfh4A7TlHM1zGz0q8rEXAkZVTC/jiRQqAGYHAw0N2zGoP+Fu3pHOZxBxyTl78qyQmNTTVTk3EQCPJV+/9CpxM/3E7/UxOklLXc0VqHkd4OP4/CJWLSpIuMs/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dRXOGIc/; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dRXOGIc/"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711447479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4hu/r1lGmbLbrNfbwXKjHXRwJ3KzUAq3WmxlB9Li9Ig=;
	b=dRXOGIc/VNyIxCZX3g+RJA8A2AvuCIWCLhjs3pHCb3WRitVCfW8BUGp29vLWrQzDNniMp4
	hZq63niU+ZsIzb+w3u6rsEYC9DqLRkKeYQ9DQmm1/+Nkyedldc9uf/ZkhXyOPhVs7OR3Tk
	T64qp+Oji/KD1oQPiedqA47nLPfktApEUcuC9okiQE69WeIhxAuu8UmQ2cENbRYUhd0W2P
	FZhOMMAQ2rrVXVSOpeilnANUem0+dZQsSqmyZm+VQck5JNUoTyD53FiY1e4738PonItBeg
	gvHoGTMrGVnZ6ElZjDRz5CGk6P7VrTpVUPqxOSEEBly+o3d3sQFHRCV4hr5CKg==
To: git@vger.kernel.org
Subject: [PATCH] send-email: add newline for improved readability
Date: Tue, 26 Mar 2024 11:04:36 +0100
Message-Id: <6ee28707b9eb8bd8fdfc8756c351455c6bc3bb62.1711447365.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

When sending multiple patches at once, without confirming the sending of each
patch separately, the displayed result statuses of sending each patch become
bunched together with the messages produced for the subsequent patch.  This
unnecessarily makes discerning each of the result statuses a bit difficult,
as visible in the sample output excerpt below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250
    OK. Log says:
    ...

Let's add a newline after each displayed result status, to make reading the
produced outputs much easier, as visible in the sample output excerpt below:

    ...
    MIME-Version: 1.0
    Content-Transfer-Encoding: 8bit

    Result: 250

    OK. Log says:
    ...

This change also adds a newline after the last produced result status, which
may be seen as redundant.  Though, it doesn't look too bad, and making that
last newline not displayed would make the code much more complex, which would
not be worth neither the time and effort now, nor the additional maintenance
burden in the future.

While there, remove one spotted stray newline in the code.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 git-send-email.perl | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 821b2b3a135a..62505ab2707c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1576,7 +1576,6 @@ sub send_message {
 		print $sm "$header\n$message";
 		close $sm or die $!;
 	} else {
-
 		if (!defined $smtp_server) {
 			die __("The required SMTP server is not properly defined.")
 		}
@@ -1686,9 +1685,9 @@ sub send_message {
 		print $header, "\n";
 		if ($smtp) {
 			print __("Result: "), $smtp->code, ' ',
-				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+				($smtp->message =~ /\n([^\n]+\n)$/s), "\n\n";
 		} else {
-			print __("Result: OK\n");
+			print __("Result: OK\n\n");
 		}
 	}
 
