Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3AFC4332D
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F8C64DBA
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 00:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBOAxu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Feb 2021 19:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhBOAxo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Feb 2021 19:53:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15284C061788
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n6so7142402wrv.8
        for <git@vger.kernel.org>; Sun, 14 Feb 2021 16:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpqKQgUz+R8bu/kg2ACsnMlKo+TGhbyZUUp5SPLltGU=;
        b=u6gRISTLHjkcXsYJEprLXHt5QTEk/a6LoxFYO6EsPWtg9k4NBi5PMDYPa1OH1OCxKn
         JDKOiqcpa/ECOWDht3YqAUPCER/AL9mGuKUwEE3kDLvBRMBdgZYO6eTCRWvC315xJgUk
         UDoZUut2Wo0Z9oUWZ7uIVlwQ0Aedc8uOPBcAmAJ0Rj+ZEjtCca/vs8GnJWX6TJMXbuFM
         Dpn7SECvBrNEPsS5O+MOkDlEbeBiyslSRhBL2VZJDXg/Lyyp4dUcuwvVnDifoRPpB1Aa
         zD7gYCcq2Gsr4dOI5I21TBp83R74yLKA7s+1/9t+wLE/91OOJIyLrOdhueK/+y9zyikA
         Nf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpqKQgUz+R8bu/kg2ACsnMlKo+TGhbyZUUp5SPLltGU=;
        b=FoRf0u8CIc51Vf3AGUT0TCJt9qrguZoZQML55SNgOGlpNwp1oL3CnVoglrlrAY9Y7K
         nfLM3lGDnHaEtHGkM9z2gz+hY8sXZoDM4z9zXBeywkJdBMQqtb8nFAD9qPjzEmx0Bj1l
         5nH8ImmRchv/Sh8E8Cvm3DbXJvHineszYS2vO92VHw3WxMA5APJrPkD7vNNvng9jZq5f
         1gadaJeR/HlVgDl9KZ2ufbXmSqVliaPc/shyBkUJ0ahCITRvZWJcGeRYP90YW+i5VkYv
         T769zhuZt9//wNf+5tcpeC59DYs5lFhUmiWPR35hC4RwA9cQenCnjbdA3dFb03z9xgu8
         ohJA==
X-Gm-Message-State: AOAM531rd7EH5mqsVNAuAZo7baSMc7uV7Dv85H5KmCK3FAkjo3IxUvmQ
        OMvy06Maw0ODjyWwo4g91p9Skk+fYbIzlw==
X-Google-Smtp-Source: ABdhPJz4ic8H1jXDjH8AXcRSN2+ywe3IEjdlp5zUDEBO9Bf0AH15I/8p6A4gQx7qRDpTaTwmbpHzMg==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr12936094wrq.3.1613350382605;
        Sun, 14 Feb 2021 16:53:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 3sm5209832wmi.2.2021.02.14.16.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 16:53:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/20] userdiff tests: explicitly test "default" pattern
Date:   Mon, 15 Feb 2021 01:52:20 +0100
Message-Id: <20210215005236.11313-5-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87tuqebj6m.fsf@evledraar.gmail.com>
References: <87tuqebj6m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 122aa6f9c0 (diff: introduce diff.<driver>.binary, 2008-10-05)
the internals of the userdiff.c code have understood a "default" name,
which is invoked as userdiff_find_by_name("default") and present in
the "builtin_drivers" struct. Let's test for this special case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 9675bc17db..cefe329aea 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -49,6 +49,7 @@ diffpatterns="
 	ruby
 	rust
 	tex
+	default
 	custom1
 	custom2
 	custom3
-- 
2.30.0.284.gd98b1dd5eaa7

