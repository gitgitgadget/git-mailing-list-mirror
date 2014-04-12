From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH 1/2] Makefile: use curl-config to determine curl flags
Date: Sat, 12 Apr 2014 16:15:01 -0700
Message-ID: <1397344502-23459-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 01:15:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ79B-0006zu-Fv
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 01:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424AbaDLXPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 19:15:13 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:65382 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaDLXPL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 19:15:11 -0400
Received: by mail-pd0-f175.google.com with SMTP id x10so6675791pdj.20
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 16:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/Y4sZO4I2pu5SxSqQQKO9Rk5pjFF5lhxEc/PrPbsVxQ=;
        b=BFsJOKIi9uNaI4Bi3leiHdLaaty+w/RqTE+HX9MLpElZw7l60GHwBriRGpdZU0hqzB
         +G4IctjRtrtdhFPiEwIettp8aj30ssIS2xfJKm0thVBslNZFamTNKZ1XVLsC3iH2zD7s
         PaTngSCggNnF0jA46FbhtCGdaXs/gRYBBqyq/eS/HrPeIYddCLFYvo4xsT9+bAqAltHa
         879xHxYZeN2/GC5/ds7JBW9yuOkxc2tiv97rb2xAiFtllqtTEPIeRpxYZwvYkZwgUESO
         wlx7voCZErTEU7SH6UTCtfkVrgP27g+uhGDa0jVFoQlq+Stg+ZoitSaSlJJ/zYUL5qco
         x7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Y4sZO4I2pu5SxSqQQKO9Rk5pjFF5lhxEc/PrPbsVxQ=;
        b=DxMnpEHtzezGqAqmlQafBfmEzAmcp1U912P4tykZYsK7g+/RDEqToKyJy8INvX+FOx
         BwdLyeZzCEF7EdG9aM4TTmFEVcnhXb45KcDXzOXYz9QlYHV+4mBp3MyDumc2K2iCA21S
         cPAYbF3g40ZAXQeRS/W84k2LSMu1Lm5oCl9tLHxK4+VKXFw72P1mjD508YOKXSkKTVKV
         cBF9I0Kul6fn5QN8Jemh6B1xg4jxW+u8LN1tR5/vtu9kaLiuKBeRIrpAS4BTqkrIIOPh
         EFOWdHhLzWzVkh8VIuBxSEl1tU1h+PJCelHL97ONvhfiFlJVRai9BXEtk1IMKyyrZXx4
         5/gA==
X-Gm-Message-State: ALoCoQlGb3PkyhZVCbvVS7oPlsqqYKEiGBS8qck/OEYsNMfhqglmKq65HgewQ0/qkx54ExPhTDiyNzq6yN2Yzrr+H+PiXJL22zue3UXg1J4UQRi6h4lxvbkee7MQ5dLBbyMBq3HY57W0l/02uSKbbyqII6gunjfyx4c+it0IxHscQPrZi4m2NJZ/Rum4neJ4kjELYOXMhPOsDk/6D75gBBztegsBkIzsrmIYeCzvxCaCqBxjUF26ybE=
X-Received: by 10.68.193.100 with SMTP id hn4mr35863838pbc.50.1397344510847;
        Sat, 12 Apr 2014 16:15:10 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id wd2sm57023669pab.0.2014.04.12.16.15.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 16:15:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246202>

curl-config should always be installed alongside a curl distribution,
and its purpose is to provide flags for building against libcurl, so
use it instead of guessing flags and dependent libraries.

Allow overriding CURL_CONFIG to a custom path to curl-config, to
compile against a curl installation other than the first in PATH.

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
