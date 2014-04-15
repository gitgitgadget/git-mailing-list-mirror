From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH v2 1/2] Makefile: use curl-config to determine curl flags
Date: Tue, 15 Apr 2014 03:40:30 -0700
Message-ID: <1397558431-22417-1-git-send-email-dborowitz@google.com>
Cc: gitster@pobox.com, Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 15 12:41:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wa0np-0005wp-KH
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 12:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbaDOKlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 06:41:14 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41035 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbaDOKlL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 06:41:11 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so9376456pab.5
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ADz51Qu6iL+HtP1nh76NXHZUneX/FSqdKB36LLptvFg=;
        b=d0cD0IPJh8wbvj/j/3n6uK1Dj2BLmI3NkjLWmtfOa3D3o/X6yYz3e1gqHklahTECZo
         sMrjCnUKWvl2CTLmF9FZm6P/BGi798nQIaxryajL4wnAfjwWj66g2YS7VCQthTiUGm39
         KZ0mWi0k16s944JU+fbAWdYR7iSjnPBuFh8b319briDTiUJBM3T592jHXNXbZEyHb1jg
         oYPbr5Kv6zxtfZYQpBjqaLFLgZKInhTubh2hahGM6hoX02J0F+M3354q78GCCQZxkV7W
         nt54qegb9pnlGR64h1SmjQaU9nj4uJcPVor8MNTGEUk7yLD3P0zyxgNzxGlBwj7h4B2p
         gnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ADz51Qu6iL+HtP1nh76NXHZUneX/FSqdKB36LLptvFg=;
        b=H2hPmaqSgdd/x1W6m+Q1YbcQxy2GgJOhHrmVAbTot+kK0oaxI2pt6YaKN66f0A4bwi
         4BXhmFsNId+/5WpNN1k3wUMASbyYOGP2BV7RDZrOil7ccVd6uEmtS5kYvKvmzsdbDHmV
         sXjcygnIvHqVunjK5vdz7gVE1wisZ/8rIkHrHzak+ydLjnOyJAE7jAaehl0kSnhJyE1+
         9ZgNoIVltB0iMuBQlCsMNfQr7sZp5k3kvcxsrrcsj5dEpCoE4S0exOgThvd1sLdfxuMf
         jD2k0VoFhLc4Qm2M/zB7EvwH9KZhfw54by1bVb5A8l28UwmBWJotL+XTrITJdwOCsSm6
         h7Zw==
X-Gm-Message-State: ALoCoQn9i9sQm3KCCPVmdOxUhoI59OG16sXGIfAm3bc9U6hNBd/3BLrT3zENSdKxvgBTmFUEmg5yLpJ4+65FkaMBXZwCKngquR6vLOQv4BvSaHeSTX4w0cN6AArNEm0zc3UHqWejPt2qNqowy8l0l8DQ7s3zgJdAUmx35np5EvrKMRlcvzg1FOo5Nq/Fuut+KKryPW1jLqfyvaip/D8515kfZRBo8JihFsup67/QxRv5pz/mBNtdK7Q=
X-Received: by 10.68.184.66 with SMTP id es2mr1053251pbc.19.1397558470750;
        Tue, 15 Apr 2014 03:41:10 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id 10sm16416353pbo.51.2014.04.15.03.41.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Apr 2014 03:41:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246282>

curl-config should always be installed alongside a curl distribution,
and its purpose is to provide flags for building against libcurl, so
use it instead of guessing flags and dependent libraries.

Allow overriding CURL_CONFIG to a custom path to curl-config, to
compile against a curl installation other than the first in PATH.

Depending on the set of features curl is compiled with, there may be
more libraries required than the previous two options of -lssl and
-lidn. For example, with a vanilla build of libcurl-7.36.0 on Mac OS X
10.9:

$ ~/d/curl-out-7.36.0/lib/curl-config --libs
-L/Users/dborowitz/d/curl-out-7.36.0/lib -lcurl -lgssapi_krb5 -lresolv -lldap -lz

Use this only when CURLDIR is not explicitly specified, to continue
supporting older builds.

Signed-off-by: Dave Borowitz <dborowitz@google.com>
---
 Makefile | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 2128ce3..d6330bc 100644
--- a/Makefile
+++ b/Makefile
@@ -34,8 +34,12 @@ all::
 # git-http-push are not built, and you cannot use http:// and https://
 # transports (neither smart nor dumb).
 #
+# Define CURL_CONFIG to the path to a curl-config binary other than the
+# default 'curl-config'.
+#
 # Define CURLDIR=/foo/bar if your curl header and library files are in
-# /foo/bar/include and /foo/bar/lib directories.
+# /foo/bar/include and /foo/bar/lib directories.  This overrides CURL_CONFIG,
+# but is less robust.
 #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports (dumb).
@@ -143,9 +147,11 @@ all::
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
@@ -1121,18 +1127,23 @@ else
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
 		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
+		ifdef NEEDS_SSL_WITH_CURL
+			CURL_LIBCURL += -lssl
+			ifdef NEEDS_CRYPTO_WITH_SSL
+				CURL_LIBCURL += -lcrypto
+			endif
+		endif
+		ifdef NEEDS_IDN_WITH_CURL
+			CURL_LIBCURL += -lidn
+		endif
 	else
-		CURL_LIBCURL = -lcurl
-	endif
-	ifdef NEEDS_SSL_WITH_CURL
-		CURL_LIBCURL += -lssl
-		ifdef NEEDS_CRYPTO_WITH_SSL
-			CURL_LIBCURL += -lcrypto
+		CURL_CONFIG ?= curl-config
+		BASIC_CFLAGS += $(shell $(CURL_CONFIG) --cflags)
+		CURL_LIBCURL = $(shell $(CURL_CONFIG) --libs)
+		ifeq "$(CURL_LIBCURL)" ""
+			$(error curl not detected; try setting CURLDIR)
 		endif
 	endif
-	ifdef NEEDS_IDN_WITH_CURL
-		CURL_LIBCURL += -lidn
-	endif
 
 	REMOTE_CURL_PRIMARY = git-remote-http$X
 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
-- 
1.9.1.423.g4596e3a
