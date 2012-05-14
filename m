From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Update "gc" behavior in commit, merge, am, rebase and
 index-pack
Date: Mon, 14 May 2012 16:50:40 -0400
Message-ID: <20120514205039.GB3740@sigill.intra.peff.net>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 22:50:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU2EA-0007pz-A6
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 22:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab2ENUum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 16:50:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43076
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757829Ab2ENUul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 16:50:41 -0400
Received: (qmail 25288 invoked by uid 107); 14 May 2012 20:51:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 16:51:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 16:50:40 -0400
Content-Disposition: inline
In-Reply-To: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197809>

On Sat, May 12, 2012 at 03:08:54PM +0700, Nguyen Thai Ngoc Duy wrote:

> Instead, we could just inform users that "gc" should be run soon in
> commonly used commands (this patch also reinstates "gc" check in
> commit, which was lost at the sh->C conversion). [1] and [2] can annoy
> users constantly with warnings. This patch shows the warning at most
> once a day.

Hmm. The missing "gc" from git-commit has been noticed before, but we
decided not to reinstate it[1]:

  http://thread.gmane.org/gmane.comp.version-control.git/78524/focus=78693

However, I'm not sure Junio's argument in that thread is valid:

  I had an impression that we accepted the hook which made "gc --auto"
  more expensive by forcing it to check the hook (and possibly execute
  it every time) after vetting am, svn and friends to make sure nobody
  triggered "gc --auto" once per every commit, and during that vetting
  process we noticed that "git commit" lost the "gc --auto" at the end.

The pre-auto-gc hook runs only when we need to gc (i.e., when we would
be doing something expensive, anyway). So it is still cheap to check
whether we need to gc (although if you have an option like "--check"
which does not _fix_ the situation after checking, then you may end up
running the hook repeatedly).

-Peff

[1] It also came up other times:

      http://thread.gmane.org/gmane.comp.version-control.git/101667

      http://thread.gmane.org/gmane.comp.version-control.git/114089

    but each time it seems to have been rejected on the basis of the
    first argument.
