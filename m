From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] prune: show progress while marking reachable objects
Date: Tue, 8 Nov 2011 00:31:49 -0500
Message-ID: <20111108053149.GA29643@sigill.intra.peff.net>
References: <1320494408-6373-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 06:31:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNeHs-0007Sj-D0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 06:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363Ab1KHFbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 00:31:51 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36059
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750970Ab1KHFbv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 00:31:51 -0500
Received: (qmail 867 invoked by uid 107); 8 Nov 2011 05:31:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 Nov 2011 00:31:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2011 00:31:49 -0500
Content-Disposition: inline
In-Reply-To: <1320494408-6373-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185067>

On Sat, Nov 05, 2011 at 07:00:08PM +0700, Nguyen Thai Ngoc Duy wrote:

> prune already shows progress meter while pruning. The marking part may
> take a few seconds or more, depending on repository size. Show
> progress meter during this time too.

Thanks, this is a nice start. It's missing a few things IMHO:

  1. It actually counts commits, not all objects. I'm tempted to say
     this doesn't matter, as any eye candy is helpful. Except that the
     most common use of prune is as part of "git gc", in which case
     pack-objects will have just done the "counting objects" phase and
     come up with some number. If we count all objects, then our end
     number is the same (modulo any .keep packs, but at least it's
     probably in the same order of magnitude). That gives the user a
     better sense of completion time.

  2. Prune should learn --progress/--no-progress, isatty(2), etc. And
     git-gc should pass --no-progress when it's told to be quiet.

Patches for both in a moment.

-Peff
