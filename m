From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: git-verify-tag script
Date: Sat, 25 Jun 2005 14:35:19 -0400
Message-ID: <20050625183519.GB10425@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jun 25 20:32:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmFSR-0000i5-Ju
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 20:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFYSio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 14:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVFYSib
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 14:38:31 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:56039 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261237AbVFYSfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 14:35:21 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DmFUu-0002pr-00; Sat, 25 Jun 2005 14:35:20 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here is a script to simplify validating the gpg signature created by
git-tag-script. Might be useful to add to the git tree so that people
don't have to search for the right post in the git mailinglist archives
when they want to validate a tag.

Jan

----
#!/bin/sh

GIT_DIR=${GIT_DIR:-.git}

tag=$1
[ -f "$GIT_DIR/refs/tags/$tag" ] && tag=$(cat "$GIT_DIR/refs/tags/$tag")

git-cat-file tag $tag > .tmp-vtag || exit 1
cat .tmp-vtag | sed '/-----BEGIN PGP/Q' | gpg --verify .tmp-vtag -
rm -f .tmp-vtag

