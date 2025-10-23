Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D55311C07
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761221733; cv=none; b=jfpYt/DGR5Ye8hLKYnFa0vn9QUu4WvOj05FDxpF7LfGlBOS4xqb78DF/x+XDg/yX5ddyfyTCqCK3fa1DQiF780Pvn70FTTxsP6mP984cMGkms8Q7wwaxgoRPU5BWL/D85T6L8oNgrU4Luf+cr6LeicccAb5Oq4qDooQY9T24nM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761221733; c=relaxed/simple;
	bh=FlqRIFLi1yLi5ZIzvVQeERtAPzYUKSJCEUi/6u6zIS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYoHeChYalVYoLV8du/7cVGRKLhugvCPLaO2fqgci5Vkg26VIoTeWFwg8YfEDUG1ZIlDSeZyOt7SCktl8g9XVg1EWqRYhmlbMYaNWwDhoydHOwD7ojKKPX1GNywTYnK7L3T4b8frjFIoKcWWcM4JLdIHYMdyNAhF5sz/kXVW75k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TydY0jPs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TydY0jPs"
Received: (qmail 315575 invoked by uid 109); 23 Oct 2025 12:15:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FlqRIFLi1yLi5ZIzvVQeERtAPzYUKSJCEUi/6u6zIS4=; b=TydY0jPs3eMUiEDklR4IEyaKQZR4hatrebuiHAt9zJmZN97IWhQfkVsgQsZCUXPy8x5lAfHdfLSZOeU5e70wdvlbRm4kimbmXK5m4+rPlT34eniAyuBIraL4gttlxRQCx+WtD46Gpc4/nSrTaJ8Rg3EtpyeCcgCh5qUiHqjyS0PkV6P8M0kZrGTbQG4bknU/p1j3t9hpoO4jpAicf9cTCEXorOyZzIE0mnRrqudjkrQNNw54kZBddeYM7QH4D1rSISed34/wGqQK7/+BDVpf7G9zoDHLvp6WjXMwzBTNXz0wmcdpxP9APbbnJI/zuz0+JqASuV5YhRm6kx9WgBM8NA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Oct 2025 12:15:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 490700 invoked by uid 111); 23 Oct 2025 12:15:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Oct 2025 08:15:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 23 Oct 2025 08:15:25 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jake Zimmerman <jake@zimmerman.io>, Lidong Yan <yldhome2d2@gmail.com>,
	git@vger.kernel.org
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
Message-ID: <20251023121525.GB1123594@coredump.intra.peff.net>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
 <20251018094037.GA1060824@coredump.intra.peff.net>
 <xmqqh5vww7xa.fsf@gitster.g>
 <20251021073640.GB259661@coredump.intra.peff.net>
 <xmqqy0p4wcac.fsf@gitster.g>
 <20251022091112.GB853931@coredump.intra.peff.net>
 <xmqqikg6zxui.fsf@gitster.g>
 <20251023120101.GA1123594@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251023120101.GA1123594@coredump.intra.peff.net>

On Thu, Oct 23, 2025 at 08:01:01AM -0400, Jeff King wrote:

> You could even imagine diff_flush_patch_quietly() saving the /dev/null
> descriptor in a static variable and effectively leaking it (or if we
> want to be more structured, cached inside the diff_options struct). And
> then the callers do not have to worry about it at all.

Something like this (on top of jk/diff-from-contents-fix, replacing what
you have in jc/diff-from-contents/fix):

diff --git a/diff.c b/diff.c
index 9b8d658b9e..c9d3aaeb0f 100644
--- a/diff.c
+++ b/diff.c
@@ -6175,14 +6175,34 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 /* return 1 if any change is found; otherwise, return 0 */
 static int diff_flush_patch_quietly(struct diff_filepair *p, struct diff_options *o)
 {
+	static FILE *dev_null;
+	FILE *saved_file = o->file;
+	int saved_color_moved = o->color_moved;
 	int saved_dry_run = o->dry_run;
 	int saved_found_changes = o->found_changes;
 	int ret;
 
+	/*
+	 * As an extra precaution against code sending output to o->file even
+	 * when o->dry_run is set, redirect to /dev/null.
+	 *
+	 * We cache the /dev/null filehandle forever, effectively leaking it.
+	 * Gross, but it's O(1) gross-ness. A better solution would perhaps be
+	 * stuffing it into o->cached_dev_null or something, and freeing it
+	 * with the rest of the diff options.
+	 */
+	if (!dev_null)
+		dev_null = xfopen("/dev/null", "w");
+
+	o->file = dev_null;
+	/* TODO check if this is actually doing anything! */
+	o->color_moved = 0;
 	o->dry_run = 1;
 	o->found_changes = 0;
 	diff_flush_patch(p, o);
 	ret = o->found_changes;
+	o->file = saved_file;
+	o->color_moved = saved_color_moved;
 	o->dry_run = saved_dry_run;
 	o->found_changes |= saved_found_changes;
 	return ret;
@@ -6876,15 +6896,6 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
 	    options->flags.exit_with_status &&
 	    options->flags.diff_from_contents) {
-		/*
-		 * run diff_flush_patch for the exit status. setting
-		 * options->file to /dev/null should be safe, because we
-		 * aren't supposed to produce any output anyway.
-		 */
-		diff_free_file(options);
-		options->file = xfopen("/dev/null", "w");
-		options->close_file = 1;
-		options->color_moved = 0;
 		for (i = 0; i < q->nr; i++) {
 			struct diff_filepair *p = q->queue[i];
 			if (check_pair_status(p))

And you can see the difference with the tests Lidong added in t4013, or
just with this simple sequence:

  git init
  echo content >file
  git add file
  git commit -m foo
  git.compile show -w --name-status

Without either the /dev/null redirection above (or the actual dry_run
fixes), you get a bogus "diff --git" header in the output.

So mulling over that for a moment...if we are going to teach all code
paths that look at o->file to check o->dry_run, why do we need a
/dev/null redirection at all? Can't we just set o->file to NULL, and
that is the clue that we do not want output?

I know that is more intricate, and not what we want to do for the
immediate regression fix. But in the long run it makes more sense to me.
We get rid of the extra flag, and any code that does the wrong thing (by
trying to write to o->file) will blow up horribly with a segfault rather
than quietly produce wrong output.

-Peff
