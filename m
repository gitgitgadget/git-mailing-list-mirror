From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch -d: Export GIT_DIR earlier
Date: Mon, 16 Feb 2009 16:39:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161636040.6289@intel-tinevez-2-302>
References: <20090216130951.GA3769@lars.home.noschinski.de> <alpine.DEB.1.00.0902161441190.6289@intel-tinevez-2-302> <20090216145137.GA4431@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:40:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5aQ-0002QG-Ug
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 16:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbZBPPjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 10:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbZBPPjR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 10:39:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:55005 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751342AbZBPPjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 10:39:16 -0500
Received: (qmail invoked by alias); 16 Feb 2009 15:39:13 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 16 Feb 2009 16:39:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+En284tP2EpwNcV++C2fB1re0F9FCck9lrHERDWJ
	0U+PI83VjbcGPc
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090216145137.GA4431@lars.home.noschinski.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110193>

Hi,

On Mon, 16 Feb 2009, Lars Noschinski wrote:

> * Johannes Schindelin <Johannes.Schindelin@gmx.de> [09-02-16 15:42]:
> > > This fix is not yet ready for commit, as it lacks a test case.
> > > 
> > > Writing a test case for this bug, I wonder about the preferred way to use
> > > a
> > > directory outside any git repository in a test: Using some directory below
> > > git/t/ will not work, as (in most cases) git is a git repository.
> >
> >How about using a filter-branch call with a filter that echoes GIT_DIR into a
> >file, then fails, and then checking the exact contents of GIT_DIR?
> 
> This would not catch this bug: for-each-ref is the only git command
> called after changing to the temporary directory and before exporting
> GIT_DIR.

Right.

Next try: is it not true that we can check that "$tempdir/backup-refs" 
is correct, i.e. identical to what 'for-each-ref' outputs for the desired 
directory?

So we could make a subdirectory, set up a dummy branch with one commit, 
call filter-branch with a tmpdir that is in _another_ subdirectory, with a 
filter that just returns false, so that the tmpdir is not deleted, and 
verify the contents of $tmpdir/backup-refs, no?

Ciao,
Dscho
