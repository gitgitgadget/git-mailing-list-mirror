From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Loosening path argument check a little bit in revision.c
Date: Sat, 22 Apr 2006 09:30:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604220921430.3701@g5.osdl.org>
References: <7vzmidkjbq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 22 19:23:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXLpU-0008K5-Hh
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 19:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDVRX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 13:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWDVRX3
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 13:23:29 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:6039 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750756AbWDVRX3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 13:23:29 -0400
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MGXhV3027359
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 16:33:43 GMT
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3MGUUtH018452
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 22 Apr 2006 09:30:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3MGUTAd000855;
	Sat, 22 Apr 2006 09:30:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmidkjbq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
X-Virus-Scanned: ClamAV 0.88/1415/Sat Apr 22 11:34:01 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19038>



On Sat, 22 Apr 2006, Junio C Hamano wrote:
> 
> This patch allows non-existing paths to be given without the
> double-dash marker as long as they exist in the index, or they
> are leading paths of blobs that exist in the index.

The only objection I have to this (and it's not a very strong one) is that 
it can cause the index to be populated for processes that really don't 
care.

We could work around that with a flag in "struct rev_info", so that 
programs that call "setup_revisions()" can specify before-hand if they are 
interested in the index or not.

The reason I somewhat care was that I was actually going to make the 
checks a bit _stronger_: I was going to say that if you have a pathspec, 
but don't have a "--" marker, then we'd additionally check:

 - none of the arguments we parsed as revisions could be interpreted as a 
   filename.

 - none of the paths are "--" 

so that there really isn't any possibility of accidental confusion in case 
somebody does have a revision that looks like a pathname too.

But I don't actually care _that_ deeply.

		Linus
