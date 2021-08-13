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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBE4C4320A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273EE610CC
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 08:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhHMIXz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 04:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbhHMIXp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 04:23:45 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FC6C0617AD
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so4912706wma.0
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FT/cG9QZkDBiuJQX/fvgtVt3Iicb5lgNvBtJ43lZGPI=;
        b=COAsgrqaGYkB50J9zF3o2jyVnAJX+IqsSrLxfmOlrrqYuhikS4KaxH3uWdf1sp3YN2
         wIqhgqau/Us3c9VqObnqrnm4w7YZ3/puuELxwZ8yv0JmRV8TFUEc7+4HXCoQxt7A2oKz
         YCtOlq1EoTpOxKkG7oYGyw8t8wITxxD9irIWB8YCaGcCHrMnr0UjnosOOu3MitWH1ty3
         HzMNUvQhBYqZlS+V+6XsouveSH2Lpa+VK2BEKWO3YhWJUjuI4ZyU5qfnbVg69Xt3IVCP
         IKrQTgMZJBLHegXGpu2N33vj3qsZmXIZ5KrhFiK2VFvAIdEh6ptA7NiQOtDD7e/r8tGz
         O6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FT/cG9QZkDBiuJQX/fvgtVt3Iicb5lgNvBtJ43lZGPI=;
        b=Kmd2QbgELUCS0p7gRcwnXNyZKt3yIRhWHUxCO8Tt/1hQMsA8WtM12vrjXYqHS/pbG1
         O6QvDvnbnWqKshcglwZLiUsdZwC5CaPsMtQrp9LFuoju2UMOXCO+cqOzBKCb2uAodPLt
         A2dOOW4dK3IVklQzWi/0Sjj43ktIY7neWDNynFpivOtbOgG9nKE4K4xwadWHVTLf4fvu
         yJfGlmkGlIVuD71zqdyJHz3tupzSS+fZbKCcB7/qMWag26enGFV+7/TJ9TtyeaiR5I+O
         22r3TyFHnraJMy9/6kzy0oOb95/Xu7DIM+Cvgjrsi/btvJjW6xu/Wko3JlV7+ptAhQif
         NtrA==
X-Gm-Message-State: AOAM531ENf8fb1FbP8WrzekfAoex1tN84twu7OXgFOs4i43kX4xiJaGF
        sCFIkOyFCmk2+oQJgD9uiPjCvRuYR8U=
X-Google-Smtp-Source: ABdhPJz/GZRjKuwhArEdd0AW8lu1C9P9SVczTz24b58HaDglKBmbN3mE5Sy/RCZSGJ9rCls9gZZxEQ==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr1523413wmn.114.1628842997618;
        Fri, 13 Aug 2021 01:23:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm825286wru.92.2021.08.13.01.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 01:23:17 -0700 (PDT)
Message-Id: <d477edb6f05672a85fd3eb907ca13cc4a524113d.1628842990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
References: <pull.1016.git.1628842990.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Aug 2021 08:22:52 +0000
Subject: [PATCH 09/27] [GSOC] ref-filter: modify the error message and value
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
index e50acfc7378..fd482e9ff20 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1766,8 +1766,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
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

