Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F21799B
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712486943; cv=none; b=b6l/4T9+I9OXeKlFQLcfXUik+OaBkGwuGXTI4jV3SDoRwvADiKc9JinsGhmO1V0I+OHu5dVbT1f0hnrRrKd2ybDUGN1dJw5O7JY17PCEfQaOInWT3Er3airjsyZDWzwMabnv1Ig8K51GOca08I5zqoz3VJcbVOdfgJUokHxafQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712486943; c=relaxed/simple;
	bh=LShqhXYQXcBD8Cg/AqNxuLbd90k78u+BJySJB7ZA0G8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qGhwzb12MhxMxWuCa4ywvepPbvUGm7XlFppvdvUAgKT8NzxOKhA1Ny5pMFrtjZqkvbJe2lLpVN0/RwXEycY+X6qn/zmrYPpThl98yLzhwxZ+PkArolNTXJ94BXuQpVRECIWzc4LgCNVOnzR5usCY4wU9kIOdp+6bchMyk94keKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=xAEVnCWI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="xAEVnCWI"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712486939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+RThENlRwuFpyiFram//EMu2zAQwhw3C1enONNNzQw=;
	b=xAEVnCWIgfa4wA5Dg5GLfR3k3qOGIAtoXhQsA+FolJ9S2lI5/r/S11et57s+eqAKHC7ny8
	caTwnPWr8xkCRNyW7u89xP02JLcjkuhb6vrO33sdbl3Qw/aKNPd/+WRp2RuX0hQkjaDE21
	nbY3/a1NqNLAa1IxqXpOJXtK1McoJElYliJMwa3klcSe3DGAwdHW/ckwMsU3FKiFnCk7IL
	SfttcfP5tI7Ud1WtOROEciJueWvJfP5bRJV/mR+gp6Q1q+yiCH5LFO+1/RKzeB7w17aF9f
	W6qm6Y+QK9bBcHCpz3mSk78NN/7ZA/2LR4qFuo/OXDbu6CiKCiHCvzikVz+mDw==
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	code@khaugsbakk.name
Subject: [PATCH v5 1/3] send-email: move newline character out of a translatable string
Date: Sun,  7 Apr 2024 12:48:50 +0200
Message-Id: <d2d456edcb5bdf7ec254542ed94fed56337f1856.1712486910.git.dsimic@manjaro.org>
In-Reply-To: <cover.1712486910.git.dsimic@manjaro.org>
References: <cover.1712486910.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Move the already existing newline character out of a translatable string,
to help a bit with the translation efforts.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 git-send-email.perl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 821b2b3a135a..a22f299ba051 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1686,10 +1686,11 @@ sub send_message {
 		print $header, "\n";
 		if ($smtp) {
 			print __("Result: "), $smtp->code, ' ',
-				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
+				($smtp->message =~ /\n([^\n]+\n)$/s);
 		} else {
-			print __("Result: OK\n");
+			print __("Result: OK");
 		}
+		print "\n";
 	}
 
 	return 1;
