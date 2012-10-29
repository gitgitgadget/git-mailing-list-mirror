From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Mon, 29 Oct 2012 07:43:10 -0400
Message-ID: <20121029114310.GA16046@sigill.intra.peff.net>
References: <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <50883E54.4080507@web.de>
 <20121025005307.GE801@odin.tremily.us>
 <508D9A12.6010104@web.de>
 <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
 <20121028223431.GF26675@odin.tremily.us>
 <20121029053401.GB30186@sigill.intra.peff.net>
 <20121029104544.GA2424@odin.tremily.us>
 <20121029105855.GA15075@sigill.intra.peff.net>
 <20121029112945.GD2424@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Nahor <nahor.j+gmane@gmail.com>, Phil Hord <phil.hord@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Oct 29 12:43:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSnkc-0001WY-FY
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 12:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758787Ab2J2LnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 07:43:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42685 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758782Ab2J2LnN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 07:43:13 -0400
Received: (qmail 19990 invoked by uid 107); 29 Oct 2012 11:43:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Oct 2012 07:43:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2012 07:43:10 -0400
Content-Disposition: inline
In-Reply-To: <20121029112945.GD2424@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208620>

On Mon, Oct 29, 2012 at 07:29:45AM -0400, W. Trevor King wrote:

> On Mon, Oct 29, 2012 at 06:58:55AM -0400, Jeff King wrote:
> > Can you send an updated version of the patch that summarizes the
> > situation in the commit message?
> 
> Sure.  Should I include Phil's $submodule_<var-name> export, or would
> you rather have that be a separate series?

I think it probably makes sense as a separate patch in the same series,
since it is meant to support the same workflows.

I am not sure it is sufficient as-is, though. It does not seem to ever
clear variables, only set them, which means that values could leak
across iterations of the loop, or down to recursive calls. E.g., when
the first submodule has submodule.*.foo set but the second one does not,
you will still end up with $submodule_foo set when you process the
second one.

-Peff
