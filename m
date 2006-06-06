From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Integrity check
Date: Tue, 6 Jun 2006 15:53:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606061550100.5498@g5.osdl.org>
References: <pan.2006.06.06.22.46.26.518589@canit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 00:54:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnkQt-0008QN-Ql
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 00:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWFFWxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 18:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWFFWxk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 18:53:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751271AbWFFWxj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 18:53:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k56MrY2g022710
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 6 Jun 2006 15:53:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k56MrXtw004912;
	Tue, 6 Jun 2006 15:53:33 -0700
To: Kenneth Johansson <ken@canit.se>
In-Reply-To: <pan.2006.06.06.22.46.26.518589@canit.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21411>



On Wed, 7 Jun 2006, Kenneth Johansson wrote:
>
> Iwas doing a git pull that ended badly and I thought that just redoing the
> command may help but then git thinks everything is just fine.

What happened is that your first pull actually worked fine, but the final 
"git-diff-tree" that shows what the pull actually _did_ ended up 
SIGSEGV'ing.

Subsequent pulls won't SIGSEGV, because they dont' have anything to do any 
more: your state is fine.

I think the SIGSEGV was due to the problem (that Junio already fixed) with 
a corrupted heap due to the "diffstat" doing bad things for renames.

So you probably do want to update your git version, but I don't think 
anything bad actually ever happened, apart from the (a) scare and (b) lack 
of diffstat output after the pull.

> After a few failed attempts I still have not find a good way to make sure
> that everything is indeed correct. What is the suggested commands to do
> that ?

In the future, just do "git fsck-objects --full" if you're nervous. That 
will do a full integrity check.

		Linus
