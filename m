Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095211EEE6
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749942131; cv=none; b=lXg/tUeIF5q8kxP2vQ9tPLvAi9jIZuVtuzgCrCYy5oJ1bra9MzySCSvoTJSGlK36BFK7n4sleANLrgkqO/d2ALRCmkKMxWPPhtVQmHY7QiULNezWLAWoEPuIfqgt+Z5yRbOT9xpb5iGGWwGtICUWsuAMtwzCGU2X7k/rKBFskCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749942131; c=relaxed/simple;
	bh=c0LEI6VZK+3lqjxN4jfJXqSMxRuo0agwp0iiP8l8i8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkXeIhxaf/3QBdGEcGnGdDfIE9jlidiGTS8xsNKl0p/qLryghgL2+gU2iMwBgh00hRv3uhSvJ3AB1WN2X2XWeYLtVtwn7wUfzmPcWsRreOtRocfa6KgbL0WnnavaCt3yuT3Dy0Td9ZzSwT7ddO9QkMBgfB/zveCHBgw1LswqBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MvpX0yDx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MvpX0yDx"
Received: (qmail 26212 invoked by uid 109); 14 Jun 2025 23:02:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=c0LEI6VZK+3lqjxN4jfJXqSMxRuo0agwp0iiP8l8i8Y=; b=MvpX0yDxm1HOsEnDkwPVqb14YzMs8TRmORUpnZurTsBK9yCE4RuhSwCiCEe4EaZBrhJICBLwT2sEIQfaB45T/ycQxYMVn38alL2DIQN7j9LD+VmoxuU5uAkqPbkj9P+Yl4k7aTxh/Y9e13nBV6RuhtVL4AEDnaVFhR7B2+l8oob9NW1Ei6EEW7zBkTIUZQuePD6RzrKJ9LIawKFvCaqhZeqCpDGhyQN0VpOGWtYNARjzXe6s/a2TSAva6HSSRvCGcs0KnrfiyffFTYE1LGlWX3o7K+XeinvPS8FMciy7/B8ciMk5mJEi8pyLQvAIYba2+/o1LAq+uDAKFRtNSL/+yA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Jun 2025 23:02:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3460 invoked by uid 111); 14 Jun 2025 23:02:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Jun 2025 19:02:01 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 14 Jun 2025 19:01:58 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: lidongyan <502024330056@smail.nju.edu.cn>,
	Alex via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Alex <alexguo1023@gmail.com>, jinyaoguo <guo846@purdue.edu>
Subject: Re: [PATCH] Allocate msg only after fatal checks to avoid leaks
Message-ID: <20250614230158.GA2568638@coredump.intra.peff.net>
References: <pull.1998.git.git.1749843142000.gitgitgadget@gmail.com>
 <3993AF96-E03D-46AB-B18E-8E6C1108EC45@smail.nju.edu.cn>
 <xmqqcyb672mc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcyb672mc.fsf@gitster.g>

On Sat, Jun 14, 2025 at 08:40:43AM -0700, Junio C Hamano wrote:

> > A memory leak on the die() path shouldn't be considered a real leak,
> > right? Since the OS will clean up all memory once the process
> > terminates, explicitly freeing msg isn't necessary in this case.
> 
> It may not matter in practice, but I think the leak checking
> machinery like sanitizers would still complain, so I view efforts on
> plugging such leaks in the error code paths more about decluttering
> the leak checker output to help us spot the real leaks.

I disagree here. These are not really leaks, and a leak-checker that
complains about them is bad.

When we call die(), the pointer to the buffer is still on the stack, and
thus the memory is still reachable and not leaked. Some tools like
valgrind may still report these as "still reachable", but because they
categorize them properly we can ignore them[1].

The one exception we've seen is that an optimizing compiler may reorder
instructions to obliterate the stack (because it knows die() is marked
with NORETURN), causing a false positive. We dealt with that via
d3775de074 (Makefile: force -O0 when compiling with SANITIZE=leak,
2022-10-18). I don't think we've seen any recurrence since then.

And while it may be tempting to say "well, it does not hurt to free them
on the die() path", in my opinion that way madness lies. You may have
access to some local variables that can be freed, but there will be many
other heap allocations that you don't even know about! Here's a toy
example from a similar discussion a few years ago:

  https://lore.kernel.org/git/YNypPeoZTRiOxPPQ@coredump.intra.peff.net/

So I'd really prefer not to go down this route. And I think the existing
code in this patch's pre-image that calls free() before die() only on
one path should be simplified, so that all die() paths consistently do
not worry about this.

I.e., this:

diff --git a/builtin/notes.c b/builtin/notes.c
index cc1163242f..f3d5eda104 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -321,12 +321,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 		die(_("failed to resolve '%s' as a valid ref."), arg);
 	if (!(value = odb_read_object(the_repository->objects, &object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
-	if (type != OBJ_BLOB) {
-		strbuf_release(&msg->buf);
-		free(value);
-		free(msg);
+	if (type != OBJ_BLOB)
 		die(_("cannot read note data from non-blob object '%s'."), arg);
-	}
 
 	strbuf_add(&msg->buf, value, len);
 	free(value);

-Peff

[1] "still reachable" leaks _can_ be useful when returning from main,
    because they may show memory held in global structures that we might
    have been able to free at a more timely spot. But there are a lot of
    these in Git, most of which are not interesting (e.g., is freeing
    the_repository really worth caring about?), and I don't think there
    is a good way to tell the difference.

    More pontificating from that earlier discussion:

      https://lore.kernel.org/git/YN3iIaovvG7XgLQP@coredump.intra.peff.net/
