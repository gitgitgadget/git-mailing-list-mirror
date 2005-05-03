From: Andreas Gal <gal@uci.edu>
Subject: Re: git and symlinks as tracked content
Date: Tue, 3 May 2005 14:51:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031446220.31626@sam.ics.uci.edu>
References: <1115145234.21105.111.camel@localhost.localdomain>
 <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
 <Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
 <Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org> <7vr7got2tz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 23:51:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT5Hd-0001zB-6Y
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVECV4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVECV4m
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:56:42 -0400
Received: from sam.ics.uci.edu ([128.195.38.141]:5546 "EHLO sam.ics.uci.edu")
	by vger.kernel.org with ESMTP id S261835AbVECV4f (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 17:56:35 -0400
Received: from sam.ics.uci.edu (localhost.localdomain [127.0.0.1])
	by sam.ics.uci.edu (8.12.11/8.12.11) with ESMTP id j43LpIsC031653;
	Tue, 3 May 2005 14:51:18 -0700
Received: from localhost (gal@localhost)
	by sam.ics.uci.edu (8.12.11/8.12.8/Submit) with ESMTP id j43LpITu031649;
	Tue, 3 May 2005 14:51:18 -0700
X-Authentication-Warning: sam.ics.uci.edu: gal owned process doing -bs
X-X-Sender: gal@sam.ics.uci.edu
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7got2tz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Whether you use an explicit "dev" type or an implicit "dev" type that 
calls itself "blob" and uses a magic mode flag to tell checkout that it 
needs special treatment doesn't make a difference (whatever you 
prefer, really). I was only trying to make the point that hashes should remain 
hashes and not become a placeholder for minors/majors. However, as 
somebody already suggested, the entire issue is probably moot. When was the last 
time you tried to version control /dev? ;)

Andreas

On Tue, 3 May 2005, Junio C Hamano wrote:

> >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> 
> LT> On Tue, 3 May 2005, Andreas Gal wrote:
> 
> >> Yuck. Thats really ugly. Right now all files have a uniform
> >> touch to them.  For every hash you can locate the file,
> >> determine its type/tag, unpack it, and check the SHA1
> >> hash. The proposal above breaks all that. Why not just
> >> introduce a new object type "dev" and put major minor in
> >> there. It will still always hash to the same SHA1 hash value,
> >> but fits much better in the overall design.
> 
> LT> Hey, I don't personally care that much. I don't see anybody using 
> LT> character device nodes in the kernel tree, and I don't think most SCM's 
> LT> support stuff like that anyway ;)
> 
> LT> If you want to make it a blob (and have a use for it), go wild. 
> 
> Introducing "dev" type, as Andreas suggests, is wrong.  This
> this should be done in the same way as you suggested for the
> symlink case.  Store a blob object with those chrdev or blkdev
> modes whose contents are of form:
> 
>     major=14
>     minor=4
>     owner=root
>     group=audio
>     perm=0660
> 
> This would impact the diff side least, and for the cache side it
> does not matter in storing and merging.  checkout-cache still
> needs to know about this.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
