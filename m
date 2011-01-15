From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC PATCH 0/3] Towards a Git-to-SVN bridge
Date: Sat, 15 Jan 2011 12:21:09 +0530
Message-ID: <1295074272-19559-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 15 07:51:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdzyT-0006Ei-Q7
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 07:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873Ab1AOGuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jan 2011 01:50:35 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56481 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab1AOGue (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jan 2011 01:50:34 -0500
Received: by iwn9 with SMTP id 9so3205802iwn.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 22:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=C+Mrq8xmq1TCmhRKcA6EYl4xPXvsyLlKI+LTommITEU=;
        b=b75uBHw75jjR53ug5biiBFmzZX1bSqursVaSkaiNICrWomr8FJ64q00qxdMhCEDB9M
         wIUtSvHB6vMH53rxpDrBivZ0CBvl0pDTABXfuSWQgIfb4Xwbk/e9YekIfogAFVhBxPTA
         rMvl3ZO2qVflKxDbp7LvSlQTtIoGZDzQPmMEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=n5IsyJA8SI+4EoO00oRtI9cxYuzn0sTTSO90+5v6XU3nOBYBLkpFJAZAUbW5B93VSM
         yN3XPWIQ03yvaO9sa9kdDbrvxz2VDgJBofXLeMXq5J9wQBQYPnTaF/4HmHIhtpNU3Nyf
         RJg3IK7ZE4efbNQCxKSvPdWTMhhlV45cXPisY=
Received: by 10.42.213.200 with SMTP id gx8mr1803962icb.362.1295074232943;
        Fri, 14 Jan 2011 22:50:32 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id k38sm1484334ick.9.2011.01.14.22.50.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 22:50:32 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165138>

Hi,

Over the last couple of days, I've been working on a parser that
converts a fast-import stream into a SVN dumpfile. So far, it's very
rough and works minimally for some common fast-import
commands. However, the major roadblock is persisting blobs: in this
implementation, they're persisted as an array of strbufs. This is very
memory-intensive and not scalable at all. With some valuable insight
from Jonathan on IRC, I've decided to try re-implementing fast-export
to eliminate blob marks and produce them inline instead [1].

Comments are much appreciated.

[1]: http://colabti.org/irclogger/irclogger_log/git-devel?date=2011-01-14

Ramkumar Ramachandra (3):
  date: Expose the time_to_tm function
  vcs-svn: Start working on the dumpfile producer
  Build an svn-fi target in contrib/svn-fe

 Makefile                  |    2 +-
 cache.h                   |    1 +
 contrib/svn-fe/Makefile   |   23 ++++-
 contrib/svn-fe/svn-fi.c   |   16 +++
 contrib/svn-fe/svn-fi.txt |   28 +++++
 date.c                    |    2 +-
 vcs-svn/dump_export.c     |   73 +++++++++++
 vcs-svn/svnload.c         |  294 +++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 435 insertions(+), 4 deletions(-)
 create mode 100644 contrib/svn-fe/svn-fi.c
 create mode 100644 contrib/svn-fe/svn-fi.txt
 create mode 100644 vcs-svn/dump_export.c
 create mode 100644 vcs-svn/svnload.c

-- 
1.7.4.rc1.7.g2cf08.dirty
