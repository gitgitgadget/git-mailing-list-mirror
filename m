Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69E1DED5B
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782062683; cv=none; b=SfjuWRm7KtNHYbC7Chbo4dAhjWcn/ohE5BtkoAr9vQ+5vGc5moIdL6g/G/lbWr6ZZJmx93qXkJXsR7sd/Ps9ty9efiikA8CZt+bCJmYfvBi4u8kqudXjMSuQMlGDB1QxnTj+l7d6D+zjieTadSXVsOS/F8jNV0wmO8IJXdvop2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782062683; c=relaxed/simple;
	bh=3KZgcdn6OqAOtBbFDazZmxmIa+6QNxClTzkVCoDSbb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eyo00CRgGhHqamA7utGgCHik3yMOmWA/YDGiLYl4QN2oOZvAzXyMvnv7uP6RLGtkeATFNcM8X5KWo0JJDLsipP+K5+U9TfwnRQgNWozp/dVqxSiCEgh5DUgezUlNERrB+gjo3w235yl+m+cA37eXWU1LNFPMsKwmgtBG1liRJBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WxnHtu4f; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WxnHtu4f"
Received: (qmail 204403 invoked by uid 106); 21 Jun 2026 17:24:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=3KZgcdn6OqAOtBbFDazZmxmIa+6QNxClTzkVCoDSbb4=; b=WxnHtu4fgPHMCZwYMKI2qP2R+72YH8Nbz80acqqcA4kQqVJrIA4uBFTKFTpFUUxP7Z77XF2jo3qWqHRjFlGJheeRni9kPPMJGXvBvYfzMhaKwpKLAqkiwFAQwI8WbHrWLMhyubQ2+vf0zPHgRe85urD69ImzvkvfzZefakawU4CCNh67vuUlqfPtrMSWzQ9XpyHwB0I2mt5v7euv/+hp2XxyBfH+2TMNQveZtTLknVR9WROnHloDKmn2BBJIbfJHMagXaOkiwCwJSz9fkxstnnF3h49RYhrH1Xr1YaGeyH+4zAE9NGtedn1sIRuMJMLPC6RZrjcF7vkfdYgq7mSPZg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Jun 2026 17:24:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 520687 invoked by uid 111); 21 Jun 2026 17:24:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Jun 2026 13:24:34 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 21 Jun 2026 13:24:32 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: git-diff in a worktree is an order of magnitude slower?
Message-ID: <20260621172432.GA2206349@coredump.intra.peff.net>
References: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
 <20260609001134.GD358144@coredump.intra.peff.net>
 <CALnO6CD+3sE1xQUnRsCFfWrZTsq2Edw7BWseLzasgT3dgtaq_Q@mail.gmail.com>
 <20260611085526.GL2191159@coredump.intra.peff.net>
 <CALnO6CAx91kbJ84d6Ef655UNG0y0rhyknBRh6Y+0o7Xn-uVytQ@mail.gmail.com>
 <xmqqa4sog1e9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa4sog1e9.fsf@gitster.g>

On Sat, Jun 20, 2026 at 05:53:02PM -0700, Junio C Hamano wrote:

> > which dates to aecbf914c4 (git-diff: resurrect the traditional empty
> > "diff --git" behaviour, 2007-08-31). On my system that comparison is
> > false because the double-negation produces 1
> > (diff_auto_refresh_index=1 or the result of git_config_bool). 
> 
> Not quite.  It was false because double-negation initializes the
> member to 1, which causes a call to diffcore_skip_stat_unmatch()
> be made, *and* the diffcore_skip_stat_unmatch() function did not
> find any ghost changes, i.e., paths that were only stat-dirty hence
> needed a call to refresh_index_quietly().

I think this is the core of the issue. These entries are "racy git
dirty" in the sense that their mtimes are the same as the index mtime,
and so we double-check the contents. This is the first bullet point
under the "Racy Git" section of Documentation/technical/racy-git.adoc.

But diffcore_skip_stat_unmatch() doesn't count them as dirty, so we
don't increment the counter, and thus top-level git-diff won't write out
the new index. And thus every subsequent diff repeats the same
expensive double-check.

But I'm not sure where the blame lies. Either:

  1. diffcore_skip_stat_unmatch() should be counting these in its
     "dirty" counter; or

  2. the index should be marking these differently. The second bullet
     point of that Racy Git section says:

       When the index file is updated that contains racily clean
       entries, cached `st_size` information is truncated to zero
       before writing a new version of the index file.

     Should the index be written out with a 0 size field here, so that
     we know they are dirty and should be updated? I guess that would be
     user-visible, though, because commands that _don't_ update the
     index (like plumbing diff-files) would generate a spurious diff
     there rather than doing the content-level comparison.

I dunno. You had solved most of the racy git stuff before I came along,
so I never gave it too much thought (and what little thought I did was
many years ago).

> > So… has that conditional been quietly dead all this time? I can't
> > imagine that's right, but…
> 
> I initially thought it was an embarrassing thinko, but after seeing
> how .skip_stat_unmatch is used as a 1-based counter (i.e., if the
> member says 42, it means it saw 41 paths that were stat-dirty but
> without actual content change), I do not think so.
> 
> Now, it is a different matter if such a "dual" purpose "more than a
> simple boolean" counter is a good idea.  Apparently it confused both
> of us in this case ;-).

Make that three of us. ;)

-Peff
