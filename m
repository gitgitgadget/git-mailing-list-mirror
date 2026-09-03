Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279A367298
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461081; cv=none; b=Kiw1fKp9zC6lD9wUI6LXZFED6P0xePoLpD32/hUaGMKosRoRwKbveYr4MLcvpv+vh9Ap72aqalZyawMEwyXCNHEsKFrVJpWG1wDEpZB1wTSpZG9/r6c0/6gzCnooc6ffVAAsvVpC5ihCKTcpvZpZ182vQMRs97LBgOBvjCaxcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461081; c=relaxed/simple;
	bh=gD74YkffXRKfKU9HMWnx6OUJFFw2pOFJsoLB/Cwew+A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=i5penC9ITZCcdCEIb5GwuWqTuY7KnfMSXlfphadbevqfr5upfyCnmFxZr2yGiveukrD9Zv28+RxgrXM5mXPGV7YU7nNF9597coVurjQvmMPTvGI1nR8CDaQZ63xKPpiSGCnaLJh1UoVgcoIb1++vIn2q5Iv1KE5Gi62+CzqYtK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=mkuxXO2Y; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="mkuxXO2Y"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hbT6C5lkCzKryQ;
	Thu, 03 Sep 2026 20:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1788461075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/iW/xQhIt1v2BH32VRDFasqX200vGIU/FBNvO+Ncao=;
	b=mkuxXO2YdjNjHnGv0dfgzs4rPOkB5wj1w4h1CfbpSdAAZwvRF2a8+PVLLhJpkhO6LwTSf2
	GL/MdsJsgOy+vXRrz8pZredsVrfnB0Ao4kgsZzY6a/4JtxUFjAfz1LPrBP95S/Fz81PY+V
	jC98B/Atb+JPPPLo1QJJlW8jfn3txATYGdVXrR3Tyg4cTpTsJ0c85yIg8tc15mjzt2CyYu
	SIWjiQzNnIjiBI3axlm3PAhe8buUajuout0ZfJLbgHa45e9F8Xv+617E96+QKqvnFTTmqj
	d7W/3V6/9VudFqWiXJsnHjxlvtjgal5bO+s5e3yd0iCFmrmJupN9g6i49/KnoQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3 1/3] pathspec: match and original in pathspec_item are
 const
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <887D6D84-F76E-4DCB-9633-CD78DA02BCC5@ytausch.de>
Date: Thu, 3 Sep 2026 20:44:24 +0200
Cc: Junio C Hamano <gitster@pobox.com>,
 dc@diogocastro.com
Content-Transfer-Encoding: 7bit
Message-Id: <D071AFC9-5727-4445-AB71-39ABB0C77C44@ytausch.de>
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g>
 <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
 <887D6D84-F76E-4DCB-9633-CD78DA02BCC5@ytausch.de>
To: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

No existing code modifies these two strings in pathspec elements
after they are created via these two pointers.  Declare them as
"const char *" to stress on this fact and cast away constness from
the code that frees these two strings.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Yannik Tausch <dev@ytausch.de>
---
 pathspec.c | 4 ++--
 pathspec.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 281858f21f..41c53ff26e 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -749,8 +749,8 @@ void clear_pathspec(struct pathspec *pathspec)
 	int i, j;
 
 	for (i = 0; i < pathspec->nr; i++) {
-		free(pathspec->items[i].match);
-		free(pathspec->items[i].original);
+		free((void *)pathspec->items[i].match);
+		free((void *)pathspec->items[i].original);
 
 		for (j = 0; j < pathspec->items[i].attr_match_nr; j++)
 			free(pathspec->items[i].attr_match[j].value);
diff --git a/pathspec.h b/pathspec.h
index 5e3a6f1fe7..fc1b9465ad 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -35,8 +35,8 @@ struct pathspec {
 	unsigned magic;
 	int max_depth;
 	struct pathspec_item {
-		char *match;
-		char *original;
+		const char *match;
+		const char *original;
 		unsigned magic;
 		int len, prefix;
 		int nowildcard_len;
-- 
2.55.0

