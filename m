From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH 10/12] Fix errcode have defined as int at MSVC
Date: Wed, 19 Aug 2009 23:52:45 +0800
Message-ID: <1250697167-5536-10-git-send-email-lznuaa@gmail.com>
References: <1250697167-5536-1-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-2-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-3-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-4-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-5-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-6-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-7-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-8-git-send-email-lznuaa@gmail.com>
 <1250697167-5536-9-git-send-email-lznuaa@gmail.com>
Cc: Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Aug 19 17:55:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdnVt-0002kq-Fa
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbZHSPzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbZHSPze
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:55:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:43473 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbZHSPze (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:55:34 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1311461rvb.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cJDsr0meVqdkiJMWQkuV8kR2UPavpD54hXGdmb8CzoI=;
        b=goGMGAi2zEkhRidsnhlKiQY6Vel+6cKGGP7p4YMnrrZgzNDYqrvMvDRqnb7fgylmmf
         0TZWJRYFTJMhIrz+PTcpsvU6qJe+HZNN5NVWJtd4L1hBVqc9czEGNXnUzyrTmJaWKTsU
         tHQ4BU2mi/aa9RSVQo764Qy0Z8tkCjJhHmag0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FEGvEd++IwcZgtyQ7sPxWXPTkf5w02d2fe7iQwgL63om7Srkt/FoxjuA498H+fEDyX
         u7GyJiwGpVUbnjZYIL7UZhcwU5+XOv0LB51M//CztBmkmXL1mvCAo9A2WLyDp5nLdkxn
         dEW5C/2VLXv8QgJlIAGmKK8q8e37pdHI2Wz3A=
Received: by 10.140.128.20 with SMTP id a20mr3560583rvd.149.1250697335807;
        Wed, 19 Aug 2009 08:55:35 -0700 (PDT)
Received: from localhost ([58.38.115.215])
        by mx.google.com with ESMTPS id b39sm1229503rvf.0.2009.08.19.08.55.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:55:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.msysgit.0
In-Reply-To: <1250697167-5536-9-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126560>

MSVC type define errcode as int.
regex.c use old style C function declare.
Change it C99 style

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 compat/regex/regex.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/compat/regex/regex.c b/compat/regex/regex.c
index 5ea0075..f94bed5 100644
--- a/compat/regex/regex.c
+++ b/compat/regex/regex.c
@@ -4852,11 +4852,8 @@ regexec (preg, string, nmatch, pmatch, eflags)
    from either regcomp or regexec.   We don't use PREG here.  */
 
 size_t
-regerror (errcode, preg, errbuf, errbuf_size)
-    int errcode;
-    const regex_t *preg;
-    char *errbuf;
-    size_t errbuf_size;
+regerror(int errcode, const regex_t *preg, 
+		 char *errbuf, size_t errbuf_size)
 {
   const char *msg;
   size_t msg_size;
-- 
1.6.4.msysgit.0
