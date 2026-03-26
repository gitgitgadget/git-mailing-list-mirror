Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3CB41C30C
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546171; cv=none; b=a5+6+V16n47sm6HwFn4p9PdB4GeboeZac6Fb+fcpRHYnasU9fI5ElP8aYwncab0r5tlWwkdQPUIIV3EGEWrJLAj7AOi6sGhNncTPB+LJKnTtGqH4G56fV57ejRSGLOb8qpPEKZKdtFHNf2abNa6T0GDz75YqIw7u9ZDw0MLcWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546171; c=relaxed/simple;
	bh=n7phfw37jQbZD8v3ZVzZqGcF0ybzHgsBBwhaLq0FN/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1RfjL2v5RjmF/xIdJLwHgl0WheIgzqlNwEAZC66eJswDNdUC5gqwb0CNC+ddMGeqaBgBdAP+iGON5rgHLUluKR1VeI9ULziUnZrv58SnTXZcncflSZhsU2VMjQftIwcVit2EmkX47UYgX+vjnfq5Y5K4kBUnVsSTeDwf7mCu0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PET344X+; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PET344X+"
Received: (qmail 154756 invoked by uid 106); 26 Mar 2026 17:29:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=n7phfw37jQbZD8v3ZVzZqGcF0ybzHgsBBwhaLq0FN/I=; b=PET344X+iVkulxP9DLm6EktG3wc6XlCXuwgfHuYGn6ctBQoGY52jWui/HYrlnh/8d1FrkDv2CGt1K13ymy883xTccQ2Mbz8ujhUtXrXhqIT9yEy67dvfdOzHWrXssE0XdRsNrsFfxmlLMNeUNZWGI4NRVWboD5dEMx5wsOzBlhWiwhQesqhHTIg8A7LzpMFkKiWRkEjcaeibzyIob/QIdLS90Nl8o0QvwUx43LAAQ2X8ORTGRulafS8gbtIUXI/D4EXF3NkHC1eZ7afb5N4bKvJuL7M0wR5L8YJ629XTqb7OBnSMjsnTazCzmHeLqR5PiR8JGiH2axzT22wmt2yksA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 17:29:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 214585 invoked by uid 111); 26 Mar 2026 17:29:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 13:29:20 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 13:29:20 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] test-lib: catch misspelt 'test_expect_successo'
Message-ID: <20260326172920.GA2447148@coredump.intra.peff.net>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-2-gitster@pobox.com>
 <20260326040828.GA686242@coredump.intra.peff.net>
 <xmqq8qbesm1r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qbesm1r.fsf@gitster.g>

On Thu, Mar 26, 2026 at 07:27:44AM -0700, Junio C Hamano wrote:

> >  test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
> > -	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
> > +	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
> >  	test_match_signal 13 "$OUT"
> >  '
> >  
> >
> > That neglects to echo $? when large_git surprisingly succeeds, but that
> > would mean $OUT is empty, which would cause the test to (correctly)
> > fail. I kind of hate it, though.
> 
> Would
> 
> 	OUT=$( ((large_git && echo 0 || echo $? 1>&3) | :) 3>&1 )
> 
> do a bit better?

Yeah, that is better (though in practice the same for our purposes in
this particular test).

> We can keep fixing things one by one as we find these little
> glitches and gochas, of it may be a whack-a-mole exercise that
> eventually will turn out to be futile.  I dunno.

Yeah, after getting the tests passing locally I pushed to CI and saw a
ton of failures. I think one is just:

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 630a47af21..7f920d7b9e 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -12,7 +12,7 @@ TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
-setfacl -k . 2>/dev/null
+setfacl -k . 2>/dev/null || true
 
 # User must have read permissions to the repo -> failure on --shared=0400
 test_expect_success 'shared = 0400 (faulty permission u-w)' '

and another seems to involve test_done barfing when no tests have been
run (e.g., if we hit a skip_all case). I didn't investigate further.

-Peff
