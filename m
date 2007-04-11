From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 16:53:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org><Pi
 ne.LNX.4.64.0704092115020.6730@woody.linux-foundation.org><461D6432.90205@v
 ilain.net>  <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org><461D6858.4090
 007@vilain.net> <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0704111600390.28394@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: David Lang <david.lang@digitalinsight.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 01:53:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbmcw-0005Rx-Gm
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbXDKXxX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbXDKXxX
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:53:23 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37050 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932195AbXDKXxX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:53:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3BNrGVZ027188
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 16:53:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3BNrFwF018375;
	Wed, 11 Apr 2007 16:53:16 -0700
In-Reply-To: <Pine.LNX.4.63.0704111600390.28394@qynat.qvtvafvgr.pbz>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44279>



On Wed, 11 Apr 2007, David Lang wrote:
> 
> would it make sense to have a --multiple-project option for fsck that would
> let you specify multiple 'projects' that share a object set and have the
> default checking not do the reachability checks that cause problems in this
> case?

Well, the thing is, sharing object directories actually makes things 
*harder* to check, rather than easier.

It can be a nice space optimization, and yes, if there really is a lot of 
shared state, it can make it much cheaper to do some of the checks, but 
right now we have absolutely *no* way for fsck to then do the reachability 
check, because there is no way to tell fsck where all the refs are (since 
now the refs come in from multiple repositories!)

So the individual objects get cheaper to fsck (no need to fsck shared 
objects over and over again), but the reachability gets much harder to 
fsck.

It's not an insurmountable problem, or even necessarily a very large one, 
but it boils down to one very basic issue:

 - nobody seems to actually *use* the shared object directory model!

The thing is, with pack-files and alternates directories, a lot of the 
original reasons for shared object directories simply don't exist..

		Linus
