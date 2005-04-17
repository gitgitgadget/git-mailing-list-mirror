From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Storing permissions
Date: Sat, 16 Apr 2005 22:37:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504162233050.7211@ppc970.osdl.org>
References: <20050416230058.GA10983@ucw.cz> <118833cc05041618017fb32a2@mail.gmail.com>
 <20050416183023.0b27b3a4.pj@sgi.com> <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>, mj@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:31:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN2Ne-0008Js-24
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVDQFfS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 01:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDQFfS
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 01:35:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:64930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbVDQFfN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 01:35:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3H5Z5s4010017
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 22:35:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3H5Z4rO008992;
	Sat, 16 Apr 2005 22:35:04 -0700
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504162138020.7211@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Linus Torvalds wrote:
> 
> Anybody want to send a patch to do this?

Actually, I just did it. Seems to work for the only test-case I tried,
namely I just committed it, and checked that the permissions all ended up
being recorded as 0644 in the tree (if it has the -x bit set, they get
recorded as 0755).

When checking out, we always check out with 0666 or 0777, and just let 
umask do its thing. We only test bit 0100 when checking for differences.

Maybe I missed some case, but this does indeed seem saner than the "try to 
restore all bits" case. If somebody sees any problems, please holler.

(Btw, you may or may not need to blow away your "index" file by just 
re-creating it with a "read-tree" after you've updated to this. I _tried_ 
to make sure that the compare just ignored the ce_mode bits, but the fact 
is, your index file may be "corrupt" in the sense that it has permission 
sets that sparse expects to never generate in an index file any more..)

		Linus
