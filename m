From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 15:44:54 -0400
Message-ID: <20150821194454.GB26466@sigill.intra.peff.net>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
 <1440121237-24576-2-git-send-email-sbeller@google.com>
 <xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	hvoigt@hvoigt.net, jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 21:45:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSsFJ-00064X-VF
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 21:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbbHUTo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 15:44:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:48320 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751934AbbHUTo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 15:44:57 -0400
Received: (qmail 16983 invoked by uid 102); 21 Aug 2015 19:44:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 14:44:57 -0500
Received: (qmail 4102 invoked by uid 107); 21 Aug 2015 19:44:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Aug 2015 15:44:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Aug 2015 15:44:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276323>

On Fri, Aug 21, 2015 at 12:05:13PM -0700, Junio C Hamano wrote:

> The primary reason I suspect is because you sent to a wrong set of
> people.  Submodule folks have largely been working in the scripted
> ones, and may not necessarily be the ones who are most familiar with
> the run-command infrastructure.
> 
> "shortlog --no-merges" tells me that the obvious suspects are j6t
> and peff.

No good deed goes unpunished. ;)

Before even looking at the implementation, my first question would be
whether this pattern is applicable in several places in git (i.e., is it
worth the extra complexity of abstracting out in the first place). I
think there are a few task-queue patterns already in git; for example
the delta search in pack-objects. Is the interface given here sufficient
to convert pack-objects? Is the result nicer to read? Is it as
efficient?

We do not need to convert all possible call-sites to the new abstracted
code at once. But I find that converting at least _one_ is a good litmus
test to confirm that a new interface is generally useful.

-Peff
