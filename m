Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4B61F463
	for <e@80x24.org>; Mon, 16 Sep 2019 04:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfIPE2u (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 00:28:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40232 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfIPE2u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 00:28:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id x5so9941343qtr.7
        for <git@vger.kernel.org>; Sun, 15 Sep 2019 21:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zGmtut5M7Scl6/NLXbaeTe6gAG2Uza+WwxBwTyKT6qs=;
        b=Etme2pdfZ/cY/Jnn04GVW4fZlLFRr7kLmgdsyRzkzcm/2+C2Q2HoZf5M0U2FfyEzbO
         OpgvG+gIPzVe15ZmHLSV9yVf4Os9knXPnUfBeIKHn6djaJUiNBiZZm6L/PMKpkVPMrCE
         pseJ9j/By6BDXxZhDNTb/WO4rcs6oGu9hm9Ra9n7qlk53cvCTSzJtFGoBm57kvl96yYn
         JC/xLG5FqK2xvOwPm5NA8IfFPuZ7s7L/ab04RYCw7Q2xN5N//DeyG0MR3bpzBD2ZGULA
         vbANgpd6oDxZbK4eq61szNPcwuJYV6bhvNagv4Fp9Z6EugAMQ5ZjhQoFvJqxgjeK8ZX2
         LzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zGmtut5M7Scl6/NLXbaeTe6gAG2Uza+WwxBwTyKT6qs=;
        b=RxI96jy1NEu/wO98MZ4GYhyuKm8xw7nhLRJIZNNXt5lQNKRCSi5o9TtR9e6VO1iZeh
         icgUGhr8OwIGgOI1qOx6LZmlmMqpldE8fHO2XRENehCD35pP0Vx6iSoOH3FJ0I8iWizq
         HK8LFXgLOJi3HVLiMSHP+P1nFdF2S52mDZo327ZIyICHnoSnwiMFEDYhanO4aGxdqfAn
         +/bXg8Ij/0K+1r7MqIvQR4hvITiqW27nTMrbGbTHG7f3HCIxnUbmFKakfh3q5XzGPRpF
         3CrMqd5h9BDyBJ6Q49dGPwD6BuWM0qmGfJRYOgSSgLSB/wDy1SzXQuvaqlHqyxoYfAh/
         77uA==
X-Gm-Message-State: APjAAAXNSxJ9MDncwB6iMzw2N12Lzf8QUvuIZQETAk/BUcFa93PDDqDz
        tY1xR4s3yvBk1ZHqqCny2wLIYoQ3iiCWnIFrI8w3dQ==
X-Google-Smtp-Source: APXvYqz0RTD4QuLr0iqSopN1YFvV3ZbjqPqjCaMYYZdlx4lXdSAPsey/+K7/UxTdK7NG+akdZ84Ce7s6ZpAXH5Jt8nw=
X-Received: by 2002:aed:3b62:: with SMTP id q31mr15876495qte.246.1568608129196;
 Sun, 15 Sep 2019 21:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190915211802.207715-1-masayasuzuki@google.com>
 <20190915211802.207715-2-masayasuzuki@google.com> <bbc3ef83-7ff9-deeb-2b7d-734112fc2418@gmail.com>
In-Reply-To: <bbc3ef83-7ff9-deeb-2b7d-734112fc2418@gmail.com>
From:   Masaya Suzuki <masayasuzuki@google.com>
Date:   Sun, 15 Sep 2019 21:28:37 -0700
Message-ID: <CAJB1erWRt-v5jVCkmSx-aE_BwijKZ5aUTkXajvtB4RK0y+6uRA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fetch: Cache the want OIDs for faster lookup
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 15, 2019 at 7:35 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 9/15/2019 5:18 PM, Masaya Suzuki wrote:
> > During git-fetch, the client checks if the advertised tags' OIDs are
> > already in the fetch request's want OID set. This check is done in a
> > linear scan. For a repository that has a lot of refs, repeating this
> > scan takes 15+ minutes. In order to speed this up, create a oid_set for
> > other refs' OIDs.
>
> Good catch! Quadratic performance is never good.
>
> The patch below looks like it works, but could you also share your
> performance timings for the 15+ minute case after your patch is
> applied?

With the following code change, I measured the time for
find_non_local_tags. It shows 215 msec with the example commands. (I
didn't measure entire fetch time as good portion of the time is spent
on the server side.)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 51a276dfaa..d3b06c733d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -25,6 +25,7 @@
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
 #include "branch.h"
+#include <time.h>

 #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)

@@ -322,8 +323,11 @@ static void find_non_local_tags(const struct ref *refs,
        const struct ref *ref;
        struct refname_hash_entry *item = NULL;

+       struct timespec start, end;
+
        refname_hash_init(&existing_refs);
        refname_hash_init(&remote_refs);
+       clock_gettime(CLOCK_MONOTONIC, &start);
        create_fetch_oidset(head, &fetch_oids);

        for_each_ref(add_one_refname, &existing_refs);
@@ -405,6 +409,12 @@ static void find_non_local_tags(const struct ref *refs,
        }
        hashmap_free(&remote_refs, 1);
        string_list_clear(&remote_refs_list, 0);
+       clock_gettime(CLOCK_MONOTONIC, &end);
+       {
+               uint64_t millisec = (end.tv_sec - start.tv_sec) * 1000
+ (end.tv_nsec - start.tv_nsec) / 1000000;
+               fprintf(stderr, "find_non_local_tags: %ld msec\n", millisec);
+       }
+
        oidset_clear(&fetch_oids);
 }
