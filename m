Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2B291F461
	for <e@80x24.org>; Tue, 27 Aug 2019 10:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfH0KOT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 06:14:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34652 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfH0KOT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 06:14:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so2047926wme.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 03:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqjWpmQup8ZS0pieyXpMhF1xWGmjAKb8RID1fw7JD9o=;
        b=GpKWX9kWZnQKL9GpWgcrNrGIzWsRfpkQh2myeaFcWe3bcLkomAI1EDUrmrcYTj7TXc
         54Pjg2qqrYUXM6HkTJybyB36TtI2DMwvM1537vBM1ZeGG60WU0pTIw0Sp7NhEpHrmlhj
         Gv8bKZUX1YxOqsq2s+vkQRUJ5opo737wne63pHFCqmVZQHEgNiZwQthYDxHr7utZumYO
         OEaP1mNX0R/r39i6Kb64g+Gs7fSfHrI0PNHApBL3UhPZx5hnBRoXS3G3IhH7772yaMVv
         dfDJIrR6sZnbIav8KrzUeRto0Bki4ri34y5rJjio/Qmjs37v7b3jaZe/9lUkl45RPdDe
         HmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqjWpmQup8ZS0pieyXpMhF1xWGmjAKb8RID1fw7JD9o=;
        b=gyrmnyZgqVr7C+wNGZHT7XshADW37dTNhocB8h/PRVnKrUj7zMvEpYO/8xKn5TnumT
         HNTSGdSNP7K/bqbLJZ1LlyRud8Pe/g5ngXmk5XcIQoIgUOWFMcZekpIEaO6bHecQgTg/
         Sw9Hf/9liAPFx3gUmRTm3KdQn/dm7Tiut5diAUW+RVFwgcAIk+k30e75jDKrlkDw578Q
         7o1vJrFt0CmKD09DqaptA3z1BcL7sw+u/6j0SHgYZccpbvaDJsBrDs2nwdgHlg/70QU6
         1IioYm3Ihq7uWecPxUuze+GDLLFoLN7y/w2zBH3I1wnBs7Pg0HpWpha4TChnubAIDQ2N
         PHsg==
X-Gm-Message-State: APjAAAWTHVi19nOXlsp6BNBAl6g2NftN8CJq/913OSQAG/5aIQ1MBDu6
        hXGhnOZV6fxqKRPm7mbv6n+/2Z76
X-Google-Smtp-Source: APXvYqzk4U7KzTYhCbLH/uXEXZ4eJMLuF+kuyfQkg532akAd4fnOXVoAbpWywznNA/9Juv/b8MVK2Q==
X-Received: by 2002:a05:600c:389:: with SMTP id w9mr26806913wmd.119.1566900856611;
        Tue, 27 Aug 2019 03:14:16 -0700 (PDT)
Received: from localhost ([2.31.128.175])
        by smtp.gmail.com with ESMTPSA id r18sm2485599wmh.6.2019.08.27.03.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 03:14:15 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 0/3] make sure stash refreshes the index properly
Date:   Tue, 27 Aug 2019 11:14:05 +0100
Message-Id: <20190827101408.76757-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.194.ge5444969c9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Peff for spotting the bug!  Here's a series that fixes it.

> And before the third one, introduction of a new entry point that
> makes merge-recursive machinery inherit the already populated
> in-core index, happens, I think the right solution is to write the
> in-core index out---the write is not pointless.

Yup, I agree with that.  In fact there are some other places where we
just call 'refresh_cache()' as a replacement for 'git update-index
--refresh'.  At least the other one in 'do_apply_stash()' also seems
like a bug, as I assume the original intention (and behaviour) was
that the index is refreshed after 'stash apply -q' finishes.

I think in do_push_stash and do_create_stash we might be able to get
away without the write, but I wasn't 100% sure, so I made them write
the index after refreshing it as well, which is what the shell script
did.

The first patch is a small refactoring that makes the actual fix a bit
easier, while the second patch is a cleanup that I found while there.

Thomas Gummerer (3):
  factor out refresh_and_write_cache function
  merge: use refresh_and_write_cache
  stash: make sure to write refreshed cache

 builtin/am.c     | 16 ++--------------
 builtin/merge.c  | 15 ++++-----------
 builtin/stash.c  | 11 +++++++----
 cache.h          |  9 +++++++++
 read-cache.c     | 17 +++++++++++++++++
 t/t3903-stash.sh | 16 ++++++++++++++++
 6 files changed, 55 insertions(+), 29 deletions(-)

-- 
2.23.0.rc2.194.ge5444969c9

