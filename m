From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write-tree performance problems
Date: Tue, 19 Apr 2005 14:23:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>
References: <200504191250.10286.mason@suse.com> <200504191412.00227.mason@suse.com>
 <Pine.LNX.4.58.0504191143220.19286@ppc970.osdl.org> <200504191708.23536.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 23:18:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO06T-0005pe-H6
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 23:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVDSVVy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 17:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDSVVy
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 17:21:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:2221 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261693AbVDSVVm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 17:21:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JLLZs4018723
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 14:21:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JLLZdP032710;
	Tue, 19 Apr 2005 14:21:35 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200504191708.23536.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Chris Mason wrote:
> 
> Regardless, putting it into the index somehow should be fastest, I'll see what 
> I can do.

Start by putting it in at "read-tree" time, and adding the code to
invalidate all parent directory indexes when somebody changes a file in
the index (ie "update-cache" for anything but a "--refresh").

That would be needed anyway, since those two are the ones that already
change the index file.

Once you're sure that you can correctly invalidate the entries (so that
you could never use a stale tree entry by mistake), the second stage would
be to update it at "write-tree" time.

		Linus
