From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/5] Add is_absolute_path(), make_absolute_path() and
 normalize_path()
Date: Thu, 26 Jul 2007 20:02:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707261955540.14781@racer.site>
References: <Pine.LNX.4.64.0707260724010.14781@racer.site>
 <7v1wevac63.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707261456040.14781@racer.site>
 <7v4pjr80lr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 21:02:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE8bo-0005x4-1V
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 21:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761481AbXGZTCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 15:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761056AbXGZTCo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 15:02:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:55231 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761271AbXGZTCn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 15:02:43 -0400
Received: (qmail invoked by alias); 26 Jul 2007 19:02:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp050) with SMTP; 26 Jul 2007 21:02:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dOslWWe8dxrFAHZPZNQLZnH3lUkEAphSvBYarrQ
	BIoUeO5kN16JoS
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pjr80lr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53859>

Hi,

On Thu, 26 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Agree.  Maybe a comment above the function, like
> >
> > 	/*
> > 	 * The function normalize_path() converts ".." and "." names in 
> > 	 * the given path so that "foo/../bar/./" will come out as "bar".
> > 	 *
> > 	 * Note: normalize_path() does not follow symlinks, so if "foo" is
> > 	 * a symlink in the example above, the result will not work as 
> > 	 * expected.
> > 	 */
> >
> > Hmm?
> 
> That comment only states the obvious and does not give a clue to
> the callers when it should not be used, I am afraid.

I am afraid, that it was unobvious enough to yours truly to forget about 
that when writing the patch.

> For example, paths taken out of index or recursively reading trees are 
> Ok because there will not be ".." and "." in them.  Making a path given 
> by the user relative to the cwd by prepending what is returned by 
> setup_git_directory() may or may not be safe, depending on how 
> setup_git_directory() does things (I think the original one is safe; I 
> am reasonably sure with the current one when GIT_WORK_TREE is not in 
> use; I do not know when that environment variable is there with the 
> current code with or without your patch series).

I am afraid that already GIT_DIR can contain symlinks, and is not checked 
by setup_git_env().

So I think some concrete comment is needed in _addition_:

	get_git_dir() is not safe, and therefore git_path(), too.

Hmm.

Maybe the easiest way _is_ to getcwd(); chdir() getcwd(); chdir(back); 
Ugly.

Ciao,
Dscho
