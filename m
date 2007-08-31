From: David Watson <dwatson@mimvista.com>
Subject: Re: git svn dcommit not checking if up-to-date?
Date: Fri, 31 Aug 2007 19:48:55 -0400
Message-ID: <20070831234854.GA6451@mimvista.com>
References: <Pine.LNX.4.64.0708312200480.28586@racer.site> <20070831221814.GB31033@untitled> <Pine.LNX.4.64.0709010017250.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 01 01:47:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRGDQ-0005iF-3w
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 01:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbXHaXrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 19:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbXHaXrt
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 19:47:49 -0400
Received: from net-207-58-228-27.arpa.fidelityaccess.net ([207.58.228.27]:54821
	"EHLO zimbra.mimvista.com" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750807AbXHaXrs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 19:47:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.mimvista.com (Postfix) with ESMTP id 7525E355E5B;
	Fri, 31 Aug 2007 19:45:58 -0400 (EDT)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: 1.193
X-Spam-Level: *
X-Spam-Status: No, score=1.193 tagged_above=-10 required=6.6
	tests=[AWL=-0.200, BAYES_00=-2.599, RCVD_IN_NJABL_DUL=1.946,
	RCVD_IN_SORBS_DUL=2.046]
Received: from zimbra.mimvista.com ([127.0.0.1])
	by localhost (zimbra.mimvista.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NzuGWBT9qBtR; Fri, 31 Aug 2007 19:45:56 -0400 (EDT)
Received: from localhost (cpe-66-61-71-72.neo.res.rr.com [66.61.71.72])
	by zimbra.mimvista.com (Postfix) with ESMTP id 5FD3F355E55;
	Fri, 31 Aug 2007 19:45:56 -0400 (EDT)
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709010017250.28586@racer.site>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57232>

I just reproduced this one in a live repository. Here's what you do:

$ git checkout -b breakme trunk
$ vi file1.txt
$ git-commit -a -m 'first change'
$ vi file2.txt
$ git-commit -a -m 'second change'
..... Full moon, become a werewolf ......
C:\svnrepo> edit file2.txt
C:\svnrepo> svn commit -m 'this will be gone'
..... Become yourself again ....
$ git svn fetch --all # (not sure if this is necessary)
$ git svn dcommit
$ git log -p

The change to file2 by your hairier, fanged self will be gone.
The critical thing is that you must dcommit *multiple* commits, and the
first one can't be the conflicting file, otherwise it will stop. At the
time the first commit of the dcommit has gone through, git-svn now thinks
it's all up-to-date.

On Sat, Sep 01, 2007 at 12:17:33AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 31 Aug 2007, Eric Wong wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > 
> > > harningt just asked about known issues of git-svn on IRC, and I 
> > > remembered that I had an issue: Accidentally, I forgot to "git svn 
> > > fetch" before "git svn dcommit"ing, and unfortunately, a colleague had 
> > > just checked in a change, which got undone by my dcommit.
> > 
> > I believe this was fixed a while back in commit
> > 45bf473a7bc2c40c8aea3d34a0eab7a41e77a8ff
> > (Thu Nov 9 01:19:37 2006 -0800).
> 
> That is strange, since I had this issue in July or August (this year).  
> And I am quite certain that I ran with pretty up-to-date git (I usually 
> track "next" quite closely).
> 
> Ciao,
> Dscho
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dave Watson
Software Engineer
MIMvista Corp
