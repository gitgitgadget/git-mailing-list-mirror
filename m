From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 17:36:52 -0400
Message-ID: <20130408213652.GE9649@sigill.intra.peff.net>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan>
 <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan>
 <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan>
 <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de>
 <51632B95.3040103@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:37:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJkU-0000ZG-P9
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936345Ab3DHVhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:37:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34325 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934661Ab3DHVg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:36:57 -0400
Received: (qmail 16408 invoked by uid 107); 8 Apr 2013 21:38:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 17:38:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 17:36:52 -0400
Content-Disposition: inline
In-Reply-To: <51632B95.3040103@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220523>

On Mon, Apr 08, 2013 at 10:41:57PM +0200, Jens Lehmann wrote:

> (While it is easier to merge the link object, a .gitmodules
> aware merge driver would work just as well)

I have not been following this thread that closely, so apologies if I
missed it, but one thing I have not seen mention of is how the extra
information inside the gitlink object will require extra merge effort.

Imagine I have two branches; one updates the submodule's commit pointer,
and the other updates some meta-information about the submodule (e.g.,
it points the URL to a new host). In the current system, one change goes
into .gitmodules, and the other goes into the gitlink path. In a new
combined object, there is a conflict and we must do content-level
merging on it (which presumably would be done with a specialized merge
driver).

So I think that in some cases .gitmodules creates more conflicts
(submodule A and submodule B are touched and have a textual conflict),
and sometimes the combined object would create more objects (you touch
two parts of the of the combined object). The solution in both cases is
a smarter merge driver that understands which parts semantically
conflict and which parts do not.

-Peff
