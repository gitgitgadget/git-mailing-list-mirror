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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35948C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33CE64DE0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 15:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhBOPvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhBOPpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 10:45:32 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD97C0617AB
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:52 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n8so9430155wrm.10
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 07:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpqKQgUz+R8bu/kg2ACsnMlKo+TGhbyZUUp5SPLltGU=;
        b=R37dXHp5lowCgt1oTkVSZB3fCIbKUi6kK94EbxtPZVLOxYCK5OqN4h/usa3Yi2ZM3J
         o4LP6Qff9Tgx9rsJMpGkWQCdMaGEKM8cq6uQ8AUbpudHAUUVHcXA/eYxu0bHXEnnnxVS
         y51Am/Kc+wXwbNyNCJy2xA6fJmop7uo/UgYXwPa4Vn5Q6rEbVeytCNKA3nKRXDCPbxO+
         jQQnH5blXLzTEQ2QRWC1GHBsKNrQhc2a1KzwcTF/MfkFmng5m8CXwef7+wObwRo7/9FG
         aPONA5z8E3dNGtkdI11+ktGquUwD14caAU229hQCJkit8Fhs2fmyQAeioctrMdwdsNwI
         ZeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpqKQgUz+R8bu/kg2ACsnMlKo+TGhbyZUUp5SPLltGU=;
        b=ocXldJBtyzF7wCooDKyFTT3aJLy29w1vwKTBsAxYPm/60WrKPXFMIhot2W7/Nu+ZlH
         o7ivFuuwf5NPRqeaVP3uGEQbT4eWR42HX1l2RVITMZ6m3dHRF548L6hINFb0Wk9AOhJW
         vDC0ApMO0Ys+6R2KvKNxo+EokIZimQQhhb1mH+rstXd/EvYgM9K/ko1uSjSK0nGZr6q7
         NfglowDw3tDyAT0DbQkaWFoVD5/osYbW7iNl9/egNCPyS1pY09DEbno1kD0hi3TLHNWl
         1T9I4MplIhE8bSyU0bMbtChrSMSB7YGwwLCB03zsurS/+kXfbXq9Y6kGpAjmEK4PcWzW
         c9MQ==
X-Gm-Message-State: AOAM533+kVvLYpBDaV0bnZdKsmrMIGdQYd6wAauQ1g72PpD9miK3CxMo
        CUSJDKeDcOlaSYb2UedxLxDxfiHTN//L6A==
X-Google-Smtp-Source: ABdhPJyw6KeYTAF3VYgjN/jLEj4ARnG/PQpdmPkJ8npLne+/AQbcDu+rs4AulfMQZEZaWO5d4ek/4g==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr18574816wrp.177.1613403890862;
        Mon, 15 Feb 2021 07:44:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm23562757wrx.57.2021.02.15.07.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 07:44:50 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/27] userdiff tests: explicitly test "default" pattern
Date:   Mon, 15 Feb 2021 16:44:06 +0100
Message-Id: <20210215154427.32693-7-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215005236.11313-1-avarab@gmail.com>
References: <20210215005236.11313-1-avarab@gmail.com>
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

