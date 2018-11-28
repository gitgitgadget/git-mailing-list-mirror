Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C151F609
	for <e@80x24.org>; Wed, 28 Nov 2018 20:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeK2H1g (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 02:27:36 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38033 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbeK2H1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 02:27:36 -0500
Received: by mail-wr1-f45.google.com with SMTP id v13so24176859wrw.5
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 12:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KQ/9m+6b5/zQ9OyXIjeBFE2mlVPNCHMV6dXvuBylWS4=;
        b=PDXyaZIAYvjcU69de2saSitzQu8u6vTSDj5lTTiCzOuv2H1Mg6Zrf5F7tnumyyPz/k
         iomnF+vexEI6QeyPFGNe6cMIwG0q0W1wX7xzkIDg+9AgAEMjpIYYuGtBiO5Vv4KAN1vV
         jB2iKAsibWk8QAtvtzi1DA8I57m591S8uQPAdJ5eKZs3H6bEZKl1n6gdPX4AGvTfELEg
         6L0ughbKcfsIkqWgoLqzT/JG/sXSMy65dJB/i4nx1Eh6rT0iW7r55GTz0yTIyLA4BWzC
         ST26FJR1EiMrdCN2zCigonTpo6bBSMMyKuhcwIANmgX7Tzj01/2YibBf6745ivRYnf0W
         Q6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KQ/9m+6b5/zQ9OyXIjeBFE2mlVPNCHMV6dXvuBylWS4=;
        b=rOGb5bnD/VMSAiDg53xY49Jf2Ru0tL5SfrhznEwgxyGTEVqHIHCdO7nleYE2mDcUX7
         v4QfcwVRi4h//09Bhn2ikuzbEUVZPN68kKW5urQ+JmOjHycFCelQmL99tHCuUW//pENF
         PKxcVTpdDiZ0kxLrJoxWGCLWB37qrMQOd65cVN8IAa4XdRE+IYjQ6yWnW4/QZTablNKA
         +fGnrvXw7+9bfXUwjjQWw1neDV7JM6+AY0+3nJWOxrcZ6ZgpjOidiTUgUlh4wTZLIR29
         kqmZhJohO8D9ZkW2z+rKbNXgTNBdTH1/45wzieLLWA564UaiIjGw9cBVVlmrwOlUmVoj
         feJg==
X-Gm-Message-State: AA+aEWYvb6ENDu3olFhsRCztwUpXVw9/Gf5EiSwLvQBgAb1b9azLlLD+
        RNLksXPS0hbrHkkqdEcI2s5xzGuY
X-Google-Smtp-Source: AFSGD/Xn0o+1RgBCig9XZZ2LoVhIjqCKn++Mjeiyx70jd42YQY4mDOJJUz1ywxkw9RY/ps+DR0DtGw==
X-Received: by 2002:adf:9361:: with SMTP id 88mr25090371wro.204.1543436336639;
        Wed, 28 Nov 2018 12:18:56 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 5sm4648896wmw.8.2018.11.28.12.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 12:18:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] format-patch: fix root cause of recent regression
Date:   Wed, 28 Nov 2018 21:18:50 +0100
Message-Id: <20181128201852.9782-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3
In-Reply-To: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 2/2 this fixes the root cause of the bug I plastered over
in
https://public-inbox.org/git/20181122211248.24546-3-avarab@gmail.com/
(that patch is sitting in 'next').

1/2 is a test for existing behavior, to make it more easily understood
what's being changed.

Junio: I know it's late, but unless Eric has objections to this UI
change I'd really like to have this in 2.20 since this is a change to
a new command-line UI that's newly added in 2.20.

As noted in 2/2 the current implementation is inherently limited, you
can't tweak diff options for the range-diff in the cover-letter and
the patch independently, now you can, and the implementation is much
less nasty now that we're not having to share diffopts across two
different modes of operation.

Ævar Arnfjörð Bjarmason (2):
  format-patch: add test for --range-diff diff output
  format-patch: allow for independent diff & range-diff options

 Documentation/git-format-patch.txt |  10 ++-
 builtin/log.c                      |  42 +++++++++---
 t/t3206-range-diff.sh              | 101 +++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 11 deletions(-)

-- 
2.20.0.rc1.387.gf8505762e3

