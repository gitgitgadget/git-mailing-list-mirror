From: Jeff King <peff@peff.net>
Subject: Re: Has anyone written a hook to block fast forward merges to a
 branch?
Date: Wed, 21 Mar 2012 14:40:51 -0400
Message-ID: <20120321184051.GB14638@sigill.intra.peff.net>
References: <CAJ8P3RCQjh1ehjsihAmu8roC1aeRo=R0sN2Wm0Y4bVk=st4ivw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 19:41:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAQSy-0000UZ-Dh
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 19:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab2CUSkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 14:40:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55340
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371Ab2CUSkx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 14:40:53 -0400
Received: (qmail 25251 invoked by uid 107); 21 Mar 2012 18:41:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Mar 2012 14:41:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Mar 2012 14:40:51 -0400
Content-Disposition: inline
In-Reply-To: <CAJ8P3RCQjh1ehjsihAmu8roC1aeRo=R0sN2Wm0Y4bVk=st4ivw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193598>

On Wed, Mar 21, 2012 at 02:22:46PM -0400, Chris Patti wrote:

> I know there are hooks out there to block various other kinds of
> change, but I was wondering if anyone had specifically ever written
> one to block fast forward merges.

How would you detect them? If I do a fast-forward merge, the result is
indistinguishable from simply building the commits directly on the
branch in the first place.

If you mean "nobody should ever build commits directly on master, but
always be merging in commits from topic branches", then that is easier
to enforce; just look for non-merge commits down the --first-parent
line, and reject if you find any. I think you could do it with:

  git rev-list --max-parents=1 --first-parent $OLD..$NEW

If that produces output, then somebody build directly on master (or did
a backwards master->topic merge, but if you care about first-parents
lineage, then that is equally bad).

-Peff
