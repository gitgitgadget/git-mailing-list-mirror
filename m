From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: rev-list --parents --full-history + path: something's fishy
Date: Sat, 24 May 2008 22:16:54 +0200
Message-ID: <1211660214.483877b69a107@webmail.nextra.at>
References: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: David Tweed <david.tweed@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 22:25:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K00Io-0004dN-91
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 22:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114AbYEXUYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 16:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbYEXUYY
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 16:24:24 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:48242 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbYEXUYX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 16:24:23 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 May 2008 16:24:23 EDT
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id EF72633BB7;
	Sat, 24 May 2008 22:16:54 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m4OKGsmW019494;
	Sat, 24 May 2008 22:16:54 +0200
Received: from 77.117.246.247 ([77.117.246.247]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Sat, 24 May 2008 22:16:54 +0200
In-Reply-To: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.117.246.247
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82826>

This script creates this history:

    C--M
   /  /
  A--B

Commits A and B modify file a.

git init
echo a > a
git add a
git commit -m A
echo 1 > a
git commit -m B -a
git checkout -b side master~1
echo b > b
git add b
git commit -m C
git merge master

At this point, this command returns the expected output (SHA1s rewritten to
A,B,C,M as above):

$ git rev-list --full-history HEAD -- a
B
A

but this does not:

$ git rev-list --full-history --parents HEAD -- a
M A B
B A
A

Of course, I'd expected to see this:

$ git rev-list --full-history --parents HEAD -- a
B A
A

Just as a heads-up, I've also seen a case (in David's repository) where a

git rev-list --full-history --parents --reverse HEAD -- some/path

incorrectly prints a commit somewhere in the middle *without* a parent where it
definitely should have printed a parent. I don't have a repeatable small
test-case, yet.

-- Hannes
