From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: My first git success [not quite]
Date: Sat, 14 Jan 2006 13:57:07 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601141350590.13339@g5.osdl.org>
References: <dq8epd$k28$1@sea.gmane.org> <Pine.LNX.4.64.0601130909290.3535@g5.osdl.org>
 <dqb5vg$a09$1@sea.gmane.org> <Pine.LNX.4.64.0601141117120.13339@g5.osdl.org>
 <dqbnl1$3si$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 14 22:57:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExtOg-0006UV-KS
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 22:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWANV5L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 16:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWANV5L
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 16:57:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42630 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751312AbWANV5L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 16:57:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0ELv8DZ019471
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 14 Jan 2006 13:57:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0ELv7GM017597;
	Sat, 14 Jan 2006 13:57:08 -0800
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dqbnl1$3si$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.65__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14687>



On Sat, 14 Jan 2006, walt wrote:
>
> Linus Torvalds wrote:
> [...]
> > Now, what happens is that when you change branches with a dirty tree, the 
> > "git checkout" will do one of two things:
> > 
> >  - if the dirty files are _identical_ in both branches...
> 
> I'm sorry to be quibbling over semantics, truly I am!  But here
> is my confusion:  if modified-but-uncommitted (hence dirty) files
> are not associated with *any* branch, then how could 'dirty' files
> be 'in' both branches (or 'in' any branch at all)?

The file itself is associated with the branch. It's just that the _dirty_ 
part isn't.

Of course, you can also truly have files that aren't associated with 
either branch at all: files that haven't gotten committed at all. They're 
also "dirty state", and exactly like modifications to known files, they 
are carried along with the switch, so they'll exist in the directory tree 
after a "git checkout".

Anyway, in git, a "branch" is technically really nothing more than "top of 
a commit chain". If you look into the files that describe a branch, you'll 
literally just find the name of the top commit. Do a

	cat .git/refs/heads/master

to see. 

So anything that isn't described by that commit is by definition "dirty 
state", whether it's because you've edited something (but not checked it 
in) or because there's some random generated file in the working tree.

So when you switch branches, you really should think of it as "ok, the 
committed state was switched around", and everything else was just "moved 
along".

		Linus
