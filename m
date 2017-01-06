Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED981FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967535AbdAFQYN (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:24:13 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:57880 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967356AbdAFQXX (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:23 -0500
X-AuditID: 12074412-5ddff700000009b5-18-586fc479e61b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 02.CF.02485.974CF685; Fri,  6 Jan 2017 11:23:21 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX7023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:20 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 17/23] log_ref_write_1(): inline function
Date:   Fri,  6 Jan 2017 17:22:37 +0100
Message-Id: <4315abb71f381c217702d70ea34e95fc3dfcc37e.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsUixO6iqFt5JD/CYGqLlUXXlW4mi4beK8wW
        uxf3M1vcXjGf2WLJw9fMFj9aepgtOqfKOrB7/H3/gclj56y77B7Ll65j9OhqP8Lm8ax3D6PH
        xUvKHp83yQWwR3HZpKTmZJalFunbJXBlHJw1gb2gg7vixuoLTA2M/zm6GDk5JARMJObM2szS
        xcjFISRwmVFi24NudgjnBJPE2r0TmUCq2AR0JRb1NIPZIgJqEhPbDoF1MAt8YJT41TmLHSQh
        LGAj8fbOElYQm0VAVWLbmW6wOK9AlET/q2csEOvkJC5t+8IMYnMKWEg07vrGCGILCZhLfJp4
        mHkCI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZJXqpKaWbGCEhJrSDcf1JuUOM
        AhyMSjy8EV55EUKsiWXFlbmHGCU5mJREecMc8yOE+JLyUyozEosz4otKc1KLDzFKcDArifDa
        HQLK8aYkVlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8P4BaRQsSk1PrUjL
        zClBSDNxcIIM5wEaLngYZHhxQWJucWY6RP4Uo6KUOO8WkGYBkERGaR5cLywFvGIUB3pFmDcI
        pJ0HmD7gul8BDWYCGewJNrgkESEl1cC45vskHvF7D61vTtp3V/zW7wc7ole5M7k6q3+7VZbk
        kfJ73vUJPyV6usTOLfX/x6dw+XDu2v/hRdz+0w0LGf2XR/9663XU8XOrba/63YJdTRPiHI+y
        iihk/V38g3XjtP/3wv48XGez8Ndi0ZT451tYDl5vXszqXNrO+0zLflWi0H3vmhUl0UGaSizF
        GYmGWsxFxYkAMCKl9NwCAAA=
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
index 846380f..39d6f5b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2821,9 +2821,9 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
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
 
@@ -2858,13 +2858,6 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
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

