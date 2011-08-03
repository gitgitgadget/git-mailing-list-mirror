From: Jeff King <peff@peff.net>
Subject: Re: Strange O(N^3) behavior in "git filter-branch"
Date: Wed, 3 Aug 2011 13:37:40 -0600
Message-ID: <20110803193740.GA23848@sigill.intra.peff.net>
References: <4E1E97C3.3030306@alum.mit.edu>
 <4E1EB5E9.1070902@alum.mit.edu>
 <4E200611.9010005@alum.mit.edu>
 <4E394E33.4060107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 03 21:37:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QohGI-0000GD-5s
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 21:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1HCThq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 15:37:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58083
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab1HCTho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 15:37:44 -0400
Received: (qmail 9743 invoked by uid 107); 3 Aug 2011 19:38:18 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Aug 2011 15:38:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2011 13:37:40 -0600
Content-Disposition: inline
In-Reply-To: <4E394E33.4060107@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178613>

On Wed, Aug 03, 2011 at 03:33:39PM +0200, Michael Haggerty wrote:

> On 07/15/2011 11:19 AM, Michael Haggerty wrote:
> > On 07/14/2011 11:24 AM, Michael Haggerty wrote:
> >> On 07/14/2011 09:16 AM, Michael Haggerty wrote:
> >>> I have noticed that "git filter-branch" gets pathologically slow when it
> >>> operates on a repository that has many references in a complicated
> >>> directory hierarchy.  The time seems to go like O(N^3), where N is the
> >>> number of references being rewritten.
> > [...]
> > A many possible improvements come to mind, in increasing order of
> > intrusiveness and generality:
> > [...]
> > 5. Organize the loose refs cache in memory as a tree, and only populate
> > the parts of it that are accessed.  This should also speed up iteration
> > through a subtree by avoiding a linear search through all loose references.
> 
> FYI: I am working on (5), namely storing a linked list of loose refs for
> each directory and only populating those directories that are accessed.
>  The directories themselves will be held in a tree/trie (AFAICT the
> distinction is primarily whether each node holds its whole key or only
> the part of the key relative to its parent, which is an implementation
> detail).  As a bonus, the caches for submodules will be handled
> correctly (they are currently never used).
> 
> It might be another week or so before I have patches ready.

Great. That is exactly the solution I was going to pursue, as well, but
I didn't actually start on it yet. I look forward to seeing your
patches.

-Peff
