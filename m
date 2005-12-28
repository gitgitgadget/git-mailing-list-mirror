From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/4] short circuit out of a few places where we would
 allocate zero bytes
Date: Tue, 27 Dec 2005 20:38:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512272036380.14098@g5.osdl.org>
References: <20051224121007.GA19136@mail.yhbt.net> <20051224121243.GA3963@mail.yhbt.net>
 <43B21312.50603@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 28 05:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErT51-0002nH-Ia
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 05:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVL1EiO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Dec 2005 23:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVL1EiO
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Dec 2005 23:38:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932471AbVL1EiN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Dec 2005 23:38:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBS4cBDZ026645
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Dec 2005 20:38:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBS4cAUi013710;
	Tue, 27 Dec 2005 20:38:11 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43B21312.50603@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14093>



On Tue, 27 Dec 2005, H. Peter Anvin wrote:
> 
> Better yet, either always return NULL or allocate 1 byte in that case, to get
> consistent behaviour.

Yes. However, if you do the "return NULL" case (which is nicest), you'll 
have to wrap "free()" too. There are some libraries where passing "free()" 
a NULL pointer causes a SIGSEGV.

That said, I think that would be preferable to changing the source code to 
unnecessarily avoid zero-sized allocations. Having a "xfree()" to match 
"xmalloc()" makes sense. 

		Linus
