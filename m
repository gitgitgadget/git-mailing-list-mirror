From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] t3301: use test_must_fail instead of !
Date: Tue, 17 Feb 2009 15:27:32 -0500
Message-ID: <20090217202731.GA16586@coredump.intra.peff.net>
References: <200902142056.42198.trast@student.ethz.ch> <8c50889d27e5baec1cbbd9a5775fa80b986c6df6.1234642638.git.trast@student.ethz.ch> <7vvdrcnnl0.fsf@gitster.siamese.dyndns.org> <200902151711.45099.trast@student.ethz.ch> <20090215181818.GA2291@coredump.intra.peff.net> <e2b179460902170129s7ae613cehe237619be5e84936@mail.gmail.com> <20090217163413.GB31297@sigill.intra.peff.net> <e2b179460902171000s605675dct1f499a9425c3ebb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 21:29:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZWZ0-0003Ry-3x
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 21:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbZBQU1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 15:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbZBQU1f
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 15:27:35 -0500
Received: from peff.net ([208.65.91.99]:52788 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbZBQU1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 15:27:34 -0500
Received: (qmail 31907 invoked by uid 107); 17 Feb 2009 20:27:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Feb 2009 15:27:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2009 15:27:32 -0500
Content-Disposition: inline
In-Reply-To: <e2b179460902171000s605675dct1f499a9425c3ebb2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110449>

On Tue, Feb 17, 2009 at 06:00:17PM +0000, Mike Ralphson wrote:

> > Hmm. I tried "make SHELL_PATH=/bin/posh test", and posh segfaulted during
> > t0005. So I don't think it's quite ready for mainstream use. ;)
> 
> Works ok for me as far as t3404-rebase-interactive on next, though
> what I actually grabbed in the end was 0.6.16[1], which claims to fix
> a segfault bug[2], but then it also claims to be 0.6.12 as well, so
> who knows? 8-)
> 
> Maybe a Debian user would like to report a repeat of [3]?

Hmm. It sort of fixes the segfault bug. With posh 0.6.16, I can do:

  $ posh -x
  $ ls
  + ls
  ...

but:

 $ posh -x t0005-signals.sh
 Segmentation fault

OK, maybe it doesn't like non-interactive shells. Let's try sourcing the
script:

 $ posh -x
 $ . t0005-signals.sh
 + . t0005-signals.sh
 posh: .: t0005-signals.sh: not found

OK, maybe it is looking in the PATH?

 $ PATH=$PATH:.
 Segmentation fault

Oops. How about a new shell with a more exact path?

 $ posh -x
 $ . ./t0005-signals.sh
 Segmentation fault

Oops. So I think there are some serious problems (at least with -x).

Of course it's hard to diagnose the non "-x" segfault in t0005 without
"-x". ;)

But this is just unproductive complaining to do it on the git list (I'm
just amazed at how frequently it is segfaulting). I'll go file some
Debian bug reports.

-Peff
