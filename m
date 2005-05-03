From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and symlinks as tracked content
Date: Tue, 03 May 2005 16:42:48 -0700
Message-ID: <7vhdhjswp3.fsf@assigned-by-dhcp.cox.net>
References: <1115145234.21105.111.camel@localhost.localdomain>
	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
	<Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
	<Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org>
	<7vr7got2tz.fsf@assigned-by-dhcp.cox.net> <42780185.7010204@zytor.com>
	<7v1x8nuchr.fsf@assigned-by-dhcp.cox.net> <427806CA.6030302@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Gal <gal@uci.edu>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 01:37:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6wK-0002eu-Bx
	for gcvg-git@gmane.org; Wed, 04 May 2005 01:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVECXmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbVECXmx
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:42:53 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:6891 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261922AbVECXmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 19:42:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503234248.VAAP16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 19:42:48 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <427806CA.6030302@zytor.com> (H. Peter Anvin's message of "Tue,
 03 May 2005 16:18:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "HPA" == H Peter Anvin <hpa@zytor.com> writes:
HPA> Junio C Hamano wrote:

HPA> Owner and permissions are part of the tree object, and apply to
HPA> all file types.

>> Huh?  I am confused...  Do you mean tree object should be
>> changed to record these?  That would make the existing in-cache
>> merging of files, which GIT was built for, quite interesting...

HPA> No, the tree object *ALREADY* records these.

As you quoted (and before I uttered my previous confusion I did
look at the code in write-tree.c which I thought to match this
description) ...

HPA> TREE: The next hierarchical object type is the "tree" object.  A tree
HPA> object is a list of permission/name/blob data, sorted by name.  In other
HPA> words the tree object is uniquely determined by the set contents, and so
HPA> two separate but identical trees will always share the exact same
HPA> object.

... it records permission (but not in the 0660 vs 0600 sense ---
it just records executable bit for file blobs and the treeness
by recording S_IFDIR), name and SHA1.  There is no owner or
group information recorded there [*1*].

I am afraid I am missing something in my reading of write-tree.c

Quite confused...

[Footnote]

*1* Nor there should be.  Otherwise comparing two identical
trees representing the same set of files become meaningless.

The reason why I placed these information in my hypothetical
representation of device nodes is exactly that.  To record owner
and group information is meaningless and harmful for the purpose
of version controlling the source files but it matters _if_ we
wanted to maintain device nodes in GIT.  Since it matters only
for those things, it would be preferable to have it as part of
the data that describes the object (i.e. device nodes), not part
of the data that contains the object (i.e. tree).  And I thought
GIT tree object is already doing the right thing by not
recording them.


