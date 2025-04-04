Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151881A08B8
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743757096; cv=none; b=H5SQyTn4pBzr6zWlw+cYeG+tXIonO3IwPCHIwY9FpT5VtaEP5syHdA9gZpgoUUuHe2vKy7y4OmE9SVCjNUct94d7eu9cOxMNAb9czrjQ54jtKlkDdRNEBEXeq/pqR3i4mgjAkJfY2bNk/rGzNV47ATsiNK7+O7gVLys/Kvnuf48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743757096; c=relaxed/simple;
	bh=EhSPsgPjn9gugECNI59yAHRTdImLkW/yduWblijQxnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCKCTw7Z7TZ0+J3vcHkn/mZQGTB1BbO0C6K5owWYAbXq5T1rXYJjIaW1bREB2BbT03zJCkI8eGIaDa30XuabSzkl9bmhgeWCta3nc+0KV1e3tMFxtADUIilDXQCBeswnASuNY0kjlfC3PYFTqp6qjgzM9s73ZmHUU5SS6EGXtpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WGr/KhNK; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WGr/KhNK"
Received: (qmail 27956 invoked by uid 109); 4 Apr 2025 08:58:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EhSPsgPjn9gugECNI59yAHRTdImLkW/yduWblijQxnE=; b=WGr/KhNKuSO1eqwWs2IWP+pen+t833qrVozpOailsSjOkxtMIYGWL66J2qoVw3N16YDsHlkAtX6IQZT8/axo5HvfRjtdHqf7F+8kF1cr8XHI3rJ9OHn606xYylN++16/d+V4RsLMA4f8Hfvwvr6OVG8oUujt0eoCzDuwsqjvKgWRd/s+Rv5scBctJEGYaEP+DHqTB4MOGlIJlUWi6ROsD2w6zzKMssyHA/9jnLzZbw2K83u6jwu3XXr0mpp/0/5MXanhyoiAhQymzFjQkTxJ49vgN62hlLvQIw2qoC3CJxME4ebYmA4O0Ri2O9QTSR97HQVPvrNfh4rTrpP9Hj3PVw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Apr 2025 08:58:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2233 invoked by uid 111); 4 Apr 2025 08:58:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Apr 2025 04:58:12 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 4 Apr 2025 04:58:12 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, Bence Ferdinandy <bence@ferdinandy.com>,
	git@vger.kernel.org
Subject: jk/fetch-follow-remote-head-fix, was Re: What's cooking in git.git
 (Mar 2025, #07; Wed, 26)
Message-ID: <20250404085812.GA772404@coredump.intra.peff.net>
References: <xmqqiknwhsdz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqiknwhsdz.fsf@gitster.g>

On Wed, Mar 26, 2025 at 05:46:00AM -0700, Junio C Hamano wrote:

> * jk/fetch-follow-remote-head-fix (2025-03-18) 3 commits
>  - fetch: don't ask for remote HEAD if followRemoteHEAD is "never"
>  - fetch: only respect followRemoteHEAD with configured refspecs
>  - Merge branch 'jk/fetch-ref-prefix-cleanup' into jk/fetch-follow-remote-head-fix
>  (this branch uses jk/fetch-ref-prefix-cleanup.)
> 
>  "git fetch [<remote>]" with only the configured fetch refspec
>  should be the only thing to update refs/remotes/<remote>/HEAD,
>  but the code was overly eager to do so in other cases.
> 
>  Will merge to 'next'?
>  source: <20250318053905.GA2051217@coredump.intra.peff.net>

I think so. The design was based on our discussion, and it seemed to get
positive comments from you and Taylor. It might be nice to get an ack
from Bence, since this is his feature I'm modifying.

Taylor did note one place where the resulting code is a little hard to
read.  That could be addressed by adding this on top (or it could be
squashed into patch 1):

-- >8 --
Subject: [PATCH] fetch: make set_head() call easier to read

We ignore any error returned from set_head(), but 638060dcb9 (fetch
set_head: refactor to use remote directly, 2025-01-26) left its call in
a noop "if" conditional as a sort of note-to-self.

When c834d1a7ce (fetch: only respect followRemoteHEAD with configured
refspecs, 2025-03-18) added a "do_set_head" flag, it was rolled into the
same conditional, putting set_head() on the right-hand side of a
short-circuit AND.

That's not wrong, but it really hides the point of the line, which
is (maybe) calling the function.

Instead, let's have a full if() block for the flag, and then our comment
(with some rewording) will be sufficient to clarify the error handling.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3658509740..dbf741ef5b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1903,12 +1903,13 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (do_set_head && set_head(remote_refs, transport->remote))
-		;
+	if (do_set_head) {
 		/*
-		 * Way too many cases where this can go wrong
-		 * so let's just fail silently for now.
+		 * Way too many cases where this can go wrong so let's just
+		 * ignore errors and fail silently for now.
 		 */
+		set_head(remote_refs, transport->remote);
+	}
 
 cleanup:
 	if (retcode) {
-- 
2.49.0.578.gaa93496c6a

