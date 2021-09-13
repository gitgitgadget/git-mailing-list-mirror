Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD233C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F3B60249
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbhIMPiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242449AbhIMPiD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:38:03 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58886C020E77
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:38 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x6so15121209wrv.13
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IEBhoXA/uCuYxHAulEbX7IBD6MgsDIgoj9dNJJdhBmE=;
        b=gFjq+4OCcNxK1hEDl/IAmqQCsaxxmz1gLshBJuhzD88IOV8ffPIUEpHWmZkhORt6Ly
         /1O5v0iDgcdirjxDwXnHKvVag15gPHaemLd/MA0DBC80Hfv6Ocvo7owwfa0gy2NaCe5O
         Kj0/PxW8G+ZIhtJlZp/rYcirqKyBxwO20I2wjpWIW+R2Co3uFP5xY9yl2SMHTmxC+Yq9
         4TQyDsVjtWVCKkm5+bw+AytNihl++lH/kVezvK+3CHOeogxJQ79Fl6jFuhMIbBmM47PZ
         fNHxXOQAE3X+R3R9VNy0rCKrp7Ayj666ncvcIL0lN+2hQC0vl1taVVXO6Kz+eIxS9F7T
         fPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IEBhoXA/uCuYxHAulEbX7IBD6MgsDIgoj9dNJJdhBmE=;
        b=Cs1P2uwEDVobrMS4lNar18y6Ixwz/NrFFP1y6mqWGa+Sw/ruzaAOaMnkBiDzeTechN
         5nN/RDa5WdrZOfWOTDtmdv30RBxE6MB/e8s12/1lVMyY0mDc7+gVjU2k720F8/JzSLMN
         edp4o8vWHY30NXHuVi2g54th/uWSSu/NVza06Y1h4MGmjdj+bQUkTob0Q2xOUxR0i64a
         gq6b8FHty253olbjQPfzDVHy5AvtFzYqFp42HkqTE+LY0rm6GtlW7KmUEViSXCPGbOZz
         b7LEwuxJ2nwn+cphvqMu96uJXpcboKY+NXNMa7av0FyaQZxCgNlumbAPUVlS37ga5Hu3
         cvwQ==
X-Gm-Message-State: AOAM532/opbavG4wWa7bwpa9B9eYaCn6vY0bECNY72S8KK0CBIyVHrD8
        LHMoigSizx6nPBKaGIOyqsupLrr7Z8nEZw==
X-Google-Smtp-Source: ABdhPJxfyo6nLwN2Xf1wTllpc3Hqo9a9TWK1Hi7hzBiZcIrrHVlZD4HoE3fS09FLjzUdfkNTpigGDg==
X-Received: by 2002:adf:db4a:: with SMTP id f10mr3884840wrj.91.1631544696671;
        Mon, 13 Sep 2021 07:51:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o24sm3638854wmm.11.2021.09.13.07.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:51:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Stenberg <daniel@haxx.se>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/9] INSTALL: mention that we need libcurl 7.19.4 or newer to build
Date:   Mon, 13 Sep 2021 16:51:23 +0200
Message-Id: <patch-v4-3.9-59c86f14cef-20210913T144846Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1013.ge8323766266
In-Reply-To: <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
References: <cover-v3-0.9-00000000000-20210911T092751Z-avarab@gmail.com> <cover-v4-0.9-00000000000-20210913T144846Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without NO_CURL=Y we require at least version "7.19.4" of libcurl, see
644de29e220 (http: drop support for curl < 7.19.4, 2021-07-30). Let's
document this in the "INSTALL" document.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/INSTALL b/INSTALL
index d593f628749..4140a3f5c8b 100644
--- a/INSTALL
+++ b/INSTALL
@@ -144,6 +144,10 @@ Issues of note:
 	  not need that functionality, use NO_CURL to build without
 	  it.
 
+	  Git requires version "7.19.4" or later of "libcurl" to build
+	  without NO_CURL. This version requirement may be bumped in
+	  the future.
+
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
 	  (with NO_EXPAT).
-- 
2.33.0.1013.ge8323766266

