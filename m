From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: fatal error when merging a rename
Date: Mon, 20 Apr 2009 17:36:29 +0200 (CEST)
Message-ID: <57090.bFoQE3daRhY=.1240241789.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 17:38:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvvZR-0006O7-1C
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 17:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbZDTPgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 11:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755244AbZDTPgf
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 11:36:35 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:60897 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934AbZDTPge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 11:36:34 -0400
Received: from webmail.hotelhot.dk (web.hotelhot.dk [192.168.0.170])
	by mail.hotelhot.dk (Postfix) with ESMTP id 4EF8F44D8
	for <git@vger.kernel.org>; Mon, 20 Apr 2009 17:36:29 +0200 (CEST)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: bFoQE3daRhY=
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116999>

The talk of merge corner cases made me remember this issue:

http://thread.gmane.org/gmane.comp.version-control.git/100859/focus=100956


The merge in the script below fails with this message:

fatal: git write-tree failed to write a tree

which is fixed by the (unapplied) patch from Alex in the thread above, but
the worktree is still not updated even with that patch.


Cheers,
Anders.



#!/bin/bash

GIT=$(which git)

cd $(mktemp -d am-merge-fail.XXXXXXX)
$GIT init

mkdir before
yes | head -n100 >before/100
touch after
$GIT add before/100 after
$GIT commit -minitial

$GIT branch parallel

$GIT rm before/100 after
mkdir after
yes | head -n99 >after/99
$GIT add after/99
$GIT commit -mmove

$GIT checkout parallel
echo "Just to cause a non-ff" >other
$GIT add other
$GIT commit -mparallel

$GIT merge master
