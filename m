From: Jeff King <peff@peff.net>
Subject: Re: log: option "--follow" not the default for a single file?
Date: Thu, 1 Dec 2011 15:36:27 -0500
Message-ID: <20111201203626.GA3659@sigill.intra.peff.net>
References: <CAN0XMOJsiw0c4j_LooRrj80CVVy0omGLUcjDg4QoD4mNS3y1GA@mail.gmail.com>
 <20111130063743.GB5317@sigill.intra.peff.net>
 <CAN0XMOJGm1frOi7FEke7LfHCSBt2DRn_npkdKe0m3qZ=hQPNHw@mail.gmail.com>
 <20111201185230.GB2873@sigill.intra.peff.net>
 <CAN0XMOKrCovkmmdqu2GjsDof0wehfbf5a0EQuPo0q7GQaJ=GRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 21:36:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWDMw-0007Ua-28
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 21:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232Ab1LAUg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 15:36:29 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59302
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153Ab1LAUg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2011 15:36:29 -0500
Received: (qmail 19637 invoked by uid 107); 1 Dec 2011 20:43:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Dec 2011 15:43:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2011 15:36:27 -0500
Content-Disposition: inline
In-Reply-To: <CAN0XMOKrCovkmmdqu2GjsDof0wehfbf5a0EQuPo0q7GQaJ=GRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186190>

On Thu, Dec 01, 2011 at 09:28:31PM +0100, Ralf Thielow wrote:

> > It's possible, but it is changing the meaning of "git log foo". With
> > the current code, even if "foo" is currently a file, it will match
> > "foo/bar" in a prior revision. Switching this to "--follow" will not.
> 
> Why does it actually match both things? I think that's
> maybe wrong.

Because that's what the path argument to "git log" is designed to do --
limit revision traversal based on pathspecs.

You can argue that the "--follow" semantics are more meaningful, but it
doesn't change the fact that it is a behavior change. We have to
consider not only backwards compatibility, but also the confusing-ness
of an inconsistent interface where:

  git log foo bar

will treat "foo" as a pathspec, but:

  git log foo

will treat it as a file.

> Also I can't use "git log" with another
> file/folder doesn't exists but in another revision. What actually
> exists is the file and that's imho the only thing that should match.

You can:

  git log -- existed-long-ago

As a syntax shortcut, you can drop the "--". However, there is some
ambiguity with revision arguments, so git allows path arguments without
a "--" only when they exist in the filesystem (_not_ in a particular
revision).

-Peff
