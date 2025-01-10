Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E99B205E1A
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736509393; cv=none; b=J3oUlXDN31roH+gb/7ZrO7Gwc7m6UwBlenXKgR+KGtUu7sh+EdZnUHDoDiIusIopjGL7cMIjijIUhIM5cWXqzT0KBvgqce4aI4G05E5iiDd8ffZp0iviY0pjkW398whqd/zsZn4CH/Q2C0x8ZEYPRx77WRoUck58J9ye+b7un1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736509393; c=relaxed/simple;
	bh=pRiLAE+zWWPkmCobnpanfRxl4UFGH3p9vi6DVhTTyxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQjo3pT/dL4v/pFlns1zD5gGPFAycLOOr9QrCeoyOx/q6XJT2WABzwXvdPVAjhNoyEmblswew7kH7YocF/+W0l6c9m11Dbb4qpVLYRRvrvqyYqar8c4MFkogK687S5DOuKrUNbLpHhBAx/KzlVc0MpKuBbl8DJ8Ny/CqBjaNY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dNURf9oX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dNURf9oX"
Received: (qmail 4467 invoked by uid 109); 10 Jan 2025 11:43:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pRiLAE+zWWPkmCobnpanfRxl4UFGH3p9vi6DVhTTyxo=; b=dNURf9oXzlKWDuski0xtMTlijARrC1HLQhUdan9yghsUkpVz0gxKG1oQWmYLVUYD6imk5dmkjP8aaiv+1qV3YguJ3KmQTfqxEL7dnGo6a+N+SuJe56nCfj9Xn/GuV62veTqv2y5tzZrcRJx4SE2h7i3rq70J/xsaRZMJi8JJ3LdvBmel2cCHcXUoFapQjdLxffCM/XiF/LL3kCOi0NfqT2/N7OY7a3fxGAbKiCzuEiGjKcI+ZBbqNQgYS4zR8mZW+rwzKRMR9fvcOQUEzk2vC+aSyVWP6RKeYAo1b8M7y0NfL+JnDOlFuBQpGMvAbNiP+xoQ6QyG0vsztHiNwmwUpg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Jan 2025 11:43:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4867 invoked by uid 111); 10 Jan 2025 11:43:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2025 06:43:08 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Jan 2025 06:43:08 -0500
From: Jeff King <peff@peff.net>
To: Olly Betts <olly@survex.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git grep: ^$ false match at end of file
Message-ID: <20250110114308.GB1014503@coredump.intra.peff.net>
References: <20250109235255.GA3418@survex.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109235255.GA3418@survex.com>

On Thu, Jan 09, 2025 at 11:52:55PM +0000, Olly Betts wrote:

> git grep '^$' seems to match at the end of the file, reporting a line
> number one greater than the number of lines in that file.  This does
> not match the behaviour of grep.
> 
> To reproduce:
> 
> $ git init -q git-grep-bug
> $ cd git-grep-bug
> $ echo test > test.txt
> $ git add test.txt
> $ git commit -m test
> [master (root-commit) 55b48b26] test
>  1 file changed, 1 insertion(+)
>  create mode 100644 test.txt
> $ git grep -n '^$'
> test.txt:2:
> $ grep -n '^$' test.txt

Interesting case. Bisection shows that it started doing that in
34349bea60 (Merge branch 'jc/grep-lookahead', 2010-01-20). So it has
been that way for quite a long time. But it is doubly curious, since
neither of the parent trees exhibit the behavior. It is the merge itself
which causes the problem.

In the first-parent tree 34349bea60^1, we are still calling external
"grep", which could explain why we don't see any problem. But building
with NO_EXTERNAL_GREP (and confirming that it uses the internal code),
it doesn't show the problem either!

So where did the bug come from? Puzzled.

That branch itself contains a merge, e2d2e383d8 (Merge branch
'jc/maint-1.6.4-grep-lookahead' into jc/maint-grep-lookahead,
2010-01-12). If we merge that into 34349bea60^1, the innocent
first-parent, then the bug appears. And that brings in a bunch of
lookahead code that could plausibly be the problem.

I'm still confused why 34349bea60^2 (which does have the lookahead code)
doesn't show the bug. I guess there's some bad interaction with what had
happened in the meantime along the first-parent branch.

Looking at:

  git diff 34349bea60^2 34349bea60 -- grep.c builtin-grep.c

turns up:

diff --git a/builtin-grep.c b/builtin-grep.c
index 12833733db..da854fa94f 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -182,8 +182,6 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 			error("'%s': %s", filename, strerror(errno));
 		return 0;
 	}
-	if (!st.st_size)
-		return 0; /* empty file -- no grep hit */
 	if (!S_ISREG(st.st_mode))
 		return 0;
 	sz = xsize_t(st.st_size);
@@ -198,6 +196,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		return 0;
 	}
 	close(i);
+	data[sz] = 0;
 	if (opt->relative && opt->prefix_length)
 		filename = quote_path_relative(filename, -1, &buf, opt->prefix);
 	i = grep_buffer(opt, filename, data, sz);
@@ -223,7 +222,7 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 		 * are identical, even if worktree file has been modified, so use
 		 * cache version instead
 		 */
-		if (cached || (ce->ce_flags & CE_VALID)) {
+		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
 			if (ce_stage(ce))
 				continue;
 			hit |= grep_sha1(opt, ce->sha1, ce->name, 0);

Ah. That middle hunk seems to be the culprit. But that probably means we
were looking at uninitialized memory before, and the lookahead code was
always wrong (but got lucky when there was a non-zero byte in that final
slot). :-/

So probably the issue is the changes from a26345b608 (grep: optimize
built-in grep by skipping lines that do not hit, 2010-01-10).

I'll stop digging on it for now (but adding Junio to the cc as the
author there). Probably it would have been faster just to start with a
debugger than to look through the history. ;)

-Peff
