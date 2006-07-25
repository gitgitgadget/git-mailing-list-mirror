From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsserver: avoid warning about active db handles
Date: Tue, 25 Jul 2006 16:53:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607251649190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607251356430.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <44C6099A.5010205@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jul 25 16:54:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5OHj-0007Kd-JO
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 16:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbWGYOxU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 10:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGYOxU
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 10:53:20 -0400
Received: from mail.gmx.de ([213.165.64.21]:13217 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932387AbWGYOxT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jul 2006 10:53:19 -0400
Received: (qmail invoked by alias); 25 Jul 2006 14:53:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 25 Jul 2006 16:53:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
In-Reply-To: <44C6099A.5010205@catalyst.net.nz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24174>

Hi,

[sorry for the delay... darn meetings]

On Wed, 26 Jul 2006, Martin Langhoff (CatalystIT) wrote:

> Johannes Schindelin wrote:
> 
> > Turns out that DBD::SQLite does not favour preparing statements which 
> > are never executed. So, turn all 4 statements, which were prepared 
> > _always_, into methods, like the other 12 prepared statements.
> 
> Can you give me a reference for that "does not favour preparing 
> statements"?

The relevant bug entry is

	http://rt.cpan.org/Public/Bug/Display.html?id=17603

> I have some vague recollection of timing prepared/unprepared inserts and 
> getting a huge difference in performance.

Yes, preparing before executing is a wonderful thing. But you need to 
execute the prepared statements; otherwise it is a waste of resources 
(plus, it does not finalize with DBD::SQLite).

> Looking at the source of SQLite.pm doesn't clarify much -- 
> prepare_cached is actually implemented by DBI, the driver doesn't need 
> to implement it.

Yes. The culprit is in prepare().

> > 	Now, the only warning left is the gzip one...
> 
> That's harder. I wonder whether using libgit's XS module we can now get 
> libgit to give us a gzipped file directly. I guess it only has 
> performance savings for unpacked repos.

I still have the problem on at least two of my boxes that Git.xs does not 
load. The next thing after looking into the gzip thing is to rewrite 
git-mv in C.

Ciao,
Dscho
