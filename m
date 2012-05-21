From: mhagger@alum.mit.edu
Subject: [PATCH v2 2/4] cmd_fetch_pack(): handle non-option arguments outside of the loop
Date: Mon, 21 May 2012 09:59:57 +0200
Message-ID: <1337587199-21099-3-git-send-email-mhagger@alum.mit.edu>
References: <1337587199-21099-1-git-send-email-mhagger@alum.mit.edu>
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 10:00:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWNXl-0005rL-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 10:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab2EUIAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 04:00:37 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:46076 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751864Ab2EUIAg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 04:00:36 -0400
X-AuditID: 1207440f-b7fe16d000000920-f1-4fb9f623c7ec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 28.3A.02336.326F9BF4; Mon, 21 May 2012 04:00:35 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4L80LNx006950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2012 04:00:34 -0400
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1337587199-21099-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixO6iqKv8bae/wf7dqhZdV7qZLBp6rzBb
	3F4xn9mie8pbRgcWj7/vPzB57Jx1l93j4iVlj8+b5AJYorhtkhJLyoIz0/P07RK4M05N+stW
	cJqz4uSNRvYGxs3sXYycHBICJhLzvqxhhrDFJC7cW88GYgsJXGaU+HAuuouRC8g+wyQxYeJu
	FpAEm4CUxMvGHrBmEQE1iYlth4DiHBzMAsUSlxebgJjCApES+67lg1SwCKhKPH27AWw8r4CL
	xIxtK5kgVslLPL3fB7aKU8BV4tB1iOlCQDUbHi5mm8DIu4CRYRWjXGJOaa5ubmJmTnFqsm5x
	cmJeXmqRrolebmaJXmpK6SZGSOjw72DsWi9ziFGAg1GJh9d5xk5/IdbEsuLK3EOMkhxMSqK8
	pp+AQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR47z4EyvGmJFZWpRblw6SkOViUxHnVl6j7CQmk
	J5akZqemFqQWwWRlODiUJHinfgVqFCxKTU+tSMvMKUFIM3FwgggukA08QBsSQAp5iwsSc4sz
	0yGKTjEqSonzBoEkBEASGaV5cANgUf6KURzoH2HedJAqHmCCgOt+BTSYCWhw0AuwwSWJCCmp
	Bkb52dvXKCjV29fVna7RZv4bKTqlWteq5oLGzxmnGyb4Gm0Wvr+lex1X6fWNUywY6hL4k7lF
	fjyPNc5blqO6MtMyXSif77u4eb8Ej/CzqTyrT8RExRzd4eegufygvRjf0jKu5idrXK7qTf6T
	lbzmss/pToXQR1MEuxc+XPg9SMAiSNKglj3/qxJLcUaioRZzUXEiAIbp3sXNAgAA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198088>

From: Michael Haggerty <mhagger@alum.mit.edu>

This makes it more obvious that the code is always executed unless
there is an error, and that the first initialization of nr_heads is
unnecessary.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 7e9d62f..dabf5e9 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -910,7 +910,6 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("fetch-pack");
 
-	nr_heads = 0;
 	heads = NULL;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -972,14 +971,17 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			}
 			usage(fetch_pack_usage);
 		}
-		dest = arg;
-		heads = (char **)(argv + i + 1);
-		nr_heads = argc - i - 1;
 		break;
 	}
-	if (!dest)
+
+	if (i < argc)
+		dest = argv[i++];
+	else
 		usage(fetch_pack_usage);
 
+	heads = (char **)(argv + i);
+	nr_heads = argc - i;
+
 	if (args.stdin_refs) {
 		/*
 		 * Copy refs from cmdline to new growable list, then
-- 
1.7.10
