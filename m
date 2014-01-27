From: David Sharp <dhsharp@google.com>
Subject: [PATCH] rev-parse: Check argc before using argv[i+1]
Date: Mon, 27 Jan 2014 15:44:22 -0800
Message-ID: <1390866262-10188-1-git-send-email-dhsharp@google.com>
Cc: David Sharp <dhsharp@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 28 00:53:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7vzr-0002dQ-R8
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 00:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbaA0Xxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 18:53:38 -0500
Received: from mail-oa0-f74.google.com ([209.85.219.74]:65324 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbaA0Xxh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 18:53:37 -0500
Received: by mail-oa0-f74.google.com with SMTP id m1so1464331oag.5
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 15:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KorrZRurX+NnNId9rBWI4dQ+FhII3SW67wYNa92HOhg=;
        b=LIPjUAmjqpeo7rPOuOcG6aH4epLNr/5toWkPQPHxHWxHEjoITmmoTlgEn6JQcmCpWx
         FEXR3ldSLk45gxdroUxTqmKJjPqbSPPcK5Uu5onooxEUCdsrWkVIBZbGGK5k/gQw8xaF
         EzjjmE9Rz0rN5rVRXZiQVT0ucNYLL+RuCdykK1CaBAJu17Noiw4DMt8U2CaDqmGMMEfm
         Rs7qSoPEigs6rslhqCvzgQYTVbSj09J49c60BAaet9GrOJFft1vITk/8vQQwv/O4DemP
         lVkE2V0yo5nAS5XEI1aJuHv9F79AAkSLog5lHoVqH+IFEWK2/3GieAA8SL3inHk0Hw3e
         DGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KorrZRurX+NnNId9rBWI4dQ+FhII3SW67wYNa92HOhg=;
        b=Qr2BzaP6ue+6aN81Ryl5WfD/dcBzo7+l7WV4I71WwMy+2U8SODGkDo51rD7dbr1Gga
         H4dPd1DZfrU4kxKL9nLS2SQSQt/W7RmqzSQmTc6Z1Y5pWaZOB0ZF6GnE5HHwgX7O/nxa
         84xFyikFqUJzA+RrbbfJNQtlNUa5q+s+E6uez8q/8nZWNyhexaQ07XsSOL+Z45oSOVa4
         GEO/q98n/px+0uI+HFaGMsJ/WUhoYTiOzd5pUW12g2XDny6nhs/QGWciYG6kHxIH8+HB
         h8VouBQtCHbJCycfHRuFCF6UFL18P3f9uhegNAGFQ5gOFt5Dmp5Z1CettmzB1gmym1lx
         n0aQ==
X-Gm-Message-State: ALoCoQkofkpdvxNIavkVm5dOGed8pRzcPTOM6DPh0jLXUMR92dx7CuCaTMU6p95yJrve86YZrnCexzjBJow3tPO3Gt59+PZ+S+o1bH+oqkqz4pkjBV9cOpHmoYvF7GRmMyrqPUppsZ/rn2VbzljM1OedbpZYmVb85f3kW/L1B+IjzjsM86mcOXZter5yJibl80XMFPOltXAL
X-Received: by 10.50.18.49 with SMTP id t17mr8558677igd.3.1390866334201;
        Mon, 27 Jan 2014 15:45:34 -0800 (PST)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i24si713781yhe.6.2014.01.27.15.45.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jan 2014 15:45:34 -0800 (PST)
Received: from celeritas2.mtv.corp.google.com (celeritas2.mtv.corp.google.com [172.17.130.39])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C3A4F31C18E;
	Mon, 27 Jan 2014 15:45:33 -0800 (PST)
Received: by celeritas2.mtv.corp.google.com (Postfix, from userid 59422)
	id 66B7F1E0D43; Mon, 27 Jan 2014 15:45:33 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241170>

Without this patch, git-rev-parse --prefix, --default, or
--resolve-git-dir, without a value argument, would result in a segfault.
Instead, die() with a message.

Signed-off-by: David Sharp <dhsharp@google.com>
---
 builtin/rev-parse.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index aaeb611..3bf65c5 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -547,15 +547,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--default")) {
-				def = argv[i+1];
-				i++;
+				if (++i >= argc)
+					die("--default requires an argument");
+				def = argv[i];
 				continue;
 			}
 			if (!strcmp(arg, "--prefix")) {
-				prefix = argv[i+1];
+				if (++i >= argc)
+					die("--prefix requires an argument");
+				prefix = argv[i];
 				startup_info->prefix = prefix;
 				output_prefix = 1;
-				i++;
 				continue;
 			}
 			if (!strcmp(arg, "--revs-only")) {
@@ -738,9 +740,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				continue;
 			}
 			if (!strcmp(arg, "--resolve-git-dir")) {
-				const char *gitdir = resolve_gitdir(argv[i+1]);
+				if (++i >= argc)
+					die("--resolve-git-dir requires an argument");
+				const char *gitdir = resolve_gitdir(argv[i]);
 				if (!gitdir)
-					die("not a gitdir '%s'", argv[i+1]);
+					die("not a gitdir '%s'", argv[i]);
 				puts(gitdir);
 				continue;
 			}
-- 
1.8.5.3
