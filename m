Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1EF72070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754678AbcLaDNf (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:35 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:43008 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754660AbcLaDNc (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:32 -0500
X-AuditID: 12074412-5f5ff700000009b5-2e-5867225a7354
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 09.F7.02485.A5227685; Fri, 30 Dec 2016 22:13:30 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6uA010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:29 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 16/23] log_ref_write_1(): inline function
Date:   Sat, 31 Dec 2016 04:12:56 +0100
Message-Id: <f794e74e9aad39dc411f860c4834d4ba367ab30a.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsUixO6iqBullB5hMHW9ukXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mu5fmMVW0MFd8WTJZaYGxv8cXYwcHBICJhJPnmp2MXJxCAlcZpTYNWUdC4RznEni/v45
        jF2MnBxsAroSi3qamUBsEQE1iYlth8CKmAUmMkpM23IJLCEsYCPxavZ/MJtFQFVi2/cFbCA2
        r0CUxNrdfWC2hICcxKVtX5hBbE4BC4nFn/rA6oUEzCXW7bzEPIGRZwEjwypGucSc0lzd3MTM
        nOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkNAR2sG4/qTcIUYBDkYlHt4HN9IihFgTy4orcw8x
        SnIwKYnyWlqmRgjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4V0olx4hxJuSWFmVWpQPk5LmYFES
        5/25WN1PSCA9sSQ1OzW1ILUIJivDwaEkwaugCNQoWJSanlqRlplTgpBm4uAEGc4DNLwXpIa3
        uCAxtzgzHSJ/ilFRSpx3rQJQQgAkkVGaB9cLi+1XjOJArwjzOoG08wDTAlz3K6DBTECD1XKS
        QQaXJCKkpBoYJx/X+PlRcvP11Zf3qc/su1y1l7M9bcpUm+X/5bYXX7QSusau+WR13qVIBjfj
        +J0TG8LtFV/GqgVsPrvj95T/j9LTdi/qEzVwYJtlNlvVTal8Q6LTg79qAZIqhUvZQ3R/6Pq+
        zi4ItMovrP8luWk7m++0R5XSM2+9dcr94Pj245e1Sx9o+XCaKLEUZyQaajEXFScCAIbB8yDI
        AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now files_log_ref_write() doesn't do anything beyond call
log_ref_write_1(), so inline the latter into the former.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 455652c..a4e0de5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2820,9 +2820,9 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 	return 0;
 }
 
-static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
-			   const unsigned char *new_sha1, const char *msg,
-			   int flags, struct strbuf *err)
+int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+			const unsigned char *new_sha1, const char *msg,
+			int flags, struct strbuf *err)
 {
 	int logfd, result;
 
@@ -2857,13 +2857,6 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
-			const unsigned char *new_sha1, const char *msg,
-			int flags, struct strbuf *err)
-{
-	return log_ref_write_1(refname, old_sha1, new_sha1, msg, flags, err);
-}
-
 /*
  * Write sha1 into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and
-- 
2.9.3

