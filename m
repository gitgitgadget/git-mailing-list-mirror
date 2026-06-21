Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B10282F21
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782063922; cv=none; b=D7eGz1TgQFQl63e+W5uNeoTWWGaZliTW/KncghHa/lAr7BB4vDyI8Jg0LpOhkv5oxCJjq91dbv9v3YkbQqZzxv7lrhTf8RsEPARcTbRoVHGGPoEDbOklZXZ7U+PEQkwNv7NH+VXdNp8JEBVU4sGEhA9gaTWfcdMFrisc/QRPis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782063922; c=relaxed/simple;
	bh=Uum8TKnIHwom3qMcsX7ZPhRGnLPPq25p5Kvpd9l1/Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSdd7qHqEZW9a70stMe61t9vKmkRKU4m0J5fi11wjAV0VzMmwaIFI76IRT+KtqhMXJIUjYTOUcl2I+YiSaunM0nB4H5IThRIQXLGi+AxPQ1p1SIP2WtZWs7DJYo+ZGSlHw3Yo7jNf4UHT5Oc/ITdSqDwCdYbR1EJPV96KR1WXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PkN9ms15; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PkN9ms15"
Received: (qmail 204463 invoked by uid 106); 21 Jun 2026 17:45:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Uum8TKnIHwom3qMcsX7ZPhRGnLPPq25p5Kvpd9l1/Ro=; b=PkN9ms15RLieZQwVvG6UUm3OmxRZU838cE9UEp49BcGeNGerclmVfn1TVi1L9Pni3OV/s1QKvyh6PsRqDGcBANq2y/wveG4xQtAZTaBnmztR/iFjojNR4/TW8XaOhIc+KnoSIux7z6w0HUpKMFYOvHamtd3gCuW/NYuX2Odo8aRZgRAXj9qJ0PBAWfsjUkAUqQAursK0JOzITGtSA3Zn0/9OF0weCi04TLI3H+7Tx/TOFdXmU5TTtkTp6MHTkygFmkPuRPIqNR+zuyVwizt+dBmAbP3DzqdjVNje69RFhE/D6oM4yuF2F75qroISBSHQcmaPD8e1/BWhtAOlY9/fGg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Jun 2026 17:45:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 520912 invoked by uid 111); 21 Jun 2026 17:45:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Jun 2026 13:45:20 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 21 Jun 2026 13:45:18 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
Message-ID: <20260621174518.GB2206349@coredump.intra.peff.net>
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
 <20260609001134.GD358144@coredump.intra.peff.net>
 <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
 <20260611085526.GL2191159@coredump.intra.peff.net>
 <CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
 <xmqqa4sog1e9.fsf@gitster.g>
 <20260621172432.GA2206349@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260621172432.GA2206349@coredump.intra.peff.net>

On Sun, Jun 21, 2026 at 01:24:32PM -0400, Jeff King wrote:

> I think this is the core of the issue. These entries are "racy git
> dirty" in the sense that their mtimes are the same as the index mtime,
> and so we double-check the contents. This is the first bullet point
> under the "Racy Git" section of Documentation/technical/racy-git.adoc.
> 
> But diffcore_skip_stat_unmatch() doesn't count them as dirty, so we
> don't increment the counter, and thus top-level git-diff won't write out
> the new index. And thus every subsequent diff repeats the same
> expensive double-check.
> 
> But I'm not sure where the blame lies. Either:
> 
>   1. diffcore_skip_stat_unmatch() should be counting these in its
>      "dirty" counter; or

BTW, I don't think diffcore actually has the information it would need
to do so. The racy stuff is handled under the hood in ie_match_stat(),
which returns only a set of "changed" flags. So the caller cannot tell
the difference between the two cases:

  1. We checked ce_match_stat_basic() which said "no change", and then
     is_racy_timestamp() was false, so that was good enough.

  2. is_racy_timestamp() is true, so we further did a content check,
     found nothing, and returned the same "no change"

Obviously we could pass back another flag, but that would disrupt the
other callers. Hmm. It looks like we could pass in a flag to say "assume
racy entries are modified". And then they come back to the diff code,
diffcore_skip_stat_unmatch() sees they're not real diffs and suppresses
them, but we _do_ count them as stat-dirty.

Like this:

diff --git a/builtin/diff.c b/builtin/diff.c
index 4b46e394ce..4d36b5c1e0 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -271,6 +271,9 @@ static void builtin_diff_files(struct rev_info *revs, int argc, const char **arg
 		argv++; argc--;
 	}
 
+	if (revs->diffopt.skip_stat_unmatch)
+		options |= DIFF_RACY_IS_MODIFIED;
+
 	/*
 	 * "diff --base" should not combine merges because it was not
 	 * asked to.  "diff -c" should not densify (if the user wants

That seems to work, in the sense that "git diff" does refresh the index
afterwards. But the timings are a bit funny.

In my working tree of linux.git with many racy entries it was ~500ms to
do the first diff (and the second, and so on, because we never updated
the index). After the patch above, it is 1800ms to do the first diff,
and then fast (~30ms) after.

I could believe it takes twice as long when we refresh the index
(because I don't think we use the stat-cleanliness we collected from the
diff, but rather just do a from-scratch index refresh). But that would
imply it should take ~1000ms. Where does the extra 800ms go? I guess
that somehow the content-check done by diffcore_skip_stat_unmatch() is
slower than the one done by ie_match_stat(). I think the individual
functions are respectively diff_filespec_check_stat_unmatch() and
ce_modified_check_fs().

I don't know if any of this is really worth digging too far. This feels
like a case we could do a bit better at, but I wonder how much it
matters in practice. As soon as you do any index-refresh (including "git
status"), the racy entries are cleared and everything is faster. It
just seems kind of lame that we write out the initial working tree with
so many racy entries.

-Peff
