Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED07198E60
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747337450; cv=none; b=oAWkPEC8FZduKMLoZE2n6vamLjlzV55dftvE5iEdb9GJgxjjbybjHgASoKgi4kvfLLkxpZziONkPTZBuzuPCezlvxMcLpp0uE7pyXNldc0VCNY+ya2GojWd9lNNakjKd6x/cQV2X+/lwYbtlMwgRSTyWt/o8CfZFwycPfiroXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747337450; c=relaxed/simple;
	bh=fUk35NQtHtarCby7iHGFgVG8Dz82IK5t1g0/In9wRHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy2j44C6+ZXyGqyr8GFw0SwiZWneqNV/QaSX4CbF6Br49C1xByrL1oDPflqVEIm6LOG3zMEg4wF7f1s9iB1uT8aD7e6kkTifbcpwiYODP4csupoI3toibLJWN26Bm3njY9qAqQAE2hoiR/NW2jj0hAPI3j0ljbDEHOPXb1zADNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U2R26itq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U2R26itq"
Received: (qmail 399 invoked by uid 109); 15 May 2025 19:30:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fUk35NQtHtarCby7iHGFgVG8Dz82IK5t1g0/In9wRHw=; b=U2R26itq9m+8/KeIoSOop7rUadBmPGw4CbzoFpw5qBGHXU6lZXHMkws0oeTy0MJrnGJwU2KY2+wYE3/90djiopEyLdTN6TVoL3XzIsRIsRbtPk5GElRC5OiM6ID3MlRlUtWAMEDTYupktQ7T/1cHzF0IGXspAG8F7qiIhH9zVf0T8UKrTY0cZcK4TTq6pjPBUOdwEg43laI7t3dM1G8nGjmIm4faK7mkJbA/xW6xHvDt2BiEEJtxI+RC3K3Nk/9KTqspYLtsm5h1T/oPN45s27dkQCwTUDPsnFlp/zQO9317EB4QxLhMZuyzrmeV24q4wGTw3Inbs5gIqL4Kz3UgbA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 19:30:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30156 invoked by uid 111); 15 May 2025 19:30:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 15:30:48 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 15:30:46 -0400
From: Jeff King <peff@peff.net>
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
Message-ID: <20250515193046.GA3320240@coredump.intra.peff.net>
References: <xmqqjz6sb15u.fsf@gitster.g>
 <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
 <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com>
 <874ixnjltf.fsf@iotcl.com>
 <xmqqy0uz7zzh.fsf@gitster.g>
 <0f491261-bbe1-474d-a240-0ddbf22cc754@xiplink.com>
 <aCXsKHiP4uIzCMrt@pks.im>
 <xmqqa57d3k1d.fsf@gitster.g>
 <a97db895-5121-427a-b64f-df225309f429@xiplink.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a97db895-5121-427a-b64f-df225309f429@xiplink.com>

On Thu, May 15, 2025 at 01:39:59PM -0400, Marc Branchaud wrote:

> > As an end-user, I view "where does the body of this function came
> > from" and "when did I touch this file the last time" quite different
> > and unrelated kind of queries.
> 
> I can see them either way, depending on how I squint.  I have no objection
> if people want to think of this new operation as
> something-that-is-not-a-blame.  But then don't call it blame-tree!
> 
> How about last-touch?

The name "blame-tree" is probably my fault, as that's what I called it
in 2012 when I originally wrote it. I don't have access to the adjacent
repos anymore, but I _think_ it was replacing a script that was in fact
called "git-last-modified" or something like that. So it all comes
around. ;)

The debate has mostly been over "blame" here. But I think "tree" is also
inaccurate. Theoretically it can be about any set of paths in the repo,
not just the entries of a single tree. So:

  git last-modified Makefile Documentation/Makefile t/Makefile

would be a perfectly valid thing to ask about (and of course a
pathspec like '**Makefile' would be a simpler way to do so). The word
"tree" was there because the original use case at GitHub was getting
those values for all of the entries in a particular tree.

But conceptually it is just about expanding a pathspec into a set of
paths, and then traversing and reporting the last time each path was
modified. It _almost_ fits into the "git-log" family, which is all about
traversing and pathspecs. The output is a bit different, but I almost
wonder if it would work as an option to continuously limit the pathspec.
Something like:

  $ git log --format=%H --last-modified --raw '**Makefile'
  89d557b950c7a0581c12452e8f9576c45546246b
  :100644 100644 13f9062a05 c4d21ccd3d M  Makefile
  [ skip a bunch of commits that touched only Makefile, nothing else ]
  a7fa5b2f0ccb567a5a6afedece113f207902fa6f
  :100644 100644 6485d40f62 b109d25e9c M  Documentation/Makefile
  [ skip more; now this one is interesting, because one commit touches a
    bunch of files! It also touches Documentation/Makefile, but we'd
    have already narrowed our pathspec to forget about it by this point ]
  5309c1e9fb399c390ed36ef476e91f76f6746fa9
  :100644 100644 3e67552cc5 97ce9c92fb M  contrib/credential/libsecret/Makefile
  :100644 100644 238f5f8c36 0948297e20 M  contrib/credential/osxkeychain/Makefile
  :100644 100644 6e992c0866 5b795fc9fe M  contrib/credential/wincred/Makefile
  :100644 100644 f2be7cc924 33c2ccc9f7 M  contrib/diff-highlight/Makefile
  :100644 100644 5ff5275496 2a98541477 M  contrib/diff-highlight/t/Makefile
  :100644 100644 4e603512a3 497ac434d6 M  contrib/mw-to-git/Makefile
  :100644 100644 f422203fa0 6c9f377caa M  contrib/mw-to-git/t/Makefile
  :100644 100644 52b84ba3d4 691737e76b M  contrib/persistent-https/Makefile
  :100644 100644 093399c788 2a85f5ee84 M  contrib/subtree/t/Makefile
  :100644 100644 667c39ed56 6c5a12bc32 M  git-gui/Makefile
  :100644 100644 749aa2e7ec e656b0d2b0 M  git-gui/po/glossary/Makefile
  :100644 100644 6911c2915a 4ff4ed0616 M  t/interop/Makefile
  :100644 100644 e4808aebed 9b3090c4ed M  t/perf/Makefile
  :100644 100644 bd1e9e30c1 722755338d M  templates/Makefile
  [ ... end immediately without traversing further here, since all
    paths have been reported ... ]

I dunno. I just made that up. The output is obviously quite different
than blame-tree produces, but it would be easy-ish to collect it in the
same way. And it's much more flexible, because you could use --format
and diff options to report as much or as little about each commit as
you'd want.

It is a bit different from regular log, though, in that we'd expand the
pathspec at the very start, rather than applying it continuously as we
traverse (otherwise we could never end early, since we'd never know if
there was a "foo/Makefile" deep in history).

So you could argue that "git last-modified" could also just take
format and diff output options. ;)

-Peff
