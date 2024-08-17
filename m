Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C4F20E6
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879789; cv=none; b=fzJwEqS1pEPvn8LL60f3vRgcYZE8qETlibWvJOg4nszs9Hv6ai9VsoW83++exvgcMqW/4lIx7aTsRRStHRxqXfxsfh4KrtQK152UNqKFQUba4KYjel0ySU82VICt33G9YUI0aqANd2XBh++6E0fZHA1Rse44YEFkWTt5xHy9/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879789; c=relaxed/simple;
	bh=PWAsPAuK/XgUfakIfggmy9KExA2NPl/u0Qcb36qPJQU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCqgpGbC9OA2Vzmktq0et85i4zbH8MR6CXH5LO9BdLUgl4XwE4YyOf+yi5BiiW4ZwK9APEN7xNJoK28CETVrNpj5JsaFOvpjJ9OI2DIYCnSssatD2aPE6v85a4dzCXpocs/VJoqAg9DohYKYTJwjDEN1VKJsQsRSvLuBYTfGgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23591 invoked by uid 109); 17 Aug 2024 07:29:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 07:29:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27579 invoked by uid 111); 17 Aug 2024 07:29:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 03:29:50 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 03:29:45 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 4/5] ref-filter: drop unused parameters from
 email_atom_option_parser()
Message-ID: <20240817072945.GD1535915@coredump.intra.peff.net>
References: <20240817072621.GA1535666@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817072621.GA1535666@coredump.intra.peff.net>

This code was extracted from person_email_atom_parser() in a3d2e83a17
(ref-filter: add mailmap support, 2023-09-25), but the part that was
extracted doesn't care about the atom struct or the error strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6d8b591930..2d7a65a56b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -742,8 +742,7 @@ static int person_name_atom_parser(struct ref_format *format UNUSED,
 	return 0;
 }
 
-static int email_atom_option_parser(struct used_atom *atom,
-				    const char **arg, struct strbuf *err)
+static int email_atom_option_parser(const char **arg)
 {
 	if (!*arg)
 		return EO_RAW;
@@ -761,7 +760,7 @@ static int person_email_atom_parser(struct ref_format *format UNUSED,
 				    const char *arg, struct strbuf *err)
 {
 	for (;;) {
-		int opt = email_atom_option_parser(atom, &arg, err);
+		int opt = email_atom_option_parser(&arg);
 		const char *bad_arg = arg;
 
 		if (opt < 0)
-- 
2.46.0.585.gd6679c16d8

