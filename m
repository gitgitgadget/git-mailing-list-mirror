Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3C31F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 08:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJIPcf (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 11:32:35 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39963 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIPcf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 11:32:35 -0400
Received: by mail-wm1-f49.google.com with SMTP id z204-v6so903297wmc.5
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LCRZivXyivbX+VWYMDanmrA7qr6CsgxdohQtugPslFY=;
        b=Mr/Ey6sqFlkIrtIu4COL5usLRkB4hFhKe1E2qHVuJj98kcVWr99KfDKcnk981KINGI
         csgnxQT4bOFgT67l8kIj8RZyPDiP9OdXs6VOvtjNmyWC5CY1tn3OJPJS+pkuiP1YonN5
         4ROBkbI067XE5H06hnD3TexQgmGUlam4M55q2vtbCV65e3ysFt24szDmdGGHCqqNg+JD
         MWeYPLIulvHEak+n8/uNieRufojNtUGH5CBR2zSsEi1TIgLIO78fsSQrONATcOG2QsDK
         V4/3Vj8VAHzg5jPBIjLcwiCBSTkjqzTyT5lm/EJHWHyTxHC6dqtIP64pjZW5ZTuRnzFU
         agGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LCRZivXyivbX+VWYMDanmrA7qr6CsgxdohQtugPslFY=;
        b=ibqVXzOn+kOJiAwuY7kPCbew2wM+ZHqFrBpO7MWW1Cu5jT93v7AjBx9OayKypXA16h
         ByJugvbIVfg8cWB/K4YM0LhsAMDaZVH69m5oQKYRWP9CajsswnAXJCJeKh9goHQgCVGb
         0i7QbW73NdEajIdMpZ+7x/negcakH5TgcTNfecpUdfTuvmJhZExZERMAGnZHFsAwpxOk
         cYHrix1I6aSwcYtNzC9wzrCat5AU6LqUzdeQBxYbmVM1Nk6NJC3fykC/k3xux+xuaXvu
         3S+HR1ETTb8nomMtbLqCeA0h3qaMkZEsstZ1BbGgDVtSgw5WNkETFEQk0RhD+LH+hXJV
         RKVA==
X-Gm-Message-State: ABuFfojn05YuDL8xxvyGwTvlE79eYm/HxQcI0T0ujaMBbsRILhrouu1H
        v71lvhXnLafRBDkYPhXR1NbWspKMXm3jFRQ0OnnUo+vdz/A=
X-Google-Smtp-Source: ACcGV60qd6s0m9dq+fsnAMivOH/qPTr0CQydyuaGOe//6QUQIEUMQRElvjm2MkfgdSJImL+RybZxmXIftF8rxBA9IxU=
X-Received: by 2002:a1c:d04e:: with SMTP id h75-v6mr1080309wmg.92.1539073009568;
 Tue, 09 Oct 2018 01:16:49 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Tue, 9 Oct 2018 11:12:32 +0300
Message-ID: <CAL21BmkdUiNgr4NqpwTdi9f47i85s8oXCZMmVx5VyNKotL78uA@mail.gmail.com>
Subject: [PATCH 0/3] ref-filter: reduce memory leaks
To:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce memory leaks in ref-filter.c.
We still have leaks, but at least not so much.

I use command valgrind --leak-check=full -v ./git for-each-ref to check results.

Before:
==24727== LEAK SUMMARY:
==24727==    definitely lost: 69,424 bytes in 724 blocks
==24727==    indirectly lost: 29,643 bytes in 723 blocks
==24727==      possibly lost: 120 bytes in 3 blocks
==24727==    still reachable: 16,535 bytes in 185 blocks
==24727==         suppressed: 0 bytes in 0 blocks
==24727== Reachable blocks (those to which a pointer was found) are not shown.
==24727== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==24727==
==24727== ERROR SUMMARY: 107 errors from 107 contexts (suppressed: 0 from 0)
==24727== ERROR SUMMARY: 107 errors from 107 contexts (suppressed: 0 from 0)

After:
==16419== LEAK SUMMARY:
==16419==    definitely lost: 17,144 bytes in 1,447 blocks
==16419==    indirectly lost: 0 bytes in 0 blocks
==16419==      possibly lost: 120 bytes in 3 blocks
==16419==    still reachable: 16,217 bytes in 181 blocks
==16419==         suppressed: 0 bytes in 0 blocks
==16419== Reachable blocks (those to which a pointer was found) are not shown.
==16419== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==16419==
==16419== ERROR SUMMARY: 82 errors from 82 contexts (suppressed: 0 from 0)
==16419== ERROR SUMMARY: 82 errors from 82 contexts (suppressed: 0 from 0)

Travis build failed, but it also failed in master, so I guess it's not my fault.
https://github.com/git/git/pull/538

Thank you!
Olga
