From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-bisect not working correctly in the kvm.git repository?
Date: Mon, 17 Nov 2008 11:34:11 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811171131330.18283@nehalem.linux-foundation.org>
References: <gfs9hn$hq9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 20:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L29tD-0007vI-MN
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 20:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbYKQTes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 14:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbYKQTes
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 14:34:48 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59031 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751760AbYKQTer (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2008 14:34:47 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAHJYBP5023770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Nov 2008 11:34:13 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAHJYB11029204;
	Mon, 17 Nov 2008 11:34:11 -0800
In-Reply-To: <gfs9hn$hq9$1@ger.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.438 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101237>



On Mon, 17 Nov 2008, walt wrote:
>
> I'm trying to find a bug introduced somewhere between kvm-69
> and kvm-70, so of course I want to git-bisect down to it.
> 
> The weirdness is that when I give git-bisect the good and
> bad tags, almost everything in my working directory just
> disappears, leaving only the qemu subdirectory behind.

Have you done subdirectory merges or other odd merges?

If you merge stuff from another project that isn't a full repository, then 
you are merging commits that simply don't _have_ the full tree of your 
repo. If you then bisect into those commits, the checkout will then (of 
course) end up having only the files that are in that partial tree.

This will happen in the git repository too, if "git bisect" ends up 
jumping into one of the commits that were done in the 'gitk' repository. 

For an example of this, do something like

	git clean -dqfx
	git checkout -b oddbranch eb33a67f218b612f6fb1456e19b40a1f97ff02c0

in the git repository, and see all files disappear, and gitk is no longer 
in the 'gitk-git' subdirectory, but got moved to the top level.

Because in the history that is that commit, that is literally how things 
were. The data from that commit just got merged into a subdirectory of its 
own, and together with all the rest of git, by using a subtree merge.

			Linus
