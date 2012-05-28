From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] clone: make --local handle URLs
Date: Mon, 28 May 2012 15:10:30 -0400
Message-ID: <20120528191030.GB2478@sigill.intra.peff.net>
References: <20120526034226.GA14287@sigill.intra.peff.net>
 <20120526034532.GB14332@sigill.intra.peff.net>
 <4FC3C46D.5070704@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon May 28 21:10:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ5Ku-0006gL-Vv
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 21:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757Ab2E1TKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 May 2012 15:10:32 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:34408
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534Ab2E1TKc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 15:10:32 -0400
Received: (qmail 15144 invoked by uid 107); 28 May 2012 19:10:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 May 2012 15:10:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 May 2012 15:10:30 -0400
Content-Disposition: inline
In-Reply-To: <4FC3C46D.5070704@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198715>

On Mon, May 28, 2012 at 08:31:09PM +0200, Johannes Sixt wrote:

> Am 26.05.2012 05:45, schrieb Jeff King:
> > And did you know that file:// URLs
> > can have a hostname in them? How useless.
> ...
> > +test_expect_success 'cloning file:// turns off local optimizations' '
> > +	git clone --bare file://"$PWD"/a non-local &&
> > +	! repo_is_hardlinked non-local
> > +'
> > +
> > +test_expect_success 'cloning file:// with --local uses hardlinks' '
> > +	git clone --bare --local file://"$PWD"/a force-local &&
> > +	repo_is_hardlinked force-local
> > +'
> > +
> > +test_expect_success 'cloning file:// with --local parses URL properly' '
> > +	git clone --bare --local file://host/"$PWD"/%61 force-local-odd &&
> > +	repo_is_hardlinked force-local-odd
> > +'
> 
> I'm pretty certain that we must use file://c:/path/to/repo on Windows to
> make these work. This means we need $(pwd) rather than $PWD.

Ah, sorry, I always forget your pwd woes.

> But what does this mean w.r.t. parsing the URL in the strict sense? Is
> "c:" the host part?

Technically, yes. But there is magic in connect.c to handle
file://c:/path/to/repo, and include "c:/" as part of the path. And I
replicated that logic in my patch (it's the  call to
has_dos_drive_prefix in url_to_local_path).

-Peff
