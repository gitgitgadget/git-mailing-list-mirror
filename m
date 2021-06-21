Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF366C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 962F460FE9
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhFUW2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhFUW2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:28:02 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578A6C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:47 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s19so10010506ilj.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E7g7KePDkycaatnR6SQPYLn26QnL2jc3tVnJa5mP2eQ=;
        b=IkzVP9pLxczsa3HG6jKZmhijdT98keokJaEiwBInLtIbsMisWHXutYgeXibdNCFv5f
         d9ljwcyH4A163gOjkg1VqKHKFS41PEPJHSz8kY+Ljn4/cbvOry9AexDnryratsSPgg4Y
         jwJ7hMdS7e5z2wQ4w3IW5pebYGPyonuiAVBEAgTDzXuas5ddqBAFkKjkFfsweDeac4Uv
         WMq9NTFZwE6mQu2ZAz/xCXtKs17JcxWfaDgv+4hk6Y6Q0NalJiI2DnsyHseFFY9GadrQ
         z2KM8KoCrzbCmZ8FJokxVZcLD7tJMi4Fh1uDdsNfr4dHucZg/ctRirsC7PNmC6S9sx6f
         aLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E7g7KePDkycaatnR6SQPYLn26QnL2jc3tVnJa5mP2eQ=;
        b=INnwq7wR+NVURh4BaUDEOsJbgeUm3NLKq8byy2M2UW4TMaFj3ChZullpFb5lLmQv20
         oTDrafhSkrUDnA5qYjdAjZkKVHfOhH+ELSbThxtKE3hI0kOnobvbWlSdCgawy/tjWFR3
         9XsO2Ds1yMfnvoA3jEGgD4DMK3wBfH+IiFpGWeP2yaoz7U0DhSH6J+LW2m9hE6Kf1TyJ
         QxdG1+ViXBdrQ6y7FzgWumDgnY+yIHzkVwImWc9ar53lh+qlF6Cz/WAauucAHDHG1uoD
         ryjY76dwWgNMV51MClqSpfzSLwY5kJuS9mwgF8xY6nAOUuNE4YJriElboBzFEJRVN5hx
         9KcA==
X-Gm-Message-State: AOAM533zUVWM/4OKPImh9hkWaqkqaESittGxLVc3caKhBTf/68sgVmLJ
        iVRWDzw/SbRJpAFH+RAAl9UUWKou/NK3xdxi
X-Google-Smtp-Source: ABdhPJzTHLJZkyM3jjklc48dOXMYW2qin2BihBqlfwGcU/mK2yPev7b0SfaxVH5fw7Sh2EIl8g7o3Q==
X-Received: by 2002:a92:7b07:: with SMTP id w7mr345380ilc.308.1624314346649;
        Mon, 21 Jun 2021 15:25:46 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id g3sm11297966iob.13.2021.06.21.15.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:46 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 18/24] t0410: disable
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
Message-ID: <2a5df1832a340bfedba80bbb1b223b82d14ce3f9.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Generating a MIDX bitmap causes tests which repack in a partial clone to
fail because they are missing objects. Missing objects is an expected
component of tests in t0410, so disable this knob altogether. Graceful
degradation when writing a bitmap with missing objects is tested in
t5326.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t0410-partial-clone.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 1667450917..4fd8e83da1 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -4,6 +4,9 @@ test_description='partial clone'
 
 . ./test-lib.sh
 
+# missing promisor objects cause repacks which write bitmaps to fail
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
 delete_object () {
 	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
 }
-- 
2.31.1.163.ga65ce7f831

