Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9681C433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 01:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhLQBjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 20:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhLQBjf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 20:39:35 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59ADC06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:34 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c4so1139924wrd.9
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 17:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxh68uU7jF4zSQ3XWzHLm82LKkUP0o4wKc2GLAJ3vD0=;
        b=h4EFVjNvHEy5rCeT4uQMrenubGZNRwm3hukaQ+LgLjAYvYDlXaH0Vzxdy97iCJlS39
         /q3FxCojA6qUks2lFLw0PB/i4lVf1GQQda2r2+8yTmpbVKP3lMRcp+4q8Iglvbf98kda
         jPppNIrybswLMhdvZFzId4guaHAxOrmoO5Z7W/1PIl/c2jozZurYihlGoXTOQxXujgWM
         W6VvCfVybcwsRVV2ZQsQdzmQ8CQ3g0GTHF5FoxBOCxEfpHGOPCy21dahPDw7iFgtADm4
         VQ/XNPZspSHyDN+c+fzsSMiL84KYLu+Lhmqn/mbKpfxRQBO0Qb1QZ/zdRvIC5VvOttod
         OmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxh68uU7jF4zSQ3XWzHLm82LKkUP0o4wKc2GLAJ3vD0=;
        b=6hpz6cjtaRE5Mjn1NW6jao5XHZtSW76nESJncO+Tj9OcFG4PVbljDX+MsIS/gBdZaY
         vGNxLhUYLShNAwt+NzKMGx69U3mnEk3RLU8TGWiTHwL69AgPmxwlXwgO9ST/oyeTUeIS
         HCgEB2D1Zf1NnpNvE5SIAdjak7busAfC4ZAGGTbGdvAi3vNdqpq+VNPWVKQ0/XA6qaUw
         T3yW3kBX5XcXUphyiwCDWjhDqlcN/jdHoYe9ggyNc34F1j+0s0ZRcjLwS4D4+fYjS6w9
         dVmuNeLHdj/TSSlwqL2nRwc36POTx5oTOuz1QrQZTmyWuU6PHKn2iFQlUQiOhishOohx
         yulg==
X-Gm-Message-State: AOAM533N1Tb3poDIoNJaMSOv62ohUZQoIsJUb1dj8U472p6Ib2jZG0N+
        gIS2m0TLBJSGkA5K/MiSAJtq2iAARIxJJQ==
X-Google-Smtp-Source: ABdhPJy/t9rHrMwwYN5NGsLimjL1w+//8UbCLqIEqTvGSW8e2PrHZ0dZ9fZ8jWvAD9hjy8gg8ZleqA==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr475306wrs.157.1639705173014;
        Thu, 16 Dec 2021 17:39:33 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c4sm5843869wrr.37.2021.12.16.17.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 17:39:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] Makefile: disable GNU make built-in wildcard rules
Date:   Fri, 17 Dec 2021 02:39:20 +0100
Message-Id: <patch-2.8-b0c63abe091-20211217T012902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211217T012902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Override built-in rules of GNU make that use a wildcard target. This
can speeds things up significantly as we don't need to stat() so many
files. GNU make does that by default to see if it can retrieve their
contents from RCS or SCCS. See [1] for an old mailing list discussion
about how to disable these.

The speed-up may wary. I've seen 1-10% depending on the speed of the
local disk, caches, -jN etc. Running:

    strace -f -c -S calls make -j1 NO_TCLTK=Y

Shows that we reduce the number of syscalls we make, mostly in "stat"
calls.

We could also invoke make with "-r" by setting "MAKEFLAGS = -r"
early. Doing so might make us a bit faster still. But doing so is a
much bigger hammer, since it will disable all built-in rules,
some (all?) of which can be seen with:

    make -f/dev/null -p | grep -v -e ^# -e ^$

We may have something that relies on them, so let's go for the more
isolated optimization here that gives us most or all of the wins.

1. https://lists.gnu.org/archive/html/help-make/2002-11/msg00063.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/shared.mak b/shared.mak
index 0170bb397ae..29f0e69ecb9 100644
--- a/shared.mak
+++ b/shared.mak
@@ -1,3 +1,14 @@
+### Remove GNU make implicit rules
+
+## This speeds things up since we don't need to look for and stat() a
+## "foo.c,v" every time a rule referring to "foo.c" is in play. See
+## "make -p -f/dev/null | grep ^%::'".
+%:: %,v
+%:: RCS/%,v
+%:: RCS/%
+%:: s.%
+%:: SCCS/s.%
+
 ### Flags affecting all rules
 
 # A GNU make extension since gmake 3.72 (released in late 1994) to
-- 
2.34.1.1119.g7a3fc8778ee

