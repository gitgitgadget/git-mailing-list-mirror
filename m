From: Johannes Sixt <j.sixt@viscovery.net>
Subject: --exec-path not always honored
Date: Tue, 17 Mar 2009 10:11:07 +0100
Message-ID: <49BF692B.9020002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 10:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjVLm-0002tB-0C
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 10:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293AbZCQJLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 05:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbZCQJLN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 05:11:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6389 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbZCQJLM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 05:11:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LjVKG-0003wa-C8
	for git@vger.kernel.org; Tue, 17 Mar 2009 10:11:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP id 039656C4
	for <git@vger.kernel.org>; Tue, 17 Mar 2009 10:11:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113445>

I noticed this failure if I run git from the build directory:

$ ./git --exec-path=. gc
usage: git pack-objects [{ -q | --progress | --all-progress }]
        [--max-pack-size=N] [--local] [--incremental]
        [--window=N] [--window-memory=N] [--depth=N]
        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset]
        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog]
        [--include-tag] [--keep-unreachable | --unpack-unreachable]
        --stdout | base-name < ref-or-object-list
error: failed to run repack

The reason is that the version of pack-objects that I have installed in
$prefix does not know the option --kept-pack-only, which ./git-repack
passes along. It doesn't matter whether I have $prefix in PATH or not.

But on the other hand:

$ ./git --exec-path=. repack -a -d
Counting objects: 104070, done.
Delta compression using 2 threads.
Compressing objects: 100% (26161/26161), done.
Writing objects: 100% (104070/104070), done.
Total 104070 (delta 76376), reused 104070 (delta 76376)

works just fine whereas without --exec-path it fails like git-gc above.

git-gc is a builtin. Should git setenv("GIT_EXEC_PATH") before it runs
other git commands?

-- Hannes
