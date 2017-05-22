Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 484F82023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934575AbdEVOTC (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:02 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42984 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934717AbdEVOSz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:55 -0400
X-AuditID: 12074413-0c9ff70000001dc3-c5-5922f348798e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 28.20.07619.843F2295; Mon, 22 May 2017 10:18:48 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24Q023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:46 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 17/25] ref_update_reject_duplicates(): add a sanity check
Date:   Mon, 22 May 2017 16:17:47 +0200
Message-Id: <8383dc8f8e30b61548374a5427da09f98a2175af.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqOvxWSnS4Mk2Y4u1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxpufm1gLDrNX
        HH/+hKmB8SlrFyMHh4SAicSce+xdjFwcQgI7mCQOPj/CCOGcYpL4+eEdUIaTg01AV2JRTzMT
        iC0ioCYxse0QC0gRs8AGZok301eDJYQFfCSO3rjPCGKzCKhKbF3zjw3E5hWIkli3qA0sLiEg
        L7Gr7SIriM0pYCHxe9YBsF4hAXOJ3n+rWSYw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5da
        pGuul5tZopeaUrqJERKIwjsYd52UO8QowMGoxMOr8VgpUog1say4MvcQoyQHk5Io79E3QCG+
        pPyUyozE4oz4otKc1OJDjBIczEoivNp3gXK8KYmVValF+TApaQ4WJXFetSXqfkIC6Yklqdmp
        qQWpRTBZGQ4OJQlevU9AjYJFqempFWmZOSUIaSYOTpDhPEDD13wAGV5ckJhbnJkOkT/FqMsx
        597X90xCLHn5ealS4rw7QIoEQIoySvPg5sASyCtGcaC3hHkLQdbxAJMP3KRXQEuYgJZYP5MH
        WVKSiJCSamDUVfk9W/JKyLVfCyL/Js+8Jcahezwh1ttP+3XjxTfzLTSe+xe+Npngvjo8qbd2
        rUVfCAvfQv+PPz8cvbnXuGLPpNR4x5tfFui91jN3sZnrbdaftkZgm9h9s4+xU0P65K7GB2h4
        bWnZuUGJ9zm7/b0DgcWWb9ULPn9Ysa37fPqHnt8HZvOn3PuoxFKckWioxVxUnAgAknamPvsC
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's pretty cheap to make sure that the caller didn't pass us an
unsorted list by accident, so do so.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 143936a9c3..d1c781d94e 100644
--- a/refs.c
+++ b/refs.c
@@ -1709,13 +1709,19 @@ int ref_update_reject_duplicates(struct string_list *refnames,
 
 	assert(err);
 
-	for (i = 1; i < n; i++)
-		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
+	for (i = 1; i < n; i++) {
+		int cmp = strcmp(refnames->items[i - 1].string,
+				 refnames->items[i].string);
+
+		if (!cmp) {
 			strbuf_addf(err,
 				    "multiple updates for ref '%s' not allowed.",
 				    refnames->items[i].string);
 			return 1;
+		} else if (cmp > 0) {
+			die("BUG: ref_update_reject_duplicates() received unsorted list");
 		}
+	}
 	return 0;
 }
 
-- 
2.11.0

