From: "Matthew M. Ogilvie" <mmogilvi_git@miniinfo.net>
Subject: Re: Still have problem with index file.
Date: Fri, 20 Jun 2008 22:49:49 -0600
Message-ID: <20080621044949.GA1320@comcast.net>
References: <485BD988.8040201@distributel.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Le <le_wen@distributel.ca>
X-From: git-owner@vger.kernel.org Sat Jun 21 06:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9v4R-0007qL-Ve
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 06:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbYFUEtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 00:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbYFUEtx
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 00:49:53 -0400
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:43047 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750791AbYFUEtw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jun 2008 00:49:52 -0400
Received: from OMTA02.emeryville.ca.mail.comcast.net ([76.96.30.19])
	by QMTA07.emeryville.ca.mail.comcast.net with comcast
	id gEiH1Z0240QkzPwA70hz00; Sat, 21 Jun 2008 04:49:51 +0000
Received: from mmogilvi.homeip.net ([75.70.160.185])
	by OMTA02.emeryville.ca.mail.comcast.net with comcast
	id gUpq1Z00440J0Bv8NUpqcX; Sat, 21 Jun 2008 04:49:51 +0000
X-Authority-Analysis: v=1.0 c=1 a=bz1SjR-HFywA:10 a=d1DQA4ROvI8A:10
 a=C3BED4DsAAAA:8 a=VwQbUJbxAAAA:8 a=puf5bs5Yi21Y69cjSN0A:9
 a=MN_NiswIQl5taQGu8_EA:7 a=CqGmtHEelPyU8biZo9WfoiOR-o8A:4 a=LY0hPdMaydYA:10
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 32C0589115; Fri, 20 Jun 2008 22:49:50 -0600 (MDT)
Content-Disposition: inline
In-Reply-To: <485BD988.8040201@distributel.ca>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85691>

On Fri, Jun 20, 2008 at 12:23:36PM -0400, Le wrote:
> Hi, Matthew,
> 
> I am using the latest version of git cvsserver:
> md5sum /usr/bin/git-cvsserver
> fdb0396298d51b37791161f4e62536ce  /usr/bin/git-cvsserver
> 
> which has your patch. But I still have the problem of index file by 
> commit new change:
> cvs commit: Examining .
> Index already exists in git repo
> 
> I have heard that one can delete the index file in .git.
> Is it the right solution for this problem?
> After deleted this file the git repository is still working as before?
> I mean it is available for cvs client sand git clients
> at the same time?
> 
> 
> Thank you!
> 
> Le

I hadn't seen this message before, and it is not really related to my
crlf patch, but I did find some limited information via google:
http://www.gelato.unsw.edu.au/archives/git/0605/21177.html

My own take on it:

git-cvsserver has always expected to serve up a "bare"
repository (without an index file or checked out
files, using the plain git [no CVS] notion of "checked out").
git-cvsserver uses a simple hueristic of checking for a ".git/index"
file to check for a bare repository before allowing commits,
otherwise it could mess up the HEAD for the checkout.

In answer to your question, if you haven't made any uncommitted
changes to the working files in your git repository, then it should
be safe to delete those working files and the .git/index file that
goes with them.  Just make sure you have backups, and be careful
not to delete anything else under .git.  If you do have
uncommitted changes, you may want to "git commit" them first.

You may also want to look up "gitcvs-migration",
especially the part about "Setting Up a Shared Repository".
http://www.kernel.org/pub/software/scm/git/docs/gitcvs-migration.html

I noticed that neither the man page for git-cvsimport nor for
git-cvsserver mention anything about bare repositories.  I'll look
into improving the documentation.

             - Matthew Ogilvie

PS: Also, in the future it might be better to at least CC the git
mailing list, as I've just done: git@vger.kernel.org.  I've read some
of the git documentation and source code, and even submitted
a few patches, but haven't really used it much.
