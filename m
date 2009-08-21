From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 6/6 (v4)] support for path name caching in rev-cache
Date: Thu, 20 Aug 2009 20:05:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908201958010.6044@xanadu.home>
References: <op.uys3qwlmtdk399@sirnot.private>
 <alpine.LFD.2.00.0908172235360.6044@xanadu.home>
 <c77435a80908180431k2f91e1ffye25aa8895908ddb7@mail.gmail.com>
 <alpine.LFD.2.00.0908182313100.6044@xanadu.home>
 <c77435a80908200543h74fdb07dm7f30cee4fedef8c5@mail.gmail.com>
 <c77435a80908201622o7d69681ftda0ca63c5a915f4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 02:06:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeHe5-0000og-6K
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 02:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbZHUAGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 20:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754843AbZHUAGH
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 20:06:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28711 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbZHUAGG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 20:06:06 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOP002RZ9LMK2C0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Aug 2009 20:05:47 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <c77435a80908201622o7d69681ftda0ca63c5a915f4b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126664>

On Fri, 21 Aug 2009, Nick Edelen wrote:

> Ok we actually have a small problem, semi-related to the object
> listing.  By default rev-list will list everything not seen in each
> tree, whereas rev-cache will only list object introduced in a given
> commit.  This becomes problematic if you have two different files with
> the same content in the same tree: rev-cache will show the name of the
> youngest file; vanilla rev-list will list the name soonest encountered
> in the tree (which can even change if, e.g., a subdir is renamed so as
> to be list in a different order).
> 
> In fact, even if they're not in the same tree we could have a similar
> problem.  Commits are stored topologically in cache slices, so output
> is always in topo order.  If the same object is introduced in parallel
> branches under different names, the outputted name with `rev-list
> --all --objects` (vanilla) could be different from `rev-list --all
> --objects` (cached) could be different from `rev-list --all
> --topo-order --objects`.
> 
> This isn't feasably changable in rev-cache, as a) the cached position
> (and hence final output order) is effectively unrelated to tree
> structure, and b) commits _have_ to be ordered topologically for
> rev-cache to function.
> 
> The descrepency strikes me as something of a non-issue with
> pack-objects' deltafication, as the object will fit with either of its
> names.  It will mean that the (already sorta finicky) object names
> won't have garuanteed consistency between cached/non-cached calls to
> rev-list.  This is something of a corner case and dosn't strike me as
> a huge issue, but I figured I should consult you all before presuming
> things about git's interface.

The name is actually used only as a clue to delta similar objects 
together.  So this is indeed a non issue, as long as the discrepency is 
well understood and, more importantly, properly documented.  The above 
is certainly a good start.


Nicolas
