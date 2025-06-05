Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39401F4176
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109877; cv=none; b=ADUEOoGDvFIex7+2kVI0NE8gn4oXk7IhZGz3Rs762x+WiTRQyfQjD/P0UlkX3UPKkrVd8zytoaABPlO+1TBZ8DnhaXQMp9M16yel5uQsqc5GMcXQGFe9CmGusU/L6YUE8knFcXfcTQQ+kcr7FgADmTX+1BNGrIhvYTP5PqxSXmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109877; c=relaxed/simple;
	bh=cEdJzyH8kbJXlQRmjsLw4UKbo7MtauU3a/84ATb78co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgTY9Goy5SkFncpfg6z7uiiwM2reKolzSwe6ZZMP7syIOAB2gUomEJ+vTItjh9I+nsXZRN9Gc+3jC/EIsjuvQk43mXqOACSuf6BxGylxBfCXm+ANrcD60YTI/oMGbyI88TUR0ctnxu3NJSx8/yJsgM4xltwYlL0r7m5E2EXEIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S1p2SkNo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S1p2SkNo"
Received: (qmail 17334 invoked by uid 109); 5 Jun 2025 07:51:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cEdJzyH8kbJXlQRmjsLw4UKbo7MtauU3a/84ATb78co=; b=S1p2SkNoEuOirAdMkvcrhBBuy5LK4z/dav/xS8IxVotxwGc0i+hsLSGL1JqNWdSbP72whfj29YLvPxCkdHUnxqzTnd6MFXxHqqEs3+JGww/RgHiA3vsW8ToVrfnqEl8sxzas3cDPTNdL2tm/A5kMAbVCL2x/KLRF/8A1vneuYdQTUQdSgRCD+eH2oNGp5F6eITDl62JV5h1o/skOJJXbKNX8QYK9Ftzb55CrqUQBrcIhPwmEdMhbP6r5RbaXEyYgDHz3dw5v/jF3WzFf6TU/1BKsM5nEuRU7kJpz7L69WNvvgyvT+BiyJvVvP2udTI8YhwYiGfK4fJBU+abzpPa9ug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Jun 2025 07:51:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21433 invoked by uid 111); 5 Jun 2025 07:51:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 03:51:17 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 03:51:12 -0400
From: Jeff King <peff@peff.net>
To: Victoria Dye <vdye@github.com>
Cc: Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 3/3] cat-file.c: add batch handling for submodules
Message-ID: <20250605075112.GC2066712@coredump.intra.peff.net>
References: <pull.1929.git.1748890555.gitgitgadget@gmail.com>
 <980ab7f7ef56944df78530dcc9c79b54d1450806.1748890555.git.gitgitgadget@gmail.com>
 <20250604195455.GB1500045@coredump.intra.peff.net>
 <2eb54073-20b3-465a-ad11-a2f22eb55930@github.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2eb54073-20b3-465a-ad11-a2f22eb55930@github.com>

On Wed, Jun 04, 2025 at 05:12:54PM -0700, Victoria Dye wrote:

> > OK. I read over the discussion from last year, which I think mostly
> > centered around this patch. I do still think in the long run it would be
> > nice for cat-file to produce what output it _can_ for a missing object
> > (e.g., the oid and mode).
> 
> One way to handle that could be changing the message to something like:
> 
> submodule SP <mode> SP <oid>

Hmm, yeah. That seemed weird to me at first because it doesn't
necessarily match what the caller asked for via batch-check. But really,
mode and oid are the only reasonable things we could report anyway[1].
And the mode is implicit in the word "submodule", so really there is
only the oid to report.

[1] For now, at least. If we ever finally unify all of the various
    formatting code, then one might in theory be able to feed a refname
    to cat-file and print information about the ref, or perhaps other
    meta-information. But let's not worry about that hypothetical for
    now.

> ...I suspect that'd be even less compatible with existing automation around
> 'cat-file' than just swapping out "submodule" for "missing", and users can
> theoretically infer that the mode is 160000 (S_IFGITLINK). That said, if at
> some point in the future we support submodules with a different mode, then
> an explicit value would be fairly useful.
> 
> Happy to change it or keep it the same, I have no strong preference either
> way.

Right, that makes sense. I do wonder if:

  <oid> missing submodule

might be friendlier to readers who are matching on /^[0-9a-f]+ missing/,
but now I am just guessing at a hypothetical program. So it may not be
worth going down that rabbit hole, and we can just go with what you
posted.

We can always worry about extending it later with an option to say "turn
placeholders for missing objects into empty strings" or similar.

I did come across one other interesting case while thinking about this,
though. When running:

  git cat-file --batch-check='%(objectname) %(objectmode)'

we do not need to access the object at all! So why does a submodule
entry cause us to complain? The answer is that cat-file will (mostly for
historical reasons) confirm the existence of the object name that is fed
to it by calling oid_object_info(). The only exception is when we are
doing --batch-all-objects, since there we know we have the object,
because we found it by iterating the odb. And we optimize out the extra
call for that case (which makes a big difference if you're just printing
the object names).

But since we don't expect submodule entries to exist in the first place,
it might be reasonable to loosen that check. Something like this, though
I think it could benefit from some refactoring:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4b23fcecbd..bb52d9b673 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -304,8 +304,20 @@ struct expand_data {
 	 * This flag will be true if the requested batch format and options
 	 * don't require us to call oid_object_info, which can then be
 	 * optimized out.
+	 *
+	 * The "submodule" variant is true if the format doesn't require it,
+	 * but other options mean we'd usually continue to do so to check
+	 * object existence. We can still omit the call for submodules in that
+	 * case.
+	 *
+	 * This might be less confusing if we break skip_object_info down into
+	 * two parts:
+	 *   - does the format require oid_object_info?
+	 *   - do the other options require checking existence?
 	 */
 	unsigned skip_object_info : 1;
+	unsigned skip_submodule_info : 1;
+
 };
 #define EXPAND_DATA_INIT  { .mode = S_IFINVALID }
 
@@ -477,7 +489,8 @@ static void batch_object_write(const char *obj_name,
 			       struct packed_git *pack,
 			       off_t offset)
 {
-	if (!data->skip_object_info) {
+	if (!(data->skip_object_info ||
+	      (data->skip_submodule_info && data->mode == S_IFGITLINK))) {
 		int ret;
 
 		if (use_mailmap ||
@@ -939,6 +952,12 @@ static int batch_objects(struct batch_options *opt)
 
 		strbuf_release(&output);
 		return 0;
+	} else {
+		struct object_info empty = OBJECT_INFO_INIT;
+
+		if (!memcmp(&data.info, &empty, sizeof(empty)) &&
+		    opt->objects_filter.choice == LOFC_DISABLED)
+			data.skip_submodule_info = 1;
 	}
 
 	/*

I don't think that needs to be part of your series, though. We'd still
potentially need to handle the missing-submodule case for format
requests that actually look at the object, which would hit the "<oid>
submodule" case you're adding. So it could come later (or not at all),
and it's probably only worth pursuing if it would make life easier for
your intended caller.

-Peff
