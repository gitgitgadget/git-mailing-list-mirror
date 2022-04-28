Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7CAC433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 03:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbiD1DjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 23:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiD1DjH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 23:39:07 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABFF7246F
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 20:35:53 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l203so4158851oif.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 20:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWIT6UZ+Lx11P5mTkpcfJ3/QkwhieUQASn6/oHEhOJY=;
        b=oMADvdHAK9zbNgrnkykL/CuKUkxK2EFgdgtho4ftAAHqao/lJEgj9kvHQ4NZRs6I7y
         WF1atO3gLh8kEp5M/MEyWFt1AJoILEAeDE+sw8f55pgtOnpk8YGDVQdQWoEQBtF43xzh
         9PScpdPZ5uNoBL7D6m/VjaNyl782scbRmK9iy4TG5FTrnkY3uDAwqFA1P28RLv4vbelL
         bqK7/Wyk6D7d1YjAtbtQjJADVbqFo8yxLJAEoGrosuIH1EjHI8zebkyh1C1s4QuLBLcs
         OSk/BXQyE1FhMZcQzRn0jV0iRX5luYYVbNZmWYMXK0PyVeYhvM+zNW3En0LYZcaOMTFa
         mxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWIT6UZ+Lx11P5mTkpcfJ3/QkwhieUQASn6/oHEhOJY=;
        b=woOrBZkPptk+LEABwFoN1Iw+A+g8tDLV6IzEEAgJgPkIBSSDl1O3GzUXmK5lEe459Y
         fM7e2FJZprL0Eo/ujBiEC7xikmuY5+OEylVkTpXE8KecB0X5QYwKp0l9CE9VTVJDNJPU
         FFJ+c3QVV0VygA/1WxZux7WXJZI/dEroqnV/w9buBRt2VdhNdjKsy2/nFoIm8RvyR5r3
         wEUNhRiyFhqRUQfu2tAjpubcceTKKDfC4pLLOpIkzkX7dwlRynIkGNcwT9TIsBUdhwRi
         phZtLeHkTw+tpgfoWWZsaJJeGZzbsv7a+8ZR8VpHW0KAsqDVmvuCYzx9drXrCXWa54Ml
         TPqg==
X-Gm-Message-State: AOAM531qorh/hxKICHsdYbNVRcj/c3r5M+CaZuL8lepsiWWSQDKaOV0S
        4N+X+oFuFgLFFsr9QvM+iPr60PlSG1Q=
X-Google-Smtp-Source: ABdhPJxx80qcf3t1z1EnIy1pcKSDolFrz22Mn9soC3/qmZCcS8Eg58zuEp22+efY18mhcdsJbVnanw==
X-Received: by 2002:a54:4688:0:b0:325:9a36:ecfe with SMTP id k8-20020a544688000000b003259a36ecfemr1729462oic.96.1651116952077;
        Wed, 27 Apr 2022 20:35:52 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id x21-20020a4a6215000000b0033993dc1d65sm7432217ooc.8.2022.04.27.20.35.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Apr 2022 20:35:51 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/2] fix `sudo make install` regression in maint
Date:   Wed, 27 Apr 2022 20:35:42 -0700
Message-Id: <20220428033544.68188-1-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220427222649.63516-1-carenas@gmail.com>
References: <20220427222649.63516-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The following series complement the recently queued[0] RFC that adds
the missing functionality to allow git to validate a git repository
while running under sudo.

They could be squashed together if preferred, as they seem to be
smaller that I had originally assumed and also unlikely to conflict.

The test uses a function I stole from rs/t7812-pcre2-ws-bug-test that
could be alternatively moved to a common location and reused if that
is preferred, but it is small enough that might be as well be done
as part of some cleanup later.

Tried to change the documentation in a way that wouldn't conflict with
other on the fly changes, but there is at least one pending change
not in seen AFAIK in the same file from Gábor which might[1], but the
resolution should be to take both sides.

Carlo Marcelo Arenas Belón (2):
  Documentation: explain how safe.directory works when running under
    sudo
  t: add tests for safe.directory when running with sudo

 Documentation/config/safe.txt  |  8 ++++++
 t/t0034-root-safe-directory.sh | 51 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100755 t/t0034-root-safe-directory.sh

[0] https://lore.kernel.org/git/xmqqilqujgvs.fsf@gitster.g/
[1] https://lore.kernel.org/git/xmqqee1il09v.fsf@gitster.g/
-- 
2.36.0.266.g59f845bde02

