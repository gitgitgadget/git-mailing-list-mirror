Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEB2C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354438AbiFUWea (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiFUWe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DE64E7
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:26 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k22so14410762wrd.6
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mVzv7GnudKTYtlAXViJXUi7pEntKhOJxJaFksT0ENg4=;
        b=Bk1To76iuLI+0exq3AaP5aqLUtyP7Xp/oQjP3PXuKan2HJYytuCT3tG+V3TttlKBHY
         dtLeA+GcW6DZxtlx+UWVVGuNjwxdnB2ftf52esByvoUhlUX/txYC2+1ZJWJuWhsr54QJ
         rRMqdyDbbpnp839yRxpoJ1dlBZ983VfQs5XJnks2BNwyqxbntBXYJ+pyjb24J7tjOnBh
         sSZZGGD7s5SxQEG3xScHUdQpNkfV+24Zf5sUhjjTETX2dPjrTjbECajUpXK6ip7Zi2H0
         XQkvJwrZjNFNrhKQS9WsqqgeTf3P7IAbNypf4IgJDMqNW0Olgb6qgo1NlTiHkz/D22bn
         /LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mVzv7GnudKTYtlAXViJXUi7pEntKhOJxJaFksT0ENg4=;
        b=dNGp+LiskkMj3pW95TDDCK/MTD01PcXuiqFpazQX9JKgfhZaqTTGfkCEoVyCA64jDG
         6+UoDln2cABPsJ3IWuXf2I5rYHG1AtBEDFRu0Og3BK0nxKQLUJq5d4D4gAGSifxwqMfC
         1NNwbqfZ9dga7QCS24o0idnIVZavYA/cFHwkC0OCcCx6DGL32Hzonag+kY5JVkKjyB9k
         bKQfbeF9zxBrmemIZOO50ZegqWjFne1mMxAfYJEn/a/sCbC8ak1kqw1OY8WtOlveK+Zh
         7znWwOJAk7xR3nntjlywN2BfC40nac//mXQzrhEUhJUS+ETWFanHoEUrrNoyCDHHH5iQ
         8v4w==
X-Gm-Message-State: AJIora+FW6xqDS5ZrCcNfO5h+0OsIpLvH+/mzDKXHQadWwQeWAd4rSOd
        WezsaQefJ97iGZgEA2GXxciZ1bl5sIbUFg==
X-Google-Smtp-Source: AGRyM1terUlU9ryXwTBlhV6QlA/NRiK7WKeVLMflkcwwJpJyWKpJv3MoKsfjVuhOsila9pGXPg/dhw==
X-Received: by 2002:a5d:47c9:0:b0:20f:e7d1:4616 with SMTP id o9-20020a5d47c9000000b0020fe7d14616mr224949wrc.542.1655850865077;
        Tue, 21 Jun 2022 15:34:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y5-20020a7bcd85000000b0039c7c4a542csm19000299wmj.47.2022.06.21.15.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:34:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] t5510: fix the quoting mess
Date:   Wed, 22 Jun 2022 00:34:12 +0200
Message-Id: <cover-00.10-00000000000-20220621T222854Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <xmqqa6a5g0m3.fsf@gitster.g>
References: <xmqqa6a5g0m3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the upthread quoting discussion pointed at a commit of mine I
felt obligated to look at this in a deeper way.

When I added those tests I carried forward some technical debt where
we were passing arguments to a function as a string, instead of as
multiple arguments which we could get with "$@", in hindsight that was
a big mistake.

As far as I can tell the proposed
https://lore.kernel.org/git/xmqqy1xpg3th.fsf@gitster.g/ fixes the
issue at hand, but this is the deeper and I think better direction to
go in (but I could rebase in top of that fix if needed, although the
conflict is trivial, keep this side).

Now we don't use "perl", or "sed", or whatever to re-quote arguments
in t/t5510-fetch.sh.

There's still some weirdness in that test, e.g. the whole behavior of
set_config_tristate(), but I had to stop somewhere.

Ævar Arnfjörð Bjarmason (10):
  fetch tests: remove redundant test_unconfig()
  fetch tests: use named, not positional parameters
  fetch tests: use "local", &&-chaining, style etc.
  fetch tests: add a helper to avoid boilerplate
  fetch tests: pass "mode" parameter first, pave way for "$@"
  fetch tests: pass a list, not a string of arguments
  fetch tests: remove lazy variable setup
  fetch tests: remove shelling out for previously "lazy" variables
  fetch tests: stop implicitly adding refspecs
  fetch tests: fix needless and buggy re-quoting

 t/t5510-fetch.sh | 289 +++++++++++++++++++++++++++++------------------
 1 file changed, 178 insertions(+), 111 deletions(-)

-- 
2.36.1.1239.gfba91521d90

