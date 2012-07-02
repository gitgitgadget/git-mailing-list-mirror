From: Jeff King <peff@peff.net>
Subject: Re: corner case with rename tracking and reverts
Date: Mon, 2 Jul 2012 17:07:33 -0400
Message-ID: <20120702210733.GA5268@sigill.intra.peff.net>
References: <20120702124754.GA25882@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Torben Hohn <torbenh@linutronix.de>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:07:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlnqX-0004vb-TU
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 23:07:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443Ab2GBVHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 17:07:36 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:51799
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137Ab2GBVHg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 17:07:36 -0400
Received: (qmail 12629 invoked by uid 107); 2 Jul 2012 21:07:43 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Jul 2012 17:07:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Jul 2012 17:07:33 -0400
Content-Disposition: inline
In-Reply-To: <20120702124754.GA25882@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200862>

On Mon, Jul 02, 2012 at 02:47:54PM +0200, Torben Hohn wrote:

> i just came over some issue, where the rename tracking got confused.
> 
> I wanted to revert a commit to a moved file. But because it touched an
> empty file, this seems to have confused the rename tracking.
> (there were a few empty files there)

Yeah, it happens. When there are multiple identical sources (which
happens often with empty files), we try to disambiguate using some
heuristics on the filename, but they are not always correct.

As of v1.7.11, git will explicitly avoid auto-merging across renames of
empty files. Instead, you'll get a modify/delete conflict and be given
the opportunity to sort it out yourself.

-Peff
