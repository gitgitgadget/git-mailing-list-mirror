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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B49AC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEC16112D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbhIUC76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349444AbhIUC0i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2A4C1E3A40
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i23so32619913wrb.2
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xrh8pMNZdmY0yM04hWbfQbCM1u7ZT6ZCDCZTSjHyTLI=;
        b=Pc/cK8BApil/927NqVwWLtKPBsvqFju5tcM+DXaCwSMeSPWxnoRQrxi+rf2O/zKoIU
         W2aKrrMbKuqnaeunJqmsUsKC4aONFdExPd0awpPwm2iUunmGZ4Lyi4tEceG0G9dyCL4m
         Y6JiRlX27fFxJIRTJtsDROf/wmgCcSZZPj56Ojzmx8fChrPCiiAZ4lV+01Jov9+9PNmw
         pceCPnEQiyd0ALwrVeM645vNs2fVhOmcREnqCHvp3b+NBaRG00XglO580DpZKOua2ByY
         m8eUqkBvPWZUxTs2IElpjTqe5WjXWmn5re493++La2C7xL+cyboFoVm6t/QGnmeLlOMB
         IkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xrh8pMNZdmY0yM04hWbfQbCM1u7ZT6ZCDCZTSjHyTLI=;
        b=Vre8SJEdqtUUtI+OZGnNDaUv0F3DOgPSCwv4fTAUiUlNeCV91yJtTdy7nTKQiJSGTK
         F0OlXyHNWoZzfEBMgLEWuwgc0hmYYJAJaQUUaxRPLCxaEGSJ668Jnzjwe0olxUsuGsHP
         O4OLuhqIVqUgD4aTEK8a7Oqx4XO1Th5j+mu7aAhzEVStO8N2HNs1xmy5PV6byHudxAag
         C791t35kLXOjpYK+Ksw9QMlxu86cbL5POcxg2Sv2yde1MSEd8GEuy/wPPrce+0IvmW2l
         25TAK4s6cPCTBRfax/MBBG+kpEMCmNigEzlsIc9FSNfTB1mh/DqMPBdRlnR9tGECyqfs
         u1/w==
X-Gm-Message-State: AOAM530CWg8qwe4zyabykUaAIZvry2R8XchppnrUaStY2LsTyn5KX7WP
        T1rkrhqfA9YiCsDgXwYnXLEcd6w7shH4Cw==
X-Google-Smtp-Source: ABdhPJw0YeDfKRakZqdSis3sNpCtSyKgIefCR/8CU5Arq8O79KU45Neg6xwEW0bf0shWNlLlqI7AUw==
X-Received: by 2002:adf:ed82:: with SMTP id c2mr30461268wro.203.1632164674811;
        Mon, 20 Sep 2021 12:04:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 10/17] object-file.c: return -1, not "status" from unpack_loose_header()
Date:   Mon, 20 Sep 2021 21:04:14 +0200
Message-Id: <patch-v7-10.17-51d14bc9274-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Return a -1 when git_inflate() fails instead of whatever Z_* status
we'd get from zlib.c. This makes no difference to any error we report,
but makes it more obvious that we don't care about the specific zlib
error codes here.

See d21f8426907 (unpack_sha1_header(): detect malformed object header,
2016-09-25) for the commit that added the "return status" code. As far
as I can tell there was never a real reason (e.g. different reporting)
for carrying down the "status" as opposed to "-1".

At the time that d21f8426907 was written there was a corresponding
"ret < Z_OK" check right after the unpack_sha1_header() call (the
"unpack_sha1_header()" function was later rename to our current
"unpack_loose_header()").

However, that check was removed in c84a1f3ed4d (sha1_file: refactor
read_object, 2017-06-21) without changing the corresponding return
code.

So let's do the minor cleanup of also changing this function to return
a -1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index bda3497d5ca..774ec8c866f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1262,7 +1262,7 @@ int unpack_loose_header(git_zstream *stream,
 					       buffer, bufsiz);
 
 	if (status < Z_OK)
-		return status;
+		return -1;
 
 	/* Make sure we have the terminating NUL */
 	if (!memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
-- 
2.33.0.1098.g29a6526ae47

