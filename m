From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] GIT 1.5.5-rc2
Date: Fri, 28 Mar 2008 17:23:40 -0400
Message-ID: <20080328212340.GC9131@coredump.intra.peff.net>
References: <7viqz72we4.fsf@gitster.siamese.dyndns.org> <20080328181345.GB8299@coredump.intra.peff.net> <7vtziq1rwa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 22:24:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfM3m-0004wZ-9K
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 22:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbYC1VXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 17:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755085AbYC1VXo
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 17:23:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3880 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754562AbYC1VXn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 17:23:43 -0400
Received: (qmail 7628 invoked by uid 111); 28 Mar 2008 21:23:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 28 Mar 2008 17:23:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2008 17:23:40 -0400
Content-Disposition: inline
In-Reply-To: <7vtziq1rwa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78439>

On Fri, Mar 28, 2008 at 02:05:09PM -0700, Junio C Hamano wrote:

> > I never got a response to my patches to fix encoding issues in
> > "send-email --compose". It _is_ a bugfix, but I don't know if it is
> > 1.5.5-worthy.  Forgotten (and I should resubmit now), or should I wait
> > until after the release?
> 
> I was getting the impression that it was still in "ah, but this is
> better", "you are right, but how about doing this", stage and was hoping
> that "ok, based on the discussion here is the final one" will come soon.

Ah. I think the current status is "here are two patches that work, but
will always assume utf-8 encoding" which I think is not unreasonable as
a bugfix. A nice feature would be to allow setting the encoding, but:

  - I think that is a feature, and one that nobody has expressed an
    interest in. In fact, the little rfc2047 encoding already being done
    in send-email blindly assumed utf-8.
  - if that feature is going to be done, I think some thought would have
    to go into how encodings should be specified so we don't end up with
    too many (or too few) places where you have to specify the encoding
    (IOW, I think that send-email.compose-encoding is probably too
    specific, but reusing an existing encoding variable is not quite
    right).
  - As a non-user of send-email, a rare user of encodings at all, and an
    always user of utf-8, I'm not too interested in such a feature, nor
    would I feel comfortable speaking on behalf of users who _would_ use
    such a feature.

So I think it is worth taking the patches for 1.5.5 as they are a strict
improvement over the old behavior (the only reason they would not be is
if somebody used a mail pipeline that assumed non-MIME stuff was in some
random charset instead of us-ascii, and by setting utf-8 we are now
confusing that pipeline; it seems unlikely to me, and it violates the
standards).

On top of which I think they are a fine stepping stone to selecting the
encoding (IOW, if I _were_ going to do such a feature, I think I would
still submit those two patches as-is, and add configurability as a third
patch anyway).

My only real concern is that they break something unrelated, as we are
late in the -rc cycle.

-Peff
