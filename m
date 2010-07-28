From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Tue, 27 Jul 2010 21:05:10 -0400
Message-ID: <AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 03:05:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odv5h-0003Fu-9O
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 03:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab0G1BFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 21:05:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48262 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab0G1BFb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 21:05:31 -0400
Received: by wyf19 with SMTP id 19so3676117wyf.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 18:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zXG3iDLuq1FpaWdKukAFnnChh9/WCwzlAd0V5kmELIc=;
        b=IMffsGS/8azjgxjEUq9bUl0zS1WJB5jm4bgZN/NHZEeONFTRM8+KBsDmF+fjmRnBas
         BI3sZ3mCe3dfwRR8VBg0cMtx7g6ys0DNbmQWbpLjZKP4KBNCjMrguql4iLJY8YpZHcCT
         uHRbNsc5fjTKkvUd06CZ5TJk9NI8mgFdHkdnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fweGIPyUVJK8P9IaqDPf4Ojx7x0Mrn9+WiCBICwxw0E/mDy9nZugTteInEcFPpu3ER
         t+0EBhPxpoHwxYGKvl0HTmVJ9/YMis00zp53vDCKyVw6wtUQDx09LTNebp+wk0rRl4bT
         TuyGD4Wm9WvqHGo9ELxaqeU57khXrSO+3Po54=
Received: by 10.216.1.77 with SMTP id 55mr9744330wec.72.1280279130206; Tue, 27 
	Jul 2010 18:05:30 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Tue, 27 Jul 2010 18:05:10 -0700 (PDT)
In-Reply-To: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152023>

2010/7/27 Elijah Newren <newren@gmail.com>:
> 0) Sparse clones have "all" commit objects, but not all trees/blobs.
>
> Note that "all" only means all that are reachable from the refs being
> downloaded, of course. =A0I think this is widely agreed upon and has
> been suggested many times on this list.

I think downloading all commit objects would require very low
bandwidth and storage space, so it should be harmless.

In fact, I have a pretty strong impression that also downloading all
*tree* objects would be fine too.  But I've never actually gone and
counted them to see what the stats are like.  Still, I'd assume that
the vast majority of repo space is blobs, not trees, and that trees
are highly compatible with deltafication.

Note that if you happen to want to implement it in a way that you'll
also get all the commit objects from your submodules too (which I
highly encourage :)) then downloading the trees is the easiest way.
Otherwise you won't know which submodule commits you need.

> 1) A user controls sparseness by passing rev-list arguments to clone.
>
> This allows a user to control sparseness both in terms of span of
> content (files/directories) and depth of history. =A0It can also be u=
sed
> to limit to a subset of refs (cloning just one or two branches instea=
d
> of all branches and tags). =A0For example,
> =A0$ git clone ssh://repo.git dst -- Documentation/
> =A0$ git clone ssh://repo.git dst master~6..master
> =A0$ git clone ssh://repo.git dst -3
> (Note that the destination argument becomes mandatory for those doing
> a sparse clone in order to disambiguate it from rev-list options.)

It's really too bad that the dst argument took up that slot which, in
every other git command, is where the list of revs would go :(  Other
than that, I think the syntax looks nice.

> There is a slight question as to whether users should have to specify
> "--all HEAD" with all sparse clones or whether it should be assumed
> when no other refs are listed.

Since downloading commits is so cheap anyway, I'd suggest just
defaulting to downloading all the refs, as clone currently does.  If
people don't like it, they can do what they currently do:

   git init
   git remote add ...
   git fetch

Not that pretty, but then again, it's rarely needed.

> 2) Sparse checkouts are automatically invoked with the path(s) from
> =A0 the specified rev-list arguments.
>
> Can't checkout content that we don't have. =A0:-)
>
> This has a slight downside -- it makes sparse checkouts and sparse
> clones slight misfits: the syntax (.gitignore style vs. rev-list
> arguments) is a bit different, and sparse checkouts can exclude
> certain paths whereas my sparse clones would only be able to *include=
*
> paths. =A0I don't see this as a deal-breaker, but even if others
> disagree I think a more general path-exclusion mechanism for the
> revision walking machinery would be really nice for reasons beyond
> just this one. =A0I've often wanted to do something like
> =A0git log -S'important code phrase' --EXCLUDE-PATH=3Dbig-data-dir

I don't totally understand what you mean here.  But I do think that if
you can *mostly* trim down a tree, excluding every little thing is not
that important.  As was discussed on the other thread, it seems like
*most* people are trimming down their trees (currently using
submodules) just to make stuff faster, and getting rid of 90% of the
unwanted cruft is probably fine; getting rid of 100% of it isn't that
much more of a speed boost.

I guess my point is, more complex exclusions could always be added
later but they aren't so important right away.

> 3) The limiting rev-list arguments passed to clone are stored.
>
> However, relative arguments such as "-3" or "master~6" first need to
> be translated into one or more exclude ranges written as "^<sha1>".

Just run them through rev-parse, I think.

> 4) All revision-walking operations automatically use these limiting a=
rgs.
>
> This should be a simple code change, and would enable rev-list, log,
> etc. to avoid missing blobs/trees and thus enable them to work with
> sparse clones. =A0fsck would take a bit more work, since it doesn't u=
se
> the setup_revisions() and revision.h walking machinery, but shouldn't
> be too bad (I hope).

I don't know if this implementation detail would be better or worse
than just having the tools auto-trim their activities when they run
into a missing object.  But maybe.  It does sound sort of elegant:
this way they *won't* run into the missing objects.

Beware, however, that

   git log -- Documentation

outputs a different set of commits than just

   git log

You don't want to enable history simplification here; I think that
means you want --full-history on by default for the "stored" path
limiting, but not for any command-line path limiting.  That could be
slightly messy.

> 5) "Densifying" a sparse clone can be done
>
> One can fetch a new pack and replace the limiting rev-list args with
> the new choice. =A0The sparse checkout information needs to be update=
d
> too.
>
> (So users probably would want to densify a sparse clone with "pull"
> rather than "fetch", as manually updating sparse checkouts may be a
> bit of a hassle.)

I think this would work, but unless you want to re-download some
(possibly lots of) objects you've already got, it would require some
kind of extra support from the server, I think.  Maybe that's a rare
enough case that few people will care and it could be fixed later.

I don't think the pull vs. fetch distinction is valid; I would be very
surprised if pull un-sparsified my checkout, just as I would be
surprised if merge did.  And pull is just fetch+merge.

> 6) Cloning-from/fetching-from/pushing-to sparse clones is supported.
>
> Future fetches and pushes also make use of the limiting arguments.
> Receives do as well, but only to make sure the pack obtained is not
> "more sparse" than what the receiving repository already has.
> (uploads ignore the stored rev-list arguments, instead using the
> rev-list arguments passed to it -- it will die if asked for content
> not locally available to it.)

This scares me a little.  It's a reminder that it's all-too-easy to
get your repository into a really messed up state by going in and
screwing with your sparseness parameters at the wrong time.

It would make me more comfortable if there was some kind of "oh god,
just fix it by downloading any objects you think are missing" mode :)
In fact, git could benefit from that in general - every now and then
someone on the list asks about a repository they managed to mangle by
corrupting a pack or something, and there's no really good answer to
that.

> 7) Operations that need unavailable data simply error out
>
> Examples: merge, cherry-pick, rebase (and upload-pack in a sparse
> clone). =A0However, hopefully the error messages state what extra
> information needs to be downloaded so the user can appropriately
> "densify" their repository.

That sounds good to me.

Have fun,

Avery
