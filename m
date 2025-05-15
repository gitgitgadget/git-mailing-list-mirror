Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E64B1E59
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747342201; cv=none; b=dWpj+vizVosnVxsPqvTYz3R33Nr98BUf2envWMoonYVC2rTmCEkuO9/ixjYT9Pp/yAIZhZknomB2JC6m5RpDO/dRgJRU1kP4LXnfTkmP7klbND3z1WcAc3xGei2NG1UvPO74BwoeV9kylqwrlhMIwuDNM5t0WGuFk150cOHucXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747342201; c=relaxed/simple;
	bh=7B/w0ZbFxdprWACmIWBXsIWDpV0BDUeIuVCJ3WEs390=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYA9YQo3Vu6W1wEmS4lavY5sX/SB4t3sCQrSYy4AzbXcLYTcQoXfGTSzxOXcoW9RmkcYRnMLK0uOfEPx3+QV0dTxEem4rqpghF1S27Leb9YUQA3c9Uuid0vuO+GYLWX/okckX1/nbxdI0qE4nxyxrVzOVo9Oe+OPlTS9mqoQy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZrKTnb31; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZrKTnb31"
Received: (qmail 1107 invoked by uid 109); 15 May 2025 20:49:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7B/w0ZbFxdprWACmIWBXsIWDpV0BDUeIuVCJ3WEs390=; b=ZrKTnb31H7fYcQxMqgCXFGRwpX3JnyFgDRYX8Ikva2tCKh3V3JMt/kpNYUE6+AdcXWBb3jpj06x5qdscxsfAS2pkTPjIE/3upW/2Cb3QJFqI7QSozdhbxRLFlOETdHptUFocInWhDSuWZTAfXH+K3ZZ6Ep3snDUuJ78k7aHzKHMS4Rm4jjCa4HIloq0AE5nzu0g7Q1OWcgIBVyfUFSq0/dOEhE5piAq04Le2D5DbYDwpgbJInb+mvepR+324oKXeov1z3VsmUnc95640xu0hDnM0Og1j90fEICOhhcpNCpwddYUrKjhzlxgh2xcOtcxP9t9VFv1lm9BefKP3TYMuTA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 20:49:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31315 invoked by uid 111); 15 May 2025 20:50:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 16:50:00 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 16:49:57 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/11] commit: simplify code
Message-ID: <20250515204957.GA3334771@coredump.intra.peff.net>
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
 <767b1e74fc70d78c7e3c84a2dc5eb7b607252f4f.1747314709.git.gitgitgadget@gmail.com>
 <20250515194806.GC3320240@coredump.intra.peff.net>
 <xmqq4ixlzk43.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4ixlzk43.fsf@gitster.g>

On Thu, May 15, 2025 at 01:37:00PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... there are any non-ita entries). Though in that case I'd think:
> >
> >   committable = 0;
> >   for (i = 0; i < cache_nr; i++) {
> > 	if (!ce_intent_to_add(...) {
> > 		committable = 1;
> > 		break;
> > 	}
> >   }
> >
> > would be the most clear, since we do not otherwise care about the actual
> > number of ita entries. And lets us break out of the loop early.
> 
> Exactly.  If you focus on the warning too narrowly, the minimal
> change in the original patch does look OK, but in the original (even
> before Dscho's patch, that is) the intent is unclear, as opposed to
> what you showed above.  And the update to squelch false positive
> does not improve the clarity of the logic as the above rewrite does.

OK. If we do want to refactor, I think pulling it into a separate
function is the most descriptive, like:

diff --git a/builtin/commit.c b/builtin/commit.c
index 66bd91fd52..a8d43d223d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -740,6 +740,15 @@ static void change_data_free(void *util, const char *str UNUSED)
 	free(d);
 }
 
+static int has_non_ita_entries(struct index_state *index)
+{
+	int i;
+	for (i = 0; i < index->cache_nr; i++)
+		if (!ce_intent_to_add(index->cache[i]))
+			return 1;
+	return 0;
+}
+
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct commit *current_head,
 			     struct wt_status *s,
@@ -1015,14 +1024,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			parent = "HEAD^1";
 
 		if (repo_get_oid(the_repository, parent, &oid)) {
-			int i, ita_nr = 0;
-
 			/* TODO: audit for interaction with sparse-index. */
 			ensure_full_index(the_repository->index);
-			for (i = 0; i < the_repository->index->cache_nr; i++)
-				if (ce_intent_to_add(the_repository->index->cache[i]))
-					ita_nr++;
-			committable = the_repository->index->cache_nr - ita_nr > 0;
+			committable =
+				has_non_ita_entries(the_repository->index);
 		} else {
 			/*
 			 * Unless the user did explicitly request a submodule

-Peff
