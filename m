From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: running git-update-cache --refresh on different machines on a
 NFS share always ends up in a lot of io/cpu/time waste
Date: Sun, 22 May 2005 13:43:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505221332590.2307@ppc970.osdl.org>
References: <20050522122849.GJ15178@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505221205580.2307@ppc970.osdl.org>
 <20050522192734.GB23388@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 22:41:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZxGQ-0005JJ-0K
	for gcvg-git@gmane.org; Sun, 22 May 2005 22:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVEVUm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 16:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVEVUm3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 16:42:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:51393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261735AbVEVUlz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 16:41:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4MKfpjA020455
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 13:41:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4MKfone027868;
	Sun, 22 May 2005 13:41:50 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050522192734.GB23388@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 22 May 2005, Thomas Glanzmann wrote:
> 
> Is link() NFS safe? I thought only mkdir() for nfs?

Sorry, I meant "rename", not "link", and yes, it should be NFS-safe. It's 
how all the mailers do things too, afaik.

As to your update-cache problem, it seems to be just due to NFS stat
caching. You generally should _not_ work on two machines at the same time,
but it probably does the right thing in the end.

In general, I would suggest using separate GIT repositories over sharing
them over NFS. As far as I'm concerned, I think NFS should work in the
sense that you can work from different clients at _different_times_, and
I'm certainly not going to guarantee that two different clients that work
at the same time against the same repository will get sane results.

For example, if you do a "git-checkout-cache -f -a" at the same time, I 
won't guarantee that things won't race on the working files. Don't do it.

		Linus
