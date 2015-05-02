From: Jeff King <peff@peff.net>
Subject: Re: multiple source file extensions
Date: Fri, 1 May 2015 21:11:01 -0400
Message-ID: <20150502011100.GB5634@peff.net>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
 <CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Josh Hagins <hagins.josh@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 03:11:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoLxX-0002r8-1R
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 03:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbbEBBLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 21:11:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:53169 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750970AbbEBBLE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 21:11:04 -0400
Received: (qmail 2721 invoked by uid 102); 2 May 2015 01:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 20:11:03 -0500
Received: (qmail 2842 invoked by uid 107); 2 May 2015 01:11:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 21:11:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 21:11:01 -0400
Content-Disposition: inline
In-Reply-To: <CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268206>

On Fri, May 01, 2015 at 08:49:14PM -0400, Josh Hagins wrote:

> If you're using a recent version of bash, you could enable the
> 'globstar' option:
> 
>     $ shopt -s globstar
>     $ git grep 'pattern' **/*.{cc,cpp,h}
> 
> Does that work?

That will only pick up files that are in the working tree. Which is fine
for a stock "git grep" with no options, but would not be right for
grepping in the index or an older tree. For that, you can ask git to
glob for you:

  git grep pattern -- '*.cc' '*.cpp' '*.h'

Note that the "--" is important (it's what tells git "these are
pathspecs and not revision names"; normally git will guess if you are
passing literal pathnames, but the glob patterns fool the guessing
machinery).

Unfortunately there is no way to use curly braces with git's pathspec,
so you have to write out three separate `*` arguments rather than using
the shell-style {cc,cpp,h}.

-Peff
