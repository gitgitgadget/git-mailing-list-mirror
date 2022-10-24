Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05EAC38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiJXUdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiJXUcn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:32:43 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9F416F751
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:43:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d142so8468112iof.7
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIce4dFL3Qi6PES5FDfXcpCfsb4SNke22edVUFgzEJE=;
        b=IBWk0i5CChmYPn7kJRf4K8/0ZB5Vf56Z3Pp/yC7OxU8tPzE8HlinNrYEDNEFYNKBNE
         trZn7aZIBuhcd/vPq7seWtC5K+2rEYAWfCXSkdceIznSyyLb8HPJmC8Xi2KhJth4Npvx
         u3NlmShGdJtMa+zyxdljCDrI+ooS/LPs4GZc45jRpLeGGTrRVlRm31ghS0GV1CMTESyP
         upuExOAriH+Tl45kC1QNzPZLuD2cRMiWUgq0qWYJvfsDTtFwwbq8qHwRnvKQgdBKW/WX
         qukmn8YxEzemje/G8g34oL2C61P6SGG3LzeH8NZofPc06oyHnzmZsDqUfCN4kBtfQRt1
         RJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIce4dFL3Qi6PES5FDfXcpCfsb4SNke22edVUFgzEJE=;
        b=rK/9evhB2xk4MWYafRgF0+hx2yiFavqV8Jgar9OX0GsFAbgbNeNJuyAqSpeFZK7Z6W
         lo8GLvF8SGOrKeibjsVjv9fR+EY8qGi0hW76KDMh8wDj+bS5CMwTrk3FRZplJBD6Cuc6
         5tFsreC0VvDQbnPusMJf7t+niE/rj/4y3KcoC3F79s6bOu3IEx22eTGzesBsu/q+k89d
         Wx9XoUCRx4v5GZQW6UP1A+ENbjzCz66RXOdrGVZvEg4LNF0XwetRaORmT72xDxzWGqj0
         R/x8U8K/K79ybXe8Y8KqBr0U1ZIH0Wgobgb9zYl4ZmjblKS/W++Ke6DsR95rKwrKTYDb
         eLCw==
X-Gm-Message-State: ACrzQf1t+sLcA4xghRsDaq+t065kHjtLyEtCi3bShcVEjvLzUtGN9DVo
        4iK0YLAZmMGW1MGC59jCbq8qU/7jHl4B3ce8
X-Google-Smtp-Source: AMsMyM5GZn30suho0Tylzn/xRMtD4nHiS4ju56ZoSF0yNvBBbOfz/393jjXfMbwNJCB75Sac5Z+YsQ==
X-Received: by 2002:a05:6638:3d0f:b0:365:d483:17e5 with SMTP id cl15-20020a0566383d0f00b00365d48317e5mr20085120jab.304.1666636981105;
        Mon, 24 Oct 2022 11:43:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i16-20020a92c950000000b002fc61ac516csm203985ilq.87.2022.10.24.11.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:43:00 -0700 (PDT)
Date:   Mon, 24 Oct 2022 14:42:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/4] repack: implement `--expire-to` option
Message-ID: <cover.1666636974.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series polishes off the RFC [1] I sent over the summer teaching
`git repack` how to move pruned objects into a separate cruft pack in a
different repository.

We've been using this series at GitHub for some time now as an
escape-hatch mechanism for quickly recovering pruned objects that run
afoul of the "advertise-then-prune" race described in [2].

The general idea is that we write out a second cruft pack to capture the
pruned objects, with two minor changes:

  - The second cruft pack counts the first cruft pack as "saved",
    meaning that we'll exclude its objects (thus ignoring both reachable
    and unreachable-but-recent objects from the second cruft pack).

  - The second cruft pack does *not* exclude objects based on age (i.e.,
    it acts as if `--cruft-expiration=never` were given) so as to avoid
    excluding objects which are being pruned due to their age.

The first few patches are preparatory, and the substantive change is
implemented in the fourth patch. I would suggest that reviewers start
there, and then read the first three patches.

Since this series basically boils down to adding one new conditional,
like:

    if (delete_redundant && expire_to) {
        ret = write_cruft_pack(...):
        if (ret)
            return ret;
    }

The (second) call to `write_cruft_pack()` comes with a rather extensive
inline comment explaining what is going on ;-).

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/cover.1656528343.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/20190319001829.GL29661@sigill.intra.peff.net/

Taylor Blau (4):
  builtin/repack.c: pass "out" to `prepare_pack_objects`
  builtin/repack.c: pass "cruft_expiration" to `write_cruft_pack`
  builtin/repack.c: write cruft packs to arbitrary locations
  builtin/repack.c: implement `--expire-to` for storing pruned objects

 Documentation/git-repack.txt |   6 ++
 builtin/repack.c             |  67 ++++++++++++++++---
 t/t7700-repack.sh            | 121 +++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+), 8 deletions(-)

-- 
2.38.0.16.g393fd4c6db
