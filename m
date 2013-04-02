From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] remote-helpers: fix the run of all tests
Date: Tue, 2 Apr 2013 13:36:52 -0400
Message-ID: <20130402173652.GC24698@sigill.intra.peff.net>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
 <1364850872-21135-2-git-send-email-felipe.contreras@gmail.com>
 <CALWbr2wAqudzbfiSHmD1uAVQX3mtbf5vgr2JXbXEg7yzaKXJcw@mail.gmail.com>
 <20130401234016.GC30935@sigill.intra.peff.net>
 <515B0D08.4020405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 19:37:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN59C-0005JU-5w
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 19:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab3DBRg5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Apr 2013 13:36:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52369 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209Ab3DBRg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 13:36:56 -0400
Received: (qmail 11746 invoked by uid 107); 2 Apr 2013 17:38:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Apr 2013 13:38:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2013 13:36:52 -0400
Content-Disposition: inline
In-Reply-To: <515B0D08.4020405@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219815>

On Tue, Apr 02, 2013 at 06:53:28PM +0200, Torsten B=C3=B6gershausen wro=
te:

> > I think the check for duplicate-numbers is the only one that does n=
ot
> > make sense.=20
> []
> Not sure about that, I send a suggestion of a patch in a minute.
> Highlights:
> 1) - rename the contrib test cases and assigns real TC numbers
> 2) - Forward the numbers into the main "test Makefile"

I'm not sure if this is a good idea or not. It puts the
contrib/remote-helpers into the same "number namespace" as the rest of
the test scripts, and enforces uniqueness with test-lint-duplicates,
when "make test" is run from contrib/remote-helpers. But people working
on the main test scripts would not get any such check, and would happil=
y
break contrib/remote-helpers by adding duplicate test numbers.

It makes sense to me to either:

  1. Have the contrib/remote-helpers test live in their own test
     namespace completely, with their own numbers and test-results, and
     pull in relevant bits from the main test harness. We do this
     already with contrib/subtree.  I suggested this when the tests
     first appeared, but there was some argument, and I don't remember
     the details.

  2. Just integrate contrib test scripts into the main repository, but
     leave them off by default. For example, add:

       if test -z "$GIT_TEST_REMOTE_HELPERS"; then
              skip_all=3D"Remote helper tests disabled (define GIT_TEST=
_REMOTE_HELPERS)"
              test_done
       fi

     to the top of the scripts, and then set GIT_TEST_REMOTE_HELPERS
     in contrib/remote-helpers/Makefile before chaining to the test
     Makefile.

-Peff
