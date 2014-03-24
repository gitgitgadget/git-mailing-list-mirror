From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/12] t: drop useless sane_unset GIT_* calls
Date: Mon, 24 Mar 2014 17:56:38 -0400
Message-ID: <20140324215638.GH13728@sigill.intra.peff.net>
References: <20140320231159.GA7774@sigill.intra.peff.net>
 <20140320231433.GC8479@sigill.intra.peff.net>
 <xmqqy503s0s0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Tran <unsignedzero@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:56:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSCrM-0006y9-Sk
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 22:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbaCXV4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 17:56:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:46139 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbaCXV4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 17:56:40 -0400
Received: (qmail 10215 invoked by uid 102); 24 Mar 2014 21:56:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 16:56:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 17:56:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy503s0s0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244885>

On Fri, Mar 21, 2014 at 02:24:31PM -0700, Junio C Hamano wrote:

> > Unsetting these is not only useless, but can be confusing to
> > a reader, who may wonder why some tests in a script unset
> > them and others do not (t0001 is particularly guilty of this
> > inconsistency, probably because many of its tests predate
> > the test-lib.sh environment-cleansing).
> [...]
> > I suppose one could make an argument that test-lib.sh may later change
> > the set of variables it clears, and these unsets are documenting an
> > explicit need of each test. I'd find that more compelling if it were
> > actually applied consistently.
> 
> Hmph.  I am looking at "git show HEAD^:t/t0001-init.sh" after
> applying this patch, and it does look consistently done with
> GIT_CONFIG and GIT_DIR (I am not sure about GIT_WORK_TREE but from a
> cursory read it is done consistently for tests on non-bare
> repositories).

I don't understand why we stop bothering with the unsets starting with
"init with --template". Are those variables not important to the outcome
of that and later tests, or did the author simply not bother because
they are noops?

> So I would actually agree with your alternative interpretation
> "Unsetting these is useless, but it does serve documentation
> purpose---without having to see what the state of the environment
> when the subprocess is started, the reader can understand what is
> being tested", rather than the one in the log message.

I'd agree with that if I were convinced that the presence of them there
versus the absence of them later was meaningful.

> Having said that, I am perfectly OK with the change to t0001 in this
> patch, if we added at the very beginning of the test sequence a
> comment that says:
> 
>     Below, creation and use of repositories are tested with various
>     combinations of environment settings and command line flags.
>     They are done inside subshells to avoid leaking temporary
>     environment settings to later tests *and* assumes that the
>     initial environment does not have have GIT_DIR, GIT_CONFIG, and
>     GIT_WORK_TREE defined.
> 
> or something.

I do not have a problem with that, as it implicitly covers all of the
tests following it. I do not think it is particularly necessary, though.
Assuming we start with a known test environment and avoiding polluting
it for further tests are basic principles of _all_ test scripts.

-Peff
