From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: possible bug in git apply?
Date: Sat, 4 Aug 2007 21:53:07 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708042148440.5037@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0708041243070.6905@asgard.lang.hm>
 <alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, rob@landley.net
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Aug 05 06:53:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHY7U-0003qy-9m
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXHEExc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbXHEExc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:53:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46936 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751911AbXHEExb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 00:53:31 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l754rDI6001807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 4 Aug 2007 21:53:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l754r7QP025412;
	Sat, 4 Aug 2007 21:53:08 -0700
In-Reply-To: <alpine.LFD.0.999.0708042141510.5037@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54945>



On Sat, 4 Aug 2007, Linus Torvalds wrote:
>
> But yeah, it seems that the file *rename* ends up not triggering that 
> logic! Very annoying.
> 
> Does this fix it? Totally untested, but it _looks_ obvious enough..

Side note: git will never remove a directory even if it becomes empty as 
far as *git* is concerned, if there are other files that git doesn't know 
about in there. So if you really really want to remove that directory, you 
do end up having to often just doing

	rm -rf some/dir/

and the fact that you don't find a "git rmdir" is that with git, you 
really should not even need it.

We do "git mv" and friends, but the fact is, that may have confused people 
into thinking that git cares.

The "default mindset" should be to just do everything directly in the 
filesystem, and git will just figure things out on its own. The "git mv" 
and "git rm" stuff is purely *convenience* features, nothing more.

Other SCM's really want you to do "scm rm" or "scm cp" or whatever. Git 
really really really doesn't care, and I think people are a bit too afraid 
of just doing the operation the normal UNIX way.

So next time you want to remove a directory, just remove it. With 
bog-standard unix tools. Use "rm". Or a graphical file manager. Or muck 
with the disk directly using a binary editor. Git won't care. It will 
notice that the file is gone, and do the right thing.

		Linus
