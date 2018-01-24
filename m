Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED09F1F576
	for <e@80x24.org>; Wed, 24 Jan 2018 11:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeAXLOn (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 06:14:43 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:49222 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933236AbeAXLOf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 24 Jan 2018 06:14:35 -0500
X-AuditID: 1207440e-1c1ff70000000b4f-39-5a686a980990
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 27.6B.02895.99A686A5; Wed, 24 Jan 2018 06:14:33 -0500 (EST)
Received: from bagpipes.fritz.box (p54AAE3E5.dip0.t-ipconnect.de [84.170.227.229])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w0OBEIiA004669
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Jan 2018 06:14:30 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kim Gybels <kgybels@infogroep.be>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/6] packed_ref_cache: don't use mmap() for small files
Date:   Wed, 24 Jan 2018 12:14:16 +0100
Message-Id: <411272c9a3fd159ceae4649ebdb9d121ba0ea742.1516791909.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
References: <cea5e366-dc95-6f41-6373-f8bbef103561@alum.mit.edu>
In-Reply-To: <cover.1516791909.git.mhagger@alum.mit.edu>
References: <cover.1516791909.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqDszKyPK4OJlM4uuK91MFg29V5gt
        +pd3sVkc7JzJanF7xXxmix8tPcwObB5/339g8vjwMc6j78gaRo9nvXsYPS5eUvb4vEkugC2K
        yyYlNSezLLVI3y6BK6Pn61SWglauird7NrA3MM7h6GLk5JAQMJFonfyRpYuRi0NIYAeTRO/h
        ZijnEpPEqUunGUGq2AR0JRb1NDOB2CICahIT2w6BFTELnGaU2LV/GQtIQljAXWLjpcdgNouA
        qsS0PfdYQWxegSiJ6cfWskKsk5d4v+A+2FBOAQeJ7h2X2EBsIQF7ie5rh5i7GDmA4hYSlxdp
        gZhCAuYSd/7xTGDkW8DIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJPT4
        djC2r5c5xCjAwajEw3vDIj1KiDWxrLgy9xCjJAeTkihvflBGlBBfUn5KZUZicUZ8UWlOavEh
        RgkOZiUR3jxWoHLelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSvfybQ
        UMGi1PTUirTMnBKENBMHJ8hwHqDhK0FqeIsLEnOLM9Mh8qcYdTluvHjdxizEkpeflyolzlsB
        UiQAUpRRmgc3B5YyXjGKA70lzLsYpIoHmG7gJr0CWsIEtORGTSrIkpJEhJRUA6Om599+tevT
        cwrcL801To0LS1quotWnv9Dg9qxbzNJHSj6fmr1AZLLBbBvnrVWxdgXPza5tWiV5TOqG8Aou
        3TtvLO48fZF6bfmzVR/XOXQ/ZDIPtJqxnunUxgX/VnPsKlaZ/9pdSKRVcu76vWqnDmnECXNz
        Mj64q+BxIjvvqB9PuFBHzL1bCZJKLMUZiYZazEXFiQC3xm8i9AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kim Gybels <kgybels@infogroep.be>

Take a hint from commit ea68b0ce9f8 (hash-object: don't use mmap() for
small files, 2010-02-21) and use read() instead of mmap() for small
packed-refs files.

Signed-off-by: Kim Gybels <kgybels@infogroep.be>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index e829cf206d..8b4b45da67 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -458,6 +458,8 @@ static void verify_buffer_safe(struct snapshot *snapshot)
 				 last_line, eof - last_line);
 }
 
+#define SMALL_FILE_SIZE (32*1024)
+
 /*
  * Depending on `mmap_strategy`, either mmap or read the contents of
  * the `packed-refs` file into the snapshot. Return 1 if the file
@@ -495,7 +497,7 @@ static int load_contents(struct snapshot *snapshot)
 
 	if (!size) {
 		return 0;
-	} else if (mmap_strategy == MMAP_NONE) {
+	} else if (mmap_strategy == MMAP_NONE || size <= SMALL_FILE_SIZE) {
 		snapshot->buf = xmalloc(size);
 		bytes_read = read_in_full(fd, snapshot->buf, size);
 		if (bytes_read < 0 || bytes_read != size)
-- 
2.14.2

