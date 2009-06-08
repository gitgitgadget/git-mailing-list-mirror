From: Marco Nelissen <marcone@xs4all.nl>
Subject: [PATCH] fix handling of iconv configuration options
Date: Sun, 7 Jun 2009 17:45:48 -0700
Message-ID: <3a3d9e520906071745k1fde4215xba310d945db37979@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 08 02:48:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDT2h-0006p6-D8
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 02:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbZFHAps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 20:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbZFHApr
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 20:45:47 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:28049 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbZFHApq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 20:45:46 -0400
Received: by an-out-0708.google.com with SMTP id d40so5302813and.1
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 17:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=FoL5eW034GentjGHGobMHKyH/lGeNtxLeVa6KtvfacQ=;
        b=LToQabu+NlCtGvAl7ftdCL6+htFy/6vjU2pQ376mCbq0agH6QMUoEo0Y6K+nCvIdx6
         mloCP8WZKSUKbNlw3NCIxOwcKwIAuqu8amhqobIahSI4UIHvgCW+hpCSe7Kt3E6IYYMe
         xHppmaWyo7IKkjvjMnm7t8gvo6EzxIR5xnGfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=sMOztrZ41Y3VZOIt64kcLSu4s6fpb2NB9DJJRThdGP3Hk7wYxoYwuODSRf+o0YVmTL
         IhLwBZasbQv42wcXp2MAbTzxi4jovObkWuIDdZay7G+2P4FqQ1Qgk0RJO8UfQQQlLUGp
         OthzV+DaTMb2lcAO7e5UsfbOh7fxemjt+pAgQ=
Received: by 10.100.12.17 with SMTP id 17mr5600039anl.2.1244421948235; Sun, 07 
	Jun 2009 17:45:48 -0700 (PDT)
X-Google-Sender-Auth: ff9aca5219317e86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121025>

Fix the way in which the configure script handles --without-iconv
(and --with-iconv=no), which it  used to essentially ignore.
Also fix the way the configure script determines the value of
NEEDS_LIBICONV, which would be incorrectly set to 'YesPlease' on
systems that lack iconv entirely.

Signed-off-by: Marco Nelissen <marcone@xs4all.nl>
---

Since configure.ac uses a mix of 2, 3 and 4 space indentation and tabs, I
wasn't quite sure what to do with regard to that. I decided to keep the
number of lines changed to a minimum, rather than changing indentation
for a bunch of lines.

 configure.ac |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 108a97f..3388036 100644
--- a/configure.ac
+++ b/configure.ac
@@ -385,6 +385,8 @@ AC_SUBST(NO_EXPAT)
 # some Solaris installations).
 # Define NO_ICONV if neither libc nor libiconv support iconv.

+if test -z $NO_ICONV; then
+
 GIT_STASH_FLAGS($ICONVDIR)

 AC_DEFUN([ICONVTEST_SRC], [
@@ -431,6 +433,12 @@ GIT_UNSTASH_FLAGS($ICONVDIR)
 AC_SUBST(NEEDS_LIBICONV)
 AC_SUBST(NO_ICONV)

+if test -n $NO_ICONV; then
+    NEEDS_LIBICONV=
+fi
+
+fi
+
 #
 # Define NO_DEFLATE_BOUND if deflateBound is missing from zlib.

-- 
1.6.3.1
