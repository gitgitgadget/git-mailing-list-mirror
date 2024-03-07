Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B12982D8F
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803808; cv=none; b=P7NVb4DwZ600tVoi8T7ACs3pN2VvqyUiza0uJ/1aszWCRgS41CO8qhsUwjVONrRrNqryVy1sv39PooNEQEgVgu4iy7ogc4cBJokvcPTRvHtqN2st/flcByFQu53vSoQtlhDagz0ccKwbz1f9jzpbOpjv+0OqAojAQbE0sfkN8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803808; c=relaxed/simple;
	bh=7adLsxql+gbei+StrLQJfoBHp+rDPeG+wWsHgOqvqBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0NiRGpWwccEJW438bh4A37KKo3FdSQOn5B+TX8VfctHh3tPpdhJ0d/iyANwZW7xEi2vqVXnZD0P5vNf98sl6V1Fvs5Om1APgiLv1v2VvoHYxt450uvvcuj/HO/vGKsT1pT1bnLjJvmBerQHOStDwQX6jcGqtPU9NrMPDPEBIKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7074 invoked by uid 109); 7 Mar 2024 09:30:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:30:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12765 invoked by uid 111); 7 Mar 2024 09:30:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:30:10 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:30:05 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 14/15] environment: drop comment_line_char compatibility macro
Message-ID: <20240307093005.GN2080210@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307091407.GA2072522@coredump.intra.peff.net>

There is no longer any code which references the single-byte
comment_line_char. Let's drop it, clearing the way for true multi-byte
entries in comment_line_str.

It's possible there are topics in flight that have added new references
to comment_line_char. But we would prefer to fail compilation (and then
fix it) upon merging with this, rather than have them quietly ignore the
bytes after the first.

Signed-off-by: Jeff King <peff@peff.net>
---
I did merge against 'next' and there are no such topics. And likewise
"log -Scomment_line_char next..seen" shows nothing. But as somebody who
maintained a long-running fork for many years, who knows what people are
carrying in their private trees. ;)

 environment.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/environment.h b/environment.h
index 3496474cce..a8b06674eb 100644
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
2.44.0.463.g71abcb3a9f

