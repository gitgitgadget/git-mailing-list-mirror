From: Johannes Sixt <j.sixt@viscovery.net>
Subject: git-push: forced update of tag shows unabbreviated SHA1
Date: Thu, 31 Jan 2008 10:27:43 +0100
Message-ID: <47A1948F.6080308@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 10:28:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKVis-0000r0-Qv
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 10:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbYAaJ1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 04:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbYAaJ1t
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 04:27:49 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:35497 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754404AbYAaJ1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 04:27:48 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JKVhg-0003Al-MA; Thu, 31 Jan 2008 10:27:29 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8FC846B7; Thu, 31 Jan 2008 10:27:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72113>

This is just a cosmetical flaw:

When a tag is changed to point to a new commit, then the tag is pushed to
a repo that still has the old tag, it is correctly pushed, but the old
SHA1 is reported with all 40 digits:

# make upstream repo
$ mkdir A && cd A
$ git init
$ echo a > a; git add a; git commit -m a

# clone, modify, push
$ cd ..
$ git clone A B
$ cd B
$ echo b > a; git commit -a -m b
$ git push file://$PWD/../A

# tag old state in upstream
$ cd ../A
$ git tag -m T T HEAD~1

# tag new state in clone (same name) and force-push tag
$ cd ../B
$ git tag -m Tclone T
$ git push -f file://$PWD/../A refs/tags/*:refs/tags/*
Counting objects: 1, done.
Unpacking objects: 100% (1/1), done.
Writing objects: 100% (1/1), 160 bytes, done.
Total 1 (delta 0), reused 0 (delta 0)
To file:///home/jsixt/tmp/foo/B/../A
 + 639669ce44f84417f30842c622064827dda01461...475e55f T -> T (forced update)

Notice that the original SHA1 is not abbreviated.

-- Hannes
