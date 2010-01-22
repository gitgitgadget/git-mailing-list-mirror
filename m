From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [Patch 0/5] make more commands built-in
Date: Fri, 22 Jan 2010 08:22:51 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001220804550.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 17:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYMIe-0003cC-8H
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 17:23:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855Ab0AVQXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 11:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990Ab0AVQXv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 11:23:51 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55254 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752861Ab0AVQXu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 11:23:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGMpxL016336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 22 Jan 2010 08:22:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0MGMpmO015004;
	Fri, 22 Jan 2010 08:22:51 -0800
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.948 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137757>


Ok, so since I was working on this yesterday, I decided to just continue 
until I was done with all the trivial files.

This series makes five more commands built-in: 'merge-index', 'mktag', 
'unpack-file', 'pack-redundant' and 'index-pack'. It further shrinks my 
git install footprint by about 20%:

	[torvalds@nehalem git]$ du -s /home/torvalds/libexec/git-core
	21424	/home/torvalds/libexec/git-core (before)
	16920	/home/torvalds/libexec/git-core (after)

and if we didn't default to having debug info enabled, it would look 
almost acceptable:

	[torvalds@nehalem git]$ du -s /home/torvalds/libexec/git-core
	5728	/home/torvalds/libexec/git-core (with "-g" removed)
	5108	/home/torvalds/libexec/git-core (with -Os and no debugging)

There still remains a few big git commands after this, but this takes care 
of most of the core ones. 

All of these patches are trivial, the only one that has _any_ changes 
apart from the obvious builtin conversion is 'pack-redundant' which 
required some of the pack creation interfaces to now take 'const' index 
pathnames etc.

But as you can see, it removes more lines than it adds, and considering 
that yesterday the 'du' reported ~40MB of disk space for the git install, 
the shrinking certainly matters (of course, I suspect most distros 
wouldn't ship with debug info, so for most people it's about a few MB 
rather than a few tens of MB, but still).

		Linus
---
Linus Torvalds (5):
  make "merge-index" a built-in
  make "mktag" a built-in
  make "git unpack-file" a built-in
  make "git pack-redundant" a built-in
  make "index-pack" a built-in

 Makefile                                     |   10 +++++-----
 index-pack.c => builtin-index-pack.c         |   16 +++++++---------
 merge-index.c => builtin-merge-index.c       |    7 ++-----
 mktag.c => builtin-mktag.c                   |    6 +-----
 builtin-pack-objects.c                       |    5 +++--
 pack-redundant.c => builtin-pack-redundant.c |    8 ++------
 unpack-file.c => builtin-unpack-file.c       |    5 +----
 builtin.h                                    |    5 +++++
 git.c                                        |    5 +++++
 pack-write.c                                 |    4 ++--
 pack.h                                       |    2 +-
 11 files changed, 34 insertions(+), 39 deletions(-)
 rename index-pack.c => builtin-index-pack.c (98%)
 rename merge-index.c => builtin-merge-index.c (94%)
 rename mktag.c => builtin-mktag.c (98%)
 rename pack-redundant.c => builtin-pack-redundant.c (99%)
 rename unpack-file.c => builtin-unpack-file.c (89%)
