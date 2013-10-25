From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add password parameter to git svn commands and use
 it when provided instead of defaulting to end-user prompt
Date: Fri, 25 Oct 2013 03:24:29 -0400
Message-ID: <20131025072429.GB17029@sigill.intra.peff.net>
References: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com>
 <20131014141127.GA21200@google.com>
 <20131014184005.GA3352@dcvr.yhbt.net>
 <20131014223602.GB12116@sigill.intra.peff.net>
 <20131014233556.GA31230@dcvr.yhbt.net>
 <005DF7EA-CF5A-408F-A145-07F53D836974@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, matthijs@stdin.nl,
	Eric Wong <normalperson@yhbt.net>
To: arnaud brejeon <arnaud.brejeon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 09:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbl7-0004Vi-MJ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 09:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab3JYHYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 03:24:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:55396 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182Ab3JYHYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 03:24:32 -0400
Received: (qmail 7456 invoked by uid 102); 25 Oct 2013 07:24:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 02:24:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 03:24:29 -0400
Content-Disposition: inline
In-Reply-To: <005DF7EA-CF5A-408F-A145-07F53D836974@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236692>

On Mon, Oct 21, 2013 at 07:06:29PM +0200, arnaud brejeon wrote:

> I dont know if you plan to keep GIT_ASKPASS as is, but this
> environment variable is not mentioned on git svn documentation and I
> guess just a few people know about it. Moreover, the name is
> misleading as it handles all the prompts, not only the password one.

Yes, the "askpass" name is a little odd, but it is historical. The
calling convention was invented for ssh, who used that name (and we do
respect SSH_ASKPASS if it is set). Besides being a lousy name for
requesting non-password data, it's also a lousy program for doing it.
There's no way for the caller to specify "this is not a password", so
the program always hides the characters as they are typed. It's one of
the reasons the "git credential" subsystem was invented, which has a
more flexible interface.

The askpass variables are documented in "git help credentials". However,
the rest of that document does not apply to git-svn, which is unlike the
rest of git in the way it handles authentication. So it might or might
not make sense to point to it from the git-svn docs. Patches welcome if
you want to look into it.

-Peff
