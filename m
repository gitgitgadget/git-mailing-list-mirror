From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH 2/2] http-backend: Let gcc check the format of more printf-type functions.
Date: Sat, 14 Nov 2009 13:10:58 -0800
Message-ID: <1258233058-2348-2-git-send-email-tarmigan+git@gmail.com>
References: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com>
Cc: Tarmigan Casebolt <tarmigan+git@gmail.com>
To: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 22:14:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Px8-0003ic-9d
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 22:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbZKNVO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 16:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZKNVO2
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 16:14:28 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:54835 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbZKNVO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 16:14:28 -0500
Received: by pzk1 with SMTP id 1so2006469pzk.33
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 13:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=poNP+9rG8zIqb+H1WLCXqP8zqkO9p99nm2sjysVdWSE=;
        b=BBlunKvOpmHBi1hdzZmGO/xAOLZmf1vQW1yb616mZf45yfOVyUu8uBAEh/qOWoKav/
         klQJ4El2IpU+szFVWxU8cga9wLDcy6/5g23NMmYSFMgjrcN+VE3YWxYhu/QDWOJYTMzu
         uT8yz7LP8dPEz63PJLD8sRfUZlTvznXi9mnEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=RZgVznxoTkSr4s7kSW3Mjd/M8CaqzPN+xPUVuRJNszAuVQuTq4f1/cFMf6GEdDK3mr
         LMPp4e5u9kAKCmbNFo0XNSwVr3Z+r4aggxfeQ52oQwMvMaoi8yNrPeQIBedtA3/2UZkj
         0jwOQyR0D9sL/wmr/jijuGLGRUjrcMmy/LhCA=
Received: by 10.114.236.28 with SMTP id j28mr3972934wah.162.1258233273790;
        Sat, 14 Nov 2009 13:14:33 -0800 (PST)
Received: from localhost.localdomain (host-98-127-69-228.bln-mt.client.bresnan.net [98.127.69.228])
        by mx.google.com with ESMTPS id 21sm283716pzk.7.2009.11.14.13.14.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 13:14:33 -0800 (PST)
X-Mailer: git-send-email 1.6.5.52.g4544ce0
In-Reply-To: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132887>

We already have these checks in many printf-type functions that have
prototypes which are in header files.  Add these same checks to
static functions in http-backend.c

Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---

Shawn, please consider this patch in addition to the one that you posted 
that actually fixes the bug.  With this patch, gcc will warn about that bug.

 http-backend.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index ab9433d..110b166 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -108,6 +108,7 @@ static const char *get_parameter(const char *name)
 	return i ? i->util : NULL;
 }
 
+__attribute__((format (printf, 2, 3)))
 static void format_write(int fd, const char *fmt, ...)
 {
 	static char buffer[1024];
@@ -165,6 +166,7 @@ static void end_headers(void)
 	safe_write(1, "\r\n", 2);
 }
 
+__attribute__((format (printf, 1, 2)))
 static NORETURN void not_found(const char *err, ...)
 {
 	va_list params;
@@ -180,6 +182,7 @@ static NORETURN void not_found(const char *err, ...)
 	exit(0);
 }
 
+__attribute__((format (printf, 1, 2)))
 static NORETURN void forbidden(const char *err, ...)
 {
 	va_list params;
-- 
1.6.5.51.g191f5
