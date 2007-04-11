From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 15:36:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111532540.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
 <20070411080641.GF21701@admingilde.org> <81b0412b0704110129q56ee0628jafe8fca808ef9ef8@mail.gmail.com>
 <20070411083642.GH21701@admingilde.org> <7virc3p8zr.fsf@assigned-by-dhcp.cox.net>
 <20070411100328.GK21701@admingilde.org> <7vmz1eof3m.fsf@assigned-by-dhcp.cox.net>
 <20070411221930.GN21701@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:36:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HblQv-0008Rh-Cc
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 00:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161306AbXDKWgp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 18:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbXDKWgp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 18:36:45 -0400
Received: from smtp.osdl.org ([65.172.181.24]:34966 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161310AbXDKWgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 18:36:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3BMaWVZ025075
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 15:36:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3BMaVLu016373;
	Wed, 11 Apr 2007 15:36:31 -0700
In-Reply-To: <20070411221930.GN21701@admingilde.org>
X-Spam-Status: No, hits=-0.505 required=5 tests=AWL,OFFERS_ETC,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44268>



On Thu, 12 Apr 2007, Martin Waitz wrote:
> 
> But why does everybody want to detach the submodule HEAD, instead
> of creating one 'special' branch which holds the commit which is
> used by the supermodule?

I don't think "everybody" wants it.

But the point is, *regardless* of whether you want a "detached HEAD" or 
you want a "'special' branch", you should always use HEAD to look up the 
commit, and using HEAD *allows* both (ie just make HEAD a symref to the 
'special' branch if you want that behaviour).

And if you *do* use a special branch, HEAD *must* match that special 
branch anyway, since when you commit in the supermodule, the only 
behaviour that makes sense is to commit the currently checked out state!

> I want to create the extra branch exactly _because_ there is
> independent work going on in the submodule (or the project it is
> based on).

And that is entirely appropriate.

But that still means that HEAD must point to that branch (when in the 
submodule), since that branch must be the one that is checked out. If it 
isn't the branch that is checked out, normal operations like "git diff" 
etc wouldn't make sense from the supermodule.

And that is why *regardless* of whether you use a special branch or not, 
HEAD is the right thing to look up.

		Linus
