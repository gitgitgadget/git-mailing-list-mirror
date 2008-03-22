From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCH 0/3] Teach builtin-clone to pack refs
Date: Sat, 22 Mar 2008 02:10:30 +0100
Message-ID: <200803220210.30957.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Mar 22 02:11:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcsH5-000502-7A
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 02:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbYCVBLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 21:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbYCVBLK
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 21:11:10 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34399 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbYCVBLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 21:11:09 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JY30070DXYJLH00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:11:07 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY3000P4XXJ8R30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:10:31 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY3001BVXXJJ930@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 22 Mar 2008 02:10:31 +0100 (CET)
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77780>

The following series builds on top of Barkalow's existing builtin-clone work, available in the "builtin-clone" branch at:
	git://iabervon.org/~barkalow/git.git

This patch series teaches builtin-clone to create packed refs. Creating packed refs directly in clone (instead of creating loose refs and have the next "git gc" (re)pack them), makes cloning considerably faster on repos with many refs. In a test repo with 11000 refs (1000 branches, 10000 tags) I get the following numbers (Core 2 Quad, 4GB RAM running Gentoo Linux):

- Current "next": ~24.8 seconds
- Barkalow's "builtin-clone" branch: 1.47 seconds
- "builtin-clone" plus this series: 0.31 seconds

Although most of the speedup from current "next" is achieved by the builtin-clone work, there is still a considerable additional improvement from writing all refs to a single file instead of writing one file per ref. I expect the performance improvement to be much bigger on platforms with slower filesystem (aka. Windows).

A side-effect of this series is that the cloned refs will not get reflog entries. I don't know how important these "clone: from $URL" entries are to people; I, for one, wouldn't miss them at all.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
