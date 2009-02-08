From: Jeff King <peff@peff.net>
Subject: Re: checking sha1's of files
Date: Sun, 8 Feb 2009 06:13:43 -0500
Message-ID: <20090208111343.GC14359@coredump.intra.peff.net>
References: <81bfc67a0902080139j1331d967g34bfc18f4068e443@mail.gmail.com> <7veiy9z1v8.fsf@gitster.siamese.dyndns.org> <81bfc67a0902080253x5082201co7da3319b8237f5a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 12:15:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW7d2-0001uA-2e
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 12:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbZBHLNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 06:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbZBHLNq
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 06:13:46 -0500
Received: from peff.net ([208.65.91.99]:50495 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbZBHLNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 06:13:45 -0500
Received: (qmail 26970 invoked by uid 107); 8 Feb 2009 11:14:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Feb 2009 06:14:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2009 06:13:43 -0500
Content-Disposition: inline
In-Reply-To: <81bfc67a0902080253x5082201co7da3319b8237f5a0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108961>

On Sun, Feb 08, 2009 at 05:53:31AM -0500, Caleb Cushing wrote:

> > but without knowing what kind of hash they use, I cannot tell you if you
> > can reuse some part of git to compute their hash without using their tools
> > (it also is unclear why you are not using their tool to compute their hash
> > and instead are expecting git to know about the specific hash function
> > used by them).
> 
> I think you misunderstand. I'm not trying to use git to compute their
> hash, I'm trying to replace their hash with git. Once I've figured out
> how to validate the git hash with 'emerge' (said tool) I will be
> removing their hash's.

I'm still not sure I entirely understand what you are trying to do, but
these building blocks may help.

You can see git's idea of the hash of a file in history (or in the
index) by asking rev-parse:

  # hash of 'Makefile' in the most recent commit on the current branch
  $ git rev-parse HEAD:Makefile
  27b9569746179e68c635bdaab8e57395f63faf01

  # hash of 'Makefile' in the index
  $ git rev-parse :Makefile
  27b9569746179e68c635bdaab8e57395f63faf01

  # hash of 'Makefile' in some arbitrary revision
  $ git rev-parse v1.5.1:Makefile
  b159ffd0ae49c28725de6549132e0ad3a3b69d20

And you can compute the git blob hash of any file use git hash-object:

  $ git hash-object --stdin < Makefile
  27b9569746179e68c635bdaab8e57395f63faf01

So if I understand you correctly, you would use the former when
generating your manifests from a revision, and the latter when verifying
the contents of the filesystem against those manifests.

-Peff
