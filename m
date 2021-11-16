Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9D5C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFB561B3D
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhKPMI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbhKPMFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:05:32 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918EC0432C0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:54 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso1734345wms.2
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXSJBOyIgVUcx7NMu2fpoysXYWnT+MKHU2pfBKfqnFk=;
        b=oHfGli8r3wTuu6RpOOYeGZvmBY5QYKnmloOqcOLs/6t3e+eFg2ch5XD0lzjB2A9DYZ
         mqQnp2zHBhTqC4wXRm4UJsBUi9+w/Q9jr5uSArV3EEyWHsm2we98sbfnrlysKu2Fji7p
         Hs04ZSSBZ/zeD7nRDMKfmHph7QYrnto4xZnpY6bFnzrRwInpYvePwXFbJfhpZDGjtGqU
         6/DNrdXZp2wElKflsY8AmStWVkUiDWEinroGMsZYeciQB075QAMfDrUr7wwBnF0Nf6ba
         Id09hOKxXFmQ3GRU7mlji/SgSa0LIkNri2W+JfM23aThtXpe31N+RAcibl2R5D/+AUx5
         FC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXSJBOyIgVUcx7NMu2fpoysXYWnT+MKHU2pfBKfqnFk=;
        b=f/+o6LG2uGGzFXNcFgXURMFsMf4ekB7yyYo8ev5UTDi8pA0JhNcrJ/BDSkJ4F2V5ZN
         40AyPF6NJPvsPx3CGh1rAodGwqlAVO+BqYsBlbULPghOSKzomAcEVZvzoONzh0NV61k8
         i6BYXaTIjGLTFIYkXoG0CDDNefFp3CHpmbCoT72HfvQRpdbrJ/4KxU9FH74wrnBQrWd2
         cqCfgFHVOfb7jZSZamR2n1VOqSMqclsfp0WEg/9Cp32TYYMD3dTGc/LSQSOXnC7GLrH6
         FfvbjYk9LvJoieYrLAp9usVgMyE1WOdB0h/YzUnalh6OCwwPis9IESGzfXvhG+4r6RpL
         wlNQ==
X-Gm-Message-State: AOAM533+45Ec3zzI0Uf1PajOX6lvVCwCdnpUs9Jff4wgJ/U0wLpv7uzt
        +Nge+cxx0eyyHSy3sdmK1c+hfk/fHxmKLA==
X-Google-Smtp-Source: ABdhPJxfJMiwEs/GZfkgza6TzLvFh51zjy0lLbaJbG/f/4yRnkLbBD8ZCgPz5Fzsx7JiqqIA5vYp0w==
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr71247103wmj.29.1637064052639;
        Tue, 16 Nov 2021 04:00:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k37sm2427922wms.21.2021.11.16.04.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:00:52 -0800 (PST)
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
Subject: [PATCH v3 21/23] Makefile: disable GNU make built-in wildcard rules
Date:   Tue, 16 Nov 2021 13:00:21 +0100
Message-Id: <patch-v3-21.23-cb3ae5ce00b-20211116T114334Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com> <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
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

1. https://lists.gnu.org/archive/html/help-make/2002-11/msg00063.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 shared.mak | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/shared.mak b/shared.mak
index 4ee0bb7a13d..4862df1607a 100644
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
2.34.0.795.g1e9501ab396

