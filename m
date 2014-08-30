From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Sat, 30 Aug 2014 09:16:49 -0400
Message-ID: <20140830131649.GA26833@peff.net>
References: <20140829205538.GD29456@peff.net>
 <20140829205809.GB7060@peff.net>
 <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com>
 <20140829220818.GA24834@peff.net>
 <CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 15:17:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNiWZ-0001ma-2H
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 15:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbaH3NQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2014 09:16:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:33797 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751581AbaH3NQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 09:16:53 -0400
Received: (qmail 20209 invoked by uid 102); 30 Aug 2014 13:16:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 30 Aug 2014 08:16:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Aug 2014 09:16:49 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256250>

On Fri, Aug 29, 2014 at 07:59:32PM -0700, Shawn Pearce wrote:

> > I agree it is probably a bug on the sending side, but I think last time
> > this came up we decided to try to be liberal in what we accept.  c.f.
> > http://thread.gmane.org/gmane.comp.version-control.git/232305/focus=232310
> 
> IIRC they aren't valid pack files to contain duplicates.
> 
> Once upon a time JGit had a bug and android.googlesource.com returned
> duplicate objects in a Linux kernel repository. This caused at least
> some versions of git-core to fail very badly in binary search at
> object lookup time or something. We had a lot of users angry with us.
> :)
> 
> I know Nico said its OK last year, but its really not. I don't think
> implementations are capable of handling it.

We do detect and complain if --strict is given. Should we make it the
default instead? I think it is still worthwhile to have a mode that can
handle these packs. It may be the only reasonable way to recover the
data from such a broken pack (and that broken pack may be the only copy
of the data you have, if you are stuck getting it out of a broken
implementation on a remote server).

-Peff
