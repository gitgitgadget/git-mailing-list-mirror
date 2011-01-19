From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH v2 0/5] Towards a Git-to-SVN bridge
Date: Wed, 19 Jan 2011 11:14:54 +0530
Message-ID: <1295415899-1192-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 19 06:44:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfQqC-0001Ii-33
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 06:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab1ASFoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 00:44:14 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52990 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab1ASFoN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 00:44:13 -0500
Received: by gwj20 with SMTP id 20so126197gwj.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 21:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=FNGcD3aaQxqYXv/KfygFTLfNWj97EhxBZS2FuQPvGk4=;
        b=lVDd1x3Nh7RTs+nbuIX1v5a3o0a0Bw9MFn6p34DLXYRK8Gr0We9SazX2EkYI6iU13U
         1tLkgzkP21q7ZwWNMRJoo7TJSofCcABEaRw5DIGBo3olzUOO1SH540oVtOCytWj1kAJw
         7jAbmaScQLXTdfvzqRlBcJQLAROm09hhZd2cQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Y6Va3w8dOmlXuPmFOZSOTrMOh2Zx5dr2SAwDPiUIfxRtFJItViDXSJ3wfwQLEbb0Jh
         61sPXdvFg21rHohMCnVEiYTPxYcyqMU4JPczLViBf3OfDlqILB4tg9swABRXMrfMXObh
         CLCjS1vmVEgkkWMVAsSzM6n74lk4m/9NSch6o=
Received: by 10.90.87.9 with SMTP id k9mr387710agb.150.1295415852630;
        Tue, 18 Jan 2011 21:44:12 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d15sm7968646ana.35.2011.01.18.21.44.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Jan 2011 21:44:10 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165237>

Hi,

There are two major changes this time around:
1. I've managed to inline the blobs in the fast-export stream. This
completely eliminates the need for persisting blobs.
2. I've also managed to produce relevant directory nodes, keeping
directory state in a new dir_cache interface. I followed Jonathan's
suggestion to keep it as a string_list for the moment. This is highly
inefficient and should improve soon- perhaps ressurect the treap we
had? Or perhaps find a simple trie implementation somewhere?
Suggestions are welcome.

Unfortunately, I've still not had the time to clean up- there's a
probably a lot of cruft, and everything "just works" for now. Next
time, I'll also try to write some tests, so we don't have to test it
by hand.

Thanks for reading.

Ramkumar Ramachandra (5):
  date: Expose the time_to_tm function
  vcs-svn: Start working on the dumpfile producer
  Build an svn-fi target in contrib/svn-fe
  fast-export: Introduce --inline-blobs
  vcs-svn: Add dir_cache for svnload

 Documentation/git-fast-export.txt |    5 +
 Makefile                          |    4 +-
 builtin/fast-export.c             |   23 +++-
 cache.h                           |    1 +
 contrib/svn-fe/Makefile           |   23 +++-
 contrib/svn-fe/svn-fi.c           |   16 ++
 contrib/svn-fe/svn-fi.txt         |   28 ++++
 date.c                            |    2 +-
 vcs-svn/dir_cache.c               |   40 +++++
 vcs-svn/dir_cache.h               |   12 ++
 vcs-svn/dump_export.c             |  141 ++++++++++++++++++
 vcs-svn/dump_export.h             |   33 +++++
 vcs-svn/svnload.c                 |  286 +++++++++++++++++++++++++++++++++++++
 vcs-svn/svnload.h                 |   10 ++
 14 files changed, 617 insertions(+), 7 deletions(-)
 create mode 100644 contrib/svn-fe/svn-fi.c
 create mode 100644 contrib/svn-fe/svn-fi.txt
 create mode 100644 vcs-svn/dir_cache.c
 create mode 100644 vcs-svn/dir_cache.h
 create mode 100644 vcs-svn/dump_export.c
 create mode 100644 vcs-svn/dump_export.h
 create mode 100644 vcs-svn/svnload.c
 create mode 100644 vcs-svn/svnload.h

-- 
1.7.4.rc1.7.g2cf08.dirty
