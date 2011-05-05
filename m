From: Jeff King <peff@peff.net>
Subject: Re: Intermittent Failures in t1450-fsck (Bisected)
Date: Thu, 5 May 2011 17:17:36 -0400
Message-ID: <20110505211736.GA7256@sigill.intra.peff.net>
References: <115C364B-E910-4A9C-949E-3B10E5E6116C@silverinsanity.com>
 <2838BCC7-FB14-401B-9498-D0FB78C98D91@silverinsanity.com>
 <20110505093226.GA29595@sigill.intra.peff.net>
 <60194977-A4A9-4E18-9878-C1CDE77B75C2@silverinsanity.com>
 <1A288BE9-F001-4CAD-8A89-4B4D6F0F246B@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:17:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI5vc-0005Cm-DU
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 23:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985Ab1EEVRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 17:17:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49099
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752Ab1EEVRi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 17:17:38 -0400
Received: (qmail 3652 invoked by uid 107); 5 May 2011 21:19:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 17:19:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 17:17:36 -0400
Content-Disposition: inline
In-Reply-To: <1A288BE9-F001-4CAD-8A89-4B4D6F0F246B@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172916>

On Thu, May 05, 2011 at 05:07:54PM -0400, Brian Gernhardt wrote:

> On May 5, 2011, at 4:04 PM, Brian Gernhardt wrote:
> 
> > On May 5, 2011, at 5:32 AM, Jeff King wrote:
> > 
> >> Given that the problem seems racy and intermittent, have you tried
> >> running under valgrind?
> > 
> > This is on my OS X laptop and last I knew valgrind was very buggy on OS X, so I've never tried it.  I'll install it now and see if I can get anything useful out of it.
> 
> I will note the test _reliably_ fails when run in parallel with other tests.

It might be interference from another test, though in general they
should all be in their own little sandboxes. It could just be a race
condition that gets triggered more reliably when the system is under
load.

> Under valgrind I get the following error.  I will note that attempting
> to run the full test suite with valgrind gives lots of similar errors
> in many tests.  (All conditional jump in deflate, allocated in
> write_loose_object.)

This is probably a false positive. On Linux we see these in libz because
it has some weird optimized loop that can read past the end of the
buffer (though I have usually see it in the inflate code path, not
deflate).

-Peff
