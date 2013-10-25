From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/19] ewah: compressed bitmap implementation
Date: Thu, 24 Oct 2013 23:15:28 -0400
Message-ID: <20131025031528.GA26283@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
 <20131024180217.GH24180@sigill.intra.peff.net>
 <xmqqiowmkztz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 05:15:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZXsF-00075p-Er
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 05:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab3JYDPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 23:15:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:55188 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754056Ab3JYDPb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 23:15:31 -0400
Received: (qmail 27761 invoked by uid 102); 25 Oct 2013 03:15:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 22:15:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 23:15:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqiowmkztz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236646>

On Thu, Oct 24, 2013 at 04:34:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > From: Vicent Marti <tanoku@gmail.com>
> >
> > EWAH is a word-aligned compressed variant of a bitset (i.e. a data
> > structure that acts as a 0-indexed boolean array for many entries).
> 
> I think I've already pointed out some when the original series was
> posted, but this does not seem to compile with -Wdecl-after-stmt
> (possibly other violations may exist; I haven't looked very closely
> yet).

Sorry about that. I typically compile with "-Wall -Werror" which does
not catch this, and I didn't carefully go over the ewah code for style,
as I considered it mostly a black-box import (though certainly it is
worth fixing this case, as it's not just a style issue).

It looks like there is also some void pointer arithmetic...I _thought_
that was handled by -Wall, but I suppose not. Maybe I need to beef up my
warning settings.

Note that there is also some use of cast-mmap-file-to-struct, only one
instance of which uses __attribute__(packed). However, I notice that the
regular pack code is also guilty of this (e.g., see check_packed_git_idx),
so I don't know how careful we want to be (and whether we should be
using the packed attribute when needed, or if it is sufficiently
non-portable that we want to do it by hand in such cases).

-Peff
