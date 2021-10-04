Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA87C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D66F6120D
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 01:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbhJDCAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 22:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJDCAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 22:00:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC96AC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 18:58:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e12so7553403wra.4
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iORiwJkQL/Bn3ihbf/5+8i9O5gI0zqwCTqo4pq0kyHY=;
        b=TdNNVxjkp+vN3sZwATxc1PRgPeusTcBuOv8cNPwCV71cRC/rcH2cRB+78sbPMG9Qhp
         kwTLenOSGHS3HyuHF8SEmFU4cyD7s95m1sDKhlLc2STSjwXPFf1NYl1YlxTunqAbM2US
         zTkje8OJwkNl6btMw/JONB/NLHLjhQCrvNOK9NPACP7mlj93Cb8XC8D7T8/XnS9rt0xh
         rDK+9c/lqC6D+IbBuMHhJIokqktog122NPJHuR8OMPgGKwhjy0IIKFZHDuU/i/PAKmAj
         Z5pcHqW0VzsOZ+HAoQ/RTSv4odknQHbeqexM7F7jDPVm94vZvVqcVh19ylOz3W4KhQOh
         VnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iORiwJkQL/Bn3ihbf/5+8i9O5gI0zqwCTqo4pq0kyHY=;
        b=6LAjwBH5WpPN1DuwYAaPOzo3K4fRphlWSrzu3SkSkpFOLiX54bt9GsGsuHoyDqnIXV
         cfcPqUAj8gxltWpTfCxDpoBhAngM5wJIKQaog2Hj3j0u2xOBWQoV8yEnsjRNfPioMTQ5
         jMuuQD8Am+xcOQYn/oZPAKACxPDn1GUKEPYPALitqKbdL4yT2oWxuOBLHVxZ67F75qYf
         q4QJAjjbbAg8+G5i4eir7l41pHCJe9396p/gz3O8GdUdIw0yIUUuP3PULCd+iQloEpT0
         4WtmRTGrgHncHd9hhCzjPyi7PAm+P9eHJRByMXkHYIpdAyDr53/7mbS5gBQnFfYWpZxX
         a2GQ==
X-Gm-Message-State: AOAM530pOuT0tjbwhKqwJzQZb2WzR9zd/5DROiyYBBlTxCFtoNAhtZa3
        MbKyD1aUP74WIQ722EwtPJZXu8ftm/bmNQ==
X-Google-Smtp-Source: ABdhPJwowsuFMo3ts2/e0e1FJ8rp85o1Ni+hq6uNzv0iTFo8lMrG1EjReb7ftT+r3CkZkES99rmMFg==
X-Received: by 2002:adf:a152:: with SMTP id r18mr11290972wrr.317.1633312707184;
        Sun, 03 Oct 2021 18:58:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y23sm15349355wmi.16.2021.10.03.18.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 18:58:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Boeckel <mathstuf@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Heba Waly <heba.waly@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] advice.h: don't indent top-level enum
Date:   Mon,  4 Oct 2021 03:58:20 +0200
Message-Id: <patch-1.5-80cc41ca194-20211004T015432Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1404.g7bcfc82b295
In-Reply-To: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20211004T015432Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a style nit introduced in b3b18d16213 (advice: revamp advise API,
2020-03-02) and remove the leading whitespace before "enum".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 advice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/advice.h b/advice.h
index 601265fd107..694219f5cb2 100644
--- a/advice.h
+++ b/advice.h
@@ -12,7 +12,7 @@ struct string_list;
  * Add the new config variable to Documentation/config/advice.txt.
  * Call advise_if_enabled to print your advice.
  */
- enum advice_type {
+enum advice_type {
 	ADVICE_ADD_EMBEDDED_REPO,
 	ADVICE_ADD_EMPTY_PATHSPEC,
 	ADVICE_ADD_IGNORED_FILE,
-- 
2.33.0.1404.g7bcfc82b295

