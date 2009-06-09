From: Marco Nelissen <marcone@xs4all.nl>
Subject: [PATCH] fix handling of iconv configuration options
Date: Mon, 8 Jun 2009 20:46:38 -0700
Message-ID: <3a3d9e520906082046g648ac0fah1d72c0c4fd4335ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 09 05:46:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDsIU-00052I-62
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 05:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbZFIDqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 23:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbZFIDqg
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 23:46:36 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:1572 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZFIDqg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 23:46:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so6591738and.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 20:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=sGaa5jpA4zB+yrler9ikbmhyF31Bt/MNM326PD6QvZ4=;
        b=pXNQKtGqwH9t4Dj4/pVKfAOQ+eS6FzQPJjsrCU/ijlCAMN1vAOSWUH6ClLiSnEOs6H
         MNbvOar6v2bJjNA3vaBh97xKLbs2jiuRQ+WHC6+9Ds8e/5Mq6oXg7PyukKeHPF+Q6cSj
         o/2W18lpVCVYVsVw42dQ305Mun5Fr9lJc/I5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=HUkZzywUQjGHNew+TN5FTd9Ol++WjBWNmBMnwZGkS6vKIMA/MZzixzIPTovSPeatzL
         NZLrE5Ry27NOMsJE0rgZfOqPcHTlxun9EEbvtbEgZ94Rqd4J4+80S5cm9XYiYL7qMxfU
         DbKfdpjFXfFAMZhXWiZs7/mQSfFVp0Hjwd8/0=
Received: by 10.100.14.2 with SMTP id 2mr946254ann.68.1244519198122; Mon, 08 
	Jun 2009 20:46:38 -0700 (PDT)
X-Google-Sender-Auth: e12326bbc8b179c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121136>

Fix the way in which the configure script handles --without-iconv
(and --with-iconv=no), which it  used to essentially ignore.
Also fix the way the configure script determines the value of
NEEDS_LIBICONV, which would be incorrectly set to 'YesPlease' on
systems that lack iconv entirely.

Signed-off-by: Marco Nelissen <marcone@xs4all.nl>
---

Take two: use doublequotes in test

 configure.ac |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 108a97f..bd00eba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -385,6 +385,8 @@ AC_SUBST(NO_EXPAT)
 # some Solaris installations).
 # Define NO_ICONV if neither libc nor libiconv support iconv.

+if test -z "$NO_ICONV"; then
+
 GIT_STASH_FLAGS($ICONVDIR)

 AC_DEFUN([ICONVTEST_SRC], [
@@ -431,6 +433,12 @@ GIT_UNSTASH_FLAGS($ICONVDIR)
 AC_SUBST(NEEDS_LIBICONV)
 AC_SUBST(NO_ICONV)

+if test -n "$NO_ICONV"; then
+    NEEDS_LIBICONV=
+fi
+
+fi
+
 #
 # Define NO_DEFLATE_BOUND if deflateBound is missing from zlib.

-- 
1.6.3.1
