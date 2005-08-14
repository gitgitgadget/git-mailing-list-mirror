From: Wolfgang Denk <wd@denx.de>
Subject: (cogito) Branch offf from older commit?
Date: Sun, 14 Aug 2005 17:50:05 +0200
Message-ID: <20050814155005.6492A353BBF@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Aug 14 17:50:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4KlF-000717-LN
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 17:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVHNPua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Aug 2005 11:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVHNPua
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Aug 2005 11:50:30 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:61111 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932554AbVHNPu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2005 11:50:29 -0400
Received: from fwd16.aul.t-online.de 
	by mailout04.sul.t-online.com with smtp 
	id 1E4Kkd-0003fz-00; Sun, 14 Aug 2005 17:50:19 +0200
Received: from denx.de (ZXbBZcZSoexHsNJcTm4CrBXE2AhXfTAG1-YUjaDCaDKWF1c9ZqOsUc@[84.150.64.121]) by fwd16.sul.t-online.de
	with esmtp id 1E4KkY-1yZ8YS0; Sun, 14 Aug 2005 17:50:14 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id DFB0842934
	for <git@vger.kernel.org>; Sun, 14 Aug 2005 17:50:08 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 6492A353BBF
	for <git@vger.kernel.org>; Sun, 14 Aug 2005 17:50:05 +0200 (MEST)
To: git@vger.kernel.org
X-ID: ZXbBZcZSoexHsNJcTm4CrBXE2AhXfTAG1-YUjaDCaDKWF1c9ZqOsUc@t-dialin.net
X-TOI-MSGID: bf17ba6d-8640-488d-8144-ca41baec3895
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Is there (in cogito) a way to  start  a  branch  off  from  an  older
commit?

Assume I receive a patch whichis based on an old version which I want
to test first (and resolve problems) in a separate branch.

This was what I tried:

* Clone main repo:
	-> cg-clone /git/u-boot u-boot-testing 
* Identify wanted branch point and seek to it:
	-> cd u-boot-testing
	-> cg-seek 024447b186cca55c2d803ab96b4c8f8674363b86
* Apply patch

Now how to proceed?

I can add  new  files  created  by  the  patch  using  "cg-add",  but
cg-status  says  "Changes recording BLOCKED: seeked from master", and
cg-commit says "committing blocked: seeked from master", too.

However, when I now seek back I get this:

	-> cg-seek
	Warning: uncommitted local changes, trying to bring them along

which then results in a couple of conflicts which are probably to  be
expected.



So I tried this (after throwing away and re-creating my cloned repo):

* Uncommit the commit following the one I want to keep:
	-> cg-admin-uncommit 342717f72a2f92a14b9c823546e5bcec244f8bf4
	-> cg-reset
* cg-status reports a couple of unknown files (those added later to
  the tree); I manually removed these
* Apply patch
* Check in modifications
* Clone another tree
	-> cg-clone /git/u-boot u-boot-test-merge
	-> cd u-boot-test-merge
* Create branch for the stuff to be tested
	-> cg-branch-add testing-NAND /work/u-boot-testing
* Pull and merge:
	-> cg-pull testing-NAND
	-> cg-merge testing-NAND


This works as intended, but seems to be a bit  circuitous  to  me;  I
think this is probably a pretty common situation and there might be a
simpler approach which I am missing?

[If possible I'd like to use cogito only, but if there  is  a  clever
way to do this using git-core commands I'm interested, too.]


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The price of curiosity is a terminal experience.
                         - Terry Pratchett, _The Dark Side of the Sun_
