Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4A81F453
	for <e@80x24.org>; Thu, 27 Sep 2018 08:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeI0OiB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 10:38:01 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:45610 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeI0OiB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 10:38:01 -0400
Received: by mail-ot1-f53.google.com with SMTP id c13-v6so1694768otf.12
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=channable.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=NXrafdDOL2YxZ/GYizM6OFW2YqQdbk5LvgMtkThjPzA=;
        b=dBaS4wvbCFlXQCWbBBsZA+unGIfvemPLv2/GRSdwv5D4kOTVDyRlqRg+hwao93jJ5k
         NCOBoV53I9KkAp7Lv5AI4PQUjHYltFs9+t2Ky5S5VjIENbRbGnSpkqDtQIk1oli213Ij
         F8iDouG/rO8iUv764blKr+njIeHa6a2gPJHRTHFDkL/ddNmmRklBjIKsRkJqaiHVcWKi
         ynEDZvXdUHZv9qZ9i8F1Ss+ecUgOj6TqvWCULBbFPCjD7NGBvK5gSPuN+orfVVHgCKll
         uk+LUyIWYSfmZZWt02yowYsN5GF8Ev2x9mRZAmDP/h/KwD/iBNixJ5vtg/YUNKO9ln+U
         OfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NXrafdDOL2YxZ/GYizM6OFW2YqQdbk5LvgMtkThjPzA=;
        b=kmI2iu3CG/O8XRC0fNqun0qf/l1Tc25TVbhJqKAyfOkH/Xm29KcP9YN0DSVqNeJSs7
         n0huRUv26ltKxDjOx5tgFwgKm/swNMcbrCYmQZqDcuo4Kp4C6W931m40DMDqGpWb+3nE
         vix820WYxJBX8+UGQsz85xUg/f0KgYfRB1N/2FOM+VE49IJMOS86fSer+nHTjAYy+mId
         dIppBsIDH8tcpZosvhqdCOA0eX4yBqFcl4rQqk84WxSsxS0KZLbgVhDmVJTVIXea5KSc
         ew5V34RVmtRBMp1AhTP0oJqvq2OZc2mNydTHS24l2uO13GeZU6WM7rj/kGfFIKzRNI/N
         hD5Q==
X-Gm-Message-State: ABuFfohkLbwTpzLrn2RUIRPCmdlt+w+5gutMxjv6IGG4wbzSBEWgoxHH
        GZrZf4QnaDiCThseu3S6yKg1QeklTdxfmVN1F/k2lf/1HpA=
X-Google-Smtp-Source: ACcGV61nn7Hw1PgSWZiBCQVd9zt+3SMGYjmrIOcfXMEfH1BlDwUWPWpidXNnexgxNO/07V6PZpi+dhLfvX7QNXpdWXU=
X-Received: by 2002:a9d:fc1:: with SMTP id m1-v6mr6721935otd.276.1538036458439;
 Thu, 27 Sep 2018 01:20:58 -0700 (PDT)
MIME-Version: 1.0
From:   Ruud van Asseldonk <ruud@channable.com>
Date:   Thu, 27 Sep 2018 10:20:42 +0200
Message-ID: <CAAqqbi=5Dc2yisSG5r71NGvwS7bfQh_aRpxiTbtFm-XHDqjYUw@mail.gmail.com>
Subject: Null pointer dereference in rerere.c
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just ran into a segmentation fault during a rebase with rerere
enabled. Inspecting the core dump with gdb shows:

(gdb) bt
#0  0x000055d673375ce0 in do_rerere_one_path (update=0x7fff03c37f30,
rr_item=0x55d6746d0b30) at rerere.c:755
#1  do_plain_rerere (fd=3, rr=0x7fff03c37ef0) at rerere.c:853
#2  rerere (flags=flags@entry=0) at rerere.c:918
#3  0x000055d673246b01 in am_resolve (state=0x7fff03c38120) at builtin/am.c:1901
#4  cmd_am (argc=<optimised out>, argv=<optimised out>,
prefix=<optimised out>) at builtin/am.c:2394
#5  0x000055d67323f975 in run_builtin (argv=<optimised out>,
argc=<optimised out>, p=<optimised out>) at git.c:346
#6  handle_builtin (argc=<optimised out>, argv=<optimised out>) at git.c:554
#7  0x000055d6732405e5 in run_argv (argv=0x7fff03c394a0,
argcp=0x7fff03c394ac) at git.c:606
#8  cmd_main (argc=<optimised out>, argv=<optimised out>) at git.c:683
#9  0x000055d67323f64a in main (argc=4, argv=0x7fff03c396f8) at common-main.c:43
(gdb) info locals
path = 0x55d6746d08e0 "<file path redacted>"
id = 0x55d6746d01e0
rr_dir = 0x55d6746ccb80
variant = <optimised out>
path = <optimised out>
id = <optimised out>
rr_dir = <optimised out>
variant = <optimised out>
both = <optimised out>
vid = <optimised out>
path = <optimised out>
(gdb) print id
$1 = (struct rerere_id *) 0x55d6746d01e0
(gdb) print id->collection
$2 = (struct rerere_dir *) 0x55d6746ccb80
(gdb) print id->collection->status
$3 = (unsigned char *) 0x0

This is using Git 2.17.1 from the 1:2.17.1-1ubuntu0.1 Ubuntu package.
Looking at the diff between v2.17.1 and master for rerere.c it looks
like the part of the rerere.c where the null pointer dereference
happens has not been touched, so the issue might still be there.
Unfortunately I was unable to reproduce the bug; after removing
.git/MERGE_RR.lock and restarting the rebase, it completed fine.

Please let me know if there is anything I can do to help diagnose the
problem, or whether I should report the bug to Ubuntu instead.

Kind regards,

Ruud van Asseldonk
