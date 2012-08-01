From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Wed, 1 Aug 2012 17:32:07 -0400
Message-ID: <20120801213207.GB16233@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
 <20120801020124.GA18071@sigill.intra.peff.net>
 <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com>
 <7v4nongn3e.fsf@alter.siamese.dyndns.org>
 <CACsJy8Aa_YohFEApGQxL5086vOviAKBc1AB0QyWVsda6byrYzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 23:32:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwgWh-00062Q-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 23:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab2HAVcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 17:32:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46772 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755439Ab2HAVcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 17:32:14 -0400
Received: (qmail 10528 invoked by uid 107); 1 Aug 2012 21:32:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Aug 2012 17:32:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Aug 2012 17:32:07 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Aa_YohFEApGQxL5086vOviAKBc1AB0QyWVsda6byrYzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202727>

On Wed, Aug 01, 2012 at 01:34:23PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Wed, Aug 1, 2012 at 1:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> >
> >> Yes. This is probably cosmetics only, but without path information, we
> >> leave it to chance to decide which A to pair with B and C (in the
> >> A->B, A->C case above). Wrong path might lead to funny effects (i'm
> >> thinking of git log --follow).
> >
> > Isn't that why <A,B> and <A,C> can have different scores per object
> > name pair?  And if you mean by B and C the paths not object names,
> > and the blob at B and C are indeed identical, why would it matter?
> 
> I don't see how scores affect that. Suppose I have two trees and a
> rename-cache file:
> 
> $ git ls-tree -r HEAD^
> 100644 blob d00491    path1/foo
> 100644 blob d00491    path2/bar
> $ git ls-tree -r HEAD
> 100644 blob 0cfbf0    path1/fooo
> 100644 blob 00750e    path2/barr
> $ cat rename-cache
> d00491 0cfbf0 <score 1>
> d00491 00750e <score 2>
> 
> How can I be sure "git diff HEAD^!" will rename path1/foo =>
> path1/fooo and path2/bar => path2/barr, not path1/foo => path2/barr
> and path2/bar => path1/fooo?

You can't. A pathless mapping can never represent that. I think my (and
Junio's argument) is more like: why would you care? And that gets back
to the statement I just made elsewhere in the thread. Which is that you
need to consider the purpose of the rename detection. For generating
diffs and for merging, it doesn't matter in the above case. If the point
is to communicate some semantics of the change (e.g., if your change was
"double the final letter of each filename, and also make a small change),
then that is what the commit message is for.

-Peff
