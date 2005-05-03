From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 15:13:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031507460.26698@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
 <20050503200034.GA16104@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0505031306310.26698@ppc970.osdl.org>
 <20050503205957.GA25253@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 00:05:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT5Vj-0005Us-Qm
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVECWLU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 18:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVECWLU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 18:11:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:58545 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261849AbVECWLN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 18:11:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43MBAs4024992
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 15:11:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43MB9Zd019741;
	Tue, 3 May 2005 15:11:10 -0700
To: Jan Harkes <jaharkes@cs.cmu.edu>
In-Reply-To: <20050503205957.GA25253@delft.aura.cs.cmu.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Jan Harkes wrote:
> 
> Short summary:
> 
>     rc = link(old, new);
>     if (rc == -1 && errno == EXDEV)
> 	rc = rename(old, new);

Ok, that is safe enough. Will do.

> On Coda, the cross-directory link fails, the following cross-directory
> rename will work fine.  On a normal filesystem, if the link fails with
> EXDEV, the rename will fail with the same.

Yup. I do suspect that since you handle the rename anyway, you probably 
could handle the git link/unlink patterns too, but it's easy enough to 
just do the rename fallback in git itself.

The only reason not to use rename in the first place is literally just to 
be able to check for collisions. Which we don't actually _do_ right now, 
but I like to be able to do so in theory.

		Linus
