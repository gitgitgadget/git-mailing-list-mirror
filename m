From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/4] Make unpack_trees() do separate source and destination indexes
Date: Thu, 6 Mar 2008 18:16:27 -0800
Message-ID: <cover.1204856187.git.torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 03:22:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXSDZ-0001Ql-Od
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 03:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760612AbYCGCVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 21:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759839AbYCGCVO
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 21:21:14 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52673 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759653AbYCGCVN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Mar 2008 21:21:13 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272LRM2010901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Mar 2008 18:21:28 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m272L3JD032699;
	Thu, 6 Mar 2008 18:21:04 -0800
X-Spam-Status: No, hits=-4.032 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76453>

Ok, this goes on top of the five-commit series yesterday.  The first two
patches are pure fixes and cleanups, the third one does a fairly
mechanical thing to get rid of implied usage of "the_index", and the
last one actually splits up the source and destination index handling.

Linus Torvalds (4):
  Fix tree-walking compare_entry() in the presense of --prefix
  Add 'const' where appropriate to index handling functions
  Make 'unpack_trees()' take the index to work on as an argument
  Make 'unpack_trees()' have a separate source and destination index

The nice thing to see is how this clearly removes more lines than it
adds, and the code is a bit more readable too, I think.

 builtin-checkout.c        |    9 +++
 builtin-commit.c          |    2 +
 builtin-merge-recursive.c |    2 +
 builtin-read-tree.c       |   23 +------
 cache.h                   |   10 ++--
 diff-lib.c                |   47 ++-----------
 hash.c                    |    6 +-
 hash.h                    |    4 +-
 read-cache.c              |   12 ++--
 tree-walk.c               |    3 +
 unpack-trees.c            |  158 ++++++++++++++++++++++-----------------------
 unpack-trees.h            |   15 +++--
 12 files changed, 128 insertions(+), 163 deletions(-)

