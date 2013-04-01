From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] remote-helpers: fix the run of all tests
Date: Mon, 1 Apr 2013 19:40:16 -0400
Message-ID: <20130401234016.GC30935@sigill.intra.peff.net>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
 <1364850872-21135-2-git-send-email-felipe.contreras@gmail.com>
 <CALWbr2wAqudzbfiSHmD1uAVQX3mtbf5vgr2JXbXEg7yzaKXJcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 01:40:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMoLH-00034t-VE
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 01:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758049Ab3DAXkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 19:40:20 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51400 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757475Ab3DAXkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 19:40:19 -0400
Received: (qmail 3770 invoked by uid 107); 1 Apr 2013 23:42:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Apr 2013 19:42:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Apr 2013 19:40:16 -0400
Content-Disposition: inline
In-Reply-To: <CALWbr2wAqudzbfiSHmD1uAVQX3mtbf5vgr2JXbXEg7yzaKXJcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219726>

On Mon, Apr 01, 2013 at 11:46:00PM +0200, Antoine Pelisse wrote:

> On Mon, Apr 1, 2013 at 11:14 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > +export TEST_LINT :=
> 
> I think "test-lint-executable" still makes sense here.

Also test-lint-shell-syntax, which finds a problem with the current
code:

  $ cd contrib/remote-helpers
  $ make test TEST_LINT=test-lint-shell-syntax
  make -e -C ../../t test
  make[1]: Entering directory `/home/peff/compile/git/t'
  rm -f -r test-results
  /home/peff/compile/git/contrib/remote-helpers/test-bzr.sh:139: error: echo -n is not portable (please use printf):   echo -n content > expected &&
  make[1]: *** [test-lint-shell-syntax] Error 1
  make[1]: Leaving directory `/home/peff/compile/git/t'
  make: *** [test] Error 2

I think the check for duplicate-numbers is the only one that does not
make sense. Unfortunately it is not as simple as using $(filter-out) to
get rid of it from TEST_LINT, as that variable may not even be set until
we chain to the other Makefile (e.g., if it comes from loading
config.mak).

-Peff
