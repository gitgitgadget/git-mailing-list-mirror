From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] vcs-svn: rename check_overflow arguments for clarity
Date: Thu, 2 Feb 2012 04:59:23 -0600
Message-ID: <20120202105923.GJ3823@burratino>
References: <4F28378F.6080108@ramsay1.demon.co.uk>
 <20120131192053.GC12443@burratino>
 <7vipjpzxav.fsf@alter.siamese.dyndns.org>
 <20120202104128.GG3823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	David Barr <davidbarr@google.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 11:59:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsuOI-00080m-2r
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 11:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab2BBK7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 05:59:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57317 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754847Ab2BBK7l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 05:59:41 -0500
Received: by iacb35 with SMTP id b35so2982736iac.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 02:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eEDT9g0taxpXGLZfN42T67//2GZowPHOvd9pjfCjTwY=;
        b=qaagCoGmH4NO5liAy8fy9+rY62fC7Am63uJq5ivb02+y/h5EFj2ud7RP9oKvlJaqqK
         pHHEfqhNYQUxlNHDjJvE8xc8RTXCgzgRMnUAvkUYKk3xq7IV6gs0I3zkH8F3DwaO3iSu
         FkDHH5U1EimKPx7iM+z32AJ6S/nrUE0k9k6Dc=
Received: by 10.43.120.2 with SMTP id fw2mr2032335icc.37.1328180380908;
        Thu, 02 Feb 2012 02:59:40 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h9sm4310033ibh.11.2012.02.02.02.59.40
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 02:59:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120202104128.GG3823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189621>

From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Code using the argument names a and b just doesn't look right (not
sure why!).  Use more explicit names "offset" and "len" to make their
type and function clearer.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Split out from Ramsay's patch.

 vcs-svn/sliding_window.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index 1bac7a4c..fafa4a63 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -31,15 +31,15 @@ static int read_to_fill_or_whine(struct line_buffer *file,
 	return 0;
 }
 
-static int check_overflow(off_t a, size_t b)
+static int check_overflow(off_t offset, size_t len)
 {
-	if (b > maximum_signed_value_of_type(off_t))
+	if (len > maximum_signed_value_of_type(off_t))
 		return error("unrepresentable length in delta: "
-				"%"PRIuMAX" > OFF_MAX", (uintmax_t) b);
+				"%"PRIuMAX" > OFF_MAX", (uintmax_t) len);
-	if (signed_add_overflows(a, (off_t) b))
+	if (signed_add_overflows(offset, (off_t) len))
 		return error("unrepresentable offset in delta: "
 				"%"PRIuMAX" + %"PRIuMAX" > OFF_MAX",
-				(uintmax_t) a, (uintmax_t) b);
+				(uintmax_t) offset, (uintmax_t) len);
 	return 0;
 }
 
-- 
1.7.9
