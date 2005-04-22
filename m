From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] More docs
Date: Fri, 22 Apr 2005 22:44:42 +0100
Message-ID: <4269704A.9090503@dgreaves.com>
References: <4269557C.1050606@dgreaves.com> <7vwtqu5ymu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 23:40:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP5sk-0003sO-Lk
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 23:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDVVov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 17:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVDVVov
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 17:44:51 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:55460 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261170AbVDVVoq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 17:44:46 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id CF3FFE6D68; Fri, 22 Apr 2005 22:42:46 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 26323-06; Fri, 22 Apr 2005 22:42:46 +0100 (BST)
Received: from oak.dgreaves.com (modem-2249.leopard.dialup.pol.co.uk [217.135.152.201])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 89B20E6A86; Fri, 22 Apr 2005 22:42:45 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DP5x5-0004bU-Ah; Fri, 22 Apr 2005 22:44:43 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtqu5ymu.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

Thanks for the comments Junio

>>>>>>"DG" == David Greaves <david@dgreaves.com> writes:
> 
> This is Cogito invention, not in the core.  Neither is tree-id.
OK - hard to tell sometimes...

> DG> +	/0 line termination on output
> 
> Write this either '\0' (for C literate) or NUL (ASCII character
> name), please.  The same for other commands with -z.
hmm, this...

> DG> +--cached
> DG> +	Cached only (private?)
> 
> What?  The beauty of diff-tree is it does not care about
> dircache at all.  Maybe this is a Pasky addition, but I wonder
> what the semantics of this option and why it is here...
...and this, are pre-final-polish
I must have committed the wrong one - <sigh>

> DG> +NOTE NOTE NOTE! although read-tree coule do some of these nontrivial
> DG> +merges, only the "matches in all three states" thing collapses by
> DG> +default.
> 
> The above "NOTE" is taken from the initial message from Linus
> but it is no longer true.  These days, it merges when:
OK - will edit

how does this sound:

Merging
If -m is specified, read-tree performs 2 kinds of merge, a subservient
tree-read if only 1 tree is given or a 3-way merge if 3 trees are
provided.

Subservient Tree Read
If only 1 tree is specified, read-tree operates as if the user did not
specify "-m", except that if the original cache has an entry for a
given pathname; and the contents of the path matches with the tree
being read, the stat info from the cache is used. (In other words, the
cache's stat()s take precedence over the subservient tree's)

This is used to avoid unnecessary false hits when show-diff is
run after read-tree.

3-Way Merge
Each "index" entry has two bits worth of "stage" state. stage 0 is the
normal one, and is the only one you'd see in any kind of normal use.

However, when you do "read-tree" with multiple trees, the "stage"
starts out at 0, but increments for each tree you read. And in
particular, the "-m" flag means "start at stage 1" instead.

This means that you can do

	read-tree -m <tree1> <tree2> <tree3>

and you will end up with an index with all of the <tree1> entries in
"stage1", all of the <tree2> entries in "stage2" and all of the
<tree3> entries in "stage3".

Furthermore, "read-tree" has special-case logic that says: if you see
a file that matches in all respects in the following states, it
"collapses" back to "stage0":
     - stage 2 and 3 are the same
     - stage 1 and stage 2 are the same and stage 3 is different
     - stage 1 and stage 3 are the same and stage 2 is different

NOTE NOTE NOTE para removed.

> DG>  ################################################################
> DG> @@ -151,8 +603,145 @@
> DG>  show-files
> DG>  	show-files [-z] [-t] (--[cached|deleted|others|ignored|stage])*
>  
> Although I like it, I do not think -t is in core.  It is Pasky.
Well, it says Copyright (C) Linus Torvalds, 2005 - and Linus describes 
it in his discussion so...

> Also you missed "show-files --unmerged".
I did - that's me using the usage() string!!

David

-- 
