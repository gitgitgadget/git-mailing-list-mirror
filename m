From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/4] Make 'unpack_trees()' have a separate source and
 destination index
Date: Fri, 7 Mar 2008 16:11:09 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803071603170.19665@iabervon.org>
References: <cover.1204856187.git.torvalds@linux-foundation.org> <8676ea8b0313abfc2e0946f45f636643e28aade8.1204856187.git.torvalds@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 22:11:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXjr6-0006tw-9d
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 22:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbYCGVLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 16:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760438AbYCGVLL
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 16:11:11 -0500
Received: from iabervon.org ([66.92.72.58]:52382 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760423AbYCGVLK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 16:11:10 -0500
Received: (qmail 10019 invoked by uid 1000); 7 Mar 2008 21:11:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Mar 2008 21:11:09 -0000
In-Reply-To: <8676ea8b0313abfc2e0946f45f636643e28aade8.1204856187.git.torvalds@linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76526>

On Thu, 6 Mar 2008, Linus Torvalds wrote:

> We will always unpack into our own internal index, but we will take the
> source from wherever specified, and we will optionally write the result
> to a specified index (optionally, because not everybody even _wants_ any
> result: the index diffing really wants to just walk the tree and index
> in parallel).
> 
> This ends up removing a fair number more lines than it adds, for the
> simple reason that we can now skip all the crud that tried to be
> oh-so-careful about maintaining our position in the index as we were
> traversing and modifying it.  Since we don't actually modify the source
> index any more, we can just update the 'o->pos' pointer without worrying
> about whether an index entry got removed or replaced or added to.

It looks to me like it's leaking stuff stored in the index it creates if 
it ends up failing. I'm not entirely sure of the index lifecycle stuff, 
but it seems like it would be necessary. Aside from that, I think it 
should be right, although I haven't really gone over the resulting code in 
detail.

	-Daniel
*This .sig left intentionally blank*
