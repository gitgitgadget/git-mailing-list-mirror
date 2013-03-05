From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push: --follow-tag
Date: Tue, 5 Mar 2013 12:22:33 -0500
Message-ID: <20130305172233.GA9379@sigill.intra.peff.net>
References: <7vd2vewu24.fsf@alter.siamese.dyndns.org>
 <7v6216wtrk.fsf@alter.siamese.dyndns.org>
 <20130305082204.GB13552@sigill.intra.peff.net>
 <7vlia1vnwq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 18:23:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCvZu-0007T6-Eg
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 18:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029Ab3CERWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 12:22:36 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35430 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab3CERWg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 12:22:36 -0500
Received: (qmail 16364 invoked by uid 107); 5 Mar 2013 17:24:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 12:24:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 12:22:33 -0500
Content-Disposition: inline
In-Reply-To: <7vlia1vnwq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217467>

On Tue, Mar 05, 2013 at 07:58:45AM -0800, Junio C Hamano wrote:

> > This will find anything under refs/tags, including annotated and
> > non-annotated tags. I wonder if it is worth making a distinction. In
> > many workflows, unannotated tags should not be leaked out to public
> > repos. But because this feature finds any reachable tags, it will push a
> > tag you made a long time ago as a bookmarker on some part of the history
> > unrelated to the release you are making now.
> 
> What does the auto-follow feature of "git fetch" do currently?
> Whatever we do here on the "git push" side should match it.

It fetches anything in refs/tags, unannotated or not. And that is
certainly a point in favor of "git push" doing the same.

But I wonder if fetching and pushing are different in that respect. You
are (usually) fetching from a public publishing point, and it is assumed
that whatever is there is useful for sharing. The only reason to limit
it is to save time transferring objects the user does not want.

But for "push", you are on the publishing side, which usually means you
need to be a little more careful. It is not just an optimization; it is
about deciding what should be shared. You do not want to accidentally
push cruft or work in progress in your private repository. I think it's
the same logic that leads us to fetch "refs/heads/*" by default, but
only push "matching" (or more recently "HEAD").

> If somebody wants to add some form of filtering mechanism based on
> the tagname (e.g. '--auto-follow-tags=v[0-9]*'), I would not have a
> strong objection to it, but I think that is something we should do
> on top and consistently between fetch and push.  I am not thrilled
> by the idea of conflating annotated-ness and the public-ness of
> tags.

I don't like it either. But I also don't want to introduce a feature
that causes people to accidentally publish cruft. It may not be a
problem in practice; I'm just thinking out loud at this point.

-Peff
