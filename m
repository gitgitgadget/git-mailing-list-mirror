From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: adding xdelta compression to git
Date: Tue, 3 May 2005 10:35:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031031240.3594@ppc970.osdl.org>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
 <Pine.LNX.4.58.0505022215110.21733@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.61.0505031151380.32767@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 19:27:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT1Ax-0003Uq-13
	for gcvg-git@gmane.org; Tue, 03 May 2005 19:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVECRdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 13:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVECRdd
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 13:33:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:48073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261482AbVECRda (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 13:33:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43HXCs4002125
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 10:33:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43HXB1K005499;
	Tue, 3 May 2005 10:33:12 -0700
To: "C. Scott Ananian" <cscott@cscott.net>
In-Reply-To: <Pine.LNX.4.61.0505031151380.32767@cag.csail.mit.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, C. Scott Ananian wrote:
> 
> Linus knows this.  His point is just to be sure you actually *code* that 
> walk in fsck, and (hopefully) do so w/o complicating the fsck too much.

Indeed. It's also a performance issue.

If you do xdelta objects, and don't tell fsck about it, then fsck will 
just check every object as a blob. Why is that bad?

Think about it: let's say that you have a series of xdelta objects, and a 
fsck that is xdelta-unaware. It will unpack each object independently, 
which means that it will keep on doing the same early xdelta work over and 
over and over again. Instead of just applying them in order, and checking 
the sha1 of the result at each point.

Now, You probably want to limit the length of the chains to some firly 
small number anyway, so maybe that's not a big deal. Who knows. And I'm 
actually still so anal that I don't think I'd use this for _my_ tree, just 
because I'm a worry-wart (and I still think disk is incredibly cheap ;)

		Linus
