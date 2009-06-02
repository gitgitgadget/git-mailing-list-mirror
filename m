From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Am able to delete a file with no trace in the log
Date: Tue, 2 Jun 2009 14:55:24 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0906021439030.4880@localhost.localdomain>
References: <EB2D87B9-3B03-431A-B204-C7799F9BA291@ausperks.net> <20090602213439.GA7584@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Graham Perks <gperks@ausperks.net>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:55:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBbxL-0008C7-M8
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 23:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbZFBVza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 17:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbZFBVz3
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 17:55:29 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44249 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752507AbZFBVz3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 17:55:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n52LtOSh013389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2009 14:55:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n52LtOct005076;
	Tue, 2 Jun 2009 14:55:24 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090602213439.GA7584@coredump.intra.peff.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120553>



On Tue, 2 Jun 2009, Jeff King wrote:
> 
> But it doesn't show up in "git log". I believe this is because the rule
> for what to show in a merge commit is "if content is exactly the same as
> one of the parents, it's not interesting".

Correct.

What happens is that "git log" with a filename will always simplify the 
history to the side that matches. And yes, "matching" can and does include 
"doesn't exist in child, doesn't exist in parent"

Now, I admit that in this case the matching heuristic is dubious, and 
maybe we should consider "does not exist in result" to not match any 
parent. We already think that "all new" is special ("REV_TREE_NEW" vs 
"REV_TREE_DIFFERENT"), so maybe we should think that "all deleted" is also 
special ("REV_TREE_DEL")

		Linus
