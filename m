Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A230C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB3D610E6
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 11:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhGLLuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 07:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhGLLt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 07:49:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F9EC0613E5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id j34so11193794wms.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6x+Lq6UZlHCJIcz9CvulEshnfXho4geSxyabj2Ck1uw=;
        b=lPUDzLaoJmMv8vUGWhsvvPLfWHl1zbuL2hLYcqQBcuYPxiLwiN1Lqd0tR+Qh+KXrQx
         0MhqXraXoT7ncv2deOtIxhwGVhvOfj+mMlTfhsKmHwS/57w8XVQ6O1tamirnWoGJDvcK
         BOqiqvVo6jDSP8DS6AkKfjt1PJ3xr4qHgStCcUvGwFZxGa/WjDl3h6DUIFTu4KjYzoW+
         7EyHetWo+L9hUlf1YwNIQZvgTKix9AkPIceAtzb8lOxLhxWFO33+UBO11LGSH1M1tkzK
         /f6gXhMPGu+wiwCV9w/9Zb1Sd6e4ZsuA+cPklUqCAELYIHbWKHJkFIIfzISXjPZlzr/S
         BpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6x+Lq6UZlHCJIcz9CvulEshnfXho4geSxyabj2Ck1uw=;
        b=qkky2RGd9Yq5JiOIslYdvCO4bw1ky3gQUwJr6psR3POQvHdcEi4awDePvC43TExQml
         fLHRDiNdl+Gmiy51CZcXtterQPznV4Kd23ZvlhickRih1tGPXUSnUvoXsMj92SQlPPwc
         +tVV+s2qtH46ClqC8UXg0QzR+p2g4PoSeqTWf+cVjcDfNrFU+xsENsgJorrh3jsQKRvc
         PvAMs1Jc5AUt4utk4y8OhhpHNlYMCkORnIEbNmSZLAgU2vsAGAVpLNcaIjRdSnGecbiD
         A/pKACIEJit8iuw3WMV7Z/cwXGUiRiV4boAZHcI2+4AzKqFi4lvcqc9zQmuxAvfkPtoR
         DGSg==
X-Gm-Message-State: AOAM531SQEHQQXAoVBH5rhE1IQ+4sQ5Qz7sPiNmc08EFVWsggSNqUb8b
        NZ8o6k7lX5oHMWB1B64yxWiTAiztkn4=
X-Google-Smtp-Source: ABdhPJySmgYUI9nW0rIb3+cal4F2w9BRjnFHgIr+URadDNN/4gL8D1p2M6dRK6tW0DdPpPRAdFIXNg==
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr53825747wmq.140.1626090427147;
        Mon, 12 Jul 2021 04:47:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm14209016wrp.44.2021.07.12.04.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 04:47:06 -0700 (PDT)
Message-Id: <790c558d7cc1f66049c1280e6dddbe194806a0dc.1626090419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.git.1626090419.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jul 2021 11:46:51 +0000
Subject: [PATCH 11/19] [GSOC] ref-filter: modify the error message and value
 in get_object
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>,
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
index 27199ba40f5..b4f41fec871 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1762,8 +1762,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
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
index 40edf9dab53..3553f84a00c 100755
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

