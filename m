From: Jeff King <peff@peff.net>
Subject: Re: Globbing for ignored branches?
Date: Sat, 25 Jan 2014 15:02:17 -0500
Message-ID: <20140125200217.GA5608@sigill.intra.peff.net>
References: <20140124170739.GC396@x4>
 <20140124170909.GD396@x4>
 <20140124182341.GB8202@sigill.intra.peff.net>
 <20140124183222.GE396@x4>
 <20140124185538.GA9836@sigill.intra.peff.net>
 <xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
 <20140124204825.GA17167@sigill.intra.peff.net>
 <xmqqeh3xqe91.fsf@gitster.dls.corp.google.com>
 <20140125013433.GA22336@sigill.intra.peff.net>
 <20140125141542.GA402@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jim Garrison <jim.garrison@nwea.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
X-From: git-owner@vger.kernel.org Sat Jan 25 21:02:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W79RJ-00024h-0Z
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 21:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbaAYUCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 15:02:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:38855 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751936AbaAYUCV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 15:02:21 -0500
Received: (qmail 9686 invoked by uid 102); 25 Jan 2014 20:02:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 25 Jan 2014 14:02:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Jan 2014 15:02:17 -0500
Content-Disposition: inline
In-Reply-To: <20140125141542.GA402@x4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241074>

On Sat, Jan 25, 2014 at 03:15:42PM +0100, Markus Trippelsdorf wrote:

> Many thanks for the patch. It seems to work as advertised, but only if
> the negative refspec appears on a separate line. For example:
> 
> [remote "origin"]
>         url = git://gcc.gnu.org/git/gcc.git
>         fetch = +refs/heads/*:refs/remotes/origin/*
>         fetch = ^refs/remotes/hjl
> 
> works fine, but:
> 
> [remote "origin"]
>         url = git://gcc.gnu.org/git/gcc.git
>         fetch = +refs/heads/*:refs/remotes/origin/* ^refs/remotes/hjl 

That does not have anything to do with the negative refspec. The config
format is one refspec per "fetch" key, but you may have as many keys as
you like. Doing:

  [remote "origin"]
  fetch = refs/heads/a:refs/heads/a refs/heads/b:refs/heads/b

is similarly wrong. You need to do:

  [remote "origin"]
  fetch = refs/heads/a:refs/heads/a
  fetch = refs/heads/b:refs/heads/b

instead.  I believe that since space is forbidden in refnames, it should
also be forbidden in refspecs, which means that we could interpret the
first one as you expected without losing backwards compatibility. But I
do not think there is any real advantage to doing so, aside from being
more forgiving. I suspect the documentation in that area could be
improved, though.

-Peff
