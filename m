From: Jeff King <peff@peff.net>
Subject: Re: how to remove unreachable objects?
Date: Mon, 19 Sep 2011 18:52:19 -0400
Message-ID: <20110919225219.GD4056@sigill.intra.peff.net>
References: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
 <20110919195335.GA31930@sigill.intra.peff.net>
 <20110919201804.GB31930@sigill.intra.peff.net>
 <7vsjns8b6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: dieter@schoen.or.at, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 00:52:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5mhN-0004MP-Lv
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 00:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab1ISWwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 18:52:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37789
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab1ISWwV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 18:52:21 -0400
Received: (qmail 10903 invoked by uid 107); 19 Sep 2011 22:57:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Sep 2011 18:57:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2011 18:52:19 -0400
Content-Disposition: inline
In-Reply-To: <7vsjns8b6m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181718>

On Mon, Sep 19, 2011 at 02:38:41PM -0700, Junio C Hamano wrote:

> Yeah, I've been thinking about making it an error to give refs to fsck, as
> I do not think the use cases for feature justifies the possible confusion
> it may cause.
>
> One possible use case might be when your repository is corrupt, and does
> not pass "git fsck" (without any argument).  In such a case, if you are
> lucky and your disk corrupted objects only reachable from a recent topic
> branch, you might find that this command:
> 
> 	$ git fsck master next ...list other topics here...
> 
> still succeeds, so that you can figure out which topic makes such a
> limited fsck fail when it is listed on the command line, judge its
> importance and resurrect what you can from there, before nuking it to
> bring the repository back in health so that you can recreate the topic.

Does that work? I had the impression from the documentation that the
arguments are purely about the reachability analysis, and that the
actual corruption/correctness checks actually look through the object db
directly, making sure each object is well-formed. Skimming cmd_fsck
seems to confirm that.

-Peff
