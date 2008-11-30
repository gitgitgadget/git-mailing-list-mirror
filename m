From: dhruva <dhruvakm@gmail.com>
Subject: git build on msys fails (and fix)
Date: Sun, 30 Nov 2008 16:32:02 +0530
Message-ID: <e3f230850811300302y68992b9doe4897d97d513de3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 12:03:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6k5C-0007JY-ND
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 12:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbYK3LCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 06:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbYK3LCF
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 06:02:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:6948 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbYK3LCD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 06:02:03 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1993620rvb.1
        for <git@vger.kernel.org>; Sun, 30 Nov 2008 03:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=I04NE6NMNob8vdjkS8JSoQnh8QvTKvi1RBf1ueDRbjU=;
        b=Qu1uhmE/c7AJZlOPu9w3qEuN6KUhIZ0deRg5WIOe+RTuIioOj9rUYrJ4JPpWUawRdz
         zYD7BxvhJaNObO5J/OWiNmSfCVm+cvalF9ut7tiMgH/3ScGZD2eTj6ZrP6K0grI0NtFP
         R5fNf0ATD5U+TAR1lWdyI90OAg/MPRA/DR7Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=vd0bqYcSDXuz2rDZqrgoibxCdQ27apQ9sNQMk+JyoZuePG+wOpxDR8Es2SUmsCiuro
         RE91fYf40ttbkgOZbOip5MS1d0dTLqCxJGSxCmAeeMmJxfZGhlC8kwjem0PKjJiCwZ/W
         5kTN2spsNOGxvG1p1R9xTgT3dRrJswY6YFp+A=
Received: by 10.142.142.14 with SMTP id p14mr3287524wfd.202.1228042922663;
        Sun, 30 Nov 2008 03:02:02 -0800 (PST)
Received: by 10.142.110.21 with HTTP; Sun, 30 Nov 2008 03:02:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101970>

Hello,
 I build git on msys environment regularly. With the recent changes to
add cache preload facility (commit ID:
671c9b7e315db89081cc69f83a8f405e4aca37bc) brings in dependency on
pthreads. This is not available in the msys distribution which was
part of the git build distro. I installed libpthread for mingw to get
the related headers and libraries. I had to make some minor changes to
libpthread installation. I copied the 'setjmp.h' from my other mingw
installation and had to had edit it to remove some mingw specific
macros.

@:/e/users/dhruva/stub/repo/git/git
[520]$ diff -u /e/tools/gnu/include/setjmp.h /mingw/include/setjmp.h
--- /e/tools/gnu/include/setjmp.h       Sun Oct  5 04:01:15 2008
+++ /mingw/include/setjmp.h     Sun Nov 30 16:18:00 2008
@@ -36,7 +36,7 @@
  * The function provided by CRTDLL which appears to do the actual work
  * of setjmp.
  */
-_CRTIMP int __cdecl __MINGW_NOTHROW _setjmp (jmp_buf);
+int __cdecl _setjmp (jmp_buf);

 #define        setjmp(x)       _setjmp(x)

@@ -44,7 +44,7 @@
  * Return to the last setjmp call and act as if setjmp had returned
  * nVal (which had better be non-zero!).
  */
-_CRTIMP void __cdecl __MINGW_NOTHROW longjmp (jmp_buf, int)
__MINGW_ATTRIB_NORETURN;
+void __cdecl longjmp (jmp_buf, int);

 #ifdef __cplusplus
 }

Also,
 had to copy a pthread library with a dfferent name to the standard name:
$cp libpthreadGC2.a libpthread.a

The build went fine and am using the new binaries.

-dhruva

-- 
Contents reflect my personal views only!
