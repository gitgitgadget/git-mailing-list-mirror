From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 14:01:23 -0700
Message-ID: <1398718883-5630-1-git-send-email-dborowitz@google.com>
Cc: kusmabite@gmail.com, gitster@pobox.com,
	Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 23:02:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wesgu-0000MW-D7
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 23:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826AbaD1VCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 17:02:16 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62944 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbaD1VCP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 17:02:15 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so6224093pab.41
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 14:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=P70hjk+iXIrv4H697VKW69rxfyl+2qfI8px0IYY2Cy0=;
        b=EyyHV/gBJP5h4ZWpluiXKq4tC51XuN5gkahRT+/Jtz76KvuQspLZdH6dByfj5TuLkg
         OItSHZp+Jjh8RQw7Pl9rSn6yOmt2l/vU4FSOre6hgVYkdi3Dd8P978DpxD9YGzOL8Nz+
         fFrVe4Q3HpR9oK6mAVUqQztzmGUof2loT2JEUvJZcI1vCxvSPgG0WGvnhzpz4c77haMb
         IPFwsRLtXyYJfyeFonlJoyYhHVShu8A7pmP2qCUxP9qeUcjjgvvDvtZHWJgbN3hYYZtt
         5di237kvRmLAbnKHo+kK2KEHDcqhk0Q16tBgB47Nc8ROJ4Nl7HK/OiWc0SrwvDuqBRpI
         ZHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P70hjk+iXIrv4H697VKW69rxfyl+2qfI8px0IYY2Cy0=;
        b=fiK/Ebu2dz0OM/9/qBYj2ANxWTp1Ip/v9Zn3SmJk9t5kOXs+mmCJ3VB1Jr3xEjE3FZ
         pD4xMxMRjTqDxQx1B2sm1Qh0LwOF8Dm2oKFGv+0DfAytNjjE4H1wcKRwuVfu7gydFqAE
         jgufsIP+MWrL5vpJLEhF2XJP9vBbjPm9bbtbLyxUIt7/IFWj48DvuFLwp0uTsfZ9ndre
         qty1FDLM6vAgyzzSXMFc1jX30HZ0sfBCUO/iyl1C9tm1B12kjC/WHd9pRWjtAe1B/A0k
         0GiNZUiCGMkCXvhaEeZx7n/NAE/BeKArqiqKgBMfh/7BieboYXbc08SX1ItUgv2e3xb2
         SZIA==
X-Gm-Message-State: ALoCoQkvTYQcfgpOMysyKbXfJFoI9zRSaexFl/0Q54CRCgVLfHB4gO6o7+px1lS8hfYuEWw8HXytSeg4p2PIx5ohdOh7liJIgy86Qe+b2VS8D1wVlTS5PX8J9FkWoATzKbMYu2w300lJsnJFyYbL5x3JSWQuXT415Uo9u8D0DJY7DkkQ1JApxUZbqUwgiQJeGvAyR2Rn7s+HA0So8JX90sdBcGqGZyp951ouh+nwIfT2BdAAo9c7HkU=
X-Received: by 10.68.159.228 with SMTP id xf4mr31380538pbb.74.1398718935204;
        Mon, 28 Apr 2014 14:02:15 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id ry10sm97183127pab.38.2014.04.28.14.02.12
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 14:02:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247451>

The original implementation of CURL_CONFIG support did not match the
original behavior of using -lcurl when CURLDIR was not set. This broke
implementations that were lacking curl-config but did have libcurl
installed along system libraries, such as MSysGit. In other words, the
assumption that curl-config is always installed was incorrect.

Instead, if CURL_CONFIG is empty or returns an empty result (e.g. due
to curl-config being missing), use the old behavior of falling back to
-lcurl.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Makefile | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 74a929b..81e8214 100644
--- a/Makefile
+++ b/Makefile
@@ -35,14 +35,17 @@ all::
 # transports (neither smart nor dumb).
 #
 # Define CURL_CONFIG to the path to a curl-config binary other than the
-# default 'curl-config'.
+# default 'curl-config'.  If CURL_CONFIG is unset or points to a binary that
+# is not found, defaults to the CURLDIR behavior.
 #
 # Define CURL_STATIC to statically link libcurl.  Only applies if
 # CURL_CONFIG is used.
 #
 # Define CURLDIR=/foo/bar if your curl header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.  This overrides CURL_CONFIG,
-# but is less robust.
+# /foo/bar/include and /foo/bar/lib directories.  This overrides
+# CURL_CONFIG, but is less robust.  If not set, and CURL_CONFIG is not set,
+# uses -lcurl with no additional library detection (other than
+# NEEDS_*_WITH_CURL).
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports (dumb).
@@ -1127,9 +1130,27 @@ ifdef NO_CURL
 	REMOTE_CURL_NAMES =
 else
 	ifdef CURLDIR
-		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
-		BASIC_CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
+		CURL_LIBCURL =
+	else
+		CURL_CONFIG = curl-config
+		ifeq "$(CURL_CONFIG)" ""
+			CURL_LIBCURL =
+		else
+			CURL_LIBCURL := $(shell $(CURL_CONFIG) --libs)
+		endif
+	endif
+
+	ifeq "$(CURL_LIBCURL)" ""
+		ifdef CURL_STATIC
+$(error "CURL_STATIC must be used with CURL_CONFIG")
+		endif
+		ifdef CURLDIR
+			# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
+			BASIC_CFLAGS += -I$(CURLDIR)/include
+			CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
+		else
+			CURL_LIBCURL = -lcurl
+		endif
 		ifdef NEEDS_SSL_WITH_CURL
 			CURL_LIBCURL += -lssl
 			ifdef NEEDS_CRYPTO_WITH_SSL
@@ -1140,17 +1161,11 @@ else
 			CURL_LIBCURL += -lidn
 		endif
 	else
-		CURL_CONFIG ?= curl-config
 		BASIC_CFLAGS += $(shell $(CURL_CONFIG) --cflags)
 		ifdef CURL_STATIC
 			CURL_LIBCURL = $(shell $(CURL_CONFIG) --static-libs)
 			ifeq "$(CURL_LIBCURL)" ""
-				$(error libcurl not detected or not compiled with static support)
-			endif
-		else
-			CURL_LIBCURL = $(shell $(CURL_CONFIG) --libs)
-			ifeq "$(CURL_LIBCURL)" ""
-				$(error libcurl not detected; try setting CURLDIR)
+$(error libcurl not detected or not compiled with static support)
 			endif
 		endif
 	endif
-- 
1.9.1.423.g4596e3a
