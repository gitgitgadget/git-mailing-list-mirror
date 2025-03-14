Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707F2E3364
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920142; cv=none; b=BkzFpQuRt5xu8mf6GrI0f5o5VV1INip0+uiNw9hdFalHSEyu0L7oU+Je1ozss5zYIEzdxajqHQqb8R5DxFilDQxdkD2vpmOJheeuGSMDcCeHJ1Iray2x2eyZnjQtMmP+RJ6bHJDVoUPSOmEV5/TK1E6cVUsIa+xPVQb/9C3I8Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920142; c=relaxed/simple;
	bh=hm+DwtabLHNmQL8nNZ88DmHls+fYBFQpuZmzOoGFu4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+BFNb3vhTfpx56xC/PsKsm8nwtDvvli7O4ON+be0dvBYHOCwS0gzAqBNbQ+pRtjV9T0elNekRPMdBVtkHPI7E/WykTYOdr3rQd/PO7q5ci3truZkLPwihYR+WrMAYnpzb9u/TiiNvAyrb241/cksc0pl2A3nEv0kof1FjdGOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JueWoTh0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JueWoTh0"
Received: (qmail 1881 invoked by uid 109); 14 Mar 2025 02:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=hm+DwtabLHNmQL8nNZ88DmHls+fYBFQpuZmzOoGFu4Q=; b=JueWoTh0Ss+PZ3JHHzGV5yHcPwUYll/1fPJ5ka0oD066HkwShm6ehmavSbzN57IX+4YCyvPuKxG3JAZZi57K0iOi5bgMao1pvyuZh3qvLvNiiIYpAGasCHC8J+30sc+IWRjgb8sMHluAtqGYjlncuVBAeW2XHHGNMMypFW43EQhkB4jXKh4QBkUCZYBnt0b0rCah6wago/Wl2dSmnKCYJVAuTx4plwEpR9TP4UiZwN2P9xDO16UdBJu9HMTFVj3LPkXbU1bcT7wStww6wYmKIREZfjPyMqnNw6fr1BBTNNGrtYLOUc62aWF2GProfe/9HqmmL1DR1wEzNc+OQdl4zA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Mar 2025 02:42:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27385 invoked by uid 111); 14 Mar 2025 02:42:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 22:42:18 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 22:42:18 -0400
From: Jeff King <peff@peff.net>
To: Simon Josefsson <simon@josefsson.org>
Cc: git@vger.kernel.org
Subject: Re: Making bit-by-bit reproducible Git Bundles?
Message-ID: <20250314024218.GA114103@coredump.intra.peff.net>
References: <871pv2jx4a.fsf@josefsson.org>
 <20250313051538.GA94015@coredump.intra.peff.net>
 <87msdo1yal.fsf@josefsson.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msdo1yal.fsf@josefsson.org>

On Thu, Mar 13, 2025 at 09:16:34PM +0100, Simon Josefsson wrote:

> >   2. There is no way to pass pack-objects options down through
> >      git-bundle. So you'd have to either assemble the bundle yourself,
> >      or perhaps generate a stable on-disk pack state, and then generate
> >      the bundle. Perhaps something like:
> >
> >        # make one single pack, with no reuse, using the default options
> >        git -c pack.threads=1 repack -adf
> 
> Yay!  You may have solved this for me.  I have to verify this a bit
> more, but this looks promising (these are two different git clones):
> 
> jas@kaka:~/t/gnulib-1$ git -c pack.threads=1 repack -adf
> jas@kaka:~/t/gnulib-1$ git -c 'pack.threads=1' bundle create gnulib.bundle --all
> jas@kaka:~/t/gnulib-1$ sha256sum gnulib.bundle 
> c780bb07501cf016e702fbe3f52704b4f64edd6882c13c9be0f3f114c894e890  gnulib.bundle
> jas@kaka:~/t/gnulib-1$ cd ../gnulib-2
> jas@kaka:~/t/gnulib-2$ git -c pack.threads=1 repack -adf
> jas@kaka:~/t/gnulib-2$ git -c 'pack.threads=1' bundle create gnulib.bundle --all
> jas@kaka:~/t/gnulib-2$ sha256sum gnulib.bundle 
> c780bb07501cf016e702fbe3f52704b4f64edd6882c13c9be0f3f114c894e890  gnulib.bundle
> jas@kaka:~/t/gnulib-2$ 

