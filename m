From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments in read-tree about #nALT
Date: Mon, 29 Aug 2005 17:58:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508291751200.3243@g5.osdl.org>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
 <7vwtm726xq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508271709530.23242@iabervon.org>
 <Pine.LNX.4.63.0508271855100.23242@iabervon.org> <Pine.LNX.4.58.0508271621210.3317@g5.osdl.org>
 <7vr7cc6yrg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 02:59:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9uSC-0000s0-HS
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 02:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbVH3A6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 20:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVH3A6S
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 20:58:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751431AbVH3A6R (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 20:58:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7U0wBjA010665
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 17:58:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7U0wAYG002359;
	Mon, 29 Aug 2005 17:58:10 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7cc6yrg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7934>



On Mon, 29 Aug 2005, Junio C Hamano wrote:
> 
> > But if we allowed duplicate entries per stage, I think we could easily 
> > just fold stage 2/3 into one stage, and just have <n> entries in stage 2. 
> > That would immediately mean that a three-way merge could be <n> way.
> 
> I suspect you are solving a different problem here --- an
> Octopus.

Well, that too, but I did mention doing the same thing for stage 1, which 
is the "multiple merge bases" case. 

It all boils down to the same thing: we want to read in multiple trees, 
and then do merges one file at a time based on the result (and the fact 
that we can have multiple entries for files in the different stages 
essentially just complicates "git-merge-one-file").

> But I agree that the current way of doing things in stage 2 and
> stage 3 is special casing two head merges from an Octopus, and
> there might not be a fundamental reason for doing so.  Folding
> the current stage 2 and 3 into a single "merge target stage",

Daniel pointed out that there is a real reason for stage 2 - it's used as 
a special case for "matches current index". Apart from that, it's the same 
as stage 3.

Stage 3 is the one we can duplicate freely. There's can be only one branch
that is special in that it matches the current index, so expanding stage 3 
from one to many is clearly something where all the different trees are on 
equal footing.

Same goes for stage 1 - all merge bases are conceptually equally valid, 
and thus there is no reason to consider any "ordering" between them, and 
you can merge any number of trees into stage 1.

So stage 0 and stage 2 are special in that they inherently have "one
special tree" that they correspond to.

		Linus
