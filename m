From: Jeff King <peff@peff.net>
Subject: Re: Plumbing to rename a ref?
Date: Fri, 23 May 2014 08:35:03 -0400
Message-ID: <20140523123503.GB726@sigill.intra.peff.net>
References: <87ha4golck.fsf@osv.gnss.ru>
 <20140523105047.GA2249@serenity.lan>
 <87k39ck9r9.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri May 23 14:35:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnogu-0003E1-5R
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 14:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbaEWMfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 08:35:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:58038 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750981AbaEWMfG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 08:35:06 -0400
Received: (qmail 6970 invoked by uid 102); 23 May 2014 12:35:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 May 2014 07:35:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 May 2014 08:35:03 -0400
Content-Disposition: inline
In-Reply-To: <87k39ck9r9.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249987>

On Fri, May 23, 2014 at 03:35:54PM +0400, Sergei Organov wrote:

> John Keeping <john@keeping.me.uk> writes:
> > On Fri, May 23, 2014 at 02:11:55PM +0400, Sergei Organov wrote:
> >> Hello,
> >> 
> >> After convertion of a project from CVS to git, I'd like to rename some
> >> references in the created git repository (before it's published, so no
> >> problems here). Is there a plumbing that would do:
> >> 
> >> git rename-ref <old_name> <new_name>
> >> 
> >> for me?
> >
> > I think the best you can get is two invocations of `git update-ref`:
> >
> > 	git update-ref <new_name> <old_name> &&
> > 	git update-ref -d <old_name>
> 
> This should be good enough. Thanks a lot!

One thing that this misses (as does your original script) is the
reflogs. Doing "branch -m" to rename a branch will actually move the
reflogs, too, but there is otherwise no way to access that
functionality.

It does not seem unreasonable to teach "git update-ref" to do renames to
take advantage of this (it would be fairly simple; the logic is already
encapsulated internally in a rename_ref function).

-Peff
