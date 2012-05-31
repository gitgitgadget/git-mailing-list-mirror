From: David Barr <davidbarr@google.com>
Subject: [PATCH v2 3/6] vcs-svn: prefer constcmp to prefixcmp
Date: Fri,  1 Jun 2012 00:41:27 +1000
Message-ID: <1338475290-22644-4-git-send-email-davidbarr@google.com>
References: <1338475290-22644-1-git-send-email-davidbarr@google.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 16:42:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa6a9-0003gL-Mg
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 16:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403Ab2EaOm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 10:42:26 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40687 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932389Ab2EaOmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 10:42:25 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so1378013dad.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=q2lZe1X2hMZReFZryybwxfBif0Br5vFYtzAqw0Qnj8g=;
        b=V3IEPHn479N3mCVh5ILukqd9zUPoLBDHVl16wOjh9ewV49hcazjA1FGzTmSPL562XW
         hnqpRmkQ9TEcN4YplGfu2OGTFxIwWcfb33CDXCtRJh2VHTNV/75PiDczIzHNUlGOxlew
         TbZg7JpVwHJKZXxFB5F0ZdtVEWrV6Heq1ZP9T9uwwlQ13ruHE++I/UmUbDuS8iZV1dfp
         CWMfIuB/Q/RXKTy8MgR2fTBayEwIc+OY3OUZ+WlTAnfp9l2z5YAHgCxCMVVTjumPDl8/
         O9+MzaJP0DgW6tFe0INcfO6ekbB/W8O7rh8R6EH2GqhqzSV8mWv0ZYCf1lUagm6xkJ8R
         BjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=q2lZe1X2hMZReFZryybwxfBif0Br5vFYtzAqw0Qnj8g=;
        b=ZclNK2yP9asqv5KGfrr9KnCVPY5ncj86hxjs/5ufqhrk9f4I+I3lYOB4eh1g7+ie67
         CuXaCU/L5ywC1stY7ncBepJQqKuCu3jNPGDupNI8dS8PCSDZz4/osHnuhIexIkHwPyiK
         kVciRkUss9jucrnL6czVlDBQZncY9cQrrBtU9oLGYl4v2Wqt0LNDTYABp/66VMo6UlAy
         L0pLw83HT4duwA1HWh0nwyYgpkkoVqCOX0Du34xlGyRmgrtLR9QnN4HCfzbCNB+MOFBx
         E2letZ3inMb9BuD1nuAYl/Kh3V5eXLSvmJtpGi5BGiQpIeLHchJUV2UY1V97S1McFEzY
         qhiA==
Received: by 10.68.228.200 with SMTP id sk8mr360543pbc.94.1338475344836;
        Thu, 31 May 2012 07:42:24 -0700 (PDT)
Received: by 10.68.228.200 with SMTP id sk8mr360530pbc.94.1338475344729;
        Thu, 31 May 2012 07:42:24 -0700 (PDT)
Received: from localhost.localdomain (c122-107-58-35.blktn5.nsw.optusnet.com.au. [122.107.58.35])
        by mx.google.com with ESMTPS id og6sm4376720pbb.42.2012.05.31.07.42.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 07:42:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2
In-Reply-To: <1338475290-22644-1-git-send-email-davidbarr@google.com>
X-Gm-Message-State: ALoCoQmOmRrmkj8FmT+EUw8FpYVdHW93D2MML1UWJGiyFSJ+tnxkb7MhuXw59XmdANSVVALrg6HqETrS0DB7Q8krwvXIyhe1eOtXisyE2vtaLmr00MtClKEyt4e6zb68I/1sMFuGLFhcjopGhu6zQyfMST2eiz6+VIWsjySPVi0RuxGyYK6PSps=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198912>

Comparisons in svndump.c are always guarded by length.
As a bonus, elimate dependency on prefixcmp for upstream.

Signed-off-by: David Barr <davidbarr@google.com>
---
 vcs-svn/svndump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 0899790..8d0ae9c 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -361,7 +361,7 @@ void svndump_read(const char *url)
 			reset_rev_ctx(atoi(val));
 			break;
 		case sizeof("Node-path"):
-			if (prefixcmp(t, "Node-"))
+			if (constcmp(t, "Node-"))
 				continue;
 			if (!constcmp(t + strlen("Node-"), "path")) {
 				if (active_ctx == NODE_CTX)
-- 
1.7.10.2
