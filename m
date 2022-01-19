Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A01C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 17:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356429AbiASR3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356412AbiASR3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 12:29:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F7FC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:29:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso3699369wmf.1
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 09:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u3hSLdYUV9oM5IlLV6aazOYIDhcZRaEMA3A4Vn00mfo=;
        b=knAHuAesRFfqeHUnStQyC8Ru6AqH2omehYUAEn6t4OFY9b1rlx+5/qGEUWrbIEkQ+3
         jUkAZ9RpbHbb1Cp9GbSrblooT5XRYStMeIjdT38nD6b6dROXtJoJUVpIESMA0WKt0jMx
         rLpGg8fUVy/aZ445WRHck5Cl/7NHRuxPNzOIlR9mwbhY5FNfvA8BNYMfdTdA46DGSVIj
         CrIO73RG+SvLOeA20KF6AVB/gUcQD7BgicJogY58I6gI93Y+DPGYCLDc5gK9lXAH7wWB
         E4QnFzh5FQ2pGVNc94Cfg88tskpyHfW6wI9Z+c72CfnPb5xBjQkvFFpi0/7VtPiKdtqe
         4Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u3hSLdYUV9oM5IlLV6aazOYIDhcZRaEMA3A4Vn00mfo=;
        b=W2JD0tkL8x7rjN2fCOjA4k5hOBCH1rPuzyedYwiwEjCc2idCP+D5njCqZK7SrA/p5q
         SC8Pol6m5PirQvBMF6DjR82PdegsKZ5jLQaON4wAbLJ1IOZb/QPWsW+5Aj4HHM707E6M
         9NTH3OH5FPZJLHQXdtDbz4IOs5Lt5JYEVHi1cJIkQxLUeY+eG+Ad76rDNZ6zfi38jkLo
         0WM6b2IOEKF4VoQXnvHTA3sbEgyr8JKgI8LEk2ImjnnKTSlKQfFziKbNazslF692vP78
         pzNmsJzEHw2pZFZ1SjU4HcWOcqXizUCz4v91FA87jqflJ23u0O96Yo030jY5TRxuuXUM
         69WA==
X-Gm-Message-State: AOAM530ExauKqnA/TbUi85IAJSBPn9eMDIS2qGX9K/YQ3hVe0/psjn5h
        36ilFIXPNVB8tXYFtBTqGsaC2+JVaqk=
X-Google-Smtp-Source: ABdhPJzLa3sECFAdZ1CVk4dsnHitJUAdCpFwSD8xLQ4zN6jZrHSUTeb5YGjmdXv5Z4suG7SPdkWmFg==
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr4596915wmj.135.1642613383451;
        Wed, 19 Jan 2022 09:29:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm230400wrf.111.2022.01.19.09.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:29:43 -0800 (PST)
Message-Id: <1bb57ccd61452124119bb663f5e35e9676748c82.1642613380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
References: <pull.1119.git.1642613379.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Jan 2022 17:29:39 +0000
Subject: [PATCH 3/3] split-index: it really is incompatible with the sparse
 index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

... at least for now. So let's error out if we are even trying to
initialize the split index when the index is sparse, or when trying to
write the split index extension for a sparse index.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 read-cache.c  | 3 +++
 split-index.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index cbe73f14e5e..a932e01fc7a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3009,6 +3009,9 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	    !is_null_oid(&istate->split_index->base_oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
+		if (istate->sparse_index)
+			die(_("cannot write split index for a sparse index"));
+
 		err = write_link_extension(&sb, istate) < 0 ||
 			write_index_ext_header(f, eoie_c, CACHE_EXT_LINK,
 					       sb.len) < 0;
diff --git a/split-index.c b/split-index.c
index 8e52e891c3b..9d0ccc30d00 100644
--- a/split-index.c
+++ b/split-index.c
@@ -5,6 +5,9 @@
 struct split_index *init_split_index(struct index_state *istate)
 {
 	if (!istate->split_index) {
+		if (istate->sparse_index)
+			die(_("cannot use split index with a sparse index"));
+
 		CALLOC_ARRAY(istate->split_index, 1);
 		istate->split_index->refcount = 1;
 	}
-- 
gitgitgadget
