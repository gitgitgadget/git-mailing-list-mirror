From: Sam Vilain <sam@vilain.net>
Subject: Multi-headed branches (hydra? :)) for basic patch calculus
Date: Sun, 02 Apr 2006 16:07:32 +1200
Message-ID: <1143950852.21233.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 02 06:07:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPtsP-00072A-1D
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 06:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWDBEHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Apr 2006 23:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWDBEHm
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Apr 2006 23:07:42 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:45456 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750724AbWDBEHl
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 1 Apr 2006 23:07:41 -0500
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 4D4465EF4; Sun,  2 Apr 2006 16:07:38 +1200 (NZST)
Received: from localhost.localdomain (longdrop.watts.utsl.gen.nz [192.168.255.49])
	by watts.utsl.gen.nz (Postfix) with ESMTP id 659E0104A
	for <git@vger.kernel.org>; Sun,  2 Apr 2006 16:07:33 +1200 (NZST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.4.1 
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18258>

>From a discussion on #git, the idea was raised of "multi-headed
branches"

Say you've got a sequence of changes like this:

1. add foo.c
2. add bar.c
3. modify foo.c
4. modify bar.c

The darcs-like operation of this would be to have two sequences of
ordered patches that combine to a final result.  ie:

  1 -> 3
  2 -> 4

Unless you jump through hoops, git will represent it as:

  1 -> 2 -> 3 -> 4.

However, you *could* represent it as:

  1 -> 3  \
           >- head
  2 -> 4  /

Where "head" is a merge commit that just combines the trees of 3 and 4.

If somebody adds a commit (5) that changes "foo.c" again, the darcs
history would change to:

  1 -> 3 -> 5
  2 -> 4

To represent this in git you could just roll back the head merge commit,
push commit 5 on that branch, then make a new head:

  1 -> 3 -> 5 \
               >- head
  2 -> 4 -----/

However, if there was support for "hydra", or heads that are multiple
commit IDs (and necessarily, no blobs in corresponding paths in their
trees that are not identical), then you would not need to destroy and
recreate this dummy merge head commit to model your patch history in
this manner.

If the plumbing or a porcelain could be smart enough to automatically
create hydra when patches are not dependent, then many of the benefits
of patch calculus might come for free, without having to create these
complicated sounding entities manually.

Of course this doesn't give you the symbolic labelling of patches that
can allow darcs to detect already applied, but "mutated" patches, but
that might not matter in practice.

Sam.
