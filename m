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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA3EC47E4D
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91040613DF
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbhGOPnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbhGOPn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570FEC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l6so4032868wmq.0
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6x+Lq6UZlHCJIcz9CvulEshnfXho4geSxyabj2Ck1uw=;
        b=MVgReOLN9bG1yRdWWDm9s6P/9DhrDnSOSmCRmp44ZqeBXnp+nqtCBLSo3tD6U3B2bD
         NQsMw0Hnbbb+YykjBxnFkgxkBIaL2GKCVRMBhk81V7XUlNdVQDGsuR/aPRlFSEE99aAg
         qT4+MrrW63tkFnXES+h4+7B7yk2mTKZYrGwgKu9+AXvnN/1dU0MpnfMT8lO2sTDliDIN
         tyxJlfpkyBhRMwyzXL0AVV7fd4wdhVI6+IHb7ypDWXcvSIkINJL+j9z+hfPqf51PcvjA
         EJG3nwAcR2VE85TdYWY+5a976glwkkBZUugCpchcm9x/VgDPZJviC7K2B/6YTM0LxS5O
         g1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6x+Lq6UZlHCJIcz9CvulEshnfXho4geSxyabj2Ck1uw=;
        b=NTzgKuiVyfc+VwJxIgbENffssNFzt5+x5Au7qIxLpA+Ot2svKlYXbJFqzdPOvoWCC0
         w8CJ003YV4vJ68/wT3+5BT+lR8237H//IPxcYSmVEVyD0SIYH0ee1+A3pZnze5eVZQMd
         Y79/SmfgS2Or+MAxvYJuIZ1niH2rYIoKCuUW5o+jHjpnMbRvoJHc2T2Uyncv2TRHs6ey
         xJ1ZbQjq3M+AFm92P6S8wcPgYVvNvIsBsHp1lHOrzIxqVlAnZPC6QXu4e7KKAzuZrvjE
         2u0qoHKqwyipHBou6QJtHPXUknTOjJa/bwSbcnu2xJi6THkCNv6yQ5rbY1b9gPCr48U7
         t+VA==
X-Gm-Message-State: AOAM533HDriLe82vSaXjKsRKqyipktUD76cJYgKD2KPXr2IfUecdW5uh
        gGtw1By4nkw7GHYzBIaHcwGZsQANmec=
X-Google-Smtp-Source: ABdhPJyKUcQ6ms/lo58JosZaiXK17wetOZQ0G/vTzNkPEDtK19Dphb300nmUEecEndDVKgfDhRE71A==
X-Received: by 2002:a05:600c:25a:: with SMTP id 26mr11313182wmj.87.1626363633901;
        Thu, 15 Jul 2021 08:40:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24sm8496067wmi.30.2021.07.15.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:33 -0700 (PDT)
Message-Id: <7058f47d41d74ad874b9e74f469dc473fd0d3413.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:17 +0000
Subject: [PATCH v2 09/17] [GSOC] ref-filter: modify the error message and
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
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
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

