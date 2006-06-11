From: Linus Torvalds <torvalds@osdl.org>
Subject: git-applymbox broken?
Date: Sun, 11 Jun 2006 15:40:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jun 12 00:40:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpYbq-0000SI-8K
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 00:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWFKWkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 18:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWFKWkb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 18:40:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7855 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751090AbWFKWka (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 18:40:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5BMePgt004025
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Jun 2006 15:40:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5BMeOEL001069;
	Sun, 11 Jun 2006 15:40:25 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21672>


It looks like something has broken git-applymbox lately.

The "From: authorname" lines are no longer removed from the message, and 
are duplicated in the commit log. This has resulted in several recent 
kernel commits looking like this:

	commit c0bbbc73d58f1b774cd987b5687a478a027f137c
	Author: Christoph Lameter <clameter@sgi.com>
	Date:   Sun Jun 11 15:22:26 2006 -0700
	
	    [PATCH] typo in vmscan.c
	    
	    From: Christoph Lameter <clameter@sgi.com>
	    
	    Looks like a comma was left from the conversion from a struct to an
	    assignment.
	    
	    Signed-off-by: Christoph Lameter <clameter@sgi.com>
	    Signed-off-by: Andrew Morton <akpm@osdl.org>
	    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

where that "From:" in the body is totally wrong. I just didn't notice, 
until now. Arrr!

I _suspect_ that this is the work by Eric Biederman, ie part of the 
patches that do "Allow in body headers beyond the in body header 
prefix." and "Refactor commit messge handling."

Eric? Can you please fix this up? Lines from the body of the email that 
have been used to set authorship should _not_ also show up in the commit 
message.

		Linus
