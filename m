Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA3CC83F14
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbjH1WxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjH1WxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:53:06 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC329EC
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:53:03 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d7830c5b20aso4811333276.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693263183; x=1693867983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZE1PgP+/38boNpAx1097/xpf9xTwKbnXuMbbKRoWPg=;
        b=kMPZ7JhNWdbpB5wlMwHVFaSFuDmAH/HASBx5SNtOhanRDCpVDJFzRZmsIILDKjPVGS
         /nwMqzh9EzrbFat7Z83900eWwo+9UVLWt+mGrWj5NnAuRYMy8HP7UNZa7rK4QQiHqJKs
         iiX5lrTP7WsvyQyJHLQi1qmBj5iYu9GPLs7ro0bDbCxPImW4orAgiB63Br7UsNcaCo7z
         BWwxGe0u+/vcz1CdgcGY5A8niq5nmzqrGGa4Te7bPud7CatP/RbvT6zfqQ10DH9aeIyj
         c0gMPPM1f6cSflhWGkwFN/EGlVVTRzRzMX03Gj/iHGFDA1KLsDs1xsbOLfrdc2F3QzQX
         /cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263183; x=1693867983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZE1PgP+/38boNpAx1097/xpf9xTwKbnXuMbbKRoWPg=;
        b=JGYrk61IYhIv0/zO3lqklyxu7FSRmP1Z0ySViA/MjRx5JmH05r0ZJdwftx42qfUa4h
         aZfCWeKV0ZI4ypBI2Pq7Jy1xO2UF6zWhGfTrEzJ6gA8aVJoH0gzs/ijgUDvar9P5U8WV
         EX1GOyI998wuh4c0Jc2iKtz+qzvgCSSyVh3uOEX8H8QuQJJxINLb95pEwu/ygWkV/r9q
         ElXQOpPKc60TkPJFysHTxpOZpENKQRh8kvl1GJN6jX96MOJCANILemUyPPqryNHU9UON
         SOXwS+DnmhEu1w2Xad6gMHxUz/xa6RJhesNr7dzyvgg2UxlwcHfQAEkjbbWZ+RsfgWZ0
         VPWQ==
X-Gm-Message-State: AOJu0YyzFSl2ZN2yhR5BY8ePnszWDKEfNkLUj9+6sY5bYZfU6vTIxHEP
        U2uP0Hpaogyn8zdqV6hTHn/B9W9qJlrZwZjgSMGrMw==
X-Google-Smtp-Source: AGHT+IGnbnov2cD4hbpUXTliMdpz26OwbQ5Y2QGNtUwlsvzQGnD9PwB9xqyn46r1tTop3n1GrNYECA==
X-Received: by 2002:a25:ae04:0:b0:d0c:7309:87f7 with SMTP id a4-20020a25ae04000000b00d0c730987f7mr1282833ybj.10.1693263182897;
        Mon, 28 Aug 2023 15:53:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p5-20020a257405000000b00d74b5e166acsm1934534ybc.10.2023.08.28.15.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:53:02 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:53:01 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 3/4] leak tests: mark t3321-notes-stripspace.sh as
 leak-free
Message-ID: <116555fc023553586ffbb88e1bdde43ca3b919a4.1693263171.git.me@ttaylorr.com>
References: <cover.1692902414.git.me@ttaylorr.com>
 <cover.1693263171.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693263171.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test was leak-free when t3321 was originally introduced, but never
marked as such:

    $ rev="$(git log --format='%H' --reverse -1 HEAD^ -- t/t3321-notes-stripspace.sh)"
    $ git checkout $rev

    $ make SANITIZE=leak
    [...]

    $ make -C t GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=--immediate t3321-notes-stripspace.sh
    [...]
    # passed all 27 test(s)
    1..27
    # faking up non-zero exit with --invert-exit-code
    make: *** [Makefile:66: t3321-notes-stripspace.sh] Error 1
    make: Leaving directory '/home/ttaylorr/src/git/t'

Mark this test as leak-free accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t3321-notes-stripspace.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
index 028d825e8f..36abdca5ee 100755
--- a/t/t3321-notes-stripspace.sh
+++ b/t/t3321-notes-stripspace.sh
@@ -5,6 +5,7 @@
 
 test_description='Test commit notes with stripspace behavior'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 MULTI_LF="$LF$LF$LF"
-- 
2.42.0.49.g03c54e21ee

