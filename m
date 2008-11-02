From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-diff: Add --staged as a synonym for --cached.
Date: Sun, 2 Nov 2008 13:35:19 +0100
Message-ID: <20081102123519.GA21251@atjola.homenet>
References: <1225296936-1357-1-git-send-email-dsymonds@gmail.com> <20081029164253.GA3172@sigill.intra.peff.net> <ee77f5c20810290950k6d7acfcbt90b6280c290bd532@mail.gmail.com> <alpine.DEB.1.00.0810291804400.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081029171122.GA12167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Stephan Beyer <s-beyer@gmx.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 02 13:37:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwcC7-0002pz-PG
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 13:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbYKBMfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Nov 2008 07:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753636AbYKBMfZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 07:35:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:55834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753540AbYKBMfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 07:35:24 -0500
Received: (qmail invoked by alias); 02 Nov 2008 12:35:21 -0000
Received: from i577B8DDD.versanet.de (EHLO atjola.local) [87.123.141.221]
  by mail.gmx.net (mp008) with SMTP; 02 Nov 2008 13:35:21 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/2CgIBvNr2NhvVG2nI+X/lYbHSU8YYIQVkHb8xfF
	OEyNgNFFlSVnA/
Content-Disposition: inline
In-Reply-To: <20081029171122.GA12167@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99840>

On 2008.10.29 13:11:22 -0400, Jeff King wrote:
> On Wed, Oct 29, 2008 at 06:06:09PM +0100, Johannes Schindelin wrote:
>=20
> > However, note that we have to hash out what to do about the convent=
ion=20
> > that --cached traditionally means that only the staging area (forme=
rly=20
> > known as "the index") is affected, while --index means that the com=
mand=20
> > touches the working directory, too.
>=20
> If we assume that we have only the word "stage" and variations
> available, then there aren't too many options.
>=20
>   only the staging area:
>     --stage-only, --staged-only
>=20
>   both:
>     --staged (as opposed to --staged-only) --stage-and-worktree (too
>     long), --both (not descriptive enough), --stage-too (yuck)

Hm, I don't think that would work out nicely with stash. --keep-index
would become --keep-staged-only, which is IMHO pretty confusing, as the
default is to keep nothing. And even if you add another option to keep
all changes, so that the current state is just put onto the stash, but
the working tree and index are unchanged, you would have --keep-staged
and --keep-staged-only. Not really any better.

Admittedly, --keep-index is quite different from --index, but if you're
going to change the CLI to hide the word "index", that option needs to
be changed as well and the usage of the new terms should be unified.

Looking at --cached/--index we have basically three things:

  --cached to refer to the state of the index (diff, grep, [stash], ...=
)
  --cached to _work on_ the index only (rm, apply, ...)
  --index to _work on_ both the index and the working tree (apply, ...)

Maybe that could be translated to:

  --staged: refer to the state of the index
  --stage: in addition to changing the working tree, also stage the cha=
nges
  --stage-only: only stage the changes, don't change the working tree

That would give us, for example:
git diff --staged
git grep --staged

git apply --stage
git apply --stage-only
git rm --stage-only

git stash --keep-staged

A quick look through Documentation/ revealed only one problematic case,
which is ls-files that already has a --stage option. And that looks lik=
e
a dealbreaker :-(

Bj=F6rn
