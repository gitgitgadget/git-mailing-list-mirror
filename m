Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76010C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C62E61BAA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhKQKYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbhKQKXp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C03BC06120F
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so1649108wmb.5
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dziMm9DZNZAQoE9JczvCy7APwqsZflQK+6M+LBQ3huk=;
        b=D4QGNcs+KxW2HPKG4TZ7oNJ6PkWREX3QcKIKF3LyDd7v9FLfeFMXjR0g83/kNqRGLy
         vHO4x34WaEnPSqB5A9M5phussb5pE5iPmdqIlDtEZXYt/B4GEsIRy7MWUc8n3UNjNniQ
         2TkV0q7VV6ORRBIedZl4yXuGPHsPCEFTCVI2jIO3VuUamjzxjlIl9e5ZKIxNYhplE8t0
         Glee/CIXaPjWJfmVL6DlVuIHiSMddLCtM1M8Aymih82M3IcBhnuoZkZ7ZEbDEOiHQM3W
         AjbyT3xSuEGl+9tK2c6jjDT5fAGVTCARA5fnqZo0MnXfGHGP/aabyhNxr7yYz27qM36z
         SjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dziMm9DZNZAQoE9JczvCy7APwqsZflQK+6M+LBQ3huk=;
        b=2yGS07E/4Ik8xOdazi0Ue83azLZbQlVK592KIKCycS5O2DVpRs7ACTbQHHRjfPRSdd
         k9OzdrEbl5zz4LUZjbpkUQPoXWWEnEh6NQOaFej1k1FXroiXGOE43H2ABhldZSlWHZX7
         5jCUBA6DAH5aYZwRAU8Aw2McMCERHpcBHJHfm0SHy/XldGwcCAdtHTLQekiQj2q6Zr48
         R3fvCn39te+ZhSx5GsFIDsIG6VFO/wDDx4XYXwSs7tvvtyxxs7ub2W8LQFvb4pFznLEo
         3D6sAgWi0dLA9HK8KRk9VBDe3CBbmM2X4oGCc2k4cUr6Ui8QXUuedzIt9D9IhT2V56tU
         Bl1w==
X-Gm-Message-State: AOAM5330Wv8zF6qQYgkf39fki13reWwZc+PXM1Hh2qOC4tAXX3GD39Cq
        9aZFBNEEZ3ygbFbMWnOCwap+Pq0JpE9Xyw==
X-Google-Smtp-Source: ABdhPJzVmIzKnZ6CZ320yzKKsV7dhOoq55yfObj9Sc1f9vbYANnblxuxqijMe6Igsa7b0RCKR0oe9A==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr77350947wma.83.1637144442797;
        Wed, 17 Nov 2021 02:20:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:42 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 20/23] Makefile: use $(file) I/O instead of "FORCE" when possible
Date:   Wed, 17 Nov 2021 11:20:19 +0100
Message-Id: <patch-v4-20.23-59f22a0269a-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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
index 8d3023c2782..2d5d5b2fb9b 100644
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
2.34.0.796.g2c87ed6146a

