Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DF7C0B3
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235070; cv=none; b=GkRxmRkLfm6oJauG34qfwiaBaDNLiUhg7yznXrdg/loJ88xusyUjHKOHX80mrHpRwNLEn0QBqWQJSGT9kMQLNBjNFn4DBs+tr+ZiY3uY8wj8eTOenauV/wIGh3uM2wytxe7X3zyJGs+zKgUusN2+gpwkFWEvip52WSOFCQDe/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235070; c=relaxed/simple;
	bh=dE+OgkC6uDx74Un+L8u26xa5OYAByAmeNrMfhV/nnAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FutwrmqmdFzcyOD2Jm12/semRSY2i1UtDxRkgyYQDoWOArZymNLKWAZ5i3VByXg9XbB0T5sQ/gqzvxW4W4iO0QZUTh1oND6qhNfL6J+uX5SQCnnTCb7U7z5UpALOLTImXbUFEAzqYK68YBpLUkfqysdYdtR1leGgz7fpHlwoW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17725 invoked by uid 109); 12 Mar 2024 09:17:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28126 invoked by uid 111); 12 Mar 2024 09:17:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:53 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:47 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 15/16] environment: drop comment_line_char compatibility
 macro
Message-ID: <20240312091747.GO95609@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312091013.GA95442@coredump.intra.peff.net>

There is no longer any code which references the single-byte
comment_line_char. Let's drop it, clearing the way for true multi-byte
entries in comment_line_str.

It's possible there are topics in flight that have added new references
to comment_line_char. But we would prefer to fail compilation (and then
fix it) upon merging with this, rather than have them quietly ignore the
bytes after the first.

Signed-off-by: Jeff King <peff@peff.net>
---
 environment.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/environment.h b/environment.h
index 1c7d0c2f74..05fd94d7be 100644
--- a/environment.h
+++ b/environment.h
@@ -8,7 +8,6 @@ struct strvec;
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
  */
-#define comment_line_char (comment_line_str[0])
 extern const char *comment_line_str;
 extern int auto_comment_line_char;
 
-- 
2.44.0.481.gf1a6d20963

