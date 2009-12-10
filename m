From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv10 01/11] fast-import: Proper notes tree manipulation
Date: Thu, 10 Dec 2009 10:39:44 +0100
Message-ID: <200912101039.44526.johan@herland.net>
References: <1260185254-1523-1-git-send-email-johan@herland.net>
 <20091208020134.GC17588@spearce.org> <200912080345.37429.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 10 10:39:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIfV5-00054N-Hv
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 10:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759107AbZLJJjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 04:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759032AbZLJJjn
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 04:39:43 -0500
Received: from smtp.getmail.no ([84.208.15.66]:42151 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758984AbZLJJjl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Dec 2009 04:39:41 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUF004W1K6BAG20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 10 Dec 2009 10:39:47 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KUF00GOZK68HE30@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 10 Dec 2009 10:39:47 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.12.10.92716
User-Agent: KMail/1.12.4 (Linux/2.6.31-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <200912080345.37429.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135015>

On Tuesday 08 December 2009, Johan Herland wrote:
> On Tuesday 08 December 2009, Shawn O. Pearce wrote:
> > Johan Herland <johan@herland.net> wrote:
> > > > If we're here, isn't it likely that *all* notes are in the wrong
> > > > path in the tree, and we need to move them all to a new location?
> > > > If that's true then should we instead just build an entirely new
> > > > tree and swap the root when we are done?
> > >
> > > Hmm. Not always. In your earlier scenario where we add 2,000,000
> > > notes in a single commit, the current code would need to rewrite 255
> > > of them from fanout 0 to fanout 2, and 65,535 of them from fanout 1
> > > to fanout 2. But the vast majority (1,934,465) would not require
> > > rewriting (having been added at the correct fanout initially).
> > > However, if we build a new tree (by which I assume you mean
> > > tree_content_remove() from the old tree and
> > > tree_content_set() to the new tree for every single note (and
> > > non-note)), we end up processing all 2,000,000 entries.
> >
> > Well, by processing here you mean we wind up looking at them, only
> > to determine they are in the correct place already and skipping past.
> 
> No, (as far as I (mis?)understood your idea) by processing here I'm
>  talking about moving all 2,000,000 entries from the old tree to the new
>  tree.
> 
> Here's my understanding of your idea:
> - Create a new, empty tree
> - For each entry in the old/existing tree:
>   - If not a note, move[*] verbatim to new tree
>   - If a correctly placed note, move[*] verbatim to new tree
>   - Else, move[*] note to the _correct_ place in the new tree
> 
> [*]: By "move" I assume you mean tree_content_remove() from the old tree,
> followed by tree_content_set() into the new tree.
> 
> From this understanding, I cannot see how your idea improves on the
> adding-2M-notes scenario.
> 
> > I guess I see your point though.  We're fairly bounded on how many
> > we might need to move, probably only 65,535, and the rest will be
> > at the right position so we're mostly just iterating through to
> > confirm they don't have to be moved.
> 
> Yep.

Do you have more comments/suggestions on this patch? Or is it ok to include 
in fast-import as-is?


Have fun! :)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
