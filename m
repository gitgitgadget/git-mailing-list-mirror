From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and symlinks as tracked content
Date: Tue, 03 May 2005 14:30:16 -0700
Message-ID: <7vr7got2tz.fsf@assigned-by-dhcp.cox.net>
References: <1115145234.21105.111.camel@localhost.localdomain>
	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
	<Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
	<Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Gal <gal@uci.edu>, Kay Sievers <kay.sievers@vrfy.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 23:25:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT4sI-0003T1-Lm
	for gcvg-git@gmane.org; Tue, 03 May 2005 23:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVECVa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 17:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVECVa1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 17:30:27 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:54967 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261757AbVECVaT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 17:30:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503213016.NIGY23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 17:30:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 3 May 2005 13:05:36 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Tue, 3 May 2005, Andreas Gal wrote:

>> Yuck. Thats really ugly. Right now all files have a uniform
>> touch to them.  For every hash you can locate the file,
>> determine its type/tag, unpack it, and check the SHA1
>> hash. The proposal above breaks all that. Why not just
>> introduce a new object type "dev" and put major minor in
>> there. It will still always hash to the same SHA1 hash value,
>> but fits much better in the overall design.

LT> Hey, I don't personally care that much. I don't see anybody using 
LT> character device nodes in the kernel tree, and I don't think most SCM's 
LT> support stuff like that anyway ;)

LT> If you want to make it a blob (and have a use for it), go wild. 

Introducing "dev" type, as Andreas suggests, is wrong.  This
this should be done in the same way as you suggested for the
symlink case.  Store a blob object with those chrdev or blkdev
modes whose contents are of form:

    major=14
    minor=4
    owner=root
    group=audio
    perm=0660

This would impact the diff side least, and for the cache side it
does not matter in storing and merging.  checkout-cache still
needs to know about this.

