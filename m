From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 12:17:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606121214420.5498@g5.osdl.org>
References: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com> 
 <Pine.LNX.4.64.0606112028010.5498@g5.osdl.org> 
 <9e4733910606112039p7aff60c7w7a074d0e35c7b0f@mail.gmail.com> 
 <Pine.LNX.4.64.0606112056440.5498@g5.osdl.org>
 <f36b08ee0606121204q1f9dfb5dv3c09c4e9e6a16a0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 21:17:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpruz-00081L-81
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWFLTRm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWFLTRm
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:17:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932103AbWFLTRl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 15:17:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5CJHdgt028084
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Jun 2006 12:17:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5CJHbHT032508;
	Mon, 12 Jun 2006 12:17:38 -0700
To: Yakov Lerner <iler.ml@gmail.com>
In-Reply-To: <f36b08ee0606121204q1f9dfb5dv3c09c4e9e6a16a0f@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21731>



On Mon, 12 Jun 2006, Yakov Lerner wrote:
> 
> Is this related to 1-level dir tree for objects (12/object)
> vs 2-level dir tree (12/34/object) ? Does git employ more levels
> for object tree for large projects ?

The "more levels" approach was certainly an option early on, when we 
discussed how the objects should be spread out.

It was basically made a non-issue by the pack-files. These days, the rule 
is really more along the lines of "if you ever have more than a few 
thousand files, you've not repacked properly".

The git-svnimport script obviously doesn't do it right, but it should be 
trivial to fix. For the git cvsimporter, the fix was literally to just do

	$commitcount++;
	..
	if (($commitcount & 1023) == 0) {
		system("git repack -a -d");  
	}

when committing and that was it. It doesn't get much simpler than that, 
but the svnimporter just hasn't done it yet.

		Linus
