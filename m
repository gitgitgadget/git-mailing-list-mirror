Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EDCC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23E56120D
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 03:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhFVDX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 23:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFVDXS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:18 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E585C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:02 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n23so11790897wms.2
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 20:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QxfA76uPNJURqsKam/o3DOPrqTUDnF2+h0uTrqKQQHU=;
        b=pDWIavwAG7vPCnxe0KomFGJJelIeeRocpkh41ZeCw9Lhn4TG0iXAC8kwFm79TWRrAC
         vUYZkSFIO+PeLk57byKgSLJDFM4UmX9K0UfEpwsx8kHrZLrB6KuXMjtog3CbxodB0qcj
         tdq4igiAlMdjYNbzpJoUKKmg8qYhjh769UmJEayMMbj01yO/VgYjc4YLl11ymRCpl1q2
         c9c20Ovpv/7QteOrMZ07K6gcUg0EYR20ebMORjPkdnRhijJqEHr8KWg/nAOJR2zkJFfg
         TZgO7yi+MVtqbcebt7jat7cfCdbeDqHX0t33jnIZWbxgyHK3XvH36p5IOf5DEiFhGGdW
         S8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QxfA76uPNJURqsKam/o3DOPrqTUDnF2+h0uTrqKQQHU=;
        b=FygALw6wuqwsAhJ1CKQkTatQYGTs/n10GB4tYkCusTeMNjzMLjbkk+ZVytTkCXt/uH
         dgAYfAbpflw6KP9iV0Mi0Y6OOD0QcLAuYH9hr9s49jwj4ZN+vsYraB4nQX6xEeluVjGW
         85H1w+zh+WxI1QiGN9tS3xHx25rzYBIb6VNuhUydzt7XG/wdjQn3rSz+idbhbHHW9SwY
         SMw1HdLG9XfJDoJEZEOjLBorO6DxYKuFC59BExksDm74dXej3ZxrotKLbNwgCKvme6OE
         FXrLBzP1DHH+RwBtN09bkvEt/NXuFgr1edlV5vQA6TaUbG3WITvBpZKt7jNfmzMf+px3
         FwAw==
X-Gm-Message-State: AOAM533d4RUgKQpE5qbS9Yuis1UWmCba6/89nn1r/kX/Ls57GVdYwYs0
        89lgPZDV5QpBiiXi3BGtxgidqIJ9jLQ=
X-Google-Smtp-Source: ABdhPJzjm0g/dGl+DCef+I0aKYFQZu8KeUXWsMpNeIdrRaB8P8e7bDb4TrzOKHZdoA1L77KMmOW3yA==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr1886129wmk.79.1624332061280;
        Mon, 21 Jun 2021 20:21:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y16sm15910403wrp.51.2021.06.21.20.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 20:21:01 -0700 (PDT)
Message-Id: <db7dd8b042c281afdccb650f9679e88a4e378b65.1624332055.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
References: <pull.980.v3.git.1624086181.gitgitgadget@gmail.com>
        <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 03:20:49 +0000
Subject: [PATCH v4 09/14] [GSOC] ref-filter: modify the error message and
 value in get_object
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Let get_object() return 1 and print "<oid> missing" instead
of returning -1 and printing "missing object <oid> for <refname>"
if oid_object_info_extended() unable to find the data corresponding
to oid. When `cat-file --batch` use ref-filter logic later it can
help `format_ref_array_item()` just report that the object is missing
without letting Git exit.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c                   | 4 ++--
 t/t6301-for-each-ref-errors.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f21f41df0d88..181d99c92735 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1749,8 +1749,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 	}
 	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
 				     OBJECT_INFO_LOOKUP_REPLACE))
-		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
-				       oid_to_hex(&oi->oid), ref->refname);
+		return strbuf_addf_ret(err, 1, _("%s missing"),
+				       oid_to_hex(&oi->oid));
 	if (oi->info.disk_sizep && oi->disk_size < 0)
 		BUG("Object size is less than zero.");
 
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index 40edf9dab534..3553f84a00c1 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -41,7 +41,7 @@ test_expect_success 'Missing objects are reported correctly' '
 	r=refs/heads/missing &&
 	echo $MISSING >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
-	echo "fatal: missing object $MISSING for $r" >missing-err &&
+	echo "fatal: $MISSING missing" >missing-err &&
 	test_must_fail git for-each-ref 2>err &&
 	test_cmp missing-err err &&
 	(
-- 
gitgitgadget

