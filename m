From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/16] compat: add mempcpy()
Date: Wed, 17 Mar 2010 07:16:23 -0500
Message-ID: <20100317121623.GL25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:16:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrsAR-0003Ye-BC
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab0CQMQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 08:16:00 -0400
Received: from mail-pz0-f200.google.com ([209.85.222.200]:36833 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754710Ab0CQMP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:15:59 -0400
Received: by pzk38 with SMTP id 38so686201pzk.33
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=V4+G4xS4rpCelsVnGkjjAemhNna4oEbHTHI4v3VW8mI=;
        b=lG7EgtXBBaPhc/O3sHGS0TzI0WfH2ES9FOAa4Rq0ywzmsk0BMkwPqMLr3sBz0J4fkX
         ZUDkq18dhBPQUqaKr71l05Pn5sbnFNt6IWnc+viYxRkWaAFPsjnF9tb1Gy7EylMQFtkG
         s4/Ub3UQoHesbJyiEZWENN5mRnXuOLr7zgM+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WJ5URAwcoX9TVt7XOeH5a+sX1NIFaBdP0kEyBD2nq/3/SJzRy1GdJZiwVUH04XjOzX
         zyhi1Fgtxt6QTmBhAQU59mFjrX4uY0DWLxCnyY8ST0twRexT3tGDBd9QFzXzGB59GARz
         +sJuE2gef9Yy9Pvt+S2hJAOkQ/8182Lp8itUw=
Received: by 10.142.208.16 with SMTP id f16mr354855wfg.158.1268828158756;
        Wed, 17 Mar 2010 05:15:58 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm630725iwn.4.2010.03.17.05.15.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:15:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142387>

The mempcpy() function was added in glibc 2.1.  It is quite handy, so
add an implementation for cross-platform use.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
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
1.7.0
