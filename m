From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/2] merge-trees script for Linus git
Date: Sat, 16 Apr 2005 08:28:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504160820320.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
 <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
 <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
 <20050414223039.GB28082@64m.dyndns.org> <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
 <20050415062807.GA29841@64m.dyndns.org> <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
 <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
 <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net> <7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
 <7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
 <7v7jj3fjky.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
 <Pine.LNX.4.58.0504152256520.7211@ppc970.osdl.org> <7v
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 17:23:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMp94-0004jh-Ew
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 17:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262681AbVDPP1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 11:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVDPP1M
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 11:27:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:53470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262681AbVDPP07 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 11:26:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3GFQqs4021850
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 08:26:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3GFQpKR017740;
	Sat, 16 Apr 2005 08:26:52 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis2ncf8j.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Junio C Hamano wrote:
> 
> LT> NOTE NOTE NOTE! I could make "read-tree" do some of these nontrivial 
> LT> merges, but I ended up deciding that only the "matches in all three 
> LT> states" thing collapses by default.
> 
>  * Understood and agreed.

Having slept on it, I think I'll merge all the trivial cases that don't 
involve a file going away or being added. Ie if the file is in all three 
trees, but it's the same in two of them, we know what to do.

That way we'll leave thigns where the tree itself changed (files added or 
removed at any point) and/or cases where you actually need a 3-way merge.

> The userland merge policies need ways to extract the stage
> information and manipulate them.  Am I correct to say that you
> mean by "ls-files -l" the extracting part?

No, I meant "show-files", since we need to show the index, not a tree (no 
valid tree can ever have the "modes" information, since (a) it doesn't 
have the space for it anyway and (b) we refuse to write out a dirty index 
file.



> 
> LT> I should make "ls-files" have a "-l" format, which shows the
> LT> index and the mode for each file too.
> 
> You probably meant "ls-tree".  You used the word "mode" but it
> already shows the mode so I take it to mean "stage".  Perhaps
> something like this?
> 
> $ ls-tree -l -r 49c200191ba2e3cd61978672a59c90e392f54b8b
> 100644	blob	fe2a4177a760fd110e78788734f167bd633be8de	COPYING
> 100644	blob	b39b4ea37586693dd707d1d0750a9b580350ec50:1	man/frotz.6
> 100644	blob	b39b4ea37586693dd707d1d0750a9b580350ec50:2	man/frotz.6
> 100664	blob	eeed997e557fb079f38961354473113ca0d0b115:3	man/frotz.6

Apart from the fact that it would be

	show-files -l

since there are no tree objects that can have anything but fully merged
state, yes.

> Assuming that you would be working on that, I'd like to take the
> dircache manipulation part.  Let's think about the minimally
> necessary set of operations:
> 
>  * The merge policy decides to take one of the existing stage.
> 
>    In this case we need a way to register a known mode/sha1 at a
>    path.  We already have this as "update-cache --cacheinfo".
>    We just need to make sure that when "update-cache" puts
>    things at stage 0 it clears other stages as well.
> 
>  * The merge policy comes up with a desired blob somewhere on
>    the filesystem (perhaps by running an external merge
>    program).  It wants to register it as the result of the
>    merge.
> 
>    We could do this today by first storing the "desired blob"
>    in a temporary file somewhere in the path the dircache
>    controls, "update-cache --add" the temporary file, ls-tree to
>    find its mode/sha1, "update-cache --remove" the temporary
>    file and finally "update-cache --cacheinfo" the mode/sha1.
>    This is workable but clumsy.  How about:
> 
>    $ update-cache --graft [--add] desired-blob path
> 
>    to say "I want to register mode/sha1 from desired-blob, which
>    may not be of verify_path() satisfying name, at path in the
>    dircache"?
> 
>  * The merge policy decides to delete the path.
> 
>    We could do this today by first stashing away the file at the
>    path if it exists, "update-cache --remove" it, and restore
>    if necessary.  This is again workable but clumsy.  How about:
> 
>    $ update-cache --force-remove path
> 
>    to mean "I want to remove the path from dircache even though
>    it may exist in my working tree"?

Yes.

> Am I on the right track?

Exactly.

> You might want to go even lower level by letting them say
> something like:
> 
>  * update-cache --register-stage mode sha1 stage path
> 
>    Registers the mode/sha1 at stage for path.  Does not look at
>    the working tree.  stage is [0-3]

I'd prefer not. I'd avoid playing games with the stages at any other level
than the "full tree" level until we show a real need for it.

Let's go with the known-needed minimal cases that are high-level enough to
make the scripting simple, and see if there is any reason to ever touch
the tree any other way.

		Linus
