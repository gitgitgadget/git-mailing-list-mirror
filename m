Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C3A1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeC1Sig (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:38:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39587 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeC1Sig (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:38:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id c78so1390896pfj.6
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGoQeVvOPqyOYm9Oa3G9t0p1Ol1/Itm9ouS7cdIrUw4=;
        b=CuHjTn4qGI2A6/5RO2XBjK1vQZqsdBrAbTWESwh+cwjloNhPlaSko9e6aZPCHTh30z
         Z6eLY0jstzhL8l2DEcKx0lCVn6SVwYFrtXdHEEWz2RdsjYWPSXTcXR8QR9gl5GYm7L/X
         I6nBarumK5IOc9/a/gdIWJbme6ucphObHLTvdVJ4Co+y9o0TYr4BSMrHDs4gEOyNDMD3
         dELAe5L96upwosnt3rYzwXDw6tyc+wdY4TjKPh6buYHJps45fdimsBohW0DdbG3QuKyK
         sk17Pisz/vMSPEuU3Wxz/0QJsn1TCst0ckpM8Vr0XYKeu1ryZm4oICIpQo+d/FaEEmeb
         8cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kGoQeVvOPqyOYm9Oa3G9t0p1Ol1/Itm9ouS7cdIrUw4=;
        b=GasbiNwfwu8/nTABQJ8NsaFiaCS0WNVB3fLb28+FOA4Vp7LL1mlPGV7PXgLd7kRgvI
         q4ANaYKAtVOu+NfMDDPOmd4tv+arwBUqmrTNS5ivfOuEMFfZU7qfuF0OvqPLJgUOh8tv
         XdAVrwK+NbM7fuV19EYXf9+CsyRtQy3UF1vqpdfY7JhJXJ1AwxY7m9hzdzp/bBj6RGfT
         ppz1n2m7oBErX7Z4nPUZAeUUs8QmE/FkOcKR1IEafrec90PRjezJIhmbYQc8xEV0Vt2b
         RRtLyf2u6v5Vim+UaAb90IfJjtFRGL7t/dsedJK6q9IJ3pSZaUoB+uYMZ2UbYQY8Fish
         tsOQ==
X-Gm-Message-State: AElRT7Ht/5ailVDNqk62wMcpM0MGbygvx/BRdzt0MJZBH97qvBzp3cF2
        jFZRBFgOAyk31imkqs80+PITLg==
X-Google-Smtp-Source: AIpwx4/B2XwL2dBU1mNLTW3rIyv6FsIqyj/emLU0MIX6QS7d70TWN0HQOqkpJP3qWgxSew8qW9YyDg==
X-Received: by 2002:a17:902:1006:: with SMTP id b6-v6mr4917733pla.252.1522262315248;
        Wed, 28 Mar 2018 11:38:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id w24sm9552646pfl.84.2018.03.28.11.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 11:38:34 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     l.s.r@web.de
Cc:     git@vger.kernel.org, gitster@pobox.com, jeremy@feusi.co,
        pc44800@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: check for NULL return of get_submodule_ref_store()
Date:   Wed, 28 Mar 2018 11:38:32 -0700
Message-Id: <20180328183832.243036-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
In-Reply-To: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
References: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: René Scharfe <l.s.r@web.de>

If we can't find a ref store for a submodule then assume it the latter
is not initialized (or was removed).  Print a status line accordingly
instead of causing a segmentation fault by passing NULL as the first
parameter of refs_head_ref().

Reported-by: Jeremy Feusi <jeremy@feusi.co>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

I added a test for you.

Thanks,
Stefan

 builtin/submodule--helper.c |  8 ++++++--
 t/t7400-submodule-basic.sh  | 12 ++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ee020d4749..ae3014ac5a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -654,9 +654,13 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			     displaypath);
 	} else if (!(flags & OPT_CACHED)) {
 		struct object_id oid;
+		struct ref_store *refs = get_submodule_ref_store(path);
 
-		if (refs_head_ref(get_submodule_ref_store(path),
-				  handle_submodule_head_ref, &oid))
+		if (!refs) {
+			print_status(flags, '-', path, ce_oid, displaypath);
+			goto cleanup;
+		}
+		if (refs_head_ref(refs, handle_submodule_head_ref, &oid))
 			die(_("could not resolve HEAD ref inside the "
 			      "submodule '%s'"), path);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a39e69a3eb..d8aee51603 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -821,6 +821,18 @@ test_expect_success 'moving the superproject does not break submodules' '
 	)
 '
 
+test_expect_success 'moving the submodule does not break the superproject' '
+	(
+		cd addtest2 &&
+
+		mv repo repo.bak &&
+		git submodule status >actual &&
+		grep -e "^-" -e repo actual &&
+
+		mv repo.bak repo
+	)
+'
+
 test_expect_success 'submodule add --name allows to replace a submodule with another at the same path' '
 	(
 		cd addtest2 &&
-- 
2.17.0.rc1.321.gba9d0f2565-goog

