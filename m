From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Multi-ancestor read-tree notes
Date: Mon, 5 Sep 2005 01:41:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509050049030.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 07:38:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC9fv-0000Pd-W6
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 07:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVIEFhp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 01:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbVIEFhp
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 01:37:45 -0400
Received: from iabervon.org ([66.92.72.58]:43782 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932214AbVIEFho (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 01:37:44 -0400
Received: (qmail 22751 invoked by uid 1000); 5 Sep 2005 01:41:36 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Sep 2005 01:41:36 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8083>

I've got a version of read-tree which accepts multiple ancestors and does 
a merge using information from all of them.

The basic features are that it looks for an ancestor which would permit a 
trivial merge, and uses that. However, if it finds ancestors which permit 
different trivial merges, it does not merge (which I call case #16).

In case #16, I'm not sure what I should produce. I think the best thing 
might be to not leave anything in stage 1. The desired end effect is that 
the user is given a file with a section like:

  {
    *t = NULL;
    *m = 0;
<<<<<<<<
    return Z_DATA_ERROR;
========
    return Z_OK;
>>>>>>>>
  }

In other news, the merge that was giving Len Brown problems a while ago 
turns out to have the above conflict, and he happened to end up doing the 
right thing and not reverting Linus's revert of an unnecessary (but 
harmless) change. I only noticed this just now, when I was testing that 
merge, and got it to generate only two conflicts regardless of order of 
ancestors (didn't try to resolve the other one, drivers/acpi/osl.c, with 
"merge" either way).

So this test is encouraging: I get fewer non-trivial cases than either of 
the ancestors alone gives, and I catch a case that both single ancestors 
gets wrong.

Note that there are still some memory leaks for me to fix, but that's the 
only flaw I know of with this.

Patches against mainline to follow shortly.

	-Daniel
*This .sig left intentionally blank*
