Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35622C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236276196E
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 16:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFYQFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhFYQE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 12:04:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABC2C061767
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id k30-20020a05600c1c9eb02901d4d33c5ca0so734942wms.3
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 09:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1e0iKytryCbsbJLjnyrovo3yeJs6kZmNWN65BNPEnEY=;
        b=CCZundseRNaaJZVRagP5QdQ5/T3DAXhAn0NlbKPe/+FxvUpGE6QlQmnFgBEdmBakcU
         LqTRGAjutxkhNDR4sisR6ndB9OrrKG1r/PTd4SoJrPs438K3GbTMDyWP+gxXAlrA101/
         KXqKUM48h437WRjig3mYVjdDI0ZH49uP4mKfXUM04PQZpBaLMfMFj7UgKzrbVxJewy9Q
         qJ5i/ff/Gjqb931Sr9SOdionOuvf8FvFxq9aJw+MIxXzzxeaFuud0qzfEkEKgsrLbD6O
         roJOZg3i4GKC0VKx+kEjFRVOZfiISvK2yM02luqe8NqyIMeAoDSxCAs64SLDH9d7WSu7
         LrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1e0iKytryCbsbJLjnyrovo3yeJs6kZmNWN65BNPEnEY=;
        b=eCTXOYaWBKpvLa+vhvA0Aqdq1omHqiT1lvuT63MaPAcGR1NrzqmB8YFJUDOS2BhCBv
         4vd9i+BtFQCLyhuyW//TQROn7JaS02CmSQW8SRxcNogxNub5t9RW9QkTj8QXieSWi0nn
         wulBzWW+Z0ny0YPSdOaF7pU51pYHuy8GVpGcmj0cQuPRvIO7mcO9KVe406OhQo7uddqI
         xhTdppZUmY+2RNpKNEGMUqy/9civnodAE/U4y4KDHWYwkW6t60ZHF+FhaedD4YeGI4rc
         sRTWiN6Pn6cmvY+jv1LrLl62anFH53keLFtA9hiAtfI/Kxky1vsW+xonCISYxlJGHPuB
         6+tA==
X-Gm-Message-State: AOAM532ez8dg2LqwWPMxeeQlDnpBlIWySrMrJKoaaN7Jg26PxkbV4g3n
        tbOe/TB0AyX/gDB+C6Z/L+/6LuefWfw=
X-Google-Smtp-Source: ABdhPJzhPJ/N3sqzFoLRxFT3AJSSF3Tk1m4NC50wL7Y5bqVMpdncaKvfNg8Gq5JtS9AXEBYDjuNK3w==
X-Received: by 2002:a05:600c:218c:: with SMTP id e12mr11526948wme.92.1624636953471;
        Fri, 25 Jun 2021 09:02:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm5965542wmq.17.2021.06.25.09.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 09:02:33 -0700 (PDT)
Message-Id: <937f88b78371d1a4497c8dc389a499ab51446075.1624636945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
        <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Jun 2021 16:02:19 +0000
Subject: [PATCH v5 09/15] [GSOC] ref-filter: modify the error message and
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
index f21f41df0d8..181d99c9273 100644
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

