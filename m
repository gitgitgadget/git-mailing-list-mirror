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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070A3C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCCBD61249
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbhDLLJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbhDLLJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF129C06138E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x7so12463385wrw.10
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtCLBXVFgxGD5dMcuTCE7t2GK4E6j0uhLdgKnW/lAfI=;
        b=R5AEvwunI7xNip3w7uOcyAAeWuLb9phwpRyQUKIDqh1H2/x0omaVaNoALFeeORyiLW
         4FZU/P+ffQZzO3rQMmhrT2RdIMZ9UVaetnfA33sDFRaem3waC9/U6OQyibKnP4f/YCvX
         GN7Hz64RsyN8T8HIpb1UdMoOK4tTGFB0GuKVDDkG3xvA33r97lTyjUh7gjV81EIV0AcU
         EX4rdoP56phDyD4iXDYUNJ/eSx/7DqiOuoZhkiVcGUwIZdXmu5tf3n9fL2d1fbKW1pTG
         h9w8k9GGL7sPIGN9fYCFRwtB1rIVbo0bPk5rkLUCja6VEWJ3VDQqHo8gCKX5M8KBUevC
         S5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtCLBXVFgxGD5dMcuTCE7t2GK4E6j0uhLdgKnW/lAfI=;
        b=dpRF5LHHm2+pW3fzOry7PaGMg/cXtlc0emhH005cp2L26CMcxUQllh7Fn6FLW38GZo
         XMQTyiMwWSydhvGlVpSUR38lkrVKH90R+67HQ1WLr2t+pCyzYFsUci9YFvcTPC84Fzbw
         X1Ta8vMmywPUyjcyZn0EwrYfeo2A4cyisEDVec4VLEg0yedxU9Qs0X3j12qGIyyJi1Mc
         L54mZi6mXDiuIfPMiAAepkOZcS2axAn2ijoghlSY/TX46ZmM+imybp3OH8teSehscTxf
         2xEv5w70FHg3q/kbu3cd+CFN7AAf/GegQD4z90Rhsx9IIaGE3VmGVT+usKE0AzzcUeKk
         vRHQ==
X-Gm-Message-State: AOAM532ZdWeWU0pNv0t2VByh6up5Ez6lcs053D8kK9OwdhDTHauqzB/u
        5sfN5Dnn6rzrRWY+rAnCygUowbUl/etLlw==
X-Google-Smtp-Source: ABdhPJyp/AB+71mm2lTrlLlUmx6UVpOBNcTvrF/gPWMzS50ROT3zgXLn+moAtV+iY5bYAxs3itAD9w==
X-Received: by 2002:adf:e843:: with SMTP id d3mr31312018wrn.56.1618225754356;
        Mon, 12 Apr 2021 04:09:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/16] test-lib-functions: document test_commit --no-tag
Date:   Mon, 12 Apr 2021 13:08:54 +0200
Message-Id: <patch-05.16-6df03776940-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 76b8b8d05c (test-lib functions: document arguments to test_commit,
2021-01-12) I added missing documentation to test_commit, but in less
than a month later in 3803a3a099 (t: add --no-tag option to
test_commit, 2021-02-09) we got another undocumented option. Let's fix
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index d169fb2f597..fa3e3e975fd 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -177,6 +177,9 @@ debug () {
 #	Invoke "git commit" with --signoff
 #   --author <author>
 #	Invoke "git commit" with --author <author>
+#   --no-tag
+#	Do not tag the resulting commit, if supplied giving the
+#	optional "<tag>" argument is an error.
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
-- 
2.31.1.634.gb41287a30b0

