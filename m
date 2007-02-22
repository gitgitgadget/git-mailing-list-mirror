From: Pavel Roskin <proski@gnu.org>
Subject: RFC: script to add another remote
Date: Thu, 22 Feb 2007 17:16:35 -0500
Message-ID: <1172182595.20817.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 22 23:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKMEz-0004aM-AE
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 23:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbXBVWQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 17:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbXBVWQi
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 17:16:38 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:59636 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbXBVWQh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 17:16:37 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HKMDS-00012Z-UK
	for git@vger.kernel.org; Thu, 22 Feb 2007 17:15:06 -0500
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HKMEt-0001yQ-KN
	for git@vger.kernel.org; Thu, 22 Feb 2007 17:16:35 -0500
X-Mailer: Evolution 2.9.91 (2.9.91-3.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40398>

Hello!

I'm trying to find the best way to add a new remote to an existing
repository, create a local branch for it and make it easy to switch to
that branch and back and to update all branches.

This is important because some Linux developers want to publish their
branches without having to serve the whole Linux repository, which is
about 175Mb even if packed with repack.usedeltabaseoffset=true.

I have written a simple script "git-clone-more" to help users who want
to track more than one remote:


#!/bin/sh
set -e
if test $# -lt 2 || test $# -gt 4; then
	echo "Usage: git-clone-more URL REMOTE [BRANCH [REMBRANCH]]" >&2
	exit 1
fi
URL=$1
REMOTE=$2
BRANCH=${3-$REMOTE}
REMBRANCH=${4-master}
git-remote add "$REMOTE" "$URL"
git-fetch "$REMOTE"
git-config branch."$BRANCH".remote "$REMOTE"
git-config branch."$BRANCH".merge refs/heads/"$REMBRANCH"
git-checkout -b "$BRANCH" remotes/"$REMOTE"/"$REMBRANCH"


If there is any easier way to do the same thing?  Maybe we could extend
one of the git commands or make the above script another git command?

It's interesting that git-clone-more can be used instead of git-clone.
I can use it e.g. to check out git in an empty directory:

git-init
git-clone-more git://www.kernel.org/pub/scm/git/git.git git

-- 
Regards,
Pavel Roskin
