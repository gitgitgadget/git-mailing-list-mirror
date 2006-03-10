From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list feature request
Date: Thu, 9 Mar 2006 19:56:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603091950360.18022@g5.osdl.org>
References: <17424.53563.622642.738307@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 04:56:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHYk2-0006WO-CQ
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 04:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWCJD4b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 22:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWCJD4b
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 22:56:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750792AbWCJD4b (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 22:56:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2A3uLDZ014817
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Mar 2006 19:56:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2A3uKNJ031202;
	Thu, 9 Mar 2006 19:56:21 -0800
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17424.53563.622642.738307@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17446>



On Fri, 10 Mar 2006, Paul Mackerras wrote:
> 
> It would be nice also to be able to combine that with the existing
> ability to output a dense graph containing the commits that modify a
> specified set of files or directories.
> 
> In other words, I would like to be able to select any combination of
> (a) some explicitly specified commits
> (b) commits that have a reference
> (c) commits that affect specified files or directories
> 
> and have git-rev-list output a graph that shows the relationship of
> those commits.
> 
> Possible?

Yeah. I _think_ what you want is

 - phase 1: generate the current graph that we already do for

	git-rev-list --all ^cmit

 - phase 2: start at "cmit", and mark everything that refers to it as 
   "show me" (including "cmit" itself, which was originally marked 
   uninteresting)

So phase 1 already exists and was the hard part. phase 2 is just walking 
the graph (that is now all in memory) from "cmit" using the "object->refs" 
reverse references that got built up during phase 1.

The only question is how to show the ref-names, or, more properly, what to 
do when we have a ref-name, but the commit it points to wasn't interesting 
because it didn't change the set of files we used to determine interest...

And where to find the sucker^H^H^H^H^H^Hhelpful soul to actually do the 
work.

		Linus
