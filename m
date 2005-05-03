From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Tue, 3 May 2005 07:48:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505030742330.3594@ppc970.osdl.org>
References: <200505030657.38309.alonz@nolaviz.org>
 <Pine.LNX.4.58.0505022131380.3594@ppc970.osdl.org>
 <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alon Ziv <alonz@nolaviz.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 16:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSyfL-00080o-Mu
	for gcvg-git@gmane.org; Tue, 03 May 2005 16:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVECOwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 10:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVECOsj
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 10:48:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:52619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261619AbVECOqz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 10:46:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43EkSs4020032
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 07:46:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43EkRl5029003;
	Tue, 3 May 2005 07:46:27 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505030344170.14033@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Nicolas Pitre wrote:
> 
> Yep, that's what I've done last weekend (and just made it actually 
> work since people are getting interested).

I have to say that it looks uncommonly simple. Also, afaik, this should
still work with the current fsck, it's just that because fsck doesn't
understand the linkages, the error reporting won't be as good as it could
be (I'd _much_ rather see "delta failed in object xxxxx" than "unable to
read xxxxxx").

Now, one thing I like about this approach is that the actual delta 
_generation_ can be done off-line, and independently of anything else. 
Which means that the performance paths I care about (commit etc) are 
largely unaffected, and you can "deltify" a git archive overnight or 
something. 

In fact, it means that you might even be able to use some fairly expensive 
"search for the best blob object to delta against", including very much a 
intelligent rename search (ie "oh, this is a new object, let's see if any 
of the old deleted objects generate a good delta"), but you might even go 
back more than one generation.

Hmm. How nasty are those scripts?

		Linus
