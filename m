From: Linus Torvalds <torvalds@osdl.org>
Subject: git-fetch-pack
Date: Mon, 4 Jul 2005 17:08:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507041702590.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jul 05 02:09:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpazt-0005Au-2K
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 02:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVGEAI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jul 2005 20:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVGEAI5
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jul 2005 20:08:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261738AbVGEAIx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2005 20:08:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6508njA031994
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 4 Jul 2005 17:08:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6508jsi009345
	for <git@vger.kernel.org>; Mon, 4 Jul 2005 17:08:48 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok,
 I've written a "git-fetch-pack" along the lines I outlined a few days 
ago, ie the person doing the fetching ends up listing the commits it has, 
and then both ends negotiate the missing objects.

It's probably buggy in many ways, but I actually used it to fetch the last 
merge with Russell King:

	remote=$(git-fetch-pack $repo master)
	if [ "$remote" ]; then
		git resolve $(git-rev-parse HEAD) $remote "Merge $repo"
	fi

ends up doing something sane.

In general, the format is to tell git-fetch-pack where to fetch things
from, and what branch to use (if you give none, or you give multiple, it
does various magic things, you shouldn't do it). It will then fetch and 
unpack the pack, and return the SHA1 corresponding to the remote ref if 
everything was successful.

So the above will fetch a remote ref, and resolve it (ie it's basically a 
specialized "git pull").

		Linus
