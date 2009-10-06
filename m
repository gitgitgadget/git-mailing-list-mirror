From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Tue, 6 Oct 2009 09:32:22 +0200
Message-ID: <200910060932.24377.trast@student.ethz.ch>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com> <alpine.DEB.1.00.0910052314580.4985@pacific.mpi-cbg.de> <20091005225611.GB29335@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 09:39:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mv4dq-0006Vd-OV
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 09:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbZJFHeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 03:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754246AbZJFHeI
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 03:34:08 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:34603 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635AbZJFHeH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 03:34:07 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 6 Oct
 2009 09:33:21 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 6 Oct
 2009 09:32:57 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <20091005225611.GB29335@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129609>

Jeff King wrote:
> On Mon, Oct 05, 2009 at 11:17:09PM +0200, Johannes Schindelin wrote:
> 
> > > $ git checkout next
> > > error: pathspec 'next' did not match any file(s) known to git.
> > 
> > Actually, we should really think long and hard why we should not 
> > automatically check out the local branch "next" in that case.  I mean, 
> > really long and hard, and making sure to take user-friendliness into 
> > account at least as much as simplicity of implementation.
> 
> Some devil's advocate questions:
> 
>   1. How do we find "origin/next" given "next"? What are the exact
>      lookup rules? Do they cover every case? Do they avoid surprising
>      the user?
> 
>   2. What do we do if our lookup is ambiguous (e.g., "origin/next" and
>      "foobar/next" both exist)?
> 
>   3. If our lookup does have ambiguities or corner cases, is it better
>      to simply be suggesting to the user, rather than proceeding with an
>      action?

If I may add another:

4. Are there any (scripted?) use-cases where git-checkout should fail
   because it was given an invalid branch name?

The following gives a hint, though they could of course be fixed and
the ^0 case doesn't really count:

  $ git grep 'git checkout .*||' -- "*.sh"
  git-bisect.sh:          git checkout "$start_head" -- || exit
  git-rebase--interactive.sh:                     output git checkout $first_parent 2> /dev/null ||
  git-rebase--interactive.sh:                     output git checkout "$1" ||
  git-rebase.sh:git checkout -q "$onto^0" || die "could not detach HEAD"
  t/t2007-checkout-symlink.sh:git checkout -f master || exit

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
