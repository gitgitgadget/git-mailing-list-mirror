Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32586208B5
	for <e@80x24.org>; Mon,  7 Aug 2017 18:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbdHGSVN (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:21:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38212 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdHGSVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:21:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id y206so1898219wmd.5
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+nHb5UQhw6Lu775WT89nh3EqBMNu6FkI9vYgHHAgm8=;
        b=sI/DdfWmrgpWNKuAMOYzirjdNDi+domGWrZh74vUYDijJPsQ2xtgGxFnL4lgQyoHOL
         R7T+x+CEuFFKC96wvoWK6col8R/15BfApuGIrjmO++Ra+Zc0AivG8Jx9STttPGfM3zVD
         +oC7bQRb22ll7cdnqTQB26AOYPo8BlTbj+u0BNubUsSOfHPgD6jmhrNWXQX1N/NSpu2K
         5eGj0isSSH5UZ+TjMypARTiShPtnJtMVJVYPo9LeL53xSTCSSXg8+K1THKIOCkVzfsgh
         /nw2h9SFaTFRQoLIh+QgE+Ky7GPIuJKPXlFQMvLsZrPMm9omua6c+ciy2oSE2a97NcpO
         RKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n+nHb5UQhw6Lu775WT89nh3EqBMNu6FkI9vYgHHAgm8=;
        b=Op9vuYUZBPJ5ZdoxO6kAdvjj1rpQkhUseiywbh7DYo1etn7NBcUTXIxWemtVVfv2P7
         PwEYjpF9w+HpAiopkFx87FebGvEwFX4cDdtkmcOEFIfOxS7IZwCkhpzGExRzlM4Ei0qW
         LaRdM/1YpEUVA6uaxBlOnSxZ50UitapToIZPPFrfnPQnDRt01gpC2+U79E4Y1X5X8tT0
         TalQrYZzSRxaBqXXdW2Kq1ZbRYH6lbUvoT1g0rE3o8P/X6MuO4D67FNnyYGyh4b0j6Yk
         pLzuhlI9rcDmvN9KTfav6zOqNrpJbQx4j//0WDXOkL35Jgl3kp/3m6gfwtqUxYPTwjjf
         n1Tg==
X-Gm-Message-State: AHYfb5jxMZ1tlEIUhN041pLPOqUAT/PZi23HjklsMcDLPrzqAiUQOqp8
        Cooo122jZGdxbB5z
X-Received: by 10.28.27.69 with SMTP id b66mr1468351wmb.11.1502130071021;
        Mon, 07 Aug 2017 11:21:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id e27sm11519422wra.25.2017.08.07.11.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 11:21:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Dave Borowitz <dborowitz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/6] clean up parsing of maybe_bool
Date:   Mon,  7 Aug 2017 20:20:44 +0200
Message-Id: <cover.1502128418.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.5.g0f7b1ed27
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we want to parse a boolean config item without dying on error, we
call git_config_maybe_bool() which takes two arguments: the value to be
parsed (obviously) and a `name` which is completely ignored. Junio has
suggested to drop `name` and rename the function [1]. That effort even
started shortly after that, by introducing git_parse_maybe_bool(). The
new function currently only has a single user outside config.c.

Patch 5 of this series deprecates the old function and updates all
callers to use git_parse_maybe_bool() instead. Patch 6 is a final
cleanup: one of the converted callers suddenly had an unused argument.

Patches 3 and 4 prepare for the switch. In particular, patch 4 ensures
that the two functions are actually equivalent. In doing so, it affects
`git push --signed=..` which was very slightly inconsistent to the rest
of Git.

Patch 2 adds a failing test in preparation for patch 4. Patch 1 corrects
the documentation not to say "git push --sign=.." to make it a bit more
obvious that the opposite typo is not being made in patches 2 and 4.

git_parse_maybe_bool is used in sb/diff-color-move, which is in "next".
This series makes --color-moved and diff.colormoved consistent with
other booleans. That should be a good thing, but cc Stefan to be sure.

Martin

[1] https://public-inbox.org/git/xmqq7fotd71o.fsf@gitster.dls.corp.google.com/

Martin Ågren (6):
  Doc/git-{push,send-pack}: correct --sign= to --signed=
  t5334: document that git push --signed=1 does not work
  config: introduce git_parse_maybe_bool_text
  config: make git_{config,parse}_maybe_bool equivalent
  treewide: deprecate git_config_maybe_bool, use git_parse_maybe_bool
  parse_decoration_style: drop unused argument `var`

 Documentation/git-push.txt             |  4 ++--
 Documentation/git-send-pack.txt        |  4 ++--
 Documentation/technical/api-config.txt |  4 ++++
 t/t5534-push-signed.sh                 |  7 +++++++
 builtin/log.c                          | 10 +++++-----
 builtin/merge.c                        |  4 ++--
 builtin/pull.c                         |  4 ++--
 builtin/push.c                         |  2 +-
 builtin/remote.c                       |  2 +-
 builtin/send-pack.c                    |  2 +-
 config.c                               | 15 ++++++++++-----
 pager.c                                |  2 +-
 submodule-config.c                     |  6 +++---
 13 files changed, 41 insertions(+), 25 deletions(-)

-- 
2.14.0.5.g0f7b1ed27

