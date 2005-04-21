From: Linus Torvalds <torvalds@osdl.org>
Subject: Mozilla SHA1 implementation
Date: Thu, 21 Apr 2005 12:48:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504211238150.2344@ppc970.osdl.org>
References: <87hdi5oet6.dancerj@netfort.gr.jp> <Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org>
 <20050418055824.42d621b8.froese@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Apr 21 21:43:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOhZU-0001OP-8x
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 21:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVDUTrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 15:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVDUTrK
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 15:47:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:38815 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261813AbVDUTrD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 15:47:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3LJkis4021039
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 21 Apr 2005 12:46:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3LJkgFj020312;
	Thu, 21 Apr 2005 12:46:43 -0700
To: Edgar Toernig <froese@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050418055824.42d621b8.froese@gmx.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I've just integrated the Mozilla SHA1 library implementation that Adgar
Toernig sent me into the standard git archive (but I did the integration
differently).

The Mozilla SHA1 code is copyright Paul Kocher and Cryptography Research,
and is released under a dual MPL/GPL license. Git obviously uses it in the
GPL version, but I left the MPL choice there too, so that those two files
(that are in a subdirectory of its own) will continue to be dual-licensed.

NOTE! I left git using the openssl libraries by default, and this is a
built-time choice in the makefile. You can choose the Mozilla SHA1
implementation by doing

	make clean
	MOZILLA_SHA1=1 make
	make install

but I suspect that anybody that has openssl installed and is working on an
x86 is much better off with the i586-optimized openssl version. But if you
don't have openssl by default, or if you don't like openssl for some other
reason, you now have a nice easy choice.

Interestingly, the Mozilla SHA1 code is about twice as fast as the openssl
code on my G5, and judging by the disassembly, it's because it's much
simpler. I think the openssl people have unrolled all the loops totally,
which tends to be a disaster on any half-way modern CPU. But hey, it could
be something as simple as optimization flags too.

			Linus
