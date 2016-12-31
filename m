Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1FB82070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754618AbcLaDNT (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:19 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55417 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754540AbcLaDNP (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:15 -0500
X-AuditID: 1207440d-8b7ff700000009ba-8d-58672249ae0f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.21.02490.94227685; Fri, 30 Dec 2016 22:13:14 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6tv010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:12 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/23] safe_create_leading_directories_const(): preserve errno
Date:   Sat, 31 Dec 2016 04:12:43 +0100
Message-Id: <2d685f4c5cbe17bf1abf2ef3fb2f03fd20a0c23d.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqOullB5h8OEuq0XXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4MlqPJhdMZK9YuH4GewPjO9YuRk4OCQETiSVvV4PZQgKXGSW23C3qYuQCso8zSUx6MpMd
        JMEmoCuxqKeZCcQWEVCTmNh2iAWkiFlgIqPEtC2XwBLCAoESfft+MYPYLAKqEvevLwWbyisQ
        JTGtdRXUNjmJS9u+gNVwClhILP7UxwSx2Vxi3c5LzBMYeRYwMqxilEvMKc3VzU3MzClOTdYt
        Tk7My0st0jXSy80s0UtNKd3ECAkc3h2M/9fJHGIU4GBU4uF9cCMtQog1say4MvcQoyQHk5Io
        r6VlaoQQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6FcukRQrwpiZVVqUX5MClpDhYlcV61Jep+
        QgLpiSWp2ampBalFMFkZDg4lCd6FikCNgkWp6akVaZk5JQhpJg5OkOE8QMN7QWp4iwsSc4sz
        0yHypxh1OQ68X/GUSYglLz8vVUqcd60CUJEASFFGaR7cHFjEv2IUB3pLmLcWZBQPMFnATXoF
        tIQJaIlaTjLIkpJEhJRUA2OAx0TnvVPeyMd+aF7zrDPzQdy6a6/P7FNTVu30c4wPap3N97Kn
        580We09egU88n5Zx3Dy5vsJxjcIWhRSjy+W/DR9YVBUZTpr1feW6Zazev7l8l5f53Czz2P9L
        3OfyjYMLPutfao1ZE/fil+Dr+0mO6h4Ltxx8e82w8fd9Bt343SyntZbLFs5XYinOSDTUYi4q
        TgQAnulu7NMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some implementations of free() change errno (even thought they
shouldn't):

  https://sourceware.org/bugzilla/show_bug.cgi?id=17924

So preserve the errno from safe_create_leading_directories() across the
call to free().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 sha1_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 1173071..10395e7 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -166,10 +166,14 @@ enum scld_error safe_create_leading_directories(char *path)
 
 enum scld_error safe_create_leading_directories_const(const char *path)
 {
+	int save_errno;
 	/* path points to cache entries, so xstrdup before messing with it */
 	char *buf = xstrdup(path);
 	enum scld_error result = safe_create_leading_directories(buf);
+
+	save_errno = errno;
 	free(buf);
+	errno = save_errno;
 	return result;
 }
 
-- 
2.9.3

