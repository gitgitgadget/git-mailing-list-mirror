From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/7] Import David's SVN exporter
Date: Sun, 23 May 2010 23:40:25 +0200
Message-ID: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 23 23:39:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGItN-0004R9-2E
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 23:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271Ab0EWVjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 17:39:11 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:55476 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754973Ab0EWVjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 17:39:10 -0400
Received: by wwe15 with SMTP id 15so108108wwe.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 14:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=yI2plm8dtFqPrkIlksxPVJWCgDOK4Mjk5C4Q2JWuZyU=;
        b=Vl/d7wSqYSO8h3QePOp7cH+qr2gr154fU5ShurT7mlm7R19ovKr+t/prcAoiOI9/Ti
         M8+6IVsApSQe3+9RbylNQnfTM9wtwHbi24D/np14IuuKnrOfOj6nBjuX604wy3a6Y6Km
         u8xsv4csNyn+M0ccmkVb1qdaMKxE+5je+/dTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HmkUuA+3ndNzYC09Hy/1vasa3QrnS/kXBs2uuWTeD/DHhRW1Vge+aMuO5kqkAh7R4M
         XiNJG7nFYsWrTqhor4IHOcNysXD8eGeA03196Msbs0b6QhUG7yOj70xlx+KkimZJKBuK
         cQ6l0tiKbqQ+0oeiCzZCASJAUbXn0iX7YRzPI=
Received: by 10.216.86.10 with SMTP id v10mr2837267wee.183.1274650748139;
        Sun, 23 May 2010 14:39:08 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 13sm1619466ewy.9.2010.05.23.14.39.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 14:39:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147587>

Except for the first patch, this patch series attempts to include
David's exporter [1] into git.git. I've made some efforts to go
through every small detail in the code to clean and document it for
clarity. If the code is more-or-less ready for inclusion (perhaps into
'next'?), the plan is to continue developing the exporter on a
separate repository and pull changes into git.git. I haven't written a
Makefile rule for building this yet.

The first patch includes the skeleton remote helper I sent last time
with some minor changes, and is still a WIP (I'm especially unhappy
with the Makefile rule): I'll post another patch shortly. I've only
included it in this series to illustrate how I'll use David's
exporter.

[1]: http://github.com/artagnon/svn-dump-fast-export

-- Ram

Ramkumar Ramachandra (7):
  Add skeleton remote helper for SVN
  Add cpp macro implementation of treaps
  Add buffer pool library
  Add a memory pool library
  Add API for string-specific memory pool
  Add SVN revision parser and exporter
  Add handler for SVN dump

 Makefile              |    9 ++-
 remote-svn.c          |  201 +++++++++++++++++++++++++++++
 vcs-svn/fast_export.c |   61 +++++++++
 vcs-svn/fast_export.h |   17 +++
 vcs-svn/line_buffer.c |  115 +++++++++++++++++
 vcs-svn/line_buffer.h |   14 ++
 vcs-svn/obj_pool.h    |   61 +++++++++
 vcs-svn/repo_tree.c   |  333 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/repo_tree.h   |   31 +++++
 vcs-svn/string_pool.c |   84 +++++++++++++
 vcs-svn/string_pool.h |   11 ++
 vcs-svn/svnclient.c   |   20 +++
 vcs-svn/svnclient.h   |    7 +
 vcs-svn/svndump.c     |  277 ++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndump.h     |    7 +
 vcs-svn/trp.h         |  221 ++++++++++++++++++++++++++++++++
 16 files changed, 1468 insertions(+), 1 deletions(-)
 create mode 100644 remote-svn.c
 create mode 100644 vcs-svn/fast_export.c
 create mode 100644 vcs-svn/fast_export.h
 create mode 100644 vcs-svn/line_buffer.c
 create mode 100644 vcs-svn/line_buffer.h
 create mode 100644 vcs-svn/obj_pool.h
 create mode 100644 vcs-svn/repo_tree.c
 create mode 100644 vcs-svn/repo_tree.h
 create mode 100644 vcs-svn/string_pool.c
 create mode 100644 vcs-svn/string_pool.h
 create mode 100644 vcs-svn/svnclient.c
 create mode 100644 vcs-svn/svnclient.h
 create mode 100644 vcs-svn/svndump.c
 create mode 100644 vcs-svn/svndump.h
 create mode 100644 vcs-svn/trp.h
