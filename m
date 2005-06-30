From: "lode leroy" <lode_leroy@hotmail.com>
Subject: how about this as a basis for git-annotate?
Date: Thu, 30 Jun 2005 14:20:45 +0200
Message-ID: <BAY22-F23ACB8E1D2F394F9318069FFE30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-From: git-owner@vger.kernel.org Thu Jun 30 14:14:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnxvM-0002cn-3O
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 14:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbVF3MUz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 08:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVF3MUz
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 08:20:55 -0400
Received: from bay22-f23.bay22.hotmail.com ([64.4.16.73]:31144 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262832AbVF3MUs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 08:20:48 -0400
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 30 Jun 2005 05:20:45 -0700
Received: from 194.7.240.10 by by22fd.bay22.hotmail.msn.com with HTTP;
	Thu, 30 Jun 2005 12:20:45 GMT
X-Originating-IP: [194.7.240.10]
X-Originating-Email: [lode_leroy@hotmail.com]
X-Sender: lode_leroy@hotmail.com
To: git@vger.kernel.org
X-OriginalArrivalTime: 30 Jun 2005 12:20:45.0741 (UTC) FILETIME=[24375DD0:01C57D6E]
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
