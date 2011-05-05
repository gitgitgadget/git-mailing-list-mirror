From: Jeff King <peff@peff.net>
Subject: Re: Intermittent Failures in t1450-fsck (Bisected)
Date: Thu, 5 May 2011 17:03:17 -0400
Message-ID: <20110505210317.GE1770@sigill.intra.peff.net>
References: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com>
 <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com>
 <20110505093226.GA29595@sigill.intra.peff.net>
 <60194977-A4A9-4E18-9878-C1CDE77B75C2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:03:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI5hk-00069D-UJ
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 23:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab1EEVDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 17:03:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51410
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab1EEVDT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 17:03:19 -0400
Received: (qmail 3446 invoked by uid 107); 5 May 2011 21:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 17:05:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 17:03:17 -0400
Content-Disposition: inline
In-Reply-To: <60194977-A4A9-4E18-9878-C1CDE77B75C2@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172913>

On Thu, May 05, 2011 at 04:04:33PM -0400, Brian Gernhardt wrote:

> The original e-mail was from next at that point.  The output from the
> rebased version and current next (76e37e2) is identical.

Thanks. The weird thing is that running t1450 on 76e37e2 gives me this
output:

broken link from     tag 66f6581d549f70e05ca586bc2df5c15a95662c36
broken link from unknown unknown
dangling blob 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, not a commit
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not load tagged object
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links

whereas from your original email, you had:

> >>> tagged commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 (wrong) in 66f6581d549f70e05ca586bc2df5c15a95662c36
> >>> missing commit 63499e4ea8e096b831515ceb1d5a7593e4d87ae5
> >>> error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
> >>> error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or missing

which is weird. We do call "remove_object $sha", but only inside
test_when_finished. I wonder if there is some bug with
test_when_finished on your platform. Have you tried instrumenting the
remove_object function to print a message when it is run? That might
give us a clue if it is accidentally being run early.

> This is on my OS X laptop and last I knew valgrind was very buggy on
> OS X, so I've never tried it.  I'll install it now and see if I can
> get anything useful out of it.

I've tried but been unable to reproduce on Linux, so it seems like
something OS X specific.

-Peff
