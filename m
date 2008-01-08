From: Jeff King <peff@peff.net>
Subject: Re: git-diff across branches?
Date: Tue, 8 Jan 2008 03:57:06 -0500
Message-ID: <20080108085705.GA4222@sigill.intra.peff.net>
References: <478337DE.7@advancedsl.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gonzalo =?iso-8859-1?Q?Garramu=F1o?= <ggarra@advancedsl.com.ar>
X-From: git-owner@vger.kernel.org Tue Jan 08 09:57:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCAHF-0004vL-St
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 09:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758520AbYAHI5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2008 03:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758145AbYAHI5K
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 03:57:10 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3547 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757912AbYAHI5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 03:57:09 -0500
Received: (qmail 16043 invoked by uid 111); 8 Jan 2008 08:57:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Jan 2008 03:57:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jan 2008 03:57:06 -0500
Content-Disposition: inline
In-Reply-To: <478337DE.7@advancedsl.com.ar>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69851>

On Tue, Jan 08, 2008 at 05:44:14AM -0300, Gonzalo Garramu=F1o wrote:

> I was wondering if there was a way to make a git-diff across (local) =
=20
> branches.
>
> Something like:
>
> $ git-diff --branch test1 HEAD --branch test2 HEAD  file.cpp
> (would show a diff for file.cpp between test1 HEAD and test2 HEAD)

I think you are mistaken about how HEAD works; it is a pointer to a
particular branch. So there is no "HEAD" for test1; there is simply
test1, and from time to time your repository's HEAD points to test1.

However, that makes things easier. You can simply do this:

  git-diff test1 test2 file.cpp

Unless you mean that you have two separate repositories, test1 and
test2. In which case each _does_ have its own HEAD, and you will have t=
o
fetch from one repo into the other to get your answer:

  # go into one of the repos
  cd test1
  # fetch the 'master' ref from the other repo and store it in this rep=
o
  # using the name 'test2'
  git fetch ../test2 master:test2
  # now we can diff between them
  git diff HEAD test2 file.cpp

-Peff
