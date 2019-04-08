Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3F020248
	for <e@80x24.org>; Mon,  8 Apr 2019 06:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDHGDH (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 02:03:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53387 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHGDH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 02:03:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so12797356wmj.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 23:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=srnffmyiFaDxGTnyQtiPFWDlOh5rF8f0eWb7Rrpjw6g=;
        b=IjbANN/r/6+CfOxrZVA3UPBQBpkdFbeQb6NLpTjGBf7NnrbPzfPxoqFPr134D1GIKP
         V9oYEBXxLf4v/YMNTgmpXt2agTnH9tDdoBDJ+aPGAyrzgSnGCZstZirHPLWFLKZabNEX
         MtlzpHSCFi52DpbGyiN980Avdi67ZCo5FUwPH623t2qm+AXX9PENgRDaL5pvCseEv/aD
         KcJm+jMos6aYIu12Ww3klAGk3NOcKCS0mzQXFztuPtSvdx8kCS5vDYe0oOHiixj9xIpn
         nnlZKrG39bWhXVUwrelXsEgKHZKu7gJBEIQfr12Qe/c8JUMITG3H/E4L/s9pXThoBmp4
         GSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=srnffmyiFaDxGTnyQtiPFWDlOh5rF8f0eWb7Rrpjw6g=;
        b=KCmDa7Bm9M+mH7Oa9bE2ugA5O4hpNp/VOGTJ5pRui3fbI36KmR3Rx9v5BhX/ZlBE6T
         VaikwBKcGbzo+GYtYzx7kRg22swI+X6cCzoNKEz4dwvzRZL0mRfzLPr6dWGjsdDn8gdj
         mWatqH7iy1+86YfOTd0SGaCSoqXjU9MXJyWjHMIu5nVKQR6VqnLKgJ6wsflQAJW7OHBA
         RrY9jd6ABovCfuLo2aempi52vkeUrrRzGPtDFUruTnGPH5SeZylMBo3FAj0lIxa1gDpi
         uWmlp39ASh6fgyjP+T3e2Pxh5NRNpCako18Ayx5ewWWinWCfChxJxCeFuausBr5xy6/Y
         xBrQ==
X-Gm-Message-State: APjAAAUziEwYa8m9Uw25/pRJ0I5K5Hx22UXADQeOKeJtjdvi4gI1xUGa
        QFdr+nsjhEwsDgq1g+QBcIQ=
X-Google-Smtp-Source: APXvYqwd0RYBp/dyk/7qBux7tDCaYl5KeClB+LJywZSyy1pJqP2if5PLC+7qKdyQuH+QXeiRLPCD5g==
X-Received: by 2002:a1c:9991:: with SMTP id b139mr15342278wme.53.1554703385150;
        Sun, 07 Apr 2019 23:03:05 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v16sm53190261wro.48.2019.04.07.23.03.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 23:03:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] diff: batch fetching of missing blobs
References: <20190326220906.111879-1-jonathantanmy@google.com>
        <cover.1553895166.git.jonathantanmy@google.com>
        <44de02e584f449481e6fb00cf35d74adf0192e9d.1553895166.git.jonathantanmy@google.com>
        <20190404024710.GO32732@szeder.dev>
        <nycvar.QRO.7.76.6.1904051528130.41@tvgsbejvaqbjf.bet>
        <CAP8UFD1qK61MtJ-XeMuwY4W2V0CdHeZQC9rQap1M+nEeaLmBJQ@mail.gmail.com>
        <xmqqy34lb4vb.fsf@gitster-ct.c.googlers.com>
        <xmqqmul19h9j.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 08 Apr 2019 15:03:04 +0900
In-Reply-To: <xmqqmul19h9j.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 08 Apr 2019 14:51:20 +0900")
Message-ID: <xmqqftqt9gpz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>>  #include "fetch-object.h"
>>> +#include "promisor-remote.h"
>>
>> Thanks.
>
> Together with "if we are forbidding the direct access to the
> repository_format_partial_clone variable and the fetch_objects()
> funciton, make it clear that is what is being done in the
> multi-promisor topic", I think a patch that adds this header should
> also remove inclusion of "fetch-object.h".

In fact, your topic itself has the same issue.  I'll queue the
following at the tip of the topic tentatively before merging it to
'pu' with the fix we have been discussing around this thread.

Thanks.

-- >8 --
In multi-promisor world, fetch_objects() should not be used
directly; promisor_remote_get_direct() call replaces the helper.

 sha1-file.c    | 1 -
 unpack-trees.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 715a2b882a..87ea8606f4 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -30,7 +30,6 @@
 #include "mergesort.h"
 #include "quote.h"
 #include "packfile.h"
-#include "fetch-object.h"
 #include "object-store.h"
 #include "promisor-remote.h"
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 47353d85c3..ca0ab68c32 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -16,7 +16,6 @@
 #include "submodule-config.h"
 #include "fsmonitor.h"
 #include "object-store.h"
-#include "fetch-object.h"
 #include "promisor-remote.h"
 
 /*
-- 
2.21.0-196-g041f5ea1cf

