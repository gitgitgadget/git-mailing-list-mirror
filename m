From: Mike Hommey <mh@glandium.org>
Subject: Re: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Wed, 26 Nov 2014 11:30:39 +0900
Message-ID: <20141126023039.GA19401@glandium.org>
References: <20141126004242.GA13915@glandium.org>
 <20141126010051.GA29830@peff.net>
 <20141126012448.GA11183@peff.net>
 <20141126013456.GA13622@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 03:31:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtSNl-00019B-QR
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 03:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbaKZCbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 21:31:00 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:52300 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbaKZCbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 21:31:00 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XtSNL-00059y-AV; Wed, 26 Nov 2014 11:30:39 +0900
Content-Disposition: inline
In-Reply-To: <20141126013456.GA13622@peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260266>

On Tue, Nov 25, 2014 at 08:34:57PM -0500, Jeff King wrote:
> On Tue, Nov 25, 2014 at 08:24:48PM -0500, Jeff King wrote:
> 
> > However, this is not what trees created by git-notes look like. It
> > shards the object sha1s into subtrees (1a/2b/{36}), and I think does so
> > dynamically in a way that keeps each individual tree size low. The
> > in-memory data structure then only "faults in" tree objects as they are
> > needed. So a single lookup should only hit a small part of the total
> > tree.
> > 
> > Doing a single "git notes edit HEAD" in my case caused the notes code to
> > write the result using its sharding algorithm. Subsequent "git notes
> > show" invocations were only 14ms.
> > 
> > Did you use something besides git-notes to create the tree? From your
> > examples, it looks like you were accounting for the sharding during
> > lookup, so maybe this is leading in the wrong direction (but if so, I
> > could not reproduce your times at all even with a much larger case).
> 
> Hmph. Having just written all that, I looked at your example again, and
> you are running "git ls-tree -r", which would read the whole tree
> anyway. So "git notes" should be _faster_ for a single lookup.

The -r actually doesn't matter, since what's being listed is a blob, not
a tree, so there is no recursion.

Mike
