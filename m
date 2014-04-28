From: Dave Borowitz <dborowitz@google.com>
Subject: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 12:50:53 -0700
Message-ID: <1398714653-1050-1-git-send-email-dborowitz@google.com>
Cc: kusmabite@gmail.com, gitster@pobox.com,
	Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 21:51:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeraI-0005BY-3v
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932933AbaD1TvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:51:21 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57066 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbaD1TvT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:51:19 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so6103933pde.12
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EI/3mMqlcq3eA5ublXjou+ITvI8PWGYWaSsUr9IUKpg=;
        b=epZ3SUrU0vCHes0bNXlYI1CZqleu1VOvAWB26oFxUQ1AtR1mnHQVplzS5j7SgKyHVd
         1lL5YfT51RKFZsvBEteZ0Csvtb7OMH3ISjKcFZn/bF1nzHybvuyddrV3jK0k/Uao+tcl
         zITTd3tSJh2oqEwfV+TAskvI/FTEb9nMRJnrh3RtYNaLljNuXntFx1VDvHJBnZTdxMeM
         WkoUhBnrDuC1EWfVPWSeWNjMKmLpRDepMoqWfnT3HEMBDq8606IVgrfbeChM/dAi7HKj
         TFWh96S4Tag+Vk0bxSIma8RrWZbFR1jtBlPa/ajHx1PBuTaWPPdsltsryxu67t2eUFpB
         /+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EI/3mMqlcq3eA5ublXjou+ITvI8PWGYWaSsUr9IUKpg=;
        b=HEbdhk235Gch6SvqWFvu8kDVjIJ6WEe0nbmDIQEOwdCUDVNYB/qQ/O/s2wv2GCQxG3
         Z3n35fA4Aug5G+LsARNixAwEZSDY1DtEur6iZoBBDW8cc7v2TECUvS5WHHCNnYuGeHxg
         AjfJn//rrlAMMCGvX9/+cM6pMl2Wq07aB0AhX1b1ICXRYAhpRKQlpwY/a1QVeoETilBV
         rlQW9uitl8dBl9LHCK4zJDaCiq3jjLjkm3C1i64oLLmLDyCe1Zc4pBhXSDYru+FRd0w+
         U9lzXbwE4oH5FKhkNm6lEx8r/U0SISHa7kFNB2NnKBxg+WwvrDhQ/f5jAbMmKTeZuPSx
         5lDw==
X-Gm-Message-State: ALoCoQlxWGlVeeCPhexvk6JbDsKJmxAb64DLEMcJiqOOjokgQMdN7DRevk7Vvb3qBdNHMZ+HGgTDBUbhwxyqYbEV+gD1lSveuKgJxkH3WYEpYu8zDe4EAME52dbLzp4DJ5mwWNJ/8+aTbIi/oDmvZ55JF5RhUSfwoGz3jq4ndHOCCHvXg0w0UUiMczEcep3ZyIZXl7jA2/p70Ead/iiGupALyDmE1VfZ2bQntQYCLjOzxgSkYI1d3/Y=
X-Received: by 10.66.216.137 with SMTP id oq9mr27247625pac.97.1398714679001;
        Mon, 28 Apr 2014 12:51:19 -0700 (PDT)
Received: from serval.mtv.corp.google.com (serval.mtv.corp.google.com [172.27.69.27])
        by mx.google.com with ESMTPSA id tf10sm36768811pbc.70.2014.04.28.12.51.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 12:51:17 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.423.g4596e3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247424>

The original implementation of CURL_CONFIG support did not match the
original behavior of using -lcurl when CURLDIR was not set. This broke
implementations that were lacking curl-config but did have libcurl
installed along system libraries, such as MSysGit. In other words, the
assumption that curl-config is always installed was incorrect.

Instead, if CURL_CONFIG is empty or returns an empty result (e.g. due
to curl-config being missing), use the old behavior of falling back to
-lcurl.
---
 Makefile | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index 74a929b..79b7442 100644
--- a/Makefile
+++ b/Makefile
@@ -35,7 +35,9 @@ all::
 # transports (neither smart nor dumb).
 #
 # Define CURL_CONFIG to the path to a curl-config binary other than the
-# default 'curl-config'.
+# default 'curl-config'. If CURL_CONFIG is unset or points to a binary that
+# is not found, defaults to the CURLDIR behavior, or if CURLDIR is not set,
+# uses -lcurl with no additional library detection.
 #
 # Define CURL_STATIC to statically link libcurl.  Only applies if
 # CURL_CONFIG is used.
@@ -1127,9 +1129,27 @@ ifdef NO_CURL
 	REMOTE_CURL_NAMES =
 else
 	ifdef CURLDIR
-		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
-		BASIC_CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib) -lcurl
+		CURL_LIBCURL=
+	else
+		CURL_CONFIG ?= curl-config
+		ifeq "$(CURL_CONFIG)" ""
+			CURL_LIBCURL =
+		else
+			CURL_LIBCURL := $(shell $(CURL_CONFIG) --libs)
+		endif
+	endif
+
+	ifeq "$(CURL_LIBCURL)" ""
+		ifdef CURL_STATIC
+                        $(error "CURL_STATIC must be used with CURL_CONFIG")
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
@@ -1140,17 +1160,11 @@ else
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
+                                $(error libcurl not detected or not compiled with static support)
 			endif
 		endif
 	endif
-- 
1.9.1.423.g4596e3a
