From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick command reference
Date: Sun, 01 May 2005 12:27:23 -0700
Message-ID: <7v4qdmu4pw.fsf@assigned-by-dhcp.cox.net>
References: <17012.53862.704670.858276@cargo.ozlabs.ibm.com>
	<4274EB3D.2060602@dgreaves.com> <4274F373.6030001@khandalf.com>
	<4274FB3F.8090206@dgreaves.com>
	<Pine.LNX.4.58.0505010927040.2296@ppc970.osdl.org>
	<42750D06.70004@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 21:21:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSK0e-0007mw-Vn
	for gcvg-git@gmane.org; Sun, 01 May 2005 21:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVEAT1g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 15:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVEAT1g
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 15:27:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:32457 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262649AbVEAT10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 15:27:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501192725.RXFV19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 15:27:25 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <42750D06.70004@dgreaves.com> (David Greaves's message of "Sun,
 01 May 2005 18:08:22 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

After I sent my endorsements, I noticed some nits so I pick them
here.  As you already know, you would also need to adjust to the
big git-* renaming.

DG> 	[Eventually may be replaced with <tree> if <tree> means
DG> 	<tree/commit> in all commands]

Probably not.  I think commit-tree should insist on its first
parameter being a tree not a commit for example, so I would drop
this comment.

Also tags are included in tree/commit class for some but
probably not all commands these days.  How about coming up with
a short-and-sweet name like <tree-id> and use it instead of
<tree/commit>?  You would need <commit-id> as well because tags
can be auto-dereferenced to commits by certain commands.

DG> <type>
DG> 	Indicates that an object type is required.
DG> 	Currently one of: blob/tree/commit

That's:

	Currently one of: blob/commit/tag/tree

DG> <file>
DG> 	Indicates a filename - often includes leading path
DG> <path>
DG> 	Indicates the path of a file (is this ever useful?)

I do not know what you wanted to distinguish by having separate
<file> and <path>.  There is only one thing.

We may want to mention that Core GIT expects the commands to run
from the directory that corresponds to the root level of the
tree structure GIT_INDEX_FILE describes, and the path/file
(whichever name you pick) are expected to be relative to that
directory.  No absolute paths, no ./relative paths with leading
dot-slash.

DG> ################################################################
DG> cat-file
DG> 	cat-file (-t | <type>) <object>
DG> ...
DG> <type>
DG> 	One of: blob/tree/commit
DG> ...
DG> Output
DG> If -t is specified, one of:
DG>         blob/tree/commit

Let's not list the type but refer the reader to the top part of
the document that lists the type.

DG> ################################################################
DG> checkout-cache
DG> ... Note that the file contents are
DG> restored - NOT the file permissions.
DG> ??? l 58 checkout-cache.c says restore executable bit.

So which is correct?

DG> ################################################################
DG> diff-tree-helper
DG> 	diff-tree-helper [-z]

Update:
	diff-tree-helper [-z] [-R]

Add:
        -R	generate the patch in reverse.

DG> ################################################################
DG> fsck-cache
DG> 	fsck-cache [[--unreachable] <commit>*]

--root?

DG> ################################################################
DG> show-diff
DG> 	show-diff [-p] [-q] [-s] [-z] [paths...]

After big git-* rename this became git-diff-files; just to keep
an eye on when you do the updates.

DG> ################################################################
DG> show-files

And this one is now git-ls-files.

DG> ################################################################
DG> unpack-file
DG> 	unpack-file <blob>

Add:

    Note that the temporary file is created with mkstemp(3) and it
    would have permission 0600 or 0666 depending on your glibc
    version.  Make sure to fix the permission if you use this in
    your script.

DG> ################################################################
DG> Generating patches

Please drop the following part.  GIT_DIFF_CMD is not supported
anymore:

DG>    The first part of the above command-line can be customized via
DG>    the environment variable GIT_DIFF_CMD...
DG>    ... 
DG>    Caution:  Do not use more than two '%s' in GIT_DIFF_CMD.

Drop it also from "git Environment Variables" section.

