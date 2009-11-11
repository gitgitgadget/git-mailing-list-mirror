From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Re: Clarify documentation on the "ours" merge strategy.
Date: Thu, 12 Nov 2009 00:37:10 +0100
Message-ID: <200911120037.11901.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de> <7vskckn5b4.fsf@alter.siamese.dyndns.org> <20091111213049.GJ27518@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Baz <brian.ewins@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:38:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8MlH-0002x5-UA
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759666AbZKKXhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 18:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759628AbZKKXhw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:37:52 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:52409 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759627AbZKKXhv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:37:51 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 12 Nov
 2009 00:37:57 +0100
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 12 Nov
 2009 00:37:55 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.29-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <20091111213049.GJ27518@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132720>

Nicolas Sebrecht wrote:
> The 11/11/09, Junio C Hamano wrote:
> > Thomas Rast <trast@student.ethz.ch> writes:
> > 
> > > ++
> > > +Because the sides in a rebase are swapped, using this strategy with
> > > +git-rebase is never a good idea.
> > 
> > Looking very good.
> 
> If this strategy is _never_ a good idea in this case, I tend to think
> that git should forbid this option, or at least, warn and refer to the
> documentation.

Then again, I'm not sure if resolve vs. recursive makes a difference
in a rebase.  Octopus is weird for a two-head merge, I'm not sure why
the docs even talk about it.  That would leave only subtree, which
indeed has its uses.  Should we add a note to that effect to
git-rebase.txt?  Like, say,

diff --git i/Documentation/git-rebase.txt w/Documentation/git-rebase.txt
index 33e0ef1..6e54a57 100644
--- i/Documentation/git-rebase.txt
+++ w/Documentation/git-rebase.txt
@@ -228,13 +228,19 @@ OPTIONS
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
 	upstream side.
++
+Note that in a rebase merge (hence merge conflict), the sides are
+swapped: "theirs" is the to-be-applied patch, and "ours" is the so-far
+rebased series, starting with <upstream>.
 
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy.
-	If there is no `-s` option, a built-in list of strategies
-	is used instead ('git-merge-recursive' when merging a single
-	head, 'git-merge-octopus' otherwise).  This implies --merge.
+	If there is no `-s` option 'git-merge-recursive' is used
+	instead.  This implies --merge.
++
+Due to the peculiarities of 'git-rebase' (see \--merge above) the only
+built-in strategy that is actually useful is 'subtree'.
 
 -q::
 --quiet::
diff --git i/Documentation/merge-strategies.txt w/Documentation/merge-strategies.txt
index 4365b7e..c1c3add 100644
--- i/Documentation/merge-strategies.txt
+++ w/Documentation/merge-strategies.txt
@@ -33,6 +33,9 @@ ours::
 	merge is always the current branch head.  It is meant to
 	be used to supersede old development history of side
 	branches.
++
+Because the sides in a rebase are swapped, using this strategy with
+'git-rebase' is never a good idea.
 
 subtree::
 	This is a modified recursive strategy. When merging trees A and

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
