From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 14:20:57 -0400
Message-ID: <20130912182057.GB32069@sigill.intra.peff.net>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
 <20130911214116.GA12235@sigill.intra.peff.net>
 <CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
 <20130912101419.GY2582@serenity.lan>
 <xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 20:21:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKBVt-0005eK-SJ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 20:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376Ab3ILSVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 14:21:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:56906 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756491Ab3ILSVB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 14:21:01 -0400
Received: (qmail 2244 invoked by uid 102); 12 Sep 2013 18:21:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Sep 2013 13:21:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Sep 2013 14:20:57 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61u6qcez.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234666>

On Thu, Sep 12, 2013 at 08:37:08AM -0700, Junio C Hamano wrote:

> > I wonder if GCC has changed it's behaviour to more closely match C99.
> > Clang as a compatibility article about this sort of issue:
> >
> >     http://clang.llvm.org/compatibility.html#inline
> 
> Interesting.  The ways the page suggests as fixes are
> 
>  - change it to a "statis inline";
>  - remove "inline" from the definition;
>  - provide an external (non-inline) def somewhere else;
>  - compile with gnu899 dialect.

Right, option 3 seems perfectly reasonable to me, as we must be prepared
to cope with a decision not to inline the function, and there has to be
_some_ linked implementation. But shouldn't libc be providing an
external, linkable strcasecmp in this case?

-Peff
