From: Jeff King <peff@peff.net>
Subject: Re: [rfd] auto-following tags upon "git push"?
Date: Tue, 7 Jun 2011 13:30:51 -0400
Message-ID: <20110607173051.GA22216@sigill.intra.peff.net>
References: <7v4o417g9s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:31:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU07K-00062C-QE
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:31:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115Ab1FGRa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:30:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41346
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932111Ab1FGRaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:30:55 -0400
Received: (qmail 17630 invoked by uid 107); 7 Jun 2011 17:31:01 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:31:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:30:51 -0400
Content-Disposition: inline
In-Reply-To: <7v4o417g9s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175231>

On Tue, Jun 07, 2011 at 09:33:35AM -0700, Junio C Hamano wrote:

> So, while we still should _never_ automatically push any tag that points
> at a commit that is being pushed out (i.e. inverse of "fetch" that auto
> follows tags), if the user or the project can give a clear enough hint to
> git which tags are for public consumption, we should at least be able to
> push tags that are for public consumption and do point at commits that are
> being pushed out.
> 
> This is just me thinking out loud, but a typical end-user transcript may
> look something like this:
> 
>    Tell git that v*.* and v*.*.* are release tags (one-time set-up).
>    $ git config --unset-all push.autotag
>    $ git config --add push.autotag 'v*.*'
>    $ git config --add push.autotag 'v*.*.*'

Hmm. Is it a clear enough hint when the user uses an actual tag object
to make a signed or annotated tag? At least for me, private throw-away
tags tend to just be refs/tags/foo pointing to a commit, and real,
for-public-consumption tags at least get an annotation, if not a
signature.

I seem to recall we make a similar distinction somewhere else in the
code, but I can't remember offhand where. Maybe it was just a proposal
that never made it anywhere.

Anyway, the problem would be somebody who does something like:

  $ git tag -m "here is a description of how this wip is going" foo-wip

which violates the assumption above. I have no idea how common that is
(I tend to write such descriptions into a WIP commit message, and if I
really want to, tag the resulting commit directly).

-Peff
