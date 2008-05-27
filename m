From: Eric Blake <ebb9@byu.net>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Tue, 27 May 2008 13:26:10 +0000 (UTC)
Message-ID: <loom.20080527T131535-95@post.gmane.org>
References: <483AC2CE.7090801@gmail.com> <alpine.DEB.1.00.0805261521130.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 15:28:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0zCy-0006GM-E7
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 15:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467AbYE0N01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 09:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757436AbYE0N00
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 09:26:26 -0400
Received: from main.gmane.org ([80.91.229.2]:58140 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757420AbYE0N00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 09:26:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K0zBz-0003u2-Sw
	for git@vger.kernel.org; Tue, 27 May 2008 13:26:20 +0000
Received: from c-67-166-125-73.hsd1.ut.comcast.net ([67.166.125.73])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 May 2008 13:26:19 +0000
Received: from ebb9 by c-67-166-125-73.hsd1.ut.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 May 2008 13:26:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.166.125.73 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14 Mnenhy/0.7.5.666)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83012>

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> On Mon, 26 May 2008, Mark Levedahl wrote:
> 
> > Beginning with the referenced commit, the git project cannot be checked 
> > out on Cygwin (and I assume cannot be checked out on Windows using 
> > msysgit, though I have not verified this) as this commit introduces the 
> > file "t/5100/nul." On Windows, the file name "nul" is reserved, 
> > regardless of path, and cannot be created or deleted. It serves 
> > essentially the same function as /dev/null.
> 
> Even when referencing the full (or a relative) path?  That's bad!

Yes.  And it is not limited to the case-insensitive name NUL; it also covers
names like "aux".  See the very last paragraph in this section:
http://www.gnu.org/software/autoconf/manual/html_node/File-System-Conventions.html#File-System-Conventions

This will affect all versions of MSYS.  However, with cygwin 1.5.x, you can use
the workaround of a managed mount which intentionally (and transparently) munges
such invalid file names so that you can appear to name a file "nul" in spite of
Windows (at the expense of making an already short PATH_MAX of 256 even
shorter).  And if you are willing to experiment with the (still-in-development)
cygwin 1.7.0, this munging is done without even needing a managed mount and
without any penalty to the larger PATH_MAX of 4k.

At any rate, I agree with your patch to rename the file, as well as with your
aversion to rewriting history just so that a checkout on MSYS or a non-managed
mount on older cygwin can do a 'git bisect' that hits the small window of
commits with an invalid tree.

-- 
Eric Blake
