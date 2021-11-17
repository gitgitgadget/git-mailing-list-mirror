Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383AAC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A57B61BF8
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbhKQKYP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbhKQKYA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:24:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584B1C061226
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b12so3619204wrh.4
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBMr7lF+aQNpijO7CJ3wvJ2+X7KORrBeU/AVksdOFSI=;
        b=OUCQKn8g07D8kiv30nYqSCbvfUtHcpjvY9cVs8aQquxuNadmiWAOx7m0toTfn5PSTu
         qMM9W6win0fNr8pnV0ImghkZWJsQeD2qPld89FVqP6gqqcLirS/POMWh0iMYjsTUzxbj
         suWDtPa4eh1T0RxEa9rMieL2zdx4eEuagoqOQygkyqtM2EVuofJQDzICMNqR1r13T36a
         8ki+wYZwu1J4IBX3uBcEUHLorqbk4HysXTVypXh6qr6JAGTDg4JheuZSCTp90ugdwNOM
         EQBLRP235AueNkInot6Myi7kBaJleEbalEADlGovX11CR58IDXXo/mOwNU4EIo1zfDix
         qx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBMr7lF+aQNpijO7CJ3wvJ2+X7KORrBeU/AVksdOFSI=;
        b=loLWapAjC4S9+PfkzN+kWmW8URRPJrXg9Bx/6p9KbIJqIP1uKaAWqyat9g/zoe+xTl
         OA+ntCh0XimnD9GP5BZNErGhSmjBBYtrQWkCxknwonEJfv+aUsx4iFmhk2X4vl1g3nU/
         qN+gocsxcAVpUE0jKQ2lRKXnUnQbxBQNWcumHeED0tIhjZWxBjdyYD1Thh3IXm+jfNLC
         a5vIqCKtGC/XOWQ1O6CMXGBPzorwvC/XtWWZ94QWui4375UBMF5av/NqJ/0ri2v+rcu0
         aWTnzCJBbe+HeS6JJ3FEzdV3zE8M70LNk126XTAEJrpDttNo3a+IN44JUgLeLn6U/7Wd
         Rh3A==
X-Gm-Message-State: AOAM533ERxteAsYe5x6bPgBeXUhr+HLTtmC+vRntZ/gbcX6tGcVHGi7s
        wamQxWEZMx8779//8dSfQudC8y+mmxXqqg==
X-Google-Smtp-Source: ABdhPJzXvVTAsvdWKLw8x/NZPUmG3pGXBbbUVVexKCme44RQWVTJ1ChmtGrKpc4QxeOu1fXBi8M9iw==
X-Received: by 2002:a5d:630b:: with SMTP id i11mr18467589wru.316.1637144443647;
        Wed, 17 Nov 2021 02:20:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:43 -0800 (PST)
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
Subject: [PATCH v4 21/23] Makefile: disable GNU make built-in wildcard rules
Date:   Wed, 17 Nov 2021 11:20:20 +0100
Message-Id: <patch-v4-21.23-dd569a59c74-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Override built-in rules of GNU make that use a wildcard target. This
speeds things up significantly as we don't need to stat() so many
files just in case we'd be able to retrieve their contents from RCS or
SCCS. See [1] for an old mailing list discussion about how to disable
these.

This gives us a noticeable speedup on a no-op run:

    $ git hyperfine -L rev HEAD~1,HEAD~0 -s 'make -j8 all NO_TCLTK=Y' 'make NO_TCLTK=Y' --warmup 10 -M 10
    Benchmark 1: make NO_TCLTK=Y' in 'HEAD~1
      Time (mean ± σ):     182.2 ms ±   4.1 ms    [User: 146.8 ms, System: 49.5 ms]
      Range (min … max):   179.6 ms … 193.4 ms    10 runs

    Benchmark 2: make NO_TCLTK=Y' in 'HEAD~0
      Time (mean ± σ):     167.9 ms ±   1.3 ms    [User: 127.8 ms, System: 55.6 ms]
      Range (min … max):   166.1 ms … 170.4 ms    10 runs

    Summary
      'make NO_TCLTK=Y' in 'HEAD~0' ran
        1.09 ± 0.03 times faster than 'make NO_TCLTK=Y' in 'HEAD~1'

Running the same except with 'strace -c -S calls make' as the
benchmark command shows (under --show-output) that we went from ~7716
syscalls to ~7519, mostly a reduction in [l]stat().

We could also invoke make with "-r" by setting "MAKEFLAGS = -r" early,
adding a "-r" variant to the above benchmark shows that it may be 1.01
or so faster (but in my tests, always with a much bigger error
bar). But doing so is a much bigger hammer, since it will disable all
built-in rules, some (all?) of which can be seen with:

    make -f/dev/null -p | grep -v -e ^# -e ^$

We may have something that relies on them, so let's go for the more
isolated optimization here that gives us most or all of the wins.

1. https://lists.gnu.org/archive/html/help-make/2002-11/msg00063.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/shared.mak b/shared.mak
index 2d5d5b2fb9b..20109e6a90e 100644
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
2.34.0.796.g2c87ed6146a

