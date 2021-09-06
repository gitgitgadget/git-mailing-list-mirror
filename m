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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5460AC433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D4760F92
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbhIFHGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbhIFHGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:06:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803ADC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:05:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b6so8214567wrh.10
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJwmq6IXub8UNsck8+vyuYxBax7co6lDEfVRBK7ayNk=;
        b=A4c8NaDVWJn4ymbxvxJL7j+dZUsV0/dZ+0DJMRPKHIbOvzmiRTsNt1GYh5YrqpplHf
         mHxMg5x0tq3ryHXapc2jxeIGTqRHFlprl8xxitjSNujZA+JBMfEQaL/tAnft8fJ/AI5U
         X9NvQBHfoOzRukHKreEeQqFNYZQMHmkXKIl2lNy08DCBxE3h6jxKUO9Y1vbI/os4HIne
         B9XhI5JYUXEBBq6KCzaZUj8wo+IgKeOGnASY78XjQbKE5DoZP+ia1huMOraVJtDMG2oy
         rQdT7xfFrUvq76CWzBeu5ppgV2NjCW4W/T63U8qrTKrNjtGFfP1rdTTMXZ24Kq+SMoDR
         qpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJwmq6IXub8UNsck8+vyuYxBax7co6lDEfVRBK7ayNk=;
        b=l9qq/kuZ/7UV4FcUSwhOjf3pW3H9LDZMoD7k2QabxKEVbrygt1uHosjZPjWY/xynZp
         1kIstCwvbWMGMN/Tl5z2G+EKeNrj1DQfYWfW8A52fJ6BrQsyofTJI2gDFRDs6lfhPbQ1
         fZ27F2BSKvxiL9HmtgwIPYoTXVRYZouT2SB3adAo+bWwHLgHGlsf3qI+tRGZwo7hg6GY
         c/kzhlKbZk9y1VrtQvNBBoC0QUNbj24GUFFYi0/u62vU7TQ7ykgYt43jaPHqxwrOAbKr
         252hHSWSFbZYX+OFTDYN3Sa3TECS2IHl65kRMuwZEet9adetwfn0ZFC1VVKrGPLTHtqR
         LNkQ==
X-Gm-Message-State: AOAM5313IWT9wsTyFl6msIk7LVQm7w0qyJcRnx+FBKpTFholbgCvJUpY
        6P5dBpS+dir28hnkzCqB+B1CaJVKsASrIw==
X-Google-Smtp-Source: ABdhPJwtydkCDD0ft9XTVyDDsOafcY2bCGdD+ixiLakeVKx8oiNS7bE6x1Id2k16eN3Y8xYduQvKug==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr11313356wrr.298.1630911925827;
        Mon, 06 Sep 2021 00:05:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f17sm8076684wrt.63.2021.09.06.00.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:05:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] git-bisect: remove unused SHA-1 $x40 shell variable
Date:   Mon,  6 Sep 2021 09:05:17 +0200
Message-Id: <patch-v2-6.7-bcae7884bb0-20210906T070201Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
In-Reply-To: <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com> <cover-v2-0.7-00000000000-20210906T070201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable was last used in code removed in
06f5608c14 (bisect--helper: `bisect_start` shell function partially in
C, 2019-01-02).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-bisect.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 6a7afaea8da..b59f3aaad43 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,8 +34,6 @@ Please use "git help bisect" to get the full man page.'
 OPTIONS_SPEC=
 . git-sh-setup
 
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
 
-- 
2.33.0.821.gfd4106eadbd

