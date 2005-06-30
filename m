From: "lode leroy" <lode_leroy@hotmail.com>
Subject: how about this as a basis for git-annotate?
Date: Thu, 30 Jun 2005 15:55:32 +0200
Message-ID: <BAY22-F40C3079B41F242AEB407E1FFE30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-From: git-owner@vger.kernel.org Thu Jun 30 15:50:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnzOz-0000Ba-3o
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 15:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbVF3Nzp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 09:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVF3Nzp
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 09:55:45 -0400
Received: from bay22-f40.bay22.hotmail.com ([64.4.16.90]:41758 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262818AbVF3Nzg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 09:55:36 -0400
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 30 Jun 2005 06:55:32 -0700
Received: from 194.7.240.10 by by22fd.bay22.hotmail.msn.com with HTTP;
	Thu, 30 Jun 2005 13:55:32 GMT
X-Originating-IP: [194.7.240.10]
X-Originating-Email: [lode_leroy@hotmail.com]
X-Sender: lode_leroy@hotmail.com
To: git@vger.kernel.org
X-OriginalArrivalTime: 30 Jun 2005 13:55:32.0608 (UTC) FILETIME=[61DA6800:01C57D7B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

#!/bin/bash

file="$1"
anno="$file.anno"
prev=""
export GIT_DIFF_OPTS=-u0

rm $anno
touch $anno

revs=`git-rev-list HEAD | tac`

for rev in $revs; do
	if [ ! -z "$prev" ]; then
		git-diff-tree -p $prev $rev $file \
		| sed 	-e "/^--- /p" \
			-e "/^+++ /p" \
			-e "/^--- /d" \
			-e "/^+++ /d" \
			-e "s/^-/-$prev /g" \
			-e "s/^+/+$rev /g" | patch $anno
	fi
	prev=$rev
done



* gives a warning when the diff is empty
* has a problem with "\ No newline at end of file"

What I tried to do is to reconstruct the file from the diffs,
and prefixing each line with the sha1 of the revision.

After further testing, I see that the implementation I provided does not 
work,
because the context is not necessarily from the previous version, but from 
/a/ previous version.
Still the idea should work.
So patch needs to ignore the sha1 of the revision.
Maybe git-apply can be modified to do this...?
