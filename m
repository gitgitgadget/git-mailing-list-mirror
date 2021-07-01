Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B82C11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB2C61414
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbhGAQK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhGAQKx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:10:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33ECC0613DC
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 09:08:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l8so8886089wry.13
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lfbYbfzHd+Vf6Fe8m7hXH4Krc1XXpNy92hpUxXnxmLQ=;
        b=iGzP4pyVZTgMKCgDR9QTrfLbUMoWqG8q2zzcrxVc//ymxM4Z0BRLGCGZiU6uJckvUW
         cPBZdLaKrRM8VZjXYQTLCSMqtfkRlEfmzPmCDEBmuSUkO94c6GrnHQUy07pHTFscj1cz
         5FFMDc04OQ0GZqbFKM4qJTv0GYydAazOM4IipiUtGI8ZPktdllBdijwt2PXzAfzEIboj
         tQnymYiU1uWablT9NhBu/IO6raQcEc3w7GdOnj+NKQl0l6zqC7SrLyJwhNQtp1zpAjQJ
         GNDyfv6b7jepWu58iHH5oAYHsOPl7NyVY/DvvF8BYCsis10IoELrRgKkkY672wdnzlGT
         80sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lfbYbfzHd+Vf6Fe8m7hXH4Krc1XXpNy92hpUxXnxmLQ=;
        b=dJi+JMiYxNzFB9ucwxXfZy5ymHeD4EC7h8PcktR0SRjq/45zesQSrXq31IXCp+2/Yk
         zryOt/L/pUKd9E0vdufqMXu1/WWdcbx5kHupfKF0PPmBFQRXvKYuepIV9G92Or35ziUT
         WBPkt2EO8wWCIvjvQ0IjrohTHIBCwl2tNNUaO/ttyWJa8/4Jvz+ALGyGQarofSakoctt
         qoj0//R2/HbBBHCUt1I8vmvPqWemsA2jfA6QSyACClijnE1owrPDSSLcQua38dMoe/UG
         XpPXIRvoQA3awaXs7ZpHgnR+ftBAVOKL+gbJ7SFY5pJwETzxL7nGHOgohuiYNNfhFC97
         RrVg==
X-Gm-Message-State: AOAM532ooaoBQkEi80MVonp86kUb3OcH/YYa72MRvhJVisNmrBshQK2n
        7APhciAkLjlhbus7QkGphJOKJsnoH6Y=
X-Google-Smtp-Source: ABdhPJx+GYoFRqBiVBjGSzCwbZstftYV42NGYWZ3JPOpgJjioprYtMIz57aDFaCh0WAtdGytv9WXuQ==
X-Received: by 2002:a5d:678b:: with SMTP id v11mr543651wru.72.1625155700298;
        Thu, 01 Jul 2021 09:08:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm440479wrz.7.2021.07.01.09.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 09:08:20 -0700 (PDT)
Message-Id: <0149940ee4d7282360234f1ef1ec270def83c907.1625155693.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.989.git.1625155693.gitgitgadget@gmail.com>
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 16:08:07 +0000
Subject: [PATCH 09/15] [GSOC] ref-filter: modify the error message and value
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
index 45122959eef..9ca3dd5557d 100644
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

