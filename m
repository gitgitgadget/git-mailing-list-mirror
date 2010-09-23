From: Jeff King <peff@peff.net>
Subject: Re: Listing files in order they are changed
Date: Thu, 23 Sep 2010 16:38:15 -0400
Message-ID: <20100923203814.GA10951@sigill.intra.peff.net>
References: <AANLkTimHrCujEggj9KbAWWivY+WxnL0YqsXs+idhymBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Parag Kalra <paragkalra@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 22:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OysYl-0001rD-2I
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 22:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756561Ab0IWUiR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 16:38:17 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50574 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840Ab0IWUiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 16:38:16 -0400
Received: (qmail 6819 invoked by uid 111); 23 Sep 2010 20:38:15 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 23 Sep 2010 20:38:15 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Sep 2010 16:38:15 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimHrCujEggj9KbAWWivY+WxnL0YqsXs+idhymBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156905>

On Thu, Sep 23, 2010 at 11:51:56AM -0700, Parag Kalra wrote:

> Is there a way I can make Git list all the tracked=C2=A0files in the
> working directory=C2=A0in order they are changed (modified, added or
> deleted)

It's a somewhat expensive operation, since you have to walk history
backwards looking at changes. But try:

git log --pretty=3Dformat: --name-only |
  grep . |
  perl -ne 'print unless $seen{$_}++'

which will walk history backwards, printing out each filename the most
recent time it is encountered. Which should give you a list of all file=
s
in the repo (including ones which no longer exist!), in order of most
recent to oldest.

If you want to restrict only to existing files, you would have to do
some clever path-limiting, or parse the results with a slightly smarter
perl script.

You can also tweak the definition of "most recent" by using --topo-orde=
r
or --date-order with git log.

-Peff
