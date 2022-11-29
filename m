Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30380C4321E
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 14:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiK2OJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbiK2OJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 09:09:25 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F85E3F3
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:23 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gu23so15850914ejb.10
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 06:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqdhRJeWjbhJCcIHCixaVYUEMhTO9hcQ77FXmfLanrg=;
        b=Moe253T758/F80s1GcYp7bMxqJI7jvBGVd5ZMWkgs8WMI/qyYLVqouDGPBDNmJIMee
         0LBpTBHrBFs4QbNoo2AV8HltWxc25AhJiQVnivACzF/4aBYddgFJ0lgoSNvCq5E0fFHt
         I6eC0BqAQonBimOt1K1VPDNRS0yoETrEta4CsELc3YoXQw0QPPCFgO+v9xgWzWhCL8M/
         1479/jVapq/XwTsIwQJkwLM6mRRI34iLyyGJlGcopEF0WT9pHoKrKKWhnudslP/q1d9S
         xpTroi/J1T9XhDJMPHkS1+tDfy7Te6J6AqptWTHGa0sHFR1D/riWeXRFgwqWcnb2VFW8
         j5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqdhRJeWjbhJCcIHCixaVYUEMhTO9hcQ77FXmfLanrg=;
        b=Okd+YWVmKugtwLd/6ZlmTT5jVfZU2IE6AjBO3PwUgoBBbtJ4o4vpf7a7G0B7DmE4iF
         QEEdN1QcZdBOvxfu8L2BDLAKy8n31SC+zi1fNOG3YVdgiFwOPhz+t5xkwmjdDHXnIA5B
         Kw9lQsecy2s+YNmx+hFDiP1/P1EMZ85aPXyDNa7ccB7mCdH01DnDuK+aFujAWTEgAf10
         VbSBx+dsZs/Vq1siO0XH0bKxzAfuGmfeTlJqOOAvBKQNvjmOuJirhDgyXZFFt6mOoWGS
         ef+b7yxOJ7A0pA9OZ4yGR2Dz9eSY4o0XUmG2CLChQKjmRqHwCr2XLCbZsjfnws0XLH5e
         dmgg==
X-Gm-Message-State: ANoB5plarebND5iT4LJaewyAgvtx3fUZNp3Wnjoudiy+Mo/IwLPsp9qX
        RWc5QlBAQ/mTaIlhCcwzqaM3zyZUt4s59g==
X-Google-Smtp-Source: AA0mqf6AUbRRs6a3vgINdAKsAKIiSTks8I4BUEi6xZSa82m3ZueN0YLt934u4Ku9J0yHTEx9Onif8A==
X-Received: by 2002:a17:906:ca18:b0:781:c97c:84d1 with SMTP id jt24-20020a170906ca1800b00781c97c84d1mr47708537ejb.147.1669730961307;
        Tue, 29 Nov 2022 06:09:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id be14-20020a0564021a2e00b00463597d2c25sm6307907edb.74.2022.11.29.06.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:09:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Paul Smith <psmith@gnu.org>,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/4] Documentation/Makefile: avoid multiple patterns when generating one file
Date:   Tue, 29 Nov 2022 15:09:15 +0100
Message-Id: <patch-v2-2.4-e232f308e40-20221129T140159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.993.g0c499e58e3b
In-Reply-To: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
References: <20221127224251.2508200-1-psmith@gnu.org> <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Paul Smith <psmith@gnu.org>

A GNU make pattern rule with multiple targets has always meant that
a single invocation of the recipe will build all the targets.
However in older versions of GNU make a recipe that did not really
build all the targets would be tolerated.

Starting with GNU make 4.4 this behavior is deprecated and pattern
rules are expected to generate files to match all the patterns.
If not all targets are created then GNU make will not consider any
target up to date and will re-run the recipe when it is run again.

I.e. a command like:

	make -C Documentation git-am.1

Will never be satisfied that "git-am.1" has been made, because we
didn't also make "git-am.5" and "git-am.7", as the warning it'll emit
indicates:

	$ make -C Documentation git-am.1
	[...]
	    XMLTO git-am.1
	Makefile:355: warning: pattern recipe did not update peer target 'git-am.7'.
	Makefile:355: warning: pattern recipe did not update peer target 'git-am.5'.

Modify Documentation/Makefile to split the man page-creating pattern
rule into a separate pattern rule for each pattern. This requires a
small amount of copy/pasting, but due to splitting out the "DOC_MANN"
in the preceding commit it's not too bad.

Reported-by: Alexander Kanavin <alex.kanavin@gmail.com>
Signed-off-by: Paul Smith <psmith@gnu.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d239f6751f0..89929e3d60b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -356,7 +356,11 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
 $(DOC_MANN): manpage-base-url.xsl $(wildcard manpage*.xsl)
-%.1 %.5 %.7 : %.xml
+%.1 : %.xml
+	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+%.5 : %.xml
+	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+%.7 : %.xml
 	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt $(ASCIIDOC_DEPS)
-- 
2.39.0.rc0.993.g0c499e58e3b

