From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/14] builtin/fetch-pack: add argument for transport version
Date: Fri, 29 Apr 2016 16:34:44 -0700
Message-ID: <1461972887-22100-12-git-send-email-sbeller@google.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Sat Apr 30 01:35:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHwO-0000u4-Mf
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbcD2XfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:35:15 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33274 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbcD2XfK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:35:10 -0400
Received: by mail-pf0-f181.google.com with SMTP id 206so54335410pfu.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=olAvQBSEwR9eCaWDwy6/hwOSawAcUInCryv142zO5zk=;
        b=cNqcTq+QclUzx+hSd5mJHzjGylZ1MoYMAylnLsJnFVRiwTBa06qxMayTaldrf2PDaO
         vX6DYp0CKuCbAixrpWxLe4pc7RtAW6b21uThC/nMGpz2SN3dZVy0VZklen/DKLv+awwt
         LL5pxGTjLQ+nYyWB0nasLNg14aaXP+fKc4NCQDLL4QU0m7JSyfv6KWHwGPg/iPmdFHyn
         pdnGZ4s7g8XyyrnPcJkfuMSiIVFLWxJ2Ar6Ns2oik7lYoOq4LtUM0VqPhBi9O1uudcBe
         xn7B/eCSH2nOFyMoIqLFNO66FavMF6PBOlvxAhc3MWjIbUUlNgJwg2l6mszk5+ZqcWbJ
         vpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=olAvQBSEwR9eCaWDwy6/hwOSawAcUInCryv142zO5zk=;
        b=G1tQd65IdLmGbdhOh6lg+sg5M1JOw+RQp4bVQZEUgZcT0Q7N+twBp7ltZIv2PcvIHg
         0+H54RK6ResIs7guthouSWVsQProVaUWd5Db1b/zzvQ1muKf2SGeFo5bwnA8z7tNJFkM
         c1QEKA9ygtJYkFjjQxLTrGUG6RjSlSKW7Icwsb1ykhgUBbWW1nnc9qKayzfdqtdL9o2o
         sDLtq/oxDNH8P+ImEqnFb8nrVTuWadtogcWf1k1L2JKTG9q/y6+xaLsBrY/WgAPlzcl6
         bADtlpMAru1Zd0zInP4TeYMORwM8BpEQcEgMiQYdEDkN4iNilsj5n5ROZrZQgf6jGDRc
         L8jg==
X-Gm-Message-State: AOPr4FXZ6ut6nf1toxvyS4EDl1E4W+vGZnyvZQlRY7ke9EQFCuveiKM1/Qc53SBtcq6Xw0Fg
X-Received: by 10.98.81.195 with SMTP id f186mr33177864pfb.30.1461972909981;
        Fri, 29 Apr 2016 16:35:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id y128sm26248555pfb.13.2016.04.29.16.35.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 16:35:09 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461972887-22100-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293076>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch-pack.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bfd0be4..afb614b 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -4,6 +4,7 @@
 #include "remote.h"
 #include "connect.h"
 #include "sha1-array.h"
+#include "transport.h"
 
 static const char fetch_pack_usage[] =
 "git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
@@ -56,6 +57,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	memset(&args, 0, sizeof(args));
 	args.uploadpack = "git-upload-pack";
+	args.transport_version = DEFAULT_TRANSPORT_VERSION;
 
 	for (i = 1; i < argc && *argv[i] == '-'; i++) {
 		const char *arg = argv[i];
@@ -130,6 +132,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.update_shallow = 1;
 			continue;
 		}
+		if (starts_with(arg, "--transport-version=")) {
+			args.transport_version = strtol(arg + 20, NULL, 0);
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
 
@@ -178,7 +184,19 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		if (!conn)
 			return args.diag_url ? 0 : 1;
 	}
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+
+	switch (args.transport_version) {
+	case 2: /* first talk about capabilities, then get the refs */
+		negotiate_capabilities(fd, &args);
+		/* fall through */
+	case 1:
+		get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+		break;
+	default:
+		die("BUG: Transport version %d not supported",
+			args.transport_version);
+		break;
+	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
 			 &shallow, pack_lockfile_ptr);
-- 
2.8.0.32.g71f8beb.dirty
