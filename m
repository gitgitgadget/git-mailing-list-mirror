Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCC3D201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbdEQMGZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:25 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63169 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753359AbdEQMGR (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:17 -0400
X-AuditID: 1207440c-9c1ff70000001412-92-591c3cb2adf6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E0.AB.05138.2BC3C195; Wed, 17 May 2017 08:06:10 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pfx000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:09 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/23] lockfile: add a new method, is_lock_file_locked()
Date:   Wed, 17 May 2017 14:05:31 +0200
Message-Id: <70fbcd573f5c8a78a19a08ffc255437c36e7f49d.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsUixO6iqLvJRibSYO1KY4u1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG84UnWAq+sFYcnHOQrYHxJUsXIweHhICJ
        xLwumy5GLg4hgR1MEjefHmGDcE4wSVyadZ+5i5GTg01AV2JRTzMTiC0ioCYxse0QC0gRs8Bj
        Jom/y7pZQBLCAh4Sm+cuZQWxWQRUJZYtmcYGYvMKREn8+PoBLC4hIC+xq+0imM0pYCFx//0j
        dpArhATMJbZfr5zAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6hXm5miV5qSukmRkig
        8exg/LZO5hCjAAejEg/vBC7pSCHWxLLiytxDjJIcTEqivPsfAIX4kvJTKjMSizPii0pzUosP
        MUpwMCuJ8N40lYkU4k1JrKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8E6x
        BmoULEpNT61Iy8wpQUgzcXCCDOcBGs4FUsNbXJCYW5yZDpE/xajLMefe1/dMQix5+XmpUuK8
        B0CKBECKMkrz4ObAEsQrRnGgt4R580CqeIDJBW7SK6AlTEBLmkG+4y0uSURISTUwJkxSks18
        nn58V9e/mfsfPhZq/s2yQ/zPi8VHX2xadi9Dut4h5jHHqye52U+/tlxds6hm7VLrqxoe+n3W
        trNmB7ELz83xuHLUNs1067yDahY7ts4tj/zMX7xkYwwbd3vd9663Wjc95+yWMW/iWJfAqfGp
        yNQh97RD5HrOAwoZahHH4yJnX/bWVWIpzkg01GIuKk4EAPvBQ8XrAgAA
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

