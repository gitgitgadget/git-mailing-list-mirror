Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D4B620
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712362149; cv=none; b=jWuoMuYUzIN1D7BNareMMa0Ch+4oRAnfjPLpiXNjzFb1rMfpBrxBYo2rmMJQN2TQqg8EXz7JSsi1tDUXbVrIBMf4W2QToiq9kJl5p57dEhIXs0HSW3afWYy+h9cuqOCLEGag46dbF81QeQgNMJnExGnRjwIbadn7vCjfQNcOxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712362149; c=relaxed/simple;
	bh=YcyrWznCN6p/ZcnltNRumLFkOuX8uQB8Wjy2nan2rHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgq3xPo/L5f0TBFmJgA6fVkU0Wh7JyeboPG83c0LOHyQTuIcSgvhEriTIDKntmGOw8fP3M1lazsEaWHo7fry0eke12Q0LGzwPE/dwEzycfsLZhFVVEwwXtFBg3YIUltfEkDhvvT+rgDhbrZPi9ZJscRj+gVPKp/B7rsPfWfgUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CCwVsunk; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CCwVsunk"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5D7B1F28B4;
	Fri,  5 Apr 2024 20:09:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=YcyrWznCN6p/ZcnltNRumLFkO
	uX8uQB8Wjy2nan2rHY=; b=CCwVsunkSzpLvspEoh/wAixxMI/RkqJrAG+65db6y
	Gb5iap1aEUetnzNPyovl7fW9vViT4nXStlgvDWdgNXYzN4qBxKDFQM9hslAnxCaj
	2WZN4CmrGPVWptllwi50HBeP9tcP/XSAIUHDquElKjJbMsNtwVh0rX6Z5phMtOQN
	QU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D2031F28B3;
	Fri,  5 Apr 2024 20:09:06 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E955D1F28B2;
	Fri,  5 Apr 2024 20:09:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/6] CodingGuidelines: describe "export VAR=VAL" rule
Date: Fri,  5 Apr 2024 17:08:57 -0700
Message-ID: <20240406000902.3082301-2-gitster@pobox.com>
X-Mailer: git-send-email 2.44.0-501-g19981daefd
In-Reply-To: <20240406000902.3082301-1-gitster@pobox.com>
References: <20240406000902.3082301-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 E1E10AD6-F3A9-11EE-BAC5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

https://lore.kernel.org/git/201307081121.22769.tboegi@web.de/
resulted in 9968ffff (test-lint: detect 'export FOO=3Dbar',
2013-07-08) to add a rule to t/check-non-portable-shell.pl script to
reject

	export VAR=3DVAL

and suggest us to instead write it as "export VAR" followed by
"VAR=3DVAL".  This however was not spelled out in the CodingGuidelines
document.

We may want to re-evaluate the rule since it is from ages ago, but
for now, let's make the written rule and what the automation enforces
consistent.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index 9495df835d..0a39205c48 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -188,6 +188,12 @@ For shell scripts specifically (not exhaustive):
    hopefully nobody starts using "local" before they are reimplemented
    in C ;-)
=20
+ - Some versions of shell do not understand "export variable=3Dvalue",
+   so we write "export variable" and "variable=3Dvalue" on separae
+   lines.  Note that this was reported in 2013 and the situation might
+   have changed since then.  We'd need to re-evaluate this rule,
+   together with the rule in t/check-non-portable-shell.pl script.
+
  - Use octal escape sequences (e.g. "\302\242"), not hexadecimal (e.g.
    "\xc2\xa2") in printf format strings, since hexadecimal escape
    sequences are not portable.
--=20
2.44.0-501-g19981daefd

