From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/24] wrapper.c: add a new function unlink_or_msg
Date: Wed, 1 Oct 2014 18:55:45 -0700
Message-ID: <20141002015545.GV1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 03:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVcW-0005NY-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 03:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbaJBBzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 21:55:49 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:64495 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbaJBBzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 21:55:48 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq14so1298384pab.12
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 18:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uuoZIvMyO7kchM3Rop1GfPZyRijxI6ErCjuwuOOaRg8=;
        b=fIfngbOlS6JKZEmeim8VbT61hnkfxpimzAX2i3zIkU5JwA0D6/8AzRo7rxSejGSY9+
         tTmmqHNkbsaEN4RXEXzOd+MPz7TF+kquXrZuqo6ADfP41lzy8OKfIGr7+HDF+IKSQQ49
         AOFsNA3gJJdWJ+7i/NzWMk+tBvmdmZje81Ne3P+E1R4nnkgfKjQU6GaDlsSmYHqvBNsy
         K6UTCm1UmnRXbk9ONdLtazPok7llYWgSVJ/i7MN1u3Mxhs/XCzXISYuFkLi11z3VwIJl
         NqJ/Zqrpezo6dzUN1upf0TL76I2LOvJUMYlKQeB3fCLFh7UFvBMR9Zb7f1ymgnRpgTjA
         4uhA==
X-Received: by 10.70.88.78 with SMTP id be14mr34573488pdb.152.1412214948278;
        Wed, 01 Oct 2014 18:55:48 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ri9sm2148486pbc.5.2014.10.01.18.55.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 18:55:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257774>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 16 Jul 2014 11:20:36 -0700

This behaves like unlink_or_warn except that on failure it writes the message
to its 'err' argument, which the caller can display in an appropriate way or
ignore.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
As before.

 git-compat-util.h |  9 +++++++++
 wrapper.c         | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 611e77b..5ee140c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -307,6 +307,8 @@ extern char *gitbasename(char *);
 
 #include "wildmatch.h"
 
+struct strbuf;
+
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list params);
 extern void vwritef(int fd, const char *prefix, const char *err, va_list params);
@@ -710,6 +712,13 @@ void git_qsort(void *base, size_t nmemb, size_t size,
  * not exist.
  */
 int unlink_or_warn(const char *path);
+ /*
+  * Tries to unlink file.  Returns 0 if unlink succeeded
+  * or the file already didn't exist.  Returns -1 and
+  * appends a message to err suitable for
+  * 'error("%s", err->buf)' on error.
+  */
+int unlink_or_msg(const char *file, struct strbuf *err);
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success which includes trying to remove a directory that does
diff --git a/wrapper.c b/wrapper.c
index c9605cd..ec7a08b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -438,6 +438,20 @@ static int warn_if_unremovable(const char *op, const char *file, int rc)
 	return rc;
 }
 
+int unlink_or_msg(const char *file, struct strbuf *err)
+{
+	int rc = unlink(file);
+
+	assert(err);
+
+	if (!rc || errno == ENOENT)
+		return 0;
+
+	strbuf_addf(err, "unable to unlink %s: %s",
+		    file, strerror(errno));
+	return -1;
+}
+
 int unlink_or_warn(const char *file)
 {
 	return warn_if_unremovable("unlink", file, unlink(file));
-- 
2.1.0.rc2.206.gedb03e5
