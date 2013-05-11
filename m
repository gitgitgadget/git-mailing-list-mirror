From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] cache.h: eliminate SHA-1 deprecation warnings on OS X
 10.8
Date: Sat, 11 May 2013 10:22:03 +0200
Message-ID: <20130511082203.GA953@sigill.intra.peff.net>
References: <1368240282-89581-1-git-send-email-davvid@gmail.com>
 <20130511062336.GD3394@elie>
 <CAJDDKr6QkeSk32kNhU_QuvrZSGUEokcEbN7Aq3PcOhvaA_hFgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 10:22:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub54V-0000P6-Jn
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 10:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674Ab3EKIWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 04:22:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:55575 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab3EKIWI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 04:22:08 -0400
Received: (qmail 15930 invoked by uid 102); 11 May 2013 08:22:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 11 May 2013 03:22:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 10:22:03 +0200
Content-Disposition: inline
In-Reply-To: <CAJDDKr6QkeSk32kNhU_QuvrZSGUEokcEbN7Aq3PcOhvaA_hFgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223940>

On Sat, May 11, 2013 at 12:11:05AM -0700, David Aguilar wrote:

> > Does this perform better or worse than just setting
> > BLK_SHA1=YesPlease?  I'd naively think it could go either way: on one
> > hand adding another library dependency can slow down startup, and on
> > the other hand the implementation may or may not be optimized better
> > than the generic block-sha1/ implementation.
> 
> Pretty much identical.
> 
> Here are the timings (I should probably read t/perf/README and get
> better numbers):
> 
> Best of ten
> $ time git rev-list --all --objects >/dev/null
> [...]

I'm not sure that's a great test of sha1 performance. It will hash the
commit and tree objects it loads during the traversal, but that time is
almost certainly dwarfed by zlib inflation and by lookup_object.

Adding "--verify-objects" would sha1 the blobs, too, which might be more
reasonable (or running "git fsck"). Something like "git add" on a large
blob would also be a good test.

-Peff
