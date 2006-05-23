From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] cvsimport: introduce -L<imit> option to workaround memory
 leaks
Date: Tue, 23 May 2006 09:25:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605230919190.5623@g5.osdl.org>
References: <11482978883713-git-send-email-martin@catalyst.net.nz>
 <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org> <20060523153636.GA21506@thunk.org>
 <Pine.LNX.4.64.0605230848060.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Johannes.Schindelin@gmx.de,
	spyderous@gentoo.org, smurf@smurf.noris.de
X-From: git-owner@vger.kernel.org Tue May 23 18:27:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiZiD-0004W8-GK
	for gcvg-git@gmane.org; Tue, 23 May 2006 18:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWEWQ0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 12:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWEWQ0V
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 12:26:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750832AbWEWQ0V (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 12:26:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NGPntH013984
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 09:25:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NGPlAY011440;
	Tue, 23 May 2006 09:25:47 -0700
To: Theodore Tso <tytso@mit.edu>
In-Reply-To: <Pine.LNX.4.64.0605230848060.5623@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20611>



On Tue, 23 May 2006, Linus Torvalds wrote:
> 
> So an unpacked git archive on ext3 (but not ext2, I believe: ext2 should 
> use the page cache for directories) ends up being very buffer-cache 
> intensive. And the buffer cache is basically deprecated..

A few notes: I'm not 100% sure things really fit in the 2GB (*), so it 
really may be IO limited, and the low CPU use is just because that machine 
also happens to have a dang fast next-gen Intel CPU that hasn't even been 
released yet.

Also, I do realize that hashed directories should actually decrease the 
buffer cache pressure too, just because we wouldn't need to read all of 
the directory for a lookup. 

		Linus

(*) cvsps itself grows to 1.6GB of the 2GB and while that memory should be 
largely idle, the problem may simply be that we don't swap it out eagerly 
enough. Allowing filesystem metadata to swap out processes is something 
we've tuned against, because it tends to result in horrible interactive 
behaviour after a nightly "updatedb" run. So it's entirely possible that 
this is all normal..
