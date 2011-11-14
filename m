From: Jeff King <peff@peff.net>
Subject: Re: reset reports file as modified when it's in fact deleted
Date: Mon, 14 Nov 2011 17:50:56 -0500
Message-ID: <20111114225056.GA27370@sigill.intra.peff.net>
References: <20111107094330.GB10936@beez.lab.cmartin.tk>
 <20111107162642.GA27055@sigill.intra.peff.net>
 <20111111140834.GA10025@beez.lab.cmartin.tk>
 <7vr51er4nd.fsf@alter.siamese.dyndns.org>
 <20111111182109.GB16055@sigill.intra.peff.net>
 <7vhb2aqjwu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 23:51:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ5Mm-0002Vc-JH
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 23:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579Ab1KNWu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 17:50:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41320
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756565Ab1KNWu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 17:50:59 -0500
Received: (qmail 489 invoked by uid 107); 14 Nov 2011 22:51:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 17:51:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 17:50:57 -0500
Content-Disposition: inline
In-Reply-To: <7vhb2aqjwu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185411>

On Fri, Nov 11, 2011 at 04:11:29PM -0800, Junio C Hamano wrote:

> > I'm happy to make that change. What do you think of the feature overall?
> 
> The "feature" is more or less "Meh" to me; I do not mind differentiating M
> and D there because the necessary information is already there in the
> codepath, but if we were to really do that, then the variables must be
> renamed. We shouldn't name them after "you must do this at the plumbing
> level" like we have done so far, and instead use "the path is in this
> state". This is even more so if we were to further split a single "state"
> that plumbing layer considers the same and gives the same "needs X" to
> different states that Porcelains would give different messages in the
> future.

I admit I don't care all that much either, but it's easy to do, and I
think it is less surprising to users. Patches are below.

> > And should typechanges also be handled here (it's no extra work for git
> > to detect them; we just have to pass the TYPE_CHANGED flag back up the
> > stack)?
> 
> As long as "pass ... back up the stack" does not result in too much
> ugliness in the code, I am OK with it.

It ended up pretty simple, but I split it out from the deletion case so
you can see it more clearly (and can drop the latter half of the series
if we don't want it).

  [1/4]: refresh_index: rename format variables
  [2/4]: refresh_index: mark deletions in porcelain output
  [3/4]: read-cache: let refresh_cache_ent pass up changed flags
  [4/4]: refresh_index: notice typechanges in output

(If I were sure we wanted the typechange output, I think a more
reasonable ordering would be 1, then 3, then squash 2 and 4 into a
single patch. But see my comment in 4/4).

-Peff
