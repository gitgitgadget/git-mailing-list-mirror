Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C12EC3527E
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384520AbiDEVr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445892AbiDEUIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 16:08:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409E6EFF90
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 12:56:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d3so105959wrb.7
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2gKb9z9aHOpdwHYwoQuWDeYZFpeH2lEFtz+g8qSsj8=;
        b=fq4BqHDRwS17e3yBf1UKlZOntB9eIwSNeerkjPg9Na7LhlASH5tuHVPn53JIMT3pl+
         WRmcAdvCq+h0vSQDg4rwpw73ghxY82hCSEPphp5TjLI5OMJ5rK5eqDG4tIN/zxb2Y1JS
         lHb2w95/HgMoZZRl8vSXXUvcu0/qiDmYwYBGp+7S2kAF/iYA4LKOcrF4sGTxDG2eVTyS
         wB7a2/Ycr//dpa76FXe9UGDeYrDPrHTIrTcPIor4Qe2RGSGxaeIlrJFmM3uep+jMVS/r
         fs1hZJlky7iAiRUnNwwyz0S41D561IwaQrEZZwB2MoIOjWOiu693XXTZNj7lFYnTHFLc
         QRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2gKb9z9aHOpdwHYwoQuWDeYZFpeH2lEFtz+g8qSsj8=;
        b=XKQw+0+BOMwGzB8ZV031YsZFsjKxCGR791k6jnELcS5TTg3/XIAtqI83/iPP6AigYF
         afJTdUXt6LyX4uGOYJu3AYOpEpdqcSEo5tNhO/OK3EgbLZ4qT8B135dPYa0Lvgyu0mfo
         7uqMyJZHKbyGDv1NkChSjPEycaPvEH89eWFtTQ0ZsKXo/QLj8lWzGHVGydyZt0i9PDzq
         aOtHkMW0cFDVFzSp8biMBqE1h6n24VlN2zdsoD9p7MFB1owuiahKtAJSXMy+1cRzeH/L
         HW8RzYKCu4Q+HtcOSKhutb9X9v/TOqky9VBYpPpOSERKdmX8Li9Arm9Gx6gbFj3o1ZtK
         hzrQ==
X-Gm-Message-State: AOAM532nVKjZl5mHj7O+k3dR6QY/Lcf00WE82mklwfeg4+zhdTJiBMox
        7vGCq2KdLXm8juBCOmxlcXB2Rg+RcLtGRg==
X-Google-Smtp-Source: ABdhPJzxBrIotBBEvrHiHO4aDV6fVE1sT3bOUwXEVLvIiw3NH6WkrnIEmtv2wmiv0f63giPMZsKRSw==
X-Received: by 2002:a05:6000:18ac:b0:205:a73f:8288 with SMTP id b12-20020a05600018ac00b00205a73f8288mr4032993wri.172.1649188584289;
        Tue, 05 Apr 2022 12:56:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d6d09000000b00203ecdca5b7sm14126567wrq.33.2022.04.05.12.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 12:56:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Documentation/Makefile: fix "make info" regression in dad9cd7d518
Date:   Tue,  5 Apr 2022 21:56:20 +0200
Message-Id: <patch-1.1-e700d372e0c-20220405T195425Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1604.g35dc6517170
In-Reply-To: <20220405141552.qgl6t2urtbeilsmp@lucy.dinwoodie.org>
References: <20220405141552.qgl6t2urtbeilsmp@lucy.dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in my dad9cd7d518 (Makefile: move ".SUFFIXES" rule to
shared.mak, 2022-03-03). As explained in the GNU make documentation
for the $* variable, available at:

	info make --index-search='$*'

This rule relied on ".texi" being in the default list of suffixes, as
seen at:

	make -f/dev/null -p | grep -v -e ^# -e ^$|grep -F .SUFFIXES

The documentation explains what was going on here:

	In an explicit rule, there is no stem; so '$*' cannot be determined
	in that way.  Instead, if the target name ends with a recognized
	suffix (*note Old-Fashioned Suffix Rules: Suffix Rules.), '$*' is
	set to the target name minus the suffix.  For example, if the
	target name is 'foo.c', then '$*' is set to 'foo', since '.c' is a
	suffix.  GNU 'make' does this bizarre thing only for compatibility
	with other implementations of 'make'.  You should generally avoid
	using '$*' except in implicit rules or static pattern rules.

	If the target name in an explicit rule does not end with a
	recognized suffix, '$*' is set to the empty string for that rule.

I.e. this rule added back in 5cefc33bffd (Documentation: add
gitman.info target, 2007-12-10) was resolving gitman.texi from
gitman.info. We can instead just use the more obvious $< variable
referring to the prerequisite.

This was the only use of $* in our Makefiles in an explicit rule, the
three remaining ones are all implicit rules, and therefore didn't
depend on the ".SUFFIXES" list.

Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Tue, Apr 05 2022, Adam Dinwoodie wrote:

> With this commit, I get the same noisy warnings, but I also get the
> error "could not open .texi: No such file or directory".

Sorry about the regression. This fixes it, and as noted above I'm
pretty sure this was the only fallout of the change.

(I didn't have building the full extended documentation as part of my
local build, but I'll be adding it now).

 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1eb9192dae8..44c080e3e5b 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -390,7 +390,7 @@ gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
 	$(RM) $@+
 
 gitman.info: gitman.texi
-	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
+	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $<
 
 $(patsubst %.txt,%.texi,$(MAN_TXT)): %.texi : %.xml
 	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) --to-stdout $*.xml >$@
-- 
2.35.1.1604.g35dc6517170

