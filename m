From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] More docs
Date: Fri, 22 Apr 2005 13:45:29 -0700
Message-ID: <7vwtqu5ymu.fsf@assigned-by-dhcp.cox.net>
References: <4269557C.1050606@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 22:42:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP4xs-0003mz-GN
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 22:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVDVUpo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 16:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVDVUpo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 16:45:44 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26787 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262126AbVDVUpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 16:45:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050422204530.MWWM29099.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Apr 2005 16:45:30 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <4269557C.1050606@dgreaves.com> (David Greaves's message of
 "Fri, 22 Apr 2005 20:50:20 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

DG> Removed Cogito stuff

DG>  commit-id

This is Cogito invention, not in the core.  Neither is tree-id.

DG>  ################################################################
DG> +diff-cache
DG> ...
DG> +-z
DG> +	/0 line termination on output

Write this either '\0' (for C literate) or NUL (ASCII character
name), please.  The same for other commands with -z.

DG>  diff-tree
DG> -	diff-tree [-r] [-z] <tree sha1> <tree sha1>
DG> +	diff-tree [-r] [-z] <tree/commit sha1> <tree/commit sha1>
DG> +...
DG> +--cached
DG> +	Cached only (private?)

What?  The beauty of diff-tree is it does not care about
dircache at all.  Maybe this is a Pasky addition, but I wonder
what the semantics of this option and why it is here...

DG>  ################################################################
DG>  read-tree
DG> -	read-tree [-m] <sha1>
DG> +	read-tree (<sha> | -m <sha1> [<sha2> <sha3>])"
DG> +
DG> +Reads the tree information given by <sha> into the directory cache,
DG> +but does not actually _update_ any of the files it "caches". (see:
DG> +checkout-cache)
DG> +
DG> +Optionally, it can merge a tree into the cache or perform a 3-way
DG> +merge.
DG> +
DG> +Trivial merges are done by read-tree itself.  Only conflicting paths
DG> +will be in unmerged state when read-tree returns.
DG> +...
DG> +NOTE NOTE NOTE! although read-tree coule do some of these nontrivial
DG> +merges, only the "matches in all three states" thing collapses by
DG> +default.

The above "NOTE" is taken from the initial message from Linus
but it is no longer true.  These days, it merges when:

    - stage 2 and 3 are the same
    - stage 1 and stage 2 are the same and stage 3 is different
    - stage 1 and stage 3 are the same and stage 2 is different

Originally it merged only when all stages are the same.

Also you do not describe the single tree merge ("read-tree -m
sha1").  Its semantics is:

    Operate as if the user did not specify "-m", but if the
    original cache had an entry for the same pathname already
    and the contents of the original matches with the tree being
    read, use the stat info from the original instead.

This is used to avoid unnecessary false hits when show-diff is
run after read-tree.

DG>  ################################################################
DG> @@ -151,8 +603,145 @@
DG>  show-files
DG>  	show-files [-z] [-t] (--[cached|deleted|others|ignored|stage])*
 
Although I like it, I do not think -t is in core.  It is Pasky.
Also you missed "show-files --unmerged".

    

