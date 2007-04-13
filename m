From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Teach "git-read-tree -u" to check out submodules as
 a directory
Date: Thu, 12 Apr 2007 21:15:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704122109070.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704122102320.4061@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704122104030.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 13 06:15:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcDCI-00014g-MH
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 06:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbXDMEPY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 00:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbXDMEPY
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 00:15:24 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46360 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbXDMEPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 00:15:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3D4FIIs003492
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 12 Apr 2007 21:15:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3D4FGbK024328;
	Thu, 12 Apr 2007 21:15:17 -0700
In-Reply-To: <Pine.LNX.4.64.0704122104030.4061@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44382>



On Thu, 12 Apr 2007, Linus Torvalds wrote:
> 
> [ Side note: this also shows that we currently don't correctly handle
>   such subprojects that aren't checked out correctly yet.  They should
>   always show up as not being modified, but failing to resolve the
>   gitlink HEAD does not properly trigger the "not modified" logic in all 
>   places it needs to..
> 
>   So more work to be done, but that's a separate issue, unrelated to
>   the action of checking out the superproject. ]

Apart from this issue, and the fact that we don't actually diff 
subprojects at all right now (even to the point of saying "subproject XyZ 
has changed from commit X to commit Y" - the raw format knows to say that, 
but the patch format does not), I think the "really core plumbing" is 
actually mostly done with this series.

So there's certainly some loose ends to tie up and some missing 
functionality even at the core level, but I suspect this is getting to the 
point where a big chunk of the remaining part is actually to teach the 
upper layers (like "fetch", "checkout", "merge" etc) to actually iterate 
over subprojects using the theoretical higher-level ".subprojects" file, 
and do the plumbing-level operations on those.

Of course, actually trying to start to *use* these things is bound to find 
tons and tons of issues, but I still feel like a lot of the core is at 
least "fleshed out", if not necessarily actually usable yet.

I may take a few days off on this, and hope others will step in and fix up 
some of the remaining problems ..

			Linus
