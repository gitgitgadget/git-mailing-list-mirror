Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF157204F78
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260023; cv=none; b=QPMHhDl2QNtg/FbhrqIlu4WgNwv4Y32L+NB5o+b1e1MHSkI/5odGAV6lwvs9aCR5UWgdmWOYLLUWP6UJ4SKHaN/X++JaMK5JHwotVIPi186A7BI8XrFMmQG9XvPy/qxwUH6PqiX0l1SLAwaxyVVX6Xs/ZWOuP0t/K2y4xeWv+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260023; c=relaxed/simple;
	bh=g5QEsqpc00Z7J9UfzNUaeX/naI97YTEXMjXhZVO6hq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrSfm4VJWD9yuy65m8xmhNxykOFad0fmzJ9ge4ob+/iQx176Jpu3tRod88aiRWVkJeKXz9od2qYqMiRyZsZ+WR6viQvZ2kjc0q6Hxu5ggjSLYdeOnb7Fw1vHrU0ZbdbA8+MPl7LWpHGcSjEZYUy3SgNavPNHMkMU2p8+h+/Qd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aReUZrra; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aReUZrra"
Received: (qmail 30458 invoked by uid 109); 3 Dec 2024 21:06:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=g5QEsqpc00Z7J9UfzNUaeX/naI97YTEXMjXhZVO6hq8=; b=aReUZrra0M3+xIb+0ehzcdbmtMmhmQnULRfGh+d7nW5ooDdYBAUJYSid4hGkBDT8wTwUZmOocok80VWlWUVUi+AsMUBaWp1Q0uaI37rx9nms1p3Gc7silmMHKtmM4rgYqlPPUvKMnnYXltEssq/UTFvvkMzw1SqhH8EfeF12/MhSMeHCkR05k/Wi67FCRH6f9vmshKlKsCOp6B1wVcidP6GNlDhJtGSvpxHfBUhYPF6zJpG4vPd+PvKSrtOEDh6iGqmjHnfIZueFKnhvjLPMbSzNraGfpPjBJ8uKwKWwNlOXpx3bmlGWE0ShbDQqT74OJai3l+4OfuJ1tNPQW35M0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Dec 2024 21:06:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10197 invoked by uid 111); 3 Dec 2024 21:06:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Dec 2024 16:06:52 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Dec 2024 16:06:52 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH 2/1] t9300: test verification of renamed paths
Message-ID: <20241203210652.GA1413195@coredump.intra.peff.net>
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
 <pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com>
 <20241201214014.GC145938@coredump.intra.peff.net>
 <CABPp-BGP8zrSzxcacTzLY-EuYAQW5EwyDGNAMh196udGN18fmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGP8zrSzxcacTzLY-EuYAQW5EwyDGNAMh196udGN18fmg@mail.gmail.com>

On Tue, Dec 03, 2024 at 12:01:51AM -0800, Elijah Newren wrote:

> > On Sat, Nov 30, 2024 at 01:09:29AM +0000, Elijah Newren via GitGitGadget wrote:
> >
> > >     Changes since v1:
> > >
> > >      * Moved the check to a higher level, as suggested by Peff.
> >
> > Thanks, the code change looks good. Is it worth tweaking one of the
> > tests to do "R innocent-path .git/evil"? Otherwise I don't think there's
> > any coverage of the file_change_cr() call at all.
> 
> I would say yes, but since this patch too has made it to next and is
> marked for master, I'm kinda tempted to just leave it as-is...

Is is tempting. :) I wrote this up, though, which can just go on top (of
en/fast-import-verify-path).

-Peff

-- >8 --
Subject: [PATCH] t9300: test verification of renamed paths

Commit da91a90c2f (fast-import: disallow more path components,
2024-11-30) added two separate verify_path() calls (one for
added/modified files, and one for renames/copies). But our tests only
exercise the first one. Let's protect ourselves against regressions by
tweaking one of the tests to rename into the bad path. There are
adjacent tests that will stay as additions, so now both calls are
covered.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t9300-fast-import.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e2b1db6bc2..fd01a2353c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -553,9 +553,16 @@ test_expect_success 'B: fail on invalid file path of .' '
 	commit refs/heads/badpath
 	committer Name <email> $GIT_COMMITTER_DATE
 	data <<COMMIT
-	Commit Message
+	Good path
+	COMMIT
+	M 100644 :1 ok-path
+
+	commit refs/heads/badpath
+	committer Name <email> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	Bad path
 	COMMIT
-	M 100644 :1 ./invalid-path
+	R ok-path ./invalid-path
 	INPUT_END
 
 	test_when_finished "git update-ref -d refs/heads/badpath" &&
-- 
2.47.1.707.g92f6f18526

