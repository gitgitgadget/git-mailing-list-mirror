From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] want_color: automatically fallback to color.ui
Date: Sun, 4 Sep 2011 08:53:12 -0400
Message-ID: <20110904125312.GA21724@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
 <20110818050533.GJ2889@sigill.intra.peff.net>
 <alpine.DEB.2.00.1109032212310.12564@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 14:53:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0CCU-0004Vo-Ke
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 14:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab1IDMxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 08:53:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48717
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753532Ab1IDMxS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 08:53:18 -0400
Received: (qmail 11467 invoked by uid 107); 4 Sep 2011 12:54:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 04 Sep 2011 08:54:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Sep 2011 08:53:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1109032212310.12564@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180680>

On Sat, Sep 03, 2011 at 10:36:01PM -0400, Martin von Zweigbergk wrote:

> This patch makes format-patch output color escape codes to file when
> run with color.ui=always. Before the patch it did not do that. The
> documentation for color.ui says "Set it to always if you want all
> output not intended for machine consumption to use color". Is
> format-patch "intended for machine consumption" or not?

Sorry, this is a regression. The old behavior was that commands had to
copy color.ui's value manually into diff_use_color_default. With my
patch, the value is picked up automatically, and it is up to commands to
load or not load the specified config.

For diff plumbing versus porcelain, we have separate config code paths
(diff_basic versus diff_ui). I forgot that format-patch versus log has
the same situation, and needs the same split.

It's a long weekend here in the US, but I'll try to get a patch out on
Tuesday (and also check for any other similar regressions).

> I'm not sure why I had the parameter set to "always" instead of
> "true/auto" and maybe I should change it, but since this patch changes
> the behavior, I thought I should let you know (it was not mentioned in
> the commit message, so I'm not sure it was intentional).

Yeah, I don't think setting color.ui to "always" is all that useful. But
this behavior change was definitely not intentional. Thanks for
noticing.

-Peff
