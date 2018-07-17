Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA885208EB
	for <e@80x24.org>; Tue, 17 Jul 2018 12:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbeGQMkC (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 08:40:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37336 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731642AbeGQMjL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id a19-v6so1263273wmb.2
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=CPFy7omQxM1VPahYFFb+Lpm01LZBea5/ut+GEis2Kms=;
        b=DwBkyp9qDhRnM/byY15q1bs18oh+CxAGqVIWgZU3fUZoLwx4LII3Ch9z0cnnq8Sufd
         1VBe5wFCe2OxZ0879oo77kRSxMIyoqDZjDvt8+bbTA81t9pt+085WZfG1WqqZ2tn+4an
         RM88evF1skfASvDJT9IYBPUATy8jXfbUfwieCme5Q5OT5fgt47DmD+I3VPJ3XKZiQeAf
         97qk/3G4x9HVbt+7L++RF8IKbSUTsrWM3Qkdd4ZRtkPxn5rC4t2RLeTiXCSWVXO/aTCR
         g1H/6U2kDSHTQvealBDiC4i/LCiCoLo/SmSqIaAdWYlK5pMK9a5ENS/O1qLddqRhgYqV
         xwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=CPFy7omQxM1VPahYFFb+Lpm01LZBea5/ut+GEis2Kms=;
        b=iUrDMJ8fiE114g6jVSJwnowuyvhyS54ouYh43hw5cboWYvZCFVuozA/GwHwoX1gDAq
         dCsofvyCEQY/tyEyV+rK70RNkbt85XfN5oiwiwIxK6nrdXMThTbe0loVMC9bAKv0cNPe
         5pqO3ueX1/aKkB3NDuOPW7WaIVhx/J1eWSo2SAomuiUPAE7i2rU5yssJOg8cNF9g36Ug
         dEBbsK1dUmqjEjMqYf1IkyWxhT9TS+Y/kKKn7pu8ccaX+HqYSBUXSh94l5BZrRLFSe0k
         ZTxv8rJoNZPGtmiKcu7cXkRMChNr2iX/jKchrCNx59JZn3degElStax5YiNWZAJZ5Zjf
         cXDA==
X-Gm-Message-State: AOUpUlGUazGMf7S4i6H+WT220+zJ3OtoJszmfw8tkmu3Nlq82Y603dlu
        Ftjv+b4xWJ0pe8s0RzsOPjcXuQ==
X-Google-Smtp-Source: AAOMgpfeMRwLiQ5NRADhHPYI+MHB2lOh15WTgvwn1VIYAcLrQkP4YWNJkbjuFBTaZ6l7VvMmgkCIKg==
X-Received: by 2002:a1c:9550:: with SMTP id x77-v6mr1106537wmd.135.1531829209336;
        Tue, 17 Jul 2018 05:06:49 -0700 (PDT)
Received: from sebi-laptop.tendawifi.com (5-13-157-218.residential.rdsnet.ro. [5.13.157.218])
        by smtp.gmail.com with ESMTPSA id d4-v6sm542099wrp.51.2018.07.17.05.06.48
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 05:06:48 -0700 (PDT)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 4/6] sha1-name: Teach `get_oid_basic()` to be gentle
Date:   Tue, 17 Jul 2018 15:06:34 +0300
Message-Id: <d91384ff0e23cd845bcfdf170c8a162ec5551f6b.1531778417.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.18.0.rc2.184.ga79db55c2.dirty
In-Reply-To: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After teaching `read_ref_at()` we need to teach `get_oid_basic()`
that `read_ref_at()` might not call `exit()`, but report an
error through the return value.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 sha1-name.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index d741e1129..74ecbd550 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -778,6 +778,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 		timestamp_t at_time;
 		timestamp_t co_time;
 		int co_tz, co_cnt;
+		int ret;
 
 		/* Is it asking for N-th entry, or approxidate? */
 		for (i = nth = 0; 0 <= nth && i < reflog_len; i++) {
@@ -802,8 +803,12 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, flags, at_time, nth, oid, NULL,
-				&co_time, &co_tz, &co_cnt)) {
+
+		ret = read_ref_at(real_ref, flags, at_time, nth, oid, NULL,
+				&co_time, &co_tz, &co_cnt);
+		if (ret == -1)
+			return -1;
+		if (ret) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
 					str = real_ref + 11;
@@ -821,9 +826,12 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
 				}
 			} else {
-				if (flags & GET_OID_QUIETLY) {
-					exit(128);
+				if (flags & GET_OID_GENTLY) {
+					free(real_ref);
+					return -1;
 				}
+				if (flags & GET_OID_QUIETLY)
+					exit(128);
 				die("Log for '%.*s' only has %d entries.",
 				    len, str, co_cnt);
 			}
-- 
2.18.0.rc2.184.ga79db55c2.dirty

