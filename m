From: Jeff King <peff@peff.net>
Subject: Re: check-attr doesn't respect recursive definitions
Date: Tue, 2 Apr 2013 12:30:34 -0400
Message-ID: <20130402163034.GA19252@sigill.intra.peff.net>
References: <slrnkldd3g.1l4.jan@majutsushi.net>
 <20130402143130.GC23828@sigill.intra.peff.net>
 <7vtxnogbft.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Larres <jan@majutsushi.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:31:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN472-0002fp-AK
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:31:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761762Ab3DBQaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:30:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52278 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759065Ab3DBQai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:30:38 -0400
Received: (qmail 10777 invoked by uid 107); 2 Apr 2013 16:32:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 12:32:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 12:30:34 -0400
Content-Disposition: inline
In-Reply-To: <7vtxnogbft.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219791>

On Tue, Apr 02, 2013 at 09:11:02AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, it is the expected behavior, though I cannot offhand think of
> > anything that would break if we did apply it recursively.
> 
> Conceptually that breaks our brain.  "All files in doc/ directories
> are text" and "doc/ directory is text" are two different things, no?

In some systems, yes, but git does not have any notion of "doc/" as an
item (after all, we track content in files, not directories), so I do
not see what it means to specify a directory except to say "everything
under it has this property".

We already treat "foo/" in gitignore this way (i.e., "everything under
foo is ignored"). And we treat export-ignore the same way in
git-archive.

I agree that saying "Documentation diff=text" is not something I would
expect people to do, but what _should_ it do? Recursively applying under
the directory seems a sane option. I would not want to paint us into a
corner, but I cannot think of any other reasonable thing to do with it
(which is why I phrased it as "I cannot think of anything that would
break", and not "this is a great idea"; counterpoints are welcome).

I am sympathetic to Jan's issue, though. If git were consistent about
applying attributes only to paths, then the repo owner would have
written "dir/* export-ignore", not "dir". But it is not, and git-archive
does ask for attributes on directories, but without providing a good
mechanism for doing those attribute lookups from external programs.

-Peff
