From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 13:28:04 +0200
Message-ID: <4A8A9044.9030405@gmail.com>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com> <7vtz05idn0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 13:28:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdMrW-00070z-N0
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 13:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758632AbZHRL2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 07:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758258AbZHRL2O
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 07:28:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:54438 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbZHRL2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 07:28:13 -0400
Received: by fg-out-1718.google.com with SMTP id e21so844148fga.17
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=MVHHf0NHyUxLK94AiyFcNwasIcEBwxutjatRn/nJkRw=;
        b=wp6nic8e3ydePHzDTIxw7IY8aMYa7jOT5KP3hHYM/zOyGdiGrUNN2uoK+83UDuUnEq
         ke11z2BXjg6Wo5r/1UC7ubDl52/5d2quTnTd75RU1+DX5LabSyC+2FMm/5/zLdDy1L91
         NtNJktDYQd0I4FfO0airEsS06h1FWWNAc8hR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=UEM/fT7a+sXPwsByY6n8FZzHBHNMsWe4OcFTjSFlAZ0ApB+vynhY7ghi+GDrbo24EV
         TJIqPTG/qkRC4iM5dejmwCM8jgF1v0TNgiE7h2Tjlevok9zZCoP7byrPAC8/7MNKIeTw
         BHz/WktCRzVYh9Mt/4JGu6B5RZol0kiyIhoHU=
Received: by 10.86.251.40 with SMTP id y40mr3152088fgh.57.1250594893822;
        Tue, 18 Aug 2009 04:28:13 -0700 (PDT)
Received: from ?192.168.1.19? (91-67-62-226-dynip.superkabel.de [91.67.62.226])
        by mx.google.com with ESMTPS id d6sm4624462fga.24.2009.08.18.04.28.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Aug 2009 04:28:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <7vtz05idn0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126375>

On 18.08.2009 13:07, Junio C Hamano wrote:

> Your proposed commit log message makes it sound as if this change is
> limited to Windows, but it is not protected with "#ifdef WIN32"; the
> change should be applicable to non-windows but the message is misleading.

True, the change should apply for x86, no matter what the OS. I wanted to express that *on Windows* I know ntohl()/htonl() are function that do shifts internally. Maybe on some other OS  these have better implementations (for x86).

> It seems that your patch is linewrapped, so please be careful _if_ it
> needs to be modified and resent (if this version gets trivially acked I
> can fix it up when applying and in such a case there is no need to
> resend).

Here's an updated version of the patch that both improves the commit message and fixes the line wrap.

 From b4f40f73e8bf410c975b3f29d10ca779343e3095 Mon Sep 17 00:00:00 2001
From: Sebastian Schuberth <sschuberth@gmail.com>
Date: Tue, 18 Aug 2009 12:33:35 +0200
Subject: [PATCH] block-sha1: On x86, use bswap built-in in favor of ntohl()/htonl()

On x86 and compatible, use the native bswap instruction in favor of ntohl()/
htonl(). In the best case, this gets rid of function calls to crappy
implementations, in the worst case, it should be no slower than sane (inlined)
implementations. The current code depends on GCC already, so relying on
__builtin_bswap32() to be available should be safe.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
  block-sha1/sha1.c |   15 ++++++++++-----
  1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index f2830c0..07f2937 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -66,15 +66,20 @@
  
  /*
   * Performance might be improved if the CPU architecture is OK with
- * unaligned 32-bit loads and a fast ntohl() is available.
+ * unaligned 32-bit loads and a fast ntohl() is available. On Intel,
+ * use the bswap built-in to get rid of the function call overhead.
   * Otherwise fall back to byte loads and shifts which is portable,
   * and is faster on architectures with memory alignment issues.
   */
  
-#if defined(__i386__) || defined(__x86_64__) || \
-    defined(__ppc__) || defined(__ppc64__) || \
-    defined(__powerpc__) || defined(__powerpc64__) || \
-    defined(__s390__) || defined(__s390x__)
+#if defined(__i386__) || defined(__x86_64__)
+
+#define get_be32(p)	__builtin_bswap32(*(unsigned int *)(p))
+#define put_be32(p, v)	do { *(unsigned int *)(p) = __builtin_bswap32(v); } while (0)
+
+#elif defined(__ppc__) || defined(__ppc64__) || \
+      defined(__powerpc__) || defined(__powerpc64__) || \
+      defined(__s390__) || defined(__s390x__)
  
  #define get_be32(p)	ntohl(*(unsigned int *)(p))
  #define put_be32(p, v)	do { *(unsigned int *)(p) = htonl(v); } while (0)
-- 
1.6.4.169.g64d5.dirty
