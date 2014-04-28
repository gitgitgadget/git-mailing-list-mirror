From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v3 1/2] Makefile: use curl-config to determine curl flags
Date: Mon, 28 Apr 2014 12:35:03 -0700
Message-ID: <1398713704-15428-1-git-send-email-dborowitz@google.com>
Cc: kusmabite@gmail.com, gitster@pobox.com,
	Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 21:35:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerL5-0002pR-CG
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721AbaD1Tfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:35:37 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52320 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463AbaD1Tfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:35:30 -0400
Received: by mail-pb0-f49.google.com with SMTP id rr13so6208989pbb.36
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=TiWKV4mbfBw4ofdrqL40O/V4LmTakHcmqU9hCQYitKk=;
        b=e2+bud38nlp1tSwr5KQ8h9rAGyaxqGq4SLbIC6BzBsmpEOXUhC8hRR9qAw29iQX944
         mI0BJUagvSS4IOktuFAZrIOoVKvY/16zYm04AjaF0uxKYxwLtApXhKZde/DEIVMQIT/X
         T88a93dziVG5r//qofuwqfQ6lyuSudyj6zrmh1/qZXODwdXohPSzjL+d5pAWIZj1NTMq
         hrtb1/CjhZkDZVeydNqmI5L1VASOu6wnsbuXGBLxECmXB9pflFYE+MvUvcvNynPd8DjQ
         ep3T5HSlzWZgbXrIU56HeIIGrTFiVTU5uGb2AvYcBQPKA5F5nyU2Hdk8GQji5mgtftd0
         /+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TiWKV4mbfBw4ofdrqL40O/V4LmTakHcmqU9hCQYitKk=;
        b=N+KTu2qNvY3RIESvKQcPw+TT9+NuurIWdKyygDPg0J2dOYqO8ntJQCD8uXlxPT7UAG
         l6917WxcYiVN8pNUxj5zitGMhInhSvQ1dCXacceWjTdISWxyTy6o4zXQPHZxFl7eL8Br
         jatXwqYWmD5ExEwFnhSp8aJcSbtT76w0SlBwWscq1ov/WLTjOeJ1CTI2v1k/4EKdgiNY
         ghvEwgUr9mMSrG0Cmz7pNQhVnz3o3xGFbUgbvR3ngGej/SqxX1Sl0rprZQIotjlj5AcB
         I4UmRN26HFCeCNbrF1kRaCBfACgCPD7bTP5874JXkcll8WPS9Y0Z6B0yQmv7fUK/Zg70
         evcw==
X-Gm-Message-State: ALoCoQlTkUAWvbuiTGv7JqcxNQcFVRbwA8H3TN7sWMt3IIKDeqE3QqEESJcywAusn52K/ONAZ60aFDzD69N3A1aGtxWAftUpsIsh0x/figSvt3hR2A6T2H3384rKpPNywGuwo9+2cZ/y58xvxMxtTc+Bl9TIJEBP6kBD4Kc5Lcac8Q6smFvNqPG4mpXWddCTROGBJLZsfLwHRCIl8E2b46X9h2rB2E8RFE/KjUtTS90XVLkqg3b+zg0=
X-Received: by 10.69.31.11 with SMTP id ki11mr26528427pbd.88.1398713729078;
        Mon, 28 Apr 2014 12:35:29 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id ss2sm96327791pab.8.2014.04.28.12.35.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 12:35:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247415>

curl-config is usually installed alongside a curl distribution, and
its purpose is to provide flags for building against libcurl, so use
it instead of guessing flags and dependent libraries.

Allow overriding CURL_CONFIG to a custom path to curl-config, to
compile against a curl installation other than the first in PATH.

Depending on the set of features curl is compiled with, there may be
more libraries required than the previous two options of -lssl and
-lidn. For example, with a vanilla build of libcurl-7.36.0 on Mac OS X
10.9:

$ ~/d/curl-out-7.36.0/lib/curl-config --libs
-L/Users/dborowitz/d/curl-out-7.36.0/lib -lcurl -lgssapi_krb5 -lresolv -lldap -lz

Use this only when CURLDIR is not explicitly specified, to continue
supporting older builds. Moreover, if CURL_CONFIG is unset or running
it returns no results (e.g. because it is missing), default to the old
behavior of blindly setting -lcurl.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Makefile | 51 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 2128ce3..cb4ee37 100644
--- a/Makefile
+++ b/Makefile
@@ -34,8 +34,14 @@ all::
 # git-http-push are not built, and you cannot use http:// and https://
 # transports (neither smart nor dumb).
 #
+# Define CURL_CONFIG to the path to a curl-config binary other than the
+# default 'curl-config'. If CURL_CONFIG is unset or points to a binary that
+# is not found, defaults to the CURLDIR behavior, or if CURLDIR is not set,
+# uses -lcurl with no additional library detection.
+#
 # Define CURLDIR=/foo/bar if your curl header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
+# /foo/bar/include and /foo/bar/lib directories.  This overrides CURL_CONFIG,
+# but is less robust.
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports (dumb).
@@ -143,9 +149,11 @@ all::
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
 #
-# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).
+# Define NEEDS_SSL_WITH_CURL if you need -lssl with -lcurl (Minix).  Only used
+# if CURLDIR is set.
 #
-# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).
+# Define NEEDS_IDN_WITH_CURL if you need -lidn when using -lcurl (Minix).  Only
+# used if CURLDIR is set.
 #
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 #
@@ -1118,20 +1126,35 @@ ifdef NO_CURL
 	REMOTE_CURL_NAMES =
 else
 	ifdef CURLDIR
-		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
-		BASIC_CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
+		CURL_LIBCURL=
 	else
-		CURL_LIBCURL = -lcurl
-	endif
-	ifdef NEEDS_SSL_WITH_CURL
-		CURL_LIBCURL += -lssl
-		ifdef NEEDS_CRYPTO_WITH_SSL
-			CURL_LIBCURL += -lcrypto
+		CURL_CONFIG ?= curl-config
+		ifeq "$(CURL_CONFIG)" ""
+			CURL_LIBCURL =
+		else
+			CURL_LIBCURL := $(shell $(CURL_CONFIG) --libs)
 		endif
 	endif
-	ifdef NEEDS_IDN_WITH_CURL
-		CURL_LIBCURL += -lidn
+
+	ifeq "$(CURL_LIBCURL)" ""
+		ifdef CURLDIR
+			# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
+			BASIC_CFLAGS += -I$(CURLDIR)/include
+			CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
+		else
+			CURL_LIBCURL = -lcurl
+		endif
+		ifdef NEEDS_SSL_WITH_CURL
+			CURL_LIBCURL += -lssl
+			ifdef NEEDS_CRYPTO_WITH_SSL
+				CURL_LIBCURL += -lcrypto
+			endif
+		endif
+		ifdef NEEDS_IDN_WITH_CURL
+			CURL_LIBCURL += -lidn
+		endif
+	else
+		BASIC_CFLAGS += $(shell $(CURL_CONFIG) --cflags)
 	endif
 
 	REMOTE_CURL_PRIMARY = git-remote-http$X
-- 
1.9.1.423.g4596e3a
