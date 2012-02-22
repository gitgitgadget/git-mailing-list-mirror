From: Jeff King <peff@peff.net>
Subject: Re: how do you review auto-resolved files
Date: Wed, 22 Feb 2012 02:28:48 -0500
Message-ID: <20120222072848.GC17015@sigill.intra.peff.net>
References: <ji0vik$e48$1@dough.gmane.org>
 <7vhayjga0a.fsf@alter.siamese.dyndns.org>
 <4F442721.4080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 08:28:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S06dD-0005Pj-WA
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 08:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab2BVH2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 02:28:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45774
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752631Ab2BVH2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 02:28:50 -0500
Received: (qmail 26025 invoked by uid 107); 22 Feb 2012 07:28:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Feb 2012 02:28:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2012 02:28:48 -0500
Content-Disposition: inline
In-Reply-To: <4F442721.4080107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191234>

On Tue, Feb 21, 2012 at 05:22:09PM -0600, Neal Kreitzinger wrote:

> My definition for "auto-resolve": "During a merge, the working tree
> files are updated to reflect the result of the merge... When both
> sides made changes to different areas of the same file, git picks
> both sides automatically, and leaves its up to you to make sure you
> review those merge results for correctness after git has made the
> merge commit."

Once the merge commit is made, you can review these with:

  $ git show --raw

which will give you the list of paths that were touched on both sides,
and then you can examine them manually.

You can also use:

  $ git show -c

to get the combined diff, showing hunks that were changed on both sides
(but only in files that would have been listed above). Annoyingly, I
don't think there is a way to get the same multi-way diff information
before the commit is created (i.e., when you still have some conflicts
in the index and working tree left to resolve).

But even both of those are not sufficient to find merge errors. Even
though there is no textual conflict, there may be semantic conflicts
that cross file boundaries (e.g., function foo() changes in foo.c, but a
caller in bar.c is introduced on a side branch). There is no replacement
for actually looking at the full result (though for the lazy, compiling
and running the test suite can often catch the low-hanging fruit).

-Peff
