From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] diff --no-index: test for pager after option
	parsing
Date: Wed, 7 Jan 2009 01:42:48 -0500
Message-ID: <20090107064248.GC22616@coredump.intra.peff.net>
References: <1231286163-9422-1-git-send-email-trast@student.ethz.ch> <7vfxjwf041.fsf@gitster.siamese.dyndns.org> <20090107032013.GO21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 07:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKS9a-00048l-37
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 07:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757581AbZAGGmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 01:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757562AbZAGGmv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 01:42:51 -0500
Received: from peff.net ([208.65.91.99]:53430 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757556AbZAGGmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 01:42:50 -0500
Received: (qmail 13553 invoked by uid 107); 7 Jan 2009 06:43:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 07 Jan 2009 01:43:20 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Jan 2009 01:42:48 -0500
Content-Disposition: inline
In-Reply-To: <20090107032013.GO21154@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104764>

On Wed, Jan 07, 2009 at 04:20:13AM +0100, Miklos Vajna wrote:

> On Tue, Jan 06, 2009 at 04:09:18PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> > But I wonder if it still makes a difference in real life.idn't we stop
> > reporting the exit status from the pager some time ago?
> 
> I just wanted to write this, I think that code could be just removed
> since ea27a18 (spawn pager via run_command interface, 2008-07-22).

I don't think just removing it is right. You would also need to put
SETUP_PAGER into the flags for calling cmd_diff.

We do pass along the error code properly these days, but I think it is
nice that --exit-code always just suppresses the pager. Otherwise a
script like this:

  if git diff --exit-code $x $y; then
    do something
  fi

will invoke the pager (and not everybody's setup immediately exits if
there is no output, either because they have different LESS options or
because they use a different pager). Of course one might argue that the
script should not be using "git diff" porcelain at all, but I don't
think there is another way to get a --no-index diff.

-Peff
