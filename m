From: Jeff King <peff@peff.net>
Subject: Re: mktree: multiple same-named objects
Date: Wed, 27 Aug 2014 01:13:41 -0400
Message-ID: <20140827051341.GB32141@peff.net>
References: <1409114517.13351.6.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 07:13:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMVYK-000737-1u
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 07:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbaH0FNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 01:13:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:59826 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750919AbaH0FNn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 01:13:43 -0400
Received: (qmail 6315 invoked by uid 102); 27 Aug 2014 05:13:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Aug 2014 00:13:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Aug 2014 01:13:41 -0400
Content-Disposition: inline
In-Reply-To: <1409114517.13351.6.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255980>

On Wed, Aug 27, 2014 at 12:41:57AM -0400, David Turner wrote:

> git mktree seems to allow the creation of a tree object with multiple
> objects of the same name but different SHAs.

Yeah, I don't think we do many quality checks there. Ditto for "git
hash-object".

The latter goes through index_mem, which at least checks that the
resulting tree is parseable. It does not look like mktree even checks
that.

> Summary: git mktree ought to forbid this, and possibly there ought to be
> other checks (for instance, when unpacking) to prevent this.

The checks in git-fsck will notice your problem (and many others). I
think we should be running them anytime we create an object based on
arbitrary data (including mktree and hash-object). Code paths like "git
write-tree" and "git commit-tree" are probably OK, as their code should
follow the standard (it would not hurt to double-check their output,
though there may be a performance implication).

Dscho (cc'd) has been looking into this approach; I don't know how far
he has gotten.

-Peff
