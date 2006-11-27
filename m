X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Bruno Haible <bruno@clisp.org>
Subject: git: how to produce context diffs?
Date: Mon, 27 Nov 2006 15:16:30 +0100
Message-ID: <200611271516.30425.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 14:20:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-OriginalArrivalTime: 27 Nov 2006 14:20:08.0282 (UTC) FILETIME=[2429A3A0:01C7122F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32414>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GohKw-0005SV-Gt for gcvg-git@gmane.org; Mon, 27 Nov
 2006 15:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758238AbWK0OTz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 09:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758243AbWK0OTz
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 09:19:55 -0500
Received: from ftp.ilog.fr ([81.80.162.195]:38841 "EHLO ftp.ilog.fr") by
 vger.kernel.org with ESMTP id S1758238AbWK0OTy (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 09:19:54 -0500
Received: from laposte.ilog.fr (cerbere-qfe0 [81.80.162.193]) by ftp.ilog.fr
 (8.13.1/8.13.1) with ESMTP id kAREJndr029498; Mon, 27 Nov 2006 15:19:49 +0100
Received: from marbore.ilog.biz (marbore.ilog.biz [172.17.2.61]) by
 laposte.ilog.fr (8.13.1/8.13.1) with ESMTP id kAREJiUg024868; Mon, 27 Nov
 2006 15:19:44 +0100
Received: from honolulu.ilog.fr ([172.16.15.37]) by marbore.ilog.biz with
 Microsoft SMTPSVC(6.0.3790.1830); Mon, 27 Nov 2006 15:20:08 +0100
Received: by honolulu.ilog.fr (Postfix, from userid 1001) id 916F33F420; Mon,
 27 Nov 2006 15:16:30 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

Is this a bug in git-diff? The git-diff-files.html says:

  " When the environment variable GIT_EXTERNAL_DIFF is not set ...
    For example, if you prefer context diff:
    GIT_DIFF_OPTS=-c git-diff-index -p HEAD  "

This doesn't work for me with git-1.4.4:

$ unset GIT_EXTERNAL_DIFF
$ export GIT_DIFF_OPTS=-c
$ git-diff-index -p HEAD
diff --git a/configure.ac b/configure.ac
index 74901dc..d222ded 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,5 +1,5 @@
 dnl Process this file with autoconf to produce a configure script.
-AC_INIT(hello, 2.1.1, bug-gnu-hello@gnu.org)
+AC_INIT(hello, 2.1.2, bug-gnu-hello@gnu.org)
 AC_CONFIG_SRCDIR([src/hello.c])
 
 AC_PREREQ(2.52)

Expected output:

$ git-diff-index -p HEAD
index 74901dc..d222ded 100644
diff --git a/configure.ac b/configure.ac
*** a/configure.ac
--- b/configure.ac
***************
*** 1,5 ****
  dnl Process this file with autoconf to produce a configure script.
! AC_INIT(hello, 2.1.1, bug-gnu-hello@gnu.org)
  AC_CONFIG_SRCDIR([src/hello.c])
  
  AC_PREREQ(2.52)
--- 1,5 ----
  dnl Process this file with autoconf to produce a configure script.
! AC_INIT(hello, 2.1.2, bug-gnu-hello@gnu.org)
  AC_CONFIG_SRCDIR([src/hello.c])
  
  AC_PREREQ(2.52)


(Really, while I find -u diffs fine for tiny changes, I find them unreadable
for rewrites of larger blocks, and cannot live without -c for these.)

When I look at diff.c around
       const char *diffopts = getenv("GIT_DIFF_OPTS");
it appears that only unified diffs are supported??

