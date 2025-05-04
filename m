Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206C36B
	for <git@vger.kernel.org>; Sun,  4 May 2025 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746347240; cv=none; b=Dn1Dh3I2VSTHaUMvvVC7p4Fw1eVtBZMnlUczQbvnQVfiDjMIeEBmI0kTEwYW9AF4VAvwxWJoRDUyrfSQXVW9DrC2hkdaVXAXuR8IodLLjL4ShJnKslLo0SRhe0WedHMWBb2H+IOl9sHN5o+/LDK+O/CXqEtbREgNdxg+eVayyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746347240; c=relaxed/simple;
	bh=OBBePJLcljjbguTydT2qTNd5z/jZPfa2t2C+4aF++i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cncCMOroJVhMptRZkq3voWplYpfPsGZ8svBzTkr8joh1J7RCX+PdULggjEG6BRPl67jC8/KA9N1AEL5iYQN3Ed5ntgYpTOBNMxI0Dq89KhIRl9zKi+UA1y2hCxcx/OsAfmw1hJsOqo25xWyedxzd3xPANdc+FTujBb9/XlGyChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Gw5oHrv6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Gw5oHrv6"
Received: (qmail 16259 invoked by uid 109); 4 May 2025 08:27:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OBBePJLcljjbguTydT2qTNd5z/jZPfa2t2C+4aF++i8=; b=Gw5oHrv6kZq8G/gpC/EGFNqxKB9NMMSm/T0qiLP+J1+J2cTThdh7qDpj4Htp4P193IP5tIIiJLkiSUdikyPseLEqOe/Y2n19mTrft5nc17k4s8wT858FozmAjMmmAprX6IHoLWH8w4Df3Gt0YuuGLCpx27VW0pPP+mYFztIEiEPN2+oNBt2Pe60Kc6wNBAxZOhDDqgVHY+XO2GvPbIboBjsLeIADTT4At6XYAhyJoA++KE9aakNMVWjxfUqWpcwyWy6WcXG1ubhHi/+25xOjL29d03pQwCsXqjo/OVIulEPYrKTFH+pLiOI2wCETi621K0juL2Kes73Y8UPbQZesfA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 04 May 2025 08:27:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16798 invoked by uid 111); 4 May 2025 08:27:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 May 2025 04:27:20 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 4 May 2025 04:27:15 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [Bug?] "git show -s" still worries about renameLimit?
Message-ID: <20250504082715.GA6257@coredump.intra.peff.net>
References: <xmqq8qncst4f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8qncst4f.fsf@gitster.g>

On Sun, May 04, 2025 at 01:00:16AM -0700, Junio C Hamano wrote:

> $ git show -s | cat
> warning: exhaustive rename detection was skipped due to too many files.
> warning: you may want to set your diff.renameLimit variable to at least 6123 and retry the command.
> commit a3a9dd8be6b8767e690b014715aefa2ba39672e2 (HEAD -> master)
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Sat Apr 19 14:27:03 2025 -0700
> 
>     Something something something
> 
> As we have -M (rename detection) on by default these days, and this
> particular commit has very many deletions and creations, if we were
> asking to show some diff (not necessarily patch text output, but
> just "--stat" or even "--raw") it is fair to warn about rename
> detection being limited by diff.renameLimit.
> 
> But the command knows that with "-s" the user declined to show any
> diff computation, so it feels wrong to even _count_ how many
> diff_filepairs there are and comparing with the renameLimit, in
> order to warn about busting the limit.

This seemed eerily familiar. See this thread:

  https://lore.kernel.org/git/87h750q1b9.fsf@gnu.org/

and in particular this proposal:

  https://lore.kernel.org/git/YqI%2FTcZyXomxtXtN@coredump.intra.peff.net/

I've been carrying that patch in my tree (reproduced below), but I don't
remember why I never polished it. I wonder if it was the question about
--exit-code below. Or maybe I was just nervous about other corner cases.

-- >8 --
Subject: [PATCH] show: skip diff when possible

Running:

  git show -s $commit

will still compute a diff for $commit, even though we aren't going to
show it. This is wasted computation, since it cannot affect the output
or exit code of the program.

In the more general case:

  - if the requested diff format is NO_OUTPUT, then we won't change the
    output of the diff itself

  - if rev_info.always_show_header is set, then we will show the commit
    regardless of whether the diff is empty (which is true for git-show,
    for example, but not git-log)

  - we don't use --exit-code here (should check?)

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index a4d4ab59ca..740219ce99 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1105,6 +1105,10 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	if (!all_need_diff && !opt->merges_need_diff)
 		return 0;
 
+	if (opt->diffopt.output_format == DIFF_FORMAT_NO_OUTPUT &&
+	    opt->always_show_header)
+		return 0;
+
 	parse_commit_or_die(commit);
 	oid = get_commit_tree_oid(commit);
 
-- 
2.49.0.754.gd827f9aa09

