Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C203F202A0
	for <e@80x24.org>; Sat, 28 Oct 2017 09:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbdJ1JuL (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 05:50:11 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:47161 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751029AbdJ1JuH (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2017 05:50:07 -0400
X-AuditID: 12074413-38bff70000007929-21-59f452cdd34c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 18.47.31017.DC254F95; Sat, 28 Oct 2017 05:50:05 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE7F1.dip0.t-ipconnect.de [84.170.231.241])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9S9nwqY016802
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 28 Oct 2017 05:50:04 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 3/7] ref_transaction_update(): die on disallowed flags
Date:   Sat, 28 Oct 2017 11:49:52 +0200
Message-Id: <10901328af1e6e04e8c7c7b39977ec85f6c58142.1509183413.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509183413.git.mhagger@alum.mit.edu>
References: <cover.1509183413.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqHs26EukweZ2JYuuK91MFg29V5gt
        bq+Yz2xx5k0jowOLx9/3H5g8Ll5S9lj8wMvj8ya5AJYoLpuU1JzMstQifbsEroxbK/rYCz6y
        Vjw49ZGpgfEZSxcjB4eEgInEzMaSLkYuDiGBHUwSD+9PYoRwTjFJXP15grWLkZODTUBXYlFP
        MxOILSKgJjGx7RALiM0sUCTxdf1ZsLiwgJvEle3fwYayCKhKrN6lCRLmFYiS+PP2A9gYCQF5
        iXMPbjOD2JwCFhJ3l60Fs4UEzCXevlnAOoGRZwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQi
        XXO93MwSvdSU0k2MkAAR3sG466TcIUYBDkYlHl6J3M+RQqyJZcWVuYcYJTmYlER5953/FCnE
        l5SfUpmRWJwRX1Sak1p8iFGCg1lJhPeiz5dIId6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU
        7NTUgtQimKwMB4eSBG9QIFCjYFFqempFWmZOCUKaiYMTZDgP0PBGkBre4oLE3OLMdIj8KUZL
        jhsPr/9h4ui4eRdIPpv5uoFZiCUvPy9VSpz3BUiDAEhDRmke3ExYxL9iFAd6UZh3NkgVDzBZ
        wE19BbSQCWihhiTYwpJEhJRUA6O+VsDLP9dKH7dvXM/F8f+O0BV989VKwo/WVu9yjpzJUn9S
        diIP+5cX7uueq/x5/Se4587xLTyfbJ6c/GV7eZv+jLorJVu8pvrvM1n+pPqGxfoXldKX2G5c
        XsPTt356aNaTFZONJ1VscZgw/Z8Vi77nPevHNorOU9S7TR9t2pqUt2vmyfLuuEWTlViKMxIN
        tZiLihMB1xTVeNMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callers shouldn't be passing disallowed flags into
`ref_transaction_update()`. So instead of masking them off, treat it
as a bug if any are set.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 62a7621025..7c1e206e08 100644
--- a/refs.c
+++ b/refs.c
@@ -940,7 +940,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
+	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
+		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
 
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
-- 
2.14.1

