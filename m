From: Jeff King <peff@peff.net>
Subject: Re: git ls-files wildcard behavior considered harmful
Date: Mon, 30 Mar 2015 20:09:24 -0400
Message-ID: <20150331000924.GA27090@peff.net>
References: <20150330230459.GA13927@kitenet.net>
 <CACsJy8BDoXHS6nj7pEe0i8T=bMD8aG5FwuXABKgPOQBeMOr+Vw@mail.gmail.com>
 <20150330233614.GA17089@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Joey Hess <id@joeyh.name>
X-From: git-owner@vger.kernel.org Tue Mar 31 02:09:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcjkK-0004Xk-SR
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 02:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbbCaAJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 20:09:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:40063 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753800AbbCaAJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 20:09:27 -0400
Received: (qmail 24748 invoked by uid 102); 31 Mar 2015 00:09:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 19:09:27 -0500
Received: (qmail 18342 invoked by uid 107); 31 Mar 2015 00:09:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 20:09:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2015 20:09:24 -0400
Content-Disposition: inline
In-Reply-To: <20150330233614.GA17089@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266492>

On Mon, Mar 30, 2015 at 07:36:14PM -0400, Joey Hess wrote:

> Duy Nguyen wrote:
> > You can do "git --literal-pathspecs ls-files ..." or set GIT_LITERAL_PATHSPECS.
> 
> Thanks! --literal-pathspecs does allow getting around this.
> 
> Now I'm wondering what other parts of plumbing might be doing globbing
> that I did not anticipate. Maybe I should set the environment variable
> so I don't need to worry about it..

Pretty much everything takes magic patterns[1]. Pathspecs given to diff,
path limiters for pruning, etc. If you are scripting with raw filenames
(e.g., feeding the filenames out of another tool), I recommend setting
GIT_LITERAL_PATHSPECS everywhere. That's what we do on the server side
at GitHub (and is the reason I implemented --literal-pathspecs in the
first place).

-Peff

[1] Note that globbing is just part of this. Names starting with colon
    are also magical, e.g. ":/foo", or even ":(literal)foo".  These are
    documented in the "pathspec" definition of "git help glossary".
