From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep patterns
Date: Tue, 18 Oct 2011 11:04:23 -0400
Message-ID: <20111018150423.GA11593@sigill.intra.peff.net>
References: <20111018044955.GA8976@sigill.intra.peff.net>
 <20111018050105.GC9008@sigill.intra.peff.net>
 <7vd3duixdg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 17:04:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGBDW-00032h-Je
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 17:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab1JRPE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 11:04:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35024
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932324Ab1JRPE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 11:04:28 -0400
Received: (qmail 20800 invoked by uid 107); 18 Oct 2011 15:04:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Oct 2011 11:04:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Oct 2011 11:04:23 -0400
Content-Disposition: inline
In-Reply-To: <7vd3duixdg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183884>

On Tue, Oct 18, 2011 at 12:15:23AM -0700, Junio C Hamano wrote:

> > It's debatable whether this belongs in the generic completion code, as
> > it really only works if your project uses ctags. But I find it to be a
> > huge timesaver for finding callsites of functions, especially when
> > coupled with "git jump grep" from the previous patch.
> 
> Could you elaborate a bit more on how this would help for finding
> callsites? You are looking at a function and do not want to break its
> callers, so at that point presumably you already know the name of the
> function, no?
> 
> Ahh, Ok, you do not necessarily want to type the long function name.

Exactly. Actually, it is often not so much "do not want to type" as
"cannot remember the exact name", but the effect is the same. :)

I use the same completion for "vim -t" which will jump to the
definition.

> By the way, I notice that "make tags" runs "find ." looking for any files
> and directories that match "*.[hcS]" (so do $(ETAGS_TARGET) and cscope),
> without even excluding .git metadirectory.
> 
> Perhaps something like this is in order?
> [...]
> +FIND_SOURCE_FILES = git ls-files '*.[hcS]'

Makes sense to me. I doubt it matters much in practice, though, as we
don't tend to have random untracked source files lying around.

My version of ctags will actually do the recursion itself with "ctags
-R", picking out any files with with languages it knows about. But maybe
not all versions do that.

Also, I have often found myself trying to do completion on shell
functions. I wonder if it's worth adding them to the list (again, my
version of ctags understands bourne shell just fine, but I don't know if
all do).

-Peff
