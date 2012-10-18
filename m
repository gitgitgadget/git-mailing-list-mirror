From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] status: refactor output format to represent "default"
 and add --long
Date: Thu, 18 Oct 2012 17:20:57 -0400
Message-ID: <20121018212057.GA3192@sigill.intra.peff.net>
References: <20121018020308.GA24484@sigill.intra.peff.net>
 <1350569750-26304-1-git-send-email-pclouds@gmail.com>
 <7vtxtrlbvo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 23:21:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOxWj-0003EU-AG
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 23:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684Ab2JRVVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 17:21:01 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38042 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755977Ab2JRVU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 17:20:59 -0400
Received: (qmail 9611 invoked by uid 107); 18 Oct 2012 21:21:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Oct 2012 17:21:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2012 17:20:57 -0400
Content-Disposition: inline
In-Reply-To: <7vtxtrlbvo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208020>

On Thu, Oct 18, 2012 at 02:16:11PM -0700, Junio C Hamano wrote:

> I guess combining both is fine, but then the commit is no longer "in
> preparation for adding" the option, but it already adds "--long", I
> would think.

Maybe a better commit message is:

-- >8 --
Subject: status: add --long output format option

You can currently set the output format to --short or
--porcelain. There is no --long, because we default to it
already. However, you may want to override an alias that
uses "--short" to get back to the default.

This requires a little bit of refactoring, because currently
we use STATUS_FORMAT_LONG internally to mean the same as
"the user did not specify anything". By expanding the enum
to include STATUS_FORMAT_NONE, we can distinguish between
the implicit and explicit cases. This effects these
conditions:

  1. The user has asked for NUL termination. With NONE, we
     currently default to turning on the porcelain mode.
     With an explicit --long, we would in theory use NUL
     termination with the long mode, but it does not support
     it. So we can just complain and die.

  2. When an output format is given to "git commit", we
     default to "--dry-run". This behavior would now kick in
     when "--long" is given, too.
