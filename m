Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B33CB57F
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333253; cv=none; b=tsijIh4OROwOznEQvvw31Q+LjQDwSJxyrzfxmbXfKqLliwYENDULTRGpyUQOn/YkS1tRNfqC5gDYoqcDKH0rnZMOC3RnsKMUFCH194CbhvKfvi9vsxZIBEjgTjMZllJg8fgcprhf0KmLDxXHm87XqK/ZC/4BucP1vyJScn1r9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333253; c=relaxed/simple;
	bh=fbECdbEpHlDQAQknb+Ra9jfYd6kaS6AJy/a0znWcQjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S29E8kXWGfBhtMXQR9PX0BIZvxlmGCc2005oiRzJ5MJjg1ZtQdAp+ichgvUIGb9D68mSOW5ot9hEGrnqsOxBO6pvfokVhFwXpdkcrpP12aJsgrcK/JYSnihO1oFi5XiHKL4hcADk6WIcvZulyIT6BYYhbroudWLFA93CIS5b5Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=f0MEw3ZE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="f0MEw3ZE"
Received: (qmail 10145 invoked by uid 106); 2 Sep 2026 07:14:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fbECdbEpHlDQAQknb+Ra9jfYd6kaS6AJy/a0znWcQjA=; b=f0MEw3ZESHe7Db6ipOiK43PUnjTuHud7lqewbH/z4KUytd9x7d3lIRDQTx+dE7bSk6sbytVO6BxwAIdL5yNJlFX3KpGU/960rviH6yoy9exGHd8qLlEfYCRqCKUsAU14iziXlg5qw4fXXZlB15b4kYQvcMYwxocMgOzbA/g8TeV+7lBQIJqmnrIZ/YPZ4Jh9FMgMjFvaSX+JSY8yhcf+Aid9dPwPjTWc5DXZknij9R1S0bVe94I68JGQfNuNp6EgoIlwMRM8cdC881xyOKvN/V0PhqJVW3pri0IL69qQOPCOrQI3VHI5arDwz+RaffOnREyVWls2y7ZEM17TQpf1ug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2026 07:14:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 47498 invoked by uid 111); 2 Sep 2026 07:14:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2026 03:14:10 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Sep 2026 03:14:09 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	git@vger.kernel.org
Subject: [PATCH 1/2] ci: drop ALREADY_HAVE_ASCIIDOCTOR variable
Message-ID: <20260902071409.GA641414@coredump.intra.peff.net>
References: <20260902071113.GA70165@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260902071113.GA70165@coredump.intra.peff.net>

Our install-dependencies script avoids installing asciidoctor if the
CI environment claims to have it already. But the only environment which
made use of this was Azure Pipelines, which went away in 6081d3898f (ci:
retire the Azure Pipelines definition, 2020-04-11). So this conditional
was effectively doing nothing. Let's clean it up.

Signed-off-by: Jeff King <peff@peff.net>
---
 ci/install-dependencies.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 502e518077..2f61fbb07c 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -166,7 +166,6 @@ sparse)
 Documentation)
 	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby
 
-	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
 	sudo gem install concurrent-ruby
 	;;
-- 
2.55.0.1074.gcd259ea853

