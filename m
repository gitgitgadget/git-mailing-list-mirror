Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D77720259
	for <e@80x24.org>; Thu, 24 Nov 2016 11:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965277AbcKXLpu (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Nov 2016 06:45:50 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36372 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965060AbcKXLpt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2016 06:45:49 -0500
Received: by mail-pg0-f68.google.com with SMTP id x23so3223546pgx.3
        for <git@vger.kernel.org>; Thu, 24 Nov 2016 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ott5B2w5Ze5+X4qF0QX1iP6DXt5kTUHKrMFEHoHU6I8=;
        b=qaKfFbgFWMk7wezfuA7ur/DjTjHeMNWaWIxlfkIPLF8cZBK1ux12fL/ORF2F6ntFoI
         BWpmDSn1H0RC/Lnnbd4nupZfae6bXk99xoEEixh701zS8zcpPlvBbM5sZp4+1YBAPUXs
         BVi3NTDshUEM3oWoguhKGz2iB6dc1uFUw0/dQdtcaAEZ/oVP7vHE1l/7eaIjTUQUHZtu
         LWsp44Assuq+/d6Ggxd5GGhXohdknyZFnu4d7RwmITtTxeohkNRv2FtjqMG6HFVVXWTQ
         ktsEjyUhKjiT4APezhqUi4ZjbXf0yPPXy1YpLv5PB1Wrr/pm5g5zbU3uYTKKZXmihyac
         qBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ott5B2w5Ze5+X4qF0QX1iP6DXt5kTUHKrMFEHoHU6I8=;
        b=MyR5bpIDwfylUJR5ua2hKrW/feAXo4g1H6Nw3Dw1d6/D+v1VDfOVkeWhHju+jd94aC
         UbUT2SCxYaIJc0GVF0+vLlGIG7rUsIxxdldesGq4A+3wy497CaPEnEDEIUNe64M5eATr
         5OTnXg1a3uC4koZ8Da2GIZXDVY0ic3pNhvP6mvma5MFg5cMZf+K0fFx68F1EIk136W3L
         NN16DcbSUQoVBTjN1kYghgxFQJplZxJVQmF/nJamq7u8ueZV//ODUWsuUw4LDCswSvly
         Mtl/Bcej+KJPvt4+Ufs5rKZ5GaoWKh7poFtNFu0iALX4CjwkiR/ubtjjcQvvE9rycXDT
         vubQ==
X-Gm-Message-State: AKaTC03NuyP7MxR9x3RTlnKamHryWkrEAn5zaFUbEiw4adkxs154frSoh1buwS2oBEKfeA==
X-Received: by 10.98.58.81 with SMTP id h78mr1910857pfa.50.1479987948658;
        Thu, 24 Nov 2016 03:45:48 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id r124sm41940310pgr.6.2016.11.24.03.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2016 03:45:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Nov 2016 18:45:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] merge-recursive.c: use string_list_sort instead of qsort
Date:   Thu, 24 Nov 2016 18:45:36 +0700
Message-Id: <20161124114536.22249-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161122123019.7169-1-pclouds@gmail.com>
References: <20161122123019.7169-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This started out to as a hunt for remaining qsort() calls after rs/qsort
series because qsort() API is a bit easy to get wrong (*). However,
since we have string_list_sort(), it's conceptually a better way to sort
here.

(*) In this particular case, it's even more confusing when you sort one
variable but you use the number of items and item size from an unrelated
variable (from a first glance)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 merge-recursive.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9041c2f..90e83bd 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -388,12 +388,10 @@ static struct string_list *get_unmerged(void)
 	return unmerged;
 }
 
-static int string_list_df_name_compare(const void *a, const void *b)
+static int string_list_df_name_compare(const char *one, const char *two)
 {
-	const struct string_list_item *one = a;
-	const struct string_list_item *two = b;
-	int onelen = strlen(one->string);
-	int twolen = strlen(two->string);
+	int onelen = strlen(one);
+	int twolen = strlen(two);
 	/*
 	 * Here we only care that entries for D/F conflicts are
 	 * adjacent, in particular with the file of the D/F conflict
@@ -406,8 +404,8 @@ static int string_list_df_name_compare(const void *a, const void *b)
 	 * since in other cases any changes in their order due to
 	 * sorting cause no problems for us.
 	 */
-	int cmp = df_name_compare(one->string, onelen, S_IFDIR,
-				  two->string, twolen, S_IFDIR);
+	int cmp = df_name_compare(one, onelen, S_IFDIR,
+				  two, twolen, S_IFDIR);
 	/*
 	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
 	 * that 'foo' comes before 'foo/bar'.
@@ -451,8 +449,8 @@ static void record_df_conflict_files(struct merge_options *o,
 		string_list_append(&df_sorted_entries, next->string)->util =
 				   next->util;
 	}
-	qsort(df_sorted_entries.items, entries->nr, sizeof(*entries->items),
-	      string_list_df_name_compare);
+	df_sorted_entries.cmp = string_list_df_name_compare;
+	string_list_sort(&df_sorted_entries);
 
 	string_list_clear(&o->df_conflict_file_set, 1);
 	for (i = 0; i < df_sorted_entries.nr; i++) {
-- 
2.8.2.524.g6ff3d78