One thing to watch out for here: that repack is going to look at _all_
objects in the repository. So you will get different output if you make
a bundle of a tag "v1.0" today than you would get later, when "v1.1"
also exists. Ditto for any other activity in the repository, like writes
to unrelated branches, or even reflog entries.

So you'd probably want to make an absolute minimal repository with the
reachable objects, perhaps like:

  git clone --bare --no-local --single-branch -b v1.0 . just-v1.0.git
  cd just-v1.0.git
  git -c pack.threads=1 repack -adf

It doesn't have to be just one ref, of course; you might want to
snapshot the whole set of refs at the time you make the bundle. E.g., by
fetching into the empty repo using a refspec.

This would all be a non-issue if you could ask git-bundle to directly
pass the equivalent of "-f" to pack-objects (at that layer it is called
"--no-reuse-delta"). Since then it would be computing the full set of
objects itself. But without a patch to Git, I don't think there's a way
to do that.

The bundle format is pretty simple, so you _could_ hack around it
yourself, like:

  # list refs we care about; you can pick whatever subset you want
  # here.
  git for-each-ref --format='%(objectname) %(refname)' refs/heads/ >refs

  {
	# bundle header plus list of refs, plus blank line terminator
	echo "# v2 git bundle"
	cat refs
	echo

	# and now the pack. We just need to feed it the object ids for
	# all of the refs. It will handle sorting and de-duping for us.
	cut -d' ' -f1 <refs |
	git -c pack.threads=1 pack-objects \
		--stdout --revs --delta-base-offset --no-reuse-delta
  } >foo.bundle

I dunno if that is more or less gross than teaching git-bundle to pass
--no-reuse-delta itself. It's certainly more intimate with the details,
but OTOH it is less likely to change in other versions of Git (e.g., if
we started making "v3" bundles by default).

> >   # print all commits in topological order, with ties broken by
> >   # committer date, which should be stable. And then follow up with the
> >   # trees and blobs for each.
> >   git rev-list --topo-order --objects HEAD >objects
> >
> >   # now print the contents of each object (preceded by its name, type,
> >   # and length, so there's no chance of weird prepending or appending
> >   # attacks). We cut off the path information from rev-list here, since
> >   # the ordered set of objects is all we care about.
> >   cut -d' ' -f1 objects |
> >   git cat-file --batch >content
> >
> >   # and then take a hash over that content; this will be unambiguous.
> >   sha256sum <content
> 
> How to read this output?  Could this be made git bundle compatible?

You'd have to compare the result of doing that after fetching from the
bundle into an empty repo. I don't think there's a great way to operate
directly on the bundle packfile (it has to be indexed first to see
what's in it).

The closest I could get is:

  input=foo.bundle

  # split the bundle into header and packfile sections on the first
  # blank line
  sed '/^$/q' <$input >header
  size=$(stat --format=%s header)
  tail -c +$((size+1)) <$input >bundle.pack

  # we can first do a byte-level comparison of the header; if this isn't
  # the same, the bundles do not match.
  sha256sum <header

  # now index the pack, so we know what's in it; this makes bundle.idx
  git index-pack -v bundle.pack

  # and now we want to dump the full logical contents (not the
  # delta-compressed versions) of each object. First we need a list of
  # the objects. This will come out in lexical order of object id, which
  # is good for us since it will be stable.
  git show-index <bundle.idx  | awk '{print $2}' >objects

  # unfortunately here things break down. There is no command to read
  # the data directly out of the pack/idx pair without a repository
  # (even though it could be done technically). So we hack around it
  # with a temp repo.
  git init --bare tmp.git
  mv bundle.idx bundle.pack tmp.git/objects/pack/
  git -C tmp.git cat-file --batch <objects | sha256sum

So...also kind of gross. And not really all that different than what:

  git init --bare tmp.git
  cd tmp.git
  git fetch ../foo.bundle refs/*:refs/*

would do (you end up with the same pack/idx pair). So I dunno. I guess
it depends how many and which Git commands you're willing to trust. ;)

-Peff
