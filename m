From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/14] compat: add mempcpy()
Date: Sat, 20 Mar 2010 19:43:32 -0500
Message-ID: <20100321004332.GF23888@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:42:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt9FV-0002EI-Lc
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162Ab0CUAmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 20:42:33 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:64665 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab0CUAmd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:42:33 -0400
Received: by yxe12 with SMTP id 12so1197717yxe.33
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vKgW0ywxTYtYBt0vpJiOretXX4K5GdL1ExXTVwKCVgI=;
        b=KYzDGR0lpmmZJAuJhmzjI0KJbQA516+KOga9+MWP9sIstrU3seZ4J2FZWxEkHjITui
         WF/07QQPN8bL2BpB0QbinpF5qr6LCvGC44BxI5IP1jcER3hecUffxBr1lWuDNDTxM+HN
         oVbo5eH8zAKL4vff/OpoW6nBuHlC2J+3jzep0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=H23AuVRaXOlFnjA2OFjAZdneJ+XDYZxf8PnD/1nl3Hn9ACMtDGe8XrtegdXgEF6Xwm
         VUz1MExoxpBV5TJd9vjc9RvLaT0ISEiZCaEGLIYSxPxWfFsdPikeeoodgt4YZY2jlA4d
         8L2vyj4rWSCMuAK7bnmeo9c/winDXC7PSRvtQ=
Received: by 10.101.132.10 with SMTP id j10mr11921370ann.145.1269132152405;
        Sat, 20 Mar 2010 17:42:32 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1301074iwn.12.2010.03.20.17.42.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:42:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142779>

The mempcpy() function was added in glibc 2.1.  It is quite handy, so
add an implementation for cross-platform use.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
From <http://thread.gmane.org/gmane.comp.version-control.git/142374/focus=142387>.

 git-compat-util.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index a3c4537..9bed5a0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -331,6 +331,7 @@ extern int git_vsnprintf(char *str, size_t maxsize,
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
+#define HAVE_MEMPCPY
 #endif
 #endif
 
@@ -344,6 +345,14 @@ static inline char *gitstrchrnul(const char *s, int c)
 }
 #endif
 
+#ifndef HAVE_MEMPCPY
+#define mempcpy gitmempcpy
+static inline void *gitmempcpy(void *dest, const void *src, size_t n)
+{
+	return (char *)memcpy(dest, src, n) + n;
+}
+#endif
+
 extern void release_pack_memory(size_t, int);
 
 extern char *xstrdup(const char *str);
-- 
1.7.0.2
