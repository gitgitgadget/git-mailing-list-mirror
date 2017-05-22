Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 135762023D
	for <e@80x24.org>; Mon, 22 May 2017 14:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934711AbdEVOSt (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:18:49 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:64445 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934694AbdEVOSf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:35 -0400
X-AuditID: 1207440d-de7ff70000000e33-63-5922f3349244
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 21.B8.03635.533F2295; Mon, 22 May 2017 10:18:29 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24I023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:26 -0400
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
Subject: [PATCH v2 09/25] lockfile: add a new method, is_lock_file_locked()
Date:   Mon, 22 May 2017 16:17:39 +0200
Message-Id: <41938a21a7fe83b197b8b27417b0ad1230f5266a.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsUixO6iqGv6WSnSYPp0fou1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxvOFJ1gKvrBW
        HJxzkK2B8SVLFyMnh4SAicTHh9eYuxi5OIQEdjBJnPn0iQXCOcUksfdQD1gVm4CuxKKeZiYQ
        W0RATWJi2yGwImaBDcwSb6avBksIC3hLNJybxghiswioSiz5eAWsmVcgSmLuqqlQ6+QldrVd
        ZAWxOQUsJH7POgDWKyRgLtH7bzXLBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0jfRy
        M0v0UlNKNzFCQpF3B+P/dTKHGAU4GJV4eDUeK0UKsSaWFVfmHmKU5GBSEuU9+gYoxJeUn1KZ
        kVicEV9UmpNafIhRgoNZSYRX+y5QjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUI
        JivDwaEkwav3CahRsCg1PbUiLTOnBCHNxMEJMpwHaPiaDyDDiwsSc4sz0yHypxh1Oebc+/qe
        SYglLz8vVUqc1wBkkABIUUZpHtwcWAp5xSgO9JYwrwlIFQ8w/cBNegW0hAloifUzeZAlJYkI
        KakGRqZA8/MK+QenbGBKnG6tP7HFLbNqScDG/KLCnDS7n46GHNsmtScsWFPVXvNI1HF+R9Xl
        yRbbsuZo+n46KfRqk4HerksNRTxv30tMC+qsEOL97lBT977m2qHjB7cvPnHm8tLQmGapz2JM
        r3t9A++WGM3p6tKZ9+79y7o3S/hNTRctblR5oKhwWYmlOCPRUIu5qDgRAP5py/b8AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It will soon prove useful.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lockfile.h b/lockfile.h
index 7b715f9e77..572064939c 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -175,6 +175,14 @@ static inline int hold_lock_file_for_update(
 	return hold_lock_file_for_update_timeout(lk, path, flags, 0);
 }
 
+/*
+ * Return a nonzero value iff `lk` is currently locked.
+ */
+static inline int is_lock_file_locked(struct lock_file *lk)
+{
+	return is_tempfile_active(&lk->tempfile);
+}
+
 /*
  * Append an appropriate error message to `buf` following the failure
  * of `hold_lock_file_for_update()` to lock `path`. `err` should be the
-- 
2.11.0

