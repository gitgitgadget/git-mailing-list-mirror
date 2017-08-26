Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5F620285
	for <e@80x24.org>; Sat, 26 Aug 2017 08:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754523AbdHZI2j (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 04:28:39 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54564 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754345AbdHZI2f (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Aug 2017 04:28:35 -0400
X-AuditID: 1207440e-be1ff70000007085-e8-59a131327df0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.7B.28805.23131A95; Sat, 26 Aug 2017 04:28:34 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5EB.dip0.t-ipconnect.de [87.188.197.235])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7Q8SHin004049
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 26 Aug 2017 04:28:32 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johan Herland <johan@herland.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 07/12] load_subtree(): only consider blobs to be potential notes
Date:   Sat, 26 Aug 2017 10:28:07 +0200
Message-Id: <f57e3132fcb98b1a9f36b07886d3620bd224e377.1503734566.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1503734566.git.mhagger@alum.mit.edu>
References: <cover.1503734566.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsUixO6iqGtkuDDS4Nh2HouuK91MFg29V5gt
        5t3dxWTRv7yLzeL2ivnMDqwef99/YPL48DHO49LL72weFy8pe3zeJBfAGsVlk5Kak1mWWqRv
        l8CV0XVpF1PBXPaKVy/fsTYwXmXtYuTgkBAwkVj4j62LkYtDSGAHk8S7D+9ZIJxTTBIbeiYD
        ZTg52AR0JRb1NDOB2CICahIT2w6BFTELLGeU6Hh7nglkkrBAgMSOp9IgNSwCqhKrv11lB7F5
        BaIkVr6ZADZHQkBeYlfbRVYQm1PAQuLG1s9gcSEBc4m+n4tYJjDyLGBkWMUol5hTmqubm5iZ
        U5yarFucnJiXl1qka6yXm1mil5pSuokREjZ8Oxjb18scYhTgYFTi4d1QvCBSiDWxrLgy9xCj
        JAeTkiivg8bCSCG+pPyUyozE4oz4otKc1OJDjBIczEoivCuUgHK8KYmVValF+TApaQ4WJXFe
        tSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneDn2gRsGi1PTUirTMnBKENBMHJ8hwHqDhGSA1vMUF
        ibnFmekQ+VOMuhxNH7Z8YRJiycvPS5US53UAKRIAKcoozYObA4v3V4ziQG8J874GqeIBpgq4
        Sa+AljABLVEUBFtSkoiQkmpg3MK4tuRUBG9a3e2qOfc3F69yD/v6cfHycoub2VOXP/c06t65
        v5Yr6mLHr4mhbelf6mdeqZyTvHypzuMWn/Lp9y5+tOcP23JWI7y94oP7Qo2oPt2K5hsX00/e
        3L3qVmqma0nX1jnKsk1zNuhujfm2i+OiUOTlsghnwQaFVJXdUmv5b1U1X3sUp8RSnJFoqMVc
        VJwIAFCNM5vSAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old code converted any entry whose path constituted a full SHA-1
as a leaf node, without regard for the type of the entry. But only
blobs can be notes. So treat entries whose paths *look like* notes
paths but that are not blobs as non-notes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 notes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/notes.c b/notes.c
index ac69c5aa18..46ab15b83a 100644
--- a/notes.c
+++ b/notes.c
@@ -437,6 +437,11 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 
 		if (path_len == 2 * (GIT_SHA1_RAWSZ - prefix_len)) {
 			/* This is potentially the remainder of the SHA-1 */
+
+			if (!S_ISREG(entry.mode))
+				/* notes must be blobs */
+				goto handle_non_note;
+
 			if (get_oid_hex_segment(entry.path, path_len,
 						object_oid.hash + prefix_len,
 						GIT_SHA1_RAWSZ - prefix_len) < 0)
-- 
2.11.0

