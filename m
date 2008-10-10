From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GIT-GUI,GITK) 0/8] Encoding support in GUI
Date: Fri, 10 Oct 2008 21:46:09 +1100
Message-ID: <18671.12913.653592.847535@cargo.ozlabs.ibm.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
	<18646.53492.20994.908025@cargo.ozlabs.ibm.com>
	<48E36086.7050504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 10 13:04:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoFmY-0001w0-34
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 13:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758883AbYJJLC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 07:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760245AbYJJLC2
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 07:02:28 -0400
Received: from ozlabs.org ([203.10.76.45]:36790 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760191AbYJJLC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 07:02:27 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 60CEFDDDFF; Fri, 10 Oct 2008 22:02:26 +1100 (EST)
In-Reply-To: <48E36086.7050504@viscovery.net>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97923>

Johannes Sixt writes:

> I'm about to add a .gitattributes file that specifies the encoding for
> some of my files *today* because I was not clever enough to anticipate the
> usefulness of an "encoding" attribute a year ago when those files were
> added to the repository. When I browse history, I *do* want that *today's*
> encoding is picked.

Fair enough.

> > (Also it seems that we won't
> > notice if the user changes .gitattributes after we've looked at it, or
> > if they create one after we've looked for one and not found it.)
> 
> This is not a show stopper, IMHO. The user will notice soon enough, and
> can restart gitk. Nobody sane will change the encoding attributes every hour.

The scenario I'm thinking of is this: a user clicks on a file to
display it, sees that it isn't displayed using the encoding he wants,
says "duh" and creates a .gitattributes file.  User clicks on the file
again, sees that it *still* isn't displayed using the right encoding,
and says something worse than "duh". :)

If it was just one .gitattributes file, then it wouldn't be hard to
stat it each time we go to display some file, and throw away our cache
if it has changed.  But it looks like we would have to do N+1 stats
for a file N levels deep in the tree (since it looks like we also need
to stat $GIT_DIR/info/attributes).  Still, it may be worth it.  At
least on Linux, stat is pretty fast.

Paul.
