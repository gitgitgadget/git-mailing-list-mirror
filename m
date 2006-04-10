From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Implement limited context matching in git-apply.
Date: Mon, 10 Apr 2006 08:25:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604100821340.9504@g5.osdl.org>
References: <m1d5fqi23b.fsf@ebiederm.dsl.xmission.com>
 <m13bgmht9v.fsf@ebiederm.dsl.xmission.com> <m1irphhj1p.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 17:25:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSyGi-0000ux-Pu
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 17:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWDJPZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 11:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWDJPZ1
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 11:25:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21951 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751012AbWDJPZ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Apr 2006 11:25:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3AFPJtH025063
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Apr 2006 08:25:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3AFPG8b014826;
	Mon, 10 Apr 2006 08:25:18 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1irphhj1p.fsf_-_@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18589>



On Mon, 10 Apr 2006, Eric W. Biederman wrote:
> 
> If I just loop through all of Andrews patches in order
> and run git-apply --index -C1 I process the entire patchset
> in 1m53s or about 6 patches per second.  So running
> git-mailinfo, git-write-tree, git-commit-tree, and
> git-update-ref everytime has a measurable impact,
> and shows things can be speeded up even more.

git-write-tree is actually a fairly expensive operation on the kernel. It 
needs to write the 1000+ tree objects - and while _most_ of them already 
exist (and thus don't actually need to be written out), we need to 
generate the tree object and its SHA1 in order to notice that that is the 
case.

I'm almost certain that 90%+ of the overhead you see is the tree writing, 
not the rest of the scripting.

Your patch looks ok from a quick read-through:

Acked-by: Linus Torvalds <torvalds@osdl.org>

		Linus
