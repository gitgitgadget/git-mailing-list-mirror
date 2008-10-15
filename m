From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] reset --hard/read-tree --reset -u: remove unmerged new
 paths
Date: Wed, 15 Oct 2008 16:16:17 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810151615550.3288@nehalem.linux-foundation.org>
References: <20081015115654.fb34438f.akpm@linux-foundation.org> <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm> <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm> <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
 <20081015124949.b657a8db.akpm@linux-foundation.org> <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810151311210.3288@nehalem.linux-foundation.org> <7v3aixqzrn.fsf@gitster.siamese.dyndns.org>
 <7vy70ppiq1.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>, david@lang.hm,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 01:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqFff-0007Jl-BC
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 01:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYJOXQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 19:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbYJOXQz
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 19:16:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34814 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751287AbYJOXQy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 19:16:54 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FNGIuZ019304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Oct 2008 16:16:19 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9FNGHRH019462;
	Wed, 15 Oct 2008 16:16:17 -0700
In-Reply-To: <7vy70ppiq1.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.433 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98338>



On Wed, 15 Oct 2008, Junio C Hamano wrote:
>
> When aborting a failed merge that has brought in a new path using "git
> reset --hard" or "git read-tree --reset -u", we used to first forget about
> the new path (via read_cache_unmerged) and then matched the working tree
> to what is recorded in the index, thus ending up leaving the new path in
> the work tree.

Looks good to me. And from my tests, I think "git checkout -f" didn't have 
this problem at all, because it ends up using not got read-tree, but doing 
its own "reset_tree()" that uses unpack_trees().

I do wonder if "git reset" should perhaps be written in those terms, 
instead of just being a wrapper around git read-tree. But the patch looks 
fine.

		Linus
