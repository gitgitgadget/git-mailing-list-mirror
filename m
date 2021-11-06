Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E8C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17F060F5A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhKFVGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhKFVGH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:06:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23259C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:03:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j128-20020a1c2386000000b003301a98dd62so12144967wmj.5
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shiysWotyNh1XYI0j6SBBrJAmBCEDDc0ElhreC91IUQ=;
        b=Bh7tNqf/V70sfD3L5u94p9y8IwRDX2WT6YX621WZFfiZWR/fAE3vIjUBnDhJmvFuNl
         JeeaJbKTMVAPusOgNaFYuabeJX1XkqAS89WlUvgs/2fGhmexPq5nCGuoHfwkIO5yjASA
         EdTesO3yGop1A1nspalKCD4RiQGTOspnIAT+8rxeNNjUy/B3B5zxsdwZM15ZQw1Q7EOB
         11k5MWODgatBbFb6cWrGMfK0RG5p3NttZyRIGMyU5UQvhcX4j2Uo3oM+RoYrtzyjwY4q
         oW9nXgYfb3ArgNsilEkXVVYweizJenTRH2s0WyasuB8qufODArponnNDbyJrY5XTU/6I
         8LKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shiysWotyNh1XYI0j6SBBrJAmBCEDDc0ElhreC91IUQ=;
        b=wGHTRqTV1Z9hkJF0jtkxV5QOycdKye3AIoaq7lqIoDmTnkRoqsEnCuM81KjJ21hR9c
         hNOY9R4F/vwAEosbIJ+yw4F1tmLzX6J5a1CupA5mmcL3GvQvTbrzFkP/FTongavsdd4T
         JLe5DKD/pcipxomL+6cLkVCqnJ9Yv9BNfHmL/DIjBW2nT+iDfny5Bz4sZx0hKBbthymg
         cm4iCqsCNQHkI0zVJ6+fufmp0HNnQC9Ll62ZOjRY3Hc52s5X3wHFo0Fuy+LRGrdIbxgG
         y/7Q5hccRBWDMYouGm6PIKdDuZoQn5OGVRK7oM5tqKE7dgLQw1AHnbKo224vAmeRltp7
         X+Cw==
X-Gm-Message-State: AOAM530UV5NdHH2cdpVQDte1K0NwQs1oNUniYQLUrDRND3P0VWtQ/cGD
        P6XtxlNdp7awygXa6zu7CqdXR9JfpN7DSA==
X-Google-Smtp-Source: ABdhPJzSRaHid/F+sAMdlqIgFL9Xqbikx+vBQjFFllysWYqt3vT4n/G0FlCBrChxvUg47k4B/Pir/g==
X-Received: by 2002:a05:600c:3b8f:: with SMTP id n15mr41545290wms.180.1636232603495;
        Sat, 06 Nov 2021 14:03:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u16sm14108433wmc.21.2021.11.06.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:03:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/16] Makefile: move Perl-only variable assignments under !NO_PERL
Date:   Sat,  6 Nov 2021 22:03:05 +0100
Message-Id: <patch-04.16-5affe94b05f-20211106T205717Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the assignment to perl_localedir_SQ to be guarded by NO_PERL, and
furthermore only assign to it if RUNTIME_PREFIX is in effect. If the
latter isn't being used then we'll default to the empty string, so
there was no need for the second assignment added in
07d90eadb50 (Makefile: add Perl runtime prefix support, 2018-04-10).

Similarly, we can move the PERL_HEADER_TEMPLATE assignment inside the
"!NO_PERL" block, and having simplified all of this let's consolidate
three comments on this control flow into one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 009b08152b5..fd4fe6c1045 100644
--- a/Makefile
+++ b/Makefile
@@ -2291,12 +2291,7 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
-# Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
-# since the locale directory is injected.
-perl_localedir_SQ = $(localedir_SQ)
-
 ifndef NO_PERL
-PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 PERL_DEFINES =
 PERL_DEFINES += $(PERL_PATH_SQ)
 PERL_DEFINES += $(PERLLIB_EXTRA_SQ)
@@ -2305,16 +2300,15 @@ PERL_DEFINES += $(RUNTIME_PREFIX)
 PERL_DEFINES += $(NO_PERL_CPAN_FALLBACKS)
 PERL_DEFINES += $(NO_GETTEXT)
 
-# Support Perl runtime prefix. In this mode, a different header is installed
-# into Perl scripts.
+# Under RUNTIME_PREFIX we inject a header into the Perl scripts; If
+# NO_GETTEXT is not defined we'll make use of the localedir.
 ifdef RUNTIME_PREFIX
-
 PERL_HEADER_TEMPLATE = perl/header_templates/runtime_prefix.template.pl
-
-# Don't export a fixed $(localedir) path; it will be resolved by the Perl header
-# at runtime.
-perl_localedir_SQ =
-
+ifndef NO_GETTEXT
+perl_localedir_SQ = $(localedir_SQ)
+endif
+else
+PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 endif
 
 PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
-- 
2.34.0.rc1.741.gab7bfd97031

