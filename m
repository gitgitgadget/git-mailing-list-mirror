Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD19C20958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755654AbdCTQeP (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:34:15 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:50745 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755614AbdCTQeJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 12:34:09 -0400
X-AuditID: 1207440e-ccbff7000000340b-72-58d0047a7a39
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 61.3C.13323.A7400D85; Mon, 20 Mar 2017 12:34:02 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906F9B.dip0.t-ipconnect.de [87.144.111.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2KGXV9Q010511
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 20 Mar 2017 12:34:00 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/20] get_loose_ref_cache(): new function
Date:   Mon, 20 Mar 2017 17:33:21 +0100
Message-Id: <070b6e91dc78feeb50490b1e83526d64a326aec3.1490026594.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490026594.git.mhagger@alum.mit.edu>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsUixO6iqFvFciHCoGuqtEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s0X3lLeMFj9aepgd2Dz+vv/A5LFz1l12j672I2wez3r3MHpcvKTs8XmTXABb
        FJdNSmpOZllqkb5dAldGR1tZwXTOis03WhgbGB+wdzFyckgImEicnHSBsYuRi0NIYAeTxKYV
        m5ghnFNMEqsX/mQGqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCzwiFHi6vy7YKOEBawkDi//xQhi
        swioSkyY0M0KYvMKREmcvNIAtU5eYlfbRbA4p4CFxJf7jSwgtpCAuUTngl72CYw8CxgZVjHK
        JeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKEhBPfDsb29TKHGAU4GJV4eFdcOR8h
        xJpYVlyZe4hRkoNJSZT36W2gEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeqpdAOd6UxMqq1KJ8
        mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO8ChgsRQoJFqempFWmZOSUIaSYOTpDh
        PEDD54DU8BYXJOYWZ6ZD5E8xKkqJ837/D7RVACSRUZoH1wuL91eM4kCvCPPeAmnnAaYKuO5X
        QIOZgAYvu3EGZHBJIkJKqoFx7YRvgr5qzNzzNFbXmUxaE5595O6D/NNH37drHL03cd3itItu
        r37/O3f+1fRyh55fL7a6HZmxNv4um7DLcpfzc0P+L6rLmKIZtU/DzL1KSnrSuq+zEu7e2t5V
        f8A08EukbHT1wTlSm37YN9XdrD0muv0Wc/zGLUofln49qhTn3bYkf0FH5D8FZSWW4oxEQy3m
        ouJEAPpi7nrSAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a new function, `get_loose_ref_cache()`, from
get_loose_ref_dir(). The function returns the `ref_cache` for the
loose refs of a `files_ref_store`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0a16f6196c..fefc29433a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -525,7 +525,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 	}
 }
 
-static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
+static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 {
 	if (!refs->loose) {
 		/*
@@ -545,7 +545,12 @@ static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
 		add_entry_to_dir(get_ref_dir(refs->loose->root),
 				 create_dir_entry(refs->loose, "refs/", 5, 1));
 	}
-	return get_ref_dir(refs->loose->root);
+	return refs->loose;
+}
+
+static struct ref_dir *get_loose_ref_dir(struct files_ref_store *refs)
+{
+	return get_ref_dir(get_loose_ref_cache(refs)->root);
 }
 
 /*
-- 
2.11.0

