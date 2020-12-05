Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FE6C19437
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C39230FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgLEBk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgLEBkX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:40:23 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCDDC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:39:37 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id e25so8616330wme.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFSE6OnGmKJ92YCIbKVdGsC26FrhILnXzar4yvy4btE=;
        b=TJJ2vKvpQKH6Z69LKqnp9deasQpPrq3pLUynvVwCf7U0azzBh9UGB42NDKZdumRe4X
         sFdvlxVkIQqoKQ2uiFeY1hFtT/8lNj++XVzYO65ql3CIeVcaLDbWewG82dnskYkQ+1bQ
         YA/aQCN8iBPCS/V1nv/lyJ1vF1rObvqSyH8KexqNcZhTX34P2S77V1jxyJymAlDhpcI2
         erp7smCdJUwD2jrmdzZrmtbez2F/lO3fdC6rmUc2wXrKlsDnRO9iAN8smM6vlVBLMaJs
         oDdfPyXA/X+SfBejfkk0v6G630BPMSiBqQZj7jQwNdXo7XSlV1hg6gMr/+fxZvOXWa94
         hm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFSE6OnGmKJ92YCIbKVdGsC26FrhILnXzar4yvy4btE=;
        b=rb8Kl4D1LagZC1xBIXvyHW4ikmt3tEGhvYwkLbK4kjfeiFaBxJ7gPYyDFX7XS9PJTY
         iv3t7pIRCuY2xUj6gLLGys5m/lZpwQGWzYszmbobFS6XNwQ+jRi/VBITfqTH8MrC19yd
         N8ybZnXuP3027tq9k0qvjAcdybXj6bQ1ZSahrigxnh5HpUBa65wGSNWKlBsq8WDMy/x1
         Z7CDSM9zx6AHNuIIb95tauja9CQeJs3pphPqIx2NRcTxNV16fAz8oeEoGH9/E5SvF1WH
         +Y0QKf3H1jSH9a6JDLWQEYIEf3hquO+QnAEhL6EMKGm5AcchBwZ0mVwKXikTn5nGMXCI
         l9qw==
X-Gm-Message-State: AOAM531rTKCWvLR2cVtH/VqaMgDoXcINNszp5BNRNA7OOAY+tHVqWuTX
        fNZcvEJ46iN0VVKGG3g1GIxd/YqDL7M=
X-Google-Smtp-Source: ABdhPJzodENysk2/ea06JYE2/vjoW1jGhs2zxLsQF1bN4CrZ7NkmVDMF/dvCQ6hOOQ9rJ3Z9f0uhRA==
X-Received: by 2002:a1c:b4c4:: with SMTP id d187mr6956460wmf.38.1607132375794;
        Fri, 04 Dec 2020 17:39:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a1sm5537821wrv.61.2020.12.04.17.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 17:39:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] pretty format %(trailers): improve machine readability
Date:   Sat,  5 Dec 2020 02:39:13 +0100
Message-Id: <20201205013918.18981-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I started writing this on top of "master", but then saw the
outstanding series of other miscellaneous fixes to this
facility[1]. This is on top of that topic & rebased on master.

Anders, any plans to re-roll yours? Otherwise the conflicts I'd have
on mine are easy to fix, so I can also submit it as a stand-alone.

This series comes out of a discussion at work today (well, yesterday
at this point) where someone wanted to parse %(trailers) output. As
noted in 3/5 doing this is rather tedious now if you're trying to
unambiguously grap trailers as a stream of key-value pairs.

So this series adds a "key_value_separator" and "keyonly" parameters,
and fixes a few bugs I saw along the way.

1. https://lore.kernel.org/git/20201025212652.3003036-1-anders@0x63.nu/

Ævar Arnfjörð Bjarmason (5):
  pretty format %(trailers) test: split a long line
  pretty format %(trailers): avoid needless repetition
  pretty format %(trailers): add a "keyonly"
  pretty-format %(trailers): fix broken standalone "valueonly"
  pretty format %(trailers): add a "key_value_separator"

 Documentation/pretty-formats.txt | 33 ++++++++-------
 pretty.c                         | 12 ++++++
 t/t4205-log-pretty-formats.sh    | 71 +++++++++++++++++++++++++++++++-
 trailer.c                        | 14 +++++--
 trailer.h                        |  3 ++
 5 files changed, 113 insertions(+), 20 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8

