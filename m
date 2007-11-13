From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/3] tracking per-ref errors on push
Date: Tue, 13 Nov 2007 05:25:01 -0500
Message-ID: <20071113102500.GA2767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 11:25:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrsxM-00061E-Rq
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbXKMKZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXKMKZF
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:25:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3782 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598AbXKMKZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:25:04 -0500
Received: (qmail 19285 invoked by uid 111); 13 Nov 2007 10:25:01 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 05:25:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 05:25:01 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64783>

Following is a series to track push errors for individual refs.  This
should have three immediate advantages (the first two of which I
implement in the series):

  - updating tracking refs only for non-error refs
  - incorporating remote rejection into the printed status
  - printing errors in a different order than we processed
    (e.g., consolidating non-ff errors near the end with
    a special message)

The patches are:

  1. send-pack: track errors for each ref
     This is the groundwork for the other 2. I also think it makes the
     code a bit more readable by splitting out the print formatting from
     the push logic, and by explicitly naming the different states that
     we were previously deducing from the states of other variables.

  2. send-pack: check ref->status before updating tracking refs
     This should fix the bugs that people are seeing from 334f483

  3. send-pack: assign remote errors to each ref
     This may have some problems, as I will explain below.

I have a few concerns which make this an RFC and not a real patch
submission:

  - I have done pretty minimal testing, and there are no automated tests
    (at least 2, which fixes a real bug, should get a test).
    Unfortunately, I am out of time to work on this and am leaving the
    country for a week. Between that and Thanksgiving travel, I'm not
    sure when I'll have time to finish up, so I thought it best to have
    comments waiting (and others should feel free to pick up the work if
    they want -- Alex, I think your error consolidation should go nicely
    on top of this).

  - It looks like the push mirror code just made it into next, which
    is going to require a conflict-heavy rebase on my part.

  - There is a potential performance bottleneck in patch 3. See the
    commit message.

  - In patch 3, the 'ng' message sent by the remote are not
    unambiguously parseable.  See the commit message.

-Peff
