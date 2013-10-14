From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add password parameter to git svn commands and use
 it when provided instead of defaulting to end-user prompt
Date: Mon, 14 Oct 2013 18:36:02 -0400
Message-ID: <20131014223602.GB12116@sigill.intra.peff.net>
References: <1381569810-2167-1-git-send-email-arnaud.brejeon@gmail.com>
 <20131014141127.GA21200@google.com>
 <20131014184005.GA3352@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, arnaud.brejeon@gmail.com,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 00:36:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqkJ-0007HQ-9b
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab3JNWgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:36:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:49335 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932172Ab3JNWgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:36:04 -0400
Received: (qmail 20968 invoked by uid 102); 14 Oct 2013 22:36:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Oct 2013 17:36:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Oct 2013 18:36:02 -0400
Content-Disposition: inline
In-Reply-To: <20131014184005.GA3352@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236134>

On Mon, Oct 14, 2013 at 06:40:05PM +0000, Eric Wong wrote:

> > arnaud.brejeon@gmail.com wrote:
> > 
> > > Signed-off-by: Arnaud Brejeon <arnaud.brejeon <at> gmail.com>
> > 
> > Thanks.
> > 
> > Can you say a little more about the context?  Do you run a script that
> > wants to pass a password to 'git svn', do you type it each time on the
> > command line, or something else?  Is it ok that the password would
> > show up in "ps" output?  Would the platform's keyring or netrc be
> > usable here, or is there something in the context that avoids that?
> 
> I think using keyring or netrc is more appropriate.  Having a password
> on the command-line and visible to all via ps doesn't seem like
> something git should support.

Agreed. We have ready-made git-credential helpers to handle this exact
problem. We would need to convert SVN::Prompt to use git-credential
rather than prompting itself, though. One of the things that held me
back from writing such a patch is that I thought libsvn already handled
things like keychain integration, and it was better for git-svn to be
more svn-like than git-like in its access of SVN repos.

Are those already supported out of the box by libsvn? If git's
credential helpers are significantly more featureful, it might be worth
converting, but if not, I think it makes sense to stay with svn's
existing code.

-Peff
