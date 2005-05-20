From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-diff-tree -R A B == git-diff-tree B A"?
Date: Fri, 20 May 2005 09:19:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505200913170.2206@ppc970.osdl.org>
References: <7vacmquet3.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505200806150.2206@ppc970.osdl.org> <7vzmupud54.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505200844090.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 18:18:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZAAb-0001DX-Ca
	for gcvg-git@gmane.org; Fri, 20 May 2005 18:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVETQRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 12:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVETQRO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 12:17:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:49355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261484AbVETQRG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 12:17:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4KGH1U3030790
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 09:17:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4KGH0QY019314;
	Fri, 20 May 2005 09:17:00 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0505200844090.2206@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Linus Torvalds wrote:
> 
> The sorting does _not_ just affect files/directories with the same names.  
> It affects files and directories that have the same _beginning_.

Ok, I just pushed out a fix which should get this right (it introduces a 
new "base_name_compare()" function that knows about these subtleties).

I guess we should add a proper ordering test for all these cases. There's:
 - exact same name, directory vs file
 - different length names, but same in the first characters
	- this one has the subcases of the next character sorting with '/' 
	  or '\0' depending on the type of the shorter filename.

Your previous test handled only the simple "exact same name" case.

		Linus
