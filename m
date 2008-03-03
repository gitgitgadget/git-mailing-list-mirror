From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: kernel.org git tree corrupt?
Date: Mon, 3 Mar 2008 08:21:35 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803030800460.17889@woody.linux-foundation.org>
References: <524f69650803020749o469f2e48l125a55267b0b5d13@mail.gmail.com>  <alpine.LFD.1.00.0803021302070.17889@woody.linux-foundation.org> <524f69650803021943i33ce6ddbo309f118cd0a77ac9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: Steve French <smfrench@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759552AbYCCQWX@vger.kernel.org Mon Mar 03 17:23:20 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759552AbYCCQWX@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWDRW-0007fa-VG
	for glk-linux-kernel-3@gmane.org; Mon, 03 Mar 2008 17:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759552AbYCCQWX (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 3 Mar 2008 11:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755872AbYCCQWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Mar 2008 11:22:11 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34924 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755644AbYCCQWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Mar 2008 11:22:10 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m23GLit7018847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Mar 2008 08:21:46 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m23GLZeZ026627;
	Mon, 3 Mar 2008 08:21:36 -0800
In-Reply-To: <524f69650803021943i33ce6ddbo309f118cd0a77ac9@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.883 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75939>



On Sun, 2 Mar 2008, Steve French wrote:
> 
> >   - look at your "origin" branch, and make sure it's a *remote* branch, not
> >    the old-style local one. Ie it should *not* show up when you do a
> >    plain
> >
> >         git branch
> now only shows "* master"
> 
> >    but it *should* show up (as both "origin/HEAD" and "origin/master")
> >    when you do
> >
> >         git branch -a
> Now "git branch -a" shows
> * master
>   origin/master
> 
> It is missing "origin/HEAD"

Ahh, yeah, my bad. The origin/HEAD thing will be created if you use either 
clone or "git remote add -m master" to create the remote. But when I asked 
you to do it by just editing the config file, you now have to create that 
HEAD pointer manually too.

You can do

	git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/master

to create the thing (it just creates a symbolic ref from the origin/HEAD 
remote ref to the origin/master one, so now git will know that when you 
talk about 'origin', it is supposed to just use the master branch of 
that remote).

> >   - now do "git log origin" an it should show something recent
> git log origin and git log origin/master both return
> "ambiguous argument 'origin': unknown revision"

Well, origin/master should have worked, but the fact that plain "origin" 
didn't work is due to exactly the lack of HEAD file for that remote branch 
(for your kernel tree, there's only one remote branch, so it may be 
"obvious" that origin must be talking about the master branch, but if 
there are multiple branches at the origin it's not obvious *which* branch 
should be considered the default one, which is why we use HEAD)

> I must be misunderstanding the syntax/manpage of git-log but "git diff
> -m -r origin/master"
> now works fine and displays exactly what I expect so things have improved.

Well, if "origin/master" works in that situation, then "origin/master" 
should have worked in "git log" too, so maybe you mistyped?

Anyway, with the HEAD link added for the remote 'origin', you should be 
able to use plain 'origin' like you're used to.

			Linus
