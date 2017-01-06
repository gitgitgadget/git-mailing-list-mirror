Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77C41FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967549AbdAFQYR (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:24:17 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54540 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967317AbdAFQXT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:19 -0500
X-AuditID: 12074413-465ff70000000a33-b1-586fc4769d45
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 2B.A8.02611.674CF685; Fri,  6 Jan 2017 11:23:18 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX5023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:16 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 15/23] log_ref_write_1(): don't depend on logfile argument
Date:   Fri,  6 Jan 2017 17:22:35 +0100
Message-Id: <8c0da0a941845d73988e2c1100f8afb91e272841.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqFt2JD/CYPsbcYuuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKONh5kb3gEFdFw9ZLTA2MOzi6GDk4JARMJD7+Veli
        5OIQErjMKPF4/0UmCOcEk8TTVY+AHE4ONgFdiUU9zWC2iICaxMS2QywgRcwCHxglfnXOYgdJ
        CAv4Snyde5QNxGYRUJU4cX8+WAOvQJTE8ekNYDUSAnISl7Z9YQaxOQUsJBp3fWMEsYUEzCU+
        TTzMPIGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2MkAAT3sG466Tc
        IUYBDkYlHt4Ir7wIIdbEsuLK3EOMkhxMSqK8YY75EUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
        eO0OAeV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8f0AaBYtS01Mr
        0jJzShDSTBycIMN5gIYLHgYZXlyQmFucmQ6RP8WoKCXOuwWkWQAkkVGaB9cLSwCvGMWBXhHm
        DQJp5wEmD7juV0CDmUAGe4INLklESEk1MC6wuvqqWsXDcodH6602mW/vtxt6nT273iX9kdJp
        3jgJl5J6o697hLIjA1ffNzzc1xdke+7weaEZ55b9WfzJPKnunBPLTYHVFv/MpZYXsOYXf4rU
        XyIvz3bsjFVH4ynTkP7rSicPmV51OJFQJyn4Of3dI41L11r448TvHXeYe+6qM+tmNenPm5RY
        ijMSDbWYi4oTAbpO99bbAgAA
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
index f723834..9c5e804 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2838,14 +2838,18 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
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

