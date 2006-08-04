From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] autoconf: Double check for IPv6 support
Date: Fri, 4 Aug 2006 23:30:56 +0200
Message-ID: <200608042330.57413.jnareb@gmail.com>
References: <200608042333.19011.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Aug 04 23:41:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G97PP-0005gS-NV
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 23:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161500AbWHDVki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 17:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWHDVkh
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 17:40:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:14256 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161498AbWHDVkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 17:40:35 -0400
Received: by nf-out-0910.google.com with SMTP id k26so30462nfc
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 14:40:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PWbSBvack5mqmHJ/8UwpGpf4p6009I+feXIi1JRu/OkFjc1XnCNGxB6+9KclEhe37pb3NWWRZ0rnX0TsyOcbv9XW8Ntgue6z6OX9Ea66UswtKg92en8q75kn/hSO/BvaByG5y3DLcqWlHghwrQlI6yo3ZVTIqQnuYkw8zzoXCLU=
Received: by 10.48.48.18 with SMTP id v18mr6012191nfv;
        Fri, 04 Aug 2006 14:40:34 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id r34sm1038674nfc.2006.08.04.14.40.33;
        Fri, 04 Aug 2006 14:40:34 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608042333.19011.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24842>

Check for IPv6 support, first by checking if "struct addrinfo" exists,
then by checking if there is getaddrinfo() in standard libraries.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index a49bd1f..6557bd2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -204,6 +204,13 @@ AC_CHECK_TYPE(struct sockaddr_storage,[]
 [GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE=YesPlease)],
 [#include <netinet/in.h>])
 #
+# Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
+AC_CHECK_TYPE(struct addrinfo,[],
+[GIT_CONF_APPEND_LINE(NO_IPV6=YesPlease)],
+[#include <sys/types.h>
+#include <sys/socket.h>
+#include <netdb.h>])
+#
 # Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
 # do not support the 'size specifiers' introduced by C99, namely ll, hh,
 # j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).
@@ -242,14 +249,16 @@ # Define NO_SETENV if you don't have set
 AC_CHECK_FUNC(setenv,[],
 [GIT_CONF_APPEND_LINE(NO_SETENV=YesPlease)])
 #
+# Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
+AC_CHECK_FUNC(getaddrinfo,[],
+[GIT_CONF_APPEND_LINE(NO_IPV6=YesPlease)])
+#
 # Define NO_MMAP if you want to avoid mmap.
 AC_FUNC_MMAP
 if test $ac_cv_func_mmap_fixed_mapped != yes; then
 	GIT_CONF_APPEND_LINE(NO_MMAP=YesPlease)
 fi
 #
-# Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
-#
 # Define NO_ICONV if your libc does not properly support iconv.
 
 
-- 
1.4.1.1
