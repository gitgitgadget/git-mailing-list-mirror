Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9864920C23
	for <e@80x24.org>; Sat, 31 Dec 2016 03:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754710AbcLaDN7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:59 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47943 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754570AbcLaDN2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:28 -0500
X-AuditID: 1207440e-7c7ff700000009ec-22-586722573afd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F1.C9.02540.75227685; Fri, 30 Dec 2016 22:13:27 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6u8010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:26 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 14/23] log_ref_write_1(): don't depend on logfile argument
Date:   Sat, 31 Dec 2016 04:12:54 +0100
Message-Id: <1e1295aff09039fc49188b085bda6ee5166d313e.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsUixO6iqBuulB5hcGaKtUXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4MibNuctWcIiroq3rLksD4w6OLkZODgkBE4mmQw/Yuhi5OIQELjNK7Ph8G8o5ziTxZvop
        JpAqNgFdiUU9zWC2iICaxMS2QywgRcwCExklpm25BJYQFvCVaH2+mBXEZhFQlXi+Yj6YzSsQ
        JbFp1S9GiHVyEpe2fWEGsTkFLCQWf+oD6xUSMJdYt/MS8wRGngWMDKsY5RJzSnN1cxMzc4pT
        k3WLkxPz8lKLdI31cjNL9FJTSjcxQoKHbwdj+3qZQ4wCHIxKPLwd19IihFgTy4orcw8xSnIw
        KYnyWlqmRgjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4V0olx4hxJuSWFmVWpQPk5LmYFES51Vb
        ou4nJJCeWJKanZpakFoEk5Xh4FCS4F2oCNQoWJSanlqRlplTgpBm4uAEGc4DNLwXpIa3uCAx
        tzgzHSJ/ilFRSpx3rQJQQgAkkVGaB9cLi+5XjOJArwjz7gJp5wEmBrjuV0CDmYAGq+Ukgwwu
        SURISTUwGpecW/m0W31jyfyVYjNS7unJti79NFH+IpNZ+VOLZ+xhFReK9XT3znmwtrcwS9zt
        M1+gjtyyLzJrfbnNsxVj+A+kdXk6Vdl0shr/Ws2ZfIdr/aO+6GW/ru5adVguNjXgvNAeveoY
        Cyk2feFgs8c3L3893frz1s/8DbPCWipm7W3avk3i+4ELSizFGYmGWsxFxYkAlTPyk8kCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's unnecessary to pass a strbuf holding the reflog path up and down
the call stack now that it is hardly needed by the callers. Remove the
places where log_ref_write_1() uses it, in preparation for making it
internal to log_ref_setup().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7f26cf8..5a96424 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2837,14 +2837,18 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
-		strbuf_addf(err, "unable to append to '%s': %s", logfile->buf,
-			    strerror(errno));
+		int save_errno = errno;
+
+		strbuf_addf(err, "unable to append to '%s': %s",
+			    git_path("logs/%s", refname), strerror(save_errno));
 		close(logfd);
 		return -1;
 	}
 	if (close(logfd)) {
-		strbuf_addf(err, "unable to append to '%s': %s", logfile->buf,
-			    strerror(errno));
+		int save_errno = errno;
+
+		strbuf_addf(err, "unable to append to '%s': %s",
+			    git_path("logs/%s", refname), strerror(save_errno));
 		return -1;
 	}
 	return 0;
-- 
2.9.3

