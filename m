Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91E2A20A93
	for <e@80x24.org>; Fri,  6 Jan 2017 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967515AbdAFQX4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 11:23:56 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46920 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967412AbdAFQXa (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 6 Jan 2017 11:23:30 -0500
X-AuditID: 1207440c-e53ff700000009a1-19-586fc47b528b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.00.02465.B74CF685; Fri,  6 Jan 2017 11:23:23 -0500 (EST)
Received: from bagpipes.fritz.box (p57906F4E.dip0.t-ipconnect.de [87.144.111.78])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v06GMmX8023262
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 6 Jan 2017 11:23:21 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 18/23] delete_ref_loose(): derive loose reference path from lock
Date:   Fri,  6 Jan 2017 17:22:38 +0100
Message-Id: <8967c11634eeb911a056a9c1ed6b4409713e94d3.1483719289.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483719289.git.mhagger@alum.mit.edu>
References: <cover.1483719289.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqFt9JD/C4MFjaYuuK91MFg29V5gt
        di/uZ7a4vWI+s8WSh6+ZLX609DBbdE6VdWD3+Pv+A5PHzll32T2WL13H6NHVfoTN41nvHkaP
        i5eUPT5vkgtgj+KySUnNySxLLdK3S+DKWLBHpuAlW8W7ZVsZGxgPs3YxcnJICJhIXN41laWL
        kYtDSOAyo8S3Ny8ZIZwTTBIfF5xgA6liE9CVWNTTzARiiwioSUxsOwTWwSzwgVHiV+csdpCE
        sECwxJIrD8HGsgioSvQ0TAJr5hWIkniw8wUTxDo5iUvbvjCD2JwCFhKNu74xgthCAuYSnyYe
        Zp7AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6hXm5miV5qSukmRkiA8exg/LZO5hCj
        AAejEg9vhFdehBBrYllxZe4hRkkOJiVR3jDH/AghvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzt
        e4FyvCmJlVWpRfkwKWkOFiVxXtUl6n5CAumJJanZqakFqUUwWRkODiUJ3vsHgRoFi1LTUyvS
        MnNKENJMHJwgw3mAhq8CqeEtLkjMLc5Mh8ifYtTlOPB+xVMmIZa8/LxUKXFee5AiAZCijNI8
        uDmwxPCKURzoLWHexyBVPMCkAjfpFdASJqAlgp5gS0oSEVJSDYyFPH83F36MMk/Q6d7HXbOP
        yWTb/yObexeJaFZ0iL256MC4PzTjn3/x67AvE1VSuD3WVbrO631/ouyduKX7igUNk6NPmXW3
        /F17JmlT8OGsPGExLYPDtwyDD9juSDb7la/I+/1rk6VE2NToxn18V/7dOb04W392etc2yzUM
        R8UWflrtt2zWwSwlluKMREMt5qLiRABMtE0J5wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is simpler to derive the path to the file that must be deleted from
"lock->ref_name" than from the lock_file object.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 39d6f5b..4d55364 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2430,10 +2430,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 		 * loose.  The loose file name is the same as the
 		 * lockfile name, minus ".lock":
 		 */
-		char *loose_filename = get_locked_file_path(lock->lk);
-		int res = unlink_or_msg(loose_filename, err);
-		free(loose_filename);
-		if (res)
+		if (unlink_or_msg(git_path("%s", lock->ref_name), err))
 			return 1;
 	}
 	return 0;
-- 
2.9.3

