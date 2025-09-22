Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C70213E9C
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 20:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572713; cv=none; b=KxsDn+DjihanfegrnE1COhkEAEiKF8C4BUj0wrfAMUjGquP9HItZDnhCUWi0RXbLyGps5Z8rN1TzaGqWoh7USB44P/X1eloPDu2PBJU8lvEbQVpkBhrn772+0umBCN94YzPju3yifJcPdDYMmTUo+1v5gJShgQ014jcKNLF02Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572713; c=relaxed/simple;
	bh=b8k9zaxG8xo5C4q0XFRS75ynHyPlA/Iq1zQfEUvbmMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwByNfkdAeYjovBycZDSQ/VlEDjASCZIsF59CJEb6K13eF81Vr/e0WulAq3OaRn47nBf3wahTXSpGIx39thJWSF1Zy6hqfLDt3GXxTbiBHj8jMSL1FXyDDA2G9tzgqqC3Zh42pcwixMzsLMcVm7j4UnuVsJGCUBIRMe44mEfHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OjtE4TPU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OjtE4TPU"
Received: (qmail 162585 invoked by uid 109); 22 Sep 2025 20:25:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=b8k9zaxG8xo5C4q0XFRS75ynHyPlA/Iq1zQfEUvbmMI=; b=OjtE4TPUgLjUnJmYuRdVmTJpOVrPRTgl9OcPyMCoIcZPBrg5bAAvH43aIocSVvFTO2587EaMbkBtf7e6gwMpfrwxMnOqLQPe0oHYaa4iEwOAsE/Z5c4SuFcushbjB5Gnf2bbmalaz0l4tAT5PzziNuuviPYTclU9GmGYC2nFcf58Bx37AAfUlY5KztSR2C8IOm4Ri9OEbPL5eesGpn4WEKMnDvYB+8QmcaRSE+kXy3tEnrgH5jRWwiWI/sfn33sO+7mQTwXF1GfwBb+8Vi/V6PXZ5oAbsAyqjTqUf94YNHM02Y8ubobSda5QdPIjy1vZXWq23cKFxXDU0KXz/bgtQg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Sep 2025 20:25:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 259937 invoked by uid 111); 22 Sep 2025 20:25:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Sep 2025 16:25:09 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 22 Sep 2025 16:25:09 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/6] stash: tell setup_revisions() to free our allocated
 strings
Message-ID: <20250922202509.GE2205919@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
 <20250919224027.GA594545@coredump.intra.peff.net>
 <xmqq1pnywkwv.fsf@gitster.g>
 <20250922190555.GA2205919@coredump.intra.peff.net>
 <xmqqikhath3d.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqikhath3d.fsf@gitster.g>

On Mon, Sep 22, 2025 at 12:36:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I had originally written just:
> >
> >   test_expect_success 'stash show -- does not leak' '
> > 	git stash show --
> >   '
> >
> > but it felt funny, since the test is doing nothing in a build without
> > SANITIZE=leak. If we are OK with that funniness, I can switch back to
> > that.
> 
> We have a prerequisite for that.  Very nice vehicle for
> documentation purposes, even though we do not care about a single
> "stash show" invocation for correctness or performance reasons.

Ah, nice. It crossed my mind that we could try marking it as such, but I
forgot (or never knew) that we already had this prereq available. I
guess it was mainly used as "!SANITIZE_LEAK" before for suppressing
leaks.

> Perhaps I can squash the following in, unless you have other changes
> in mind.

Thanks, that looks perfect for the code change. But we probably need to
update the discussion of the test in the commit message. Here's what I
came up with (replacing patch 1):

-- >8 --
Subject: [PATCH] stash: tell setup_revisions() to free our allocated strings

In "git stash show", we do a first pass of parsing our command line
options by splitting them into revision args and stash args. These are
stored in strvecs, and we pass the revision args to setup_revisions().

But setup_revisions() may modify the argv we pass it, causing us to leak
some of the entries. In particular, if it sees a "--" string, that will
be dropped from argv. This is the same as other cases addressed by
f92dbdbc6a (revisions API: don't leak memory on argv elements that need
free()-ing, 2022-08-02), and we should fix it the same way: by passing
the free_removed_argv_elements option to setup_revisions().

The added test here is run only with SANITIZE=leak, without checking its
output, because the behavior of stash with "--" is a little odd:

  1. Running "git stash show" will show --stat output. But running "git
     stash show --" will show --patch.

  2. I'd expect a non-option after "--" to be treated as a pathspec, so:

       git stash show -p 1 -- foo

     would look treat "1" as a stash (a synonym for stash@{1}) and
     restrict the resulting diff to "foo". But it doesn't. We split the
     revision/stash args without any regard to "--". So in the example
     above both "1" and "foo" are stashes. Which is an error, but also:

       git stash show -- foo

     treats "foo" as a stash, not a pathspec.

These are both oddities that we may want to address (or may not, if we
want to retain historical quirks). But they are well outside the scope
of this patch. So for now we'll just let the tests confirm we aren't
leaking without otherwise expecting any behavior. If we later address
either of those points and end up with another test that covers "stash
show --", we can drop this leak-only test.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/stash.c  | 3 ++-
 t/t3903-stash.sh | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index f5ddee5c7f..e5ab3c4cf5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -957,6 +957,7 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 static int show_stash(int argc, const char **argv, const char *prefix,
 		      struct repository *repo UNUSED)
 {
+	struct setup_revision_opt opt = { .free_removed_argv_elements = 1 };
 	int i;
 	int ret = -1;
 	struct stash_info info = STASH_INFO_INIT;
@@ -1015,7 +1016,7 @@ static int show_stash(int argc, const char **argv, const char *prefix,
 		}
 	}
 
-	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
+	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, &opt);
 	if (argc > 1)
 		goto usage;
 	if (!rev.diffopt.output_format) {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0bb4648e36..daf96aa931 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1741,4 +1741,8 @@ test_expect_success 'submodules does not affect the branch recorded in stash mes
 	)
 '
 
+test_expect_success SANITIZE_LEAK 'stash show handles -- without leaking' '
+	git stash show --
+'
+
 test_done
-- 
2.51.0.582.g88c6764cd5

