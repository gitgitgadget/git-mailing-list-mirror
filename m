From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Tue, 5 Sep 2006 00:56:52 +0200
Message-ID: <200609050056.52590.jnareb@gmail.com>
References: <200609050054.24279.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 05 00:58:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNOw-0007fJ-Jf
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 00:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWIDW6g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 18:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWIDW6f
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 18:58:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:12568 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751351AbWIDW6d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 18:58:33 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1112911nfa
        for <git@vger.kernel.org>; Mon, 04 Sep 2006 15:58:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WS3eXxTBj4wMOZc+Lsk6/LXYxb52/yH8lpofNz5HBna/aEXg6ET12yjbGAJHw95kFmMqxgWJDb3HKE1MaHomdULCK7rECBisTQZt/ebmsxMxlAuEAmOv+NNsHaTUTNxh+a17++n1qrYIFMT4nmpdr+KnAtPebwCR6O5DZilkzbc=
Received: by 10.49.43.2 with SMTP id v2mr7116834nfj;
        Mon, 04 Sep 2006 15:58:31 -0700 (PDT)
Received: from host-81-190-21-28.torun.mm.pl ( [81.190.21.28])
        by mx.gmail.com with ESMTP id l38sm10135925nfc.2006.09.04.15.58.31;
        Mon, 04 Sep 2006 15:58:31 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609050054.24279.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26447>

Use AC_FUNC_MMAP check to check if the `mmap' function exists and
works correctly.  (It only checks private fixed mapping of
already-mapped memory.)

Still it is better than having no mmap check at all.
Attention: uses implementation detail of AC_FUNC_MMAP!

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch sent earlier in other patch series and dropped,
as git uses private mapping, not private fixed. I think
that this check is better than no check at all...

 config.mak.in |    2 +-
 configure.ac  |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 2947560..2c8fd2c 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -37,6 +37,6 @@ NO_C99_FORMAT=@NO_C99_FORMAT@
 NO_STRCASESTR=@NO_STRCASESTR@
 NO_STRLCPY=@NO_STRLCPY@
 NO_SETENV=@NO_SETENV@
-#NO_MMAP=@NO_MMAP@
+NO_MMAP=@NO_MMAP@
 #NO_ICONV=@NO_ICONV@
 
diff --git a/configure.ac b/configure.ac
index fc5b813..799321e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -249,6 +249,13 @@ AC_CHECK_FUNC(setenv,
 AC_SUBST(NO_SETENV)
 #
 # Define NO_MMAP if you want to avoid mmap.
+AC_FUNC_MMAP
+if test $ac_cv_func_mmap_fixed_mapped != yes; then
+	NO_MMAP=YesPlease
+else
+	NO_MMAP=
+fi
+AC_SUBST(NO_MMAP)
 #
 # Define NO_ICONV if your libc does not properly support iconv.
 
-- 
1.4.1.1
