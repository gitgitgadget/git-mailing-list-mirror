From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tag -d: print sha1 of deleted tag
Date: Thu, 10 Dec 2009 07:49:29 -0500
Message-ID: <20091210124929.GA444@coredump.intra.peff.net>
References: <87ljhb87nj.fsf@jondo.cante.net>
 <3b0a7bfa75126e4c13ec15a4357645b2bfd14b5b.1260447713.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jari Aalto <jari.aalto@cante.net>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 10 13:49:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIiSj-0002O9-2a
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 13:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758705AbZLJMt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 07:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758561AbZLJMt3
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 07:49:29 -0500
Received: from peff.net ([208.65.91.99]:56875 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753571AbZLJMt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 07:49:29 -0500
Received: (qmail 23025 invoked by uid 107); 10 Dec 2009 12:54:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Dec 2009 07:54:06 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2009 07:49:29 -0500
Content-Disposition: inline
In-Reply-To: <3b0a7bfa75126e4c13ec15a4357645b2bfd14b5b.1260447713.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135022>

On Thu, Dec 10, 2009 at 01:23:43PM +0100, Michael J Gruber wrote:

> Print the sha1 of the deleted tag (in addition to the tag name) so that
> one can easily recreate a mistakenly deleted tag:
> 
> git tag -d tagname
> Deleted tag 'tagname' DEADBEEF
> git tag 'tagname' DEADBEEF # for lightweight tags
> git update-ref refs/tags/'tagname' DEADBEEF # for annotated tags

I think this is a good idea, and we already do the same for branch
deletion.

I'm not sure your example is right. If "tag -d" always prints out the
sha1 in the tag ref, can't you just use "git tag 'tagname' DEADBEEF" to
recreate both lightweight and annotated tags? That is, making a
lightweight tag of an annotated tag's sha1 should just recreate the
original annotated tag.

That being said, I am not a fan of the cut-and-paste format. This is not
something that happens so frequently that I think we need to go out of
our way to save some typing. And for a user seeing this message for the
first time:

  1. It is not immediately obvious to a user seeing this message
     for this first time exactly what the trailing sha1 means. We
     already had this discussion with "git branch -d" and decided
     that "(was DEADBEEF)" was more readable.

  2. Even if they know what it means, it is not immediately obvious that
     the error line is meant to be cut-and-pasted. If you are going to
     give something to cut-and-paste, I think you are better off making
     it obvious, like:

        Deleted tag 'foo'; you can recreate it with

           git tag 'foo' DEADBEEF

     Of course that is painfully long for a message that is meant to be
     a "just in case" notification of a successful command (I can see it
     more for an actual error, where git is telling you "I couldn't do
     what you wanted, but you might try running this command first").

-Peff
