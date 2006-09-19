From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix broken sha1 locking
Date: Tue, 19 Sep 2006 14:16:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609191411460.4388@g5.osdl.org>
References: <20060919205823.18579.59604.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 19 23:16:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPmx0-0008Lk-Nn
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 23:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWISVQP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWISVQP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 17:16:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751094AbWISVQO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 17:16:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8JLG5nW025676
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Sep 2006 14:16:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8JLG3ED003411;
	Tue, 19 Sep 2006 14:16:03 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060919205823.18579.59604.stgit@machine.or.cz>
X-Spam-Status: No, hits=-2.505 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27286>



On Tue, 19 Sep 2006, Petr Baudis wrote:
>
> Current git#next is totally broken wrt. cloning over HTTP, generating refs
> at random directories. Of course it's caused by the static get_pathname()
> buffer. lock_ref_sha1() stores return value of mkpath()'s get_pathname()
> call, then calls lock_ref_sha1_basic() which calls git_path(ref) which
> calls get_pathname() at that point returning pointer to the same buffer.

Hmm. This was exactly the schenario why I did commit
e7676d2f6454c9c99e600ee2ce3c7205a9fcfb5f - allowing a couple of 
overlapping paths

Isn't that in the "next" branch too?

Of course, that still assumes that you strdup() the result at _some_ time, 
and can't just save it away, but lock_ref_sha1_basic() should do that.

			Linus
