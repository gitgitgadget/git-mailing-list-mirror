From: Darrin Thompson <darrint@progeny.com>
Subject: Some Commit Messages Scare git-rev-list
Date: Wed, 12 Apr 2006 09:11:02 -0400
Message-ID: <1144847462.5213.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 12 15:11:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTf7v-00060G-AG
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 15:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWDLNLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 09:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWDLNLE
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 09:11:04 -0400
Received: from zealot.progeny.com ([216.37.46.162]:37047 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S932185AbWDLNLC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Apr 2006 09:11:02 -0400
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP id 6AD3D636A4
	for <git@vger.kernel.org>; Wed, 12 Apr 2006 08:10:58 -0500 (EST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18630>

This scripts exhibits some odd behavior. Apparently git-rev-list
mishandles commit messages which do not end in a newline. This as best I
can tell this is a problem introduced since 1.1.5.

Here is a script to reproduce the problem:

rm -rf git-test
mkdir git-test
cd git-test
git-init-db
echo hello > hello
git-add hello

# send scary message to git-commit -F -
echo -n "test commit" | git-commit -F - -a
echo world > world
git-add world
git-update-index --add world
treeid=$(git-write-tree)

# send scary message directly to git-commit-tree
commitid=$(echo -n "another-test" | git-commit-tree $treeid -p HEAD)
git-update-ref HEAD $commitid

# see the wreckage
git-rev-list --pretty HEAD

Running gitk will also show the problem.

--
Darrin
