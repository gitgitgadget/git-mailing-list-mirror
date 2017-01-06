Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549181FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967345AbdAFQXW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:22 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47488 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967279AbdAFQXL (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:11 -0500
X-AuditID: 1207440f-47fff700000009ea-c6-586fc4639d99
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.BE.02538.364CF685; Fri,  6 Jan 2017 11:23:00 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmWs023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:22:57 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 04/23] safe_create_leading_directories_const(): preserve errno
Date:   Fri,  6 Jan 2017 17:22:24 +0100
Message-Id: <964bc414e7e96642aacb248e06912befab2724cc.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqJtyJD/C4OEhLYuuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKaD2aXDCRvWLh+hnsDYzvWLsYOTkkBEwkHvy/w9jF
        yMUhJHCZUWJ/9xpWCOcEk8TWxV8YQarYBHQlFvU0M4HYIgJqEhPbDrGAFDELfGCU+NU5ix0k
        ISwQKHHueh8biM0ioCrx8vY3sBW8AlES11vmsECsk5O4tO0LM4jNKWAh0bjrG9gCIQFziU8T
        DzNPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMkwPh3MHatlznE
        KMDBqMTDG+GVFyHEmlhWXJl7iFGSg0lJlDfMMT9CiC8pP6UyI7E4I76oNCe1+BCjBAezkgiv
        3SGgHG9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoRTFaGg0NJgrfxMFCjYFFqempF
        WmZOCUKaiYMTZDgP0PAOkBre4oLE3OLMdIj8KUZdjgPvVzxlEmLJy89LlRLn3QJygQBIUUZp
        HtwcWGJ4xSgO9JYw71WQKh5gUoGb9ApoCRPQEkFPsCUliQgpqQbGEI6lomVed0pP3vt2NaHj
        xY4Qx2sZkvW/O17aZDNMLf7xfN+anbscbF+deBuw4ixD8u/NKyTrdy5qqNByYrJi+s+3dWpG
        q8gVDo+brErWlsvSenYyCK1vTdp1T/fR5skuH8R3yvw9aKf1v19Abo8V56vpzS2/Hey3XCmM
        jzx5r/KjL8ebcBUTJZbijERDLeai4kQA2muhJ+cCAAA=
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

