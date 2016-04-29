From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/14] transport: add infrastructure to support a protocol version number
Date: Fri, 29 Apr 2016 16:34:38 -0700
Message-ID: <1461972887-22100-6-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwN-0000u4-IM
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbcD2XfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:09 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34593 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbcD2XfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:07 -0400
Received: by mail-pf0-f170.google.com with SMTP id y69so54012367pfb.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1jpsKFLO5lZQ5+IyiVrrAOZv6QLrjlMFw60vdAt4lMU=;
        b=Y5zdJwPP8u1tBikv9P7P0RP8tihhEHs2WKTYdNhP0sjZ0fhMhMpOm3IR1TdkHv4m0g
         bBTD7aOqXZQTBI5LecZNVbzi1fcjKIm6GZnN7nvl2yDGxIPPfuW96r6E4G8NQF47ab4d
         fmoRigzG/L9amGxNbL0aCXj4dhRJmDvlQSB+wlshcpwdkxFwqbTKrf4twZepELa8Pfwz
         Sk5HD8PGIFsB3JV788Ew1i9Mq7cz7Q7pbP96DqUnJO1FD8c/vtREoVFvqG95PaU7Fqpj
         Sjx7soncpe9Ki6s0vmOKkiFs0z/W2AlKhTx839p5g7a1iRdmQFSIiBqOpwrlaN7sYnKQ
         eBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1jpsKFLO5lZQ5+IyiVrrAOZv6QLrjlMFw60vdAt4lMU=;
        b=Afa2dkAGV8GaNg0jlI84ro0BqOITbAzCoC3l1mAQvSRT3wOcu9ptoedgLLzEta71DL
         zv2KlRBXhV9BXBla5CsmgizQSS5hRXfrUYHrR7om6uq59kQVk1sRf64aBRAuzmHgVBu7
         /94ZvgNKsN3iUJawM75cbeieVGcXMA9WKDTILfKQL+Ae1W9kC5Y1AcoWZ80NDWQONpFa
         DAf0yh+shnckp0Oa9vjczq5bB5g0WIrMmMzlH9IY6IbpsPnOPlzamrIvjVE8VvMAk67W
         /eTjP6YvCngNo/SIoxgUyXZ2hjbJKQrx+2pv2qnENsh/avMBSKoZ5mChUOX8AM/7ahcf
         Hldw==
X-Gm-Message-State: AOPr4FUbsiwiekvHJjDn7Y2za8N9M/736TjONLnSmVh8rLZWfoLFrl35tS6UG0w+eIH9w0ft
X-Received: by 10.98.82.19 with SMTP id g19mr32591258pfb.157.1461972901545;
        Fri, 29 Apr 2016 16:35:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id 28sm26182766pfr.89.2016.04.29.16.35.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:01 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293074>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 fetch-pack.h       |  1 +
 remote.c           |  2 ++
 remote.h           |  2 ++
 transport-helper.c |  1 +
 transport.c        | 20 ++++++++++++++++++--
 transport.h        |  8 ++++++++
 6 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fetch-pack.h b/fetch-pack.h
index bb7fd76..3314362 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -8,6 +8,7 @@ struct sha1_array;
 
 struct fetch_pack_args {
 	const char *uploadpack;
+	int transport_version;
 	int unpacklimit;
 	int depth;
 	unsigned quiet:1;
diff --git a/remote.c b/remote.c
index 28fd676..760611d 100644
--- a/remote.c
+++ b/remote.c
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "mergesort.h"
 #include "argv-array.h"
+#include "transport.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
@@ -164,6 +165,7 @@ static struct remote *make_remote(const char *name, int len)
 		return ret;
 
 	ret = xcalloc(1, sizeof(struct remote));
+	ret->transport_version = DEFAULT_TRANSPORT_VERSION;
 	ret->prune = -1;  /* unspecified */
 	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
 	remotes[remotes_nr++] = ret;
diff --git a/remote.h b/remote.h
index c21fd37..cdb25d0 100644
--- a/remote.h
+++ b/remote.h
@@ -51,6 +51,8 @@ struct remote {
 	const char *receivepack;
 	const char *uploadpack;
 
+	int transport_version;
+
 	/*
 	 * for curl remotes only
 	 */
diff --git a/transport-helper.c b/transport-helper.c
index b934183..3cb386f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -248,6 +248,7 @@ static int disconnect_helper(struct transport *transport)
 }
 
 static const char *unsupported_options[] = {
+	TRANS_OPT_TRANSPORTVERSION,
 	TRANS_OPT_UPLOADPACK,
 	TRANS_OPT_RECEIVEPACK,
 	TRANS_OPT_THIN,
diff --git a/transport.c b/transport.c
index 095e61f..608b92c 100644
--- a/transport.c
+++ b/transport.c
@@ -151,6 +151,16 @@ static int set_git_option(struct git_transport_options *opts,
 				die("transport: invalid depth option '%s'", value);
 		}
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_TRANSPORTVERSION)) {
+		if (!value)
+			opts->transport_version = DEFAULT_TRANSPORT_VERSION;
+		else {
+			char *end;
+			opts->transport_version = strtol(value, &end, 0);
+			if (*end)
+				die("transport: invalid transport version option '%s'", value);
+		}
+		return 0;
 	}
 	return 1;
 }
@@ -203,6 +213,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = data->options.uploadpack;
+	args.transport_version = data->options.transport_version;
 	args.keep_pack = data->options.keep;
 	args.lock_pack = 1;
 	args.use_thin_pack = data->options.thin;
@@ -694,6 +705,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->connect = connect_git;
 		ret->disconnect = disconnect_git;
 		ret->smart_options = &(data->options);
+		ret->smart_options->transport_version =
+			DEFAULT_TRANSPORT_VERSION;
 
 		data->conn = NULL;
 		data->got_remote_heads = 0;
@@ -706,12 +719,15 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 	if (ret->smart_options) {
 		ret->smart_options->thin = 1;
-		ret->smart_options->uploadpack = "git-upload-pack";
+		ret->smart_options->uploadpack = DEFAULT_TRANSPORT_UPLOAD_PACK;
 		if (remote->uploadpack)
 			ret->smart_options->uploadpack = remote->uploadpack;
-		ret->smart_options->receivepack = "git-receive-pack";
+		ret->smart_options->receivepack = DEFAULT_TRANSPORT_RECEIVE_PACK;
 		if (remote->receivepack)
 			ret->smart_options->receivepack = remote->receivepack;
+		if (remote->transport_version)
+			ret->smart_options->transport_version =
+				remote->transport_version;
 	}
 
 	return ret;
diff --git a/transport.h b/transport.h
index c681408..af90529 100644
--- a/transport.h
+++ b/transport.h
@@ -13,6 +13,7 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	int depth;
+	int transport_version;
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
@@ -188,6 +189,13 @@ int transport_restrict_protocols(void);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* Use a new version of the git protocol */
+#define TRANS_OPT_TRANSPORTVERSION "transportversion"
+
+#define DEFAULT_TRANSPORT_VERSION 1
+#define DEFAULT_TRANSPORT_UPLOAD_PACK "git-upload-pack"
+#define DEFAULT_TRANSPORT_RECEIVE_PACK "git-receive-pack"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.8.0.32.g71f8beb.dirty
