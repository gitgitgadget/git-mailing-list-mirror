Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C4AC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA7D61B31
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhKPMJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbhKPMFb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:05:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B62FC0797BD
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:53 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id n29so37009129wra.11
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Szy2iyXwOHP8os9PTxE0N2UjaPR+rLWL2NUEvSiQdgw=;
        b=DQ/KwOcN/Mppy30R8kNQbnywc/uAg3h2vNjywQe44Rznvpu/xTFVnd9fzueUd96cks
         Rwl+eSH9jmgRc5pG+g7FKOkoV326+hCFEm2YHOJA3Q4cjknqt0w+v1JPcsOqGXmSA88N
         ZaRHUojkLMCYqYe9fOgYB9biBI7fZmM13GWXhdtgfUCSVtimQZj8pm5WlqjY0KHiBxnV
         xJa8FYaoQzu+9yxKl4Nncp0UWEawMx3RDZxKcOKnh7HhB0DYs8kvoQdhCV32ork57fMK
         YikWZ/ubEj7wtcDy/8taEIXyDpMWDx9he7vQoyn54kTfhb5M9+19jbA27GgDoixaWtJC
         vaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Szy2iyXwOHP8os9PTxE0N2UjaPR+rLWL2NUEvSiQdgw=;
        b=v1LNB3suHOt6Gr9P/Ij6Sd9UG2eOgrEp4OU9dx5pGCCOI4a5iWuFySQqwXvAOvFiuc
         p59AAaKt6HXI9TV7FmqCFd4pcODi1uXoGbf9DsJnxbFmgJHHfK0HN6diXgw94Mgn9/m9
         xUfAE0yCqg9DocEw6FdrV01IwJMfD9LmEXSYm4jrhsxgaPeUFIQyC/df8at0vpKEfmNA
         nDvmuye6nKsOhFa+k2qfxX+HlCj9bQQhLgLIeegTNgbAZPBnA9R1s3CVUss08cHBNSAI
         MyAgPDjfo8t+C5iKdGzWBamzi0rCVv6EzBLuksZFp/MWMjDdz9uqGHzusHMg8BhnxNiI
         nNHw==
X-Gm-Message-State: AOAM531qV1YfMeU2f2qgeAAUlBWrxTGgXYPMxbMZvlpxEpIVjTXPcEDP
        JR1bDc3lRUNVG2g50ZL5b4B/rYESm9fCxQ==
X-Google-Smtp-Source: ABdhPJygPS9OdShlh2WmbAFe49tqzg1tg3l9KFpxJJ0ldVeqHpZ8ZyDaUbTLX49o5sDtho6rKo+ueA==
X-Received: by 2002:a5d:668f:: with SMTP id l15mr8755400wru.182.1637064051912;
        Tue, 16 Nov 2021 04:00:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 20/23] Makefile: use $(file) I/O instead of "FORCE" when possible
Date:   Tue, 16 Nov 2021 13:00:20 +0100
Message-Id: <patch-v3-20.23-567ad5c3ebc-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide an alternate implementation of the recently added
"TRACK_template" which uses GNU make 4.2 features. If the 'file'
function is available we don't need to shell out at all to check if
our tracked files change.

We need to use the intermediate TRACK_template calling a
TRACK_template_eval within the generated rule so that we don't eagerly
fleshen these when "make" reads the file.

This doesn't make the runtime faster on my system, but helps to cut
down on the noise of things we shell out for
unconditionally. I.e. running "make" with "SHELL_PATH='sh -x'" (twice,
so we pick up the setting) shows than a no-op run went from emitting:

    $ SHELL_PATH='sh -x' make -j8 >/dev/null 2>&1; SHELL_PATH='sh -x' make 2>&1 |wc -l
    124

To:

    $ SHELL_PATH='sh -x' make -j8 >/dev/null 2>&1; SHELL_PATH='sh -x' make 2>&1 |wc -l
    95

That 124 to 95 number is a rough approximation of how many times we
shell out. "strace -f -c" similarly shows that we went from 8798 to
8466 syscalls. So this brings us further along in the goal of making
"make" do as little as possible when it's got nothing to re-build (see
[2]).

1. https://lore.kernel.org/git/874kdn1j6i.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/shared.mak b/shared.mak
index 363138a5577..4ee0bb7a13d 100644
--- a/shared.mak
+++ b/shared.mak
@@ -8,6 +8,22 @@
 #    info make --index-search=.DELETE_ON_ERROR
 .DELETE_ON_ERROR:
 
+### GNU Make version detection
+# We don't care about "release" versions like the "90" in "3.99.90"
+MAKE_VERSION_MAJOR = $(word 1,$(subst ., ,$(MAKE_VERSION)))
+MAKE_VERSION_MINOR = $(word 2,$(subst ., ,$(MAKE_VERSION)))
+
+# The oldest supported version of GNU make is 3-something. So "not v3"
+# is a future-proof way to ask "is it modern?"
+ifneq ($(MAKE_VERSION_MAJOR),3)
+# $(file >[...]) and $(file >>[...]) is in 4.0...
+MAKE_HAVE_FILE_WRITE = Need version 4.0 or later (released in late 2013)
+# .. but we need 4.2 for $(file <[...])
+ifneq ($(filter-out 0 1,$(MAKE_VERSION_MINOR)),)
+MAKE_HAVE_FILE_READ = Need version 4.2 or later (released in mid-2016)
+endif
+endif
+
 ### Quoting helpers
 
 ## Quote a ' inside a '': FOO='$(call shq,$(BAR))'
@@ -99,6 +115,10 @@ endef
 
 ## Template for making a GIT-SOMETHING, which changes if a
 ## TRACK_SOMETHING variable changes.
+##
+## This is the slower version used on GNU make <4.2.
+ifndef MAKE_HAVE_FILE_READ
+
 define TRACK_template
 .PHONY: FORCE
 $(1): FORCE
@@ -111,3 +131,41 @@ $(1): FORCE
 		echo "$$$$FLAGS" >$(1); \
 	fi
 endef
+
+endif # !MAKE_HAVE_FILE_READ
+
+## A TRACK_template template compatible with the one above. Uses
+## features of GNU make >=4.2 to avoid shelling out for this "hot"
+## "FORCE" logic.
+##
+## Since version >=4.2 can do both "I" and "O" in I/O with using
+## $(file <)/$(file >) we read the GIT-SOMETHING file into a variable
+## with the former, and if it's different from our expected value
+## write it out with the latter.
+ifdef MAKE_HAVE_FILE_READ
+
+define TRACK_template_eval
+$(1)_WRITE =
+$(1)_EXISTS = $(wildcard $(1))
+ifeq ($$($(1)_EXISTS),)
+$(1)_WRITE = new
+else
+$(1)_CONTENT = $(file <$(1))
+ifeq ($$($(1)_CONTENT),$($(2)))
+$(1)_WRITE = same
+else
+$(1)_WRITE = changed
+endif
+endif
+ifneq ($$($(1)_WRITE),same)
+$$(info $$(wspfx) $(1) parameters ($$($(1)_WRITE)))
+$$(file >$(1),$($(2)))
+endif
+endef # TRACK_template_eval
+
+define TRACK_template
+$(1):
+	$$(eval $$(call TRACK_template_eval,$(1),$(2)))
+endef
+
+endif # MAKE_HAVE_FILE_READ
-- 
2.34.0.795.g1e9501ab396

