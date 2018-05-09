Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D041F424
	for <e@80x24.org>; Wed,  9 May 2018 14:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935044AbeEIOdT (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 10:33:19 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:44387 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934331AbeEIOdT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 10:33:19 -0400
Received: by mail-io0-f172.google.com with SMTP id d11-v6so42888966iof.11
        for <git@vger.kernel.org>; Wed, 09 May 2018 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=isH7Vk7qHdwpQC5dDfQilLDuJudbiNeerozGYXX9eeE=;
        b=U8Kq1jXbQunt4vBsFrCtAcV/YTh7hXpx+pMdMnuvBid9D3f5mqjtgYVfz4xtyN7kgz
         m7xTVd+A+dXMkOdC5MVokACkTvGfoYnsfpsuEyzXaWNkyVDwfsqKe4za7shhjCdFwLLy
         7wPlVKaN0WBezGnrSEk6WzdwXasS4weENeWFzIfS+83FBKmu33sF9zV49CFkU+nebt9y
         lRoQ9xFG0xqtq0iFfDkgjZHGMvkX/jrNgl8IVtC977zkpYN0Q3tVb4IYB8AlWcFWTcRV
         rf7jMPILD3UTWNXqDOtYubpAkUwl2ZS684kTA0n25r8ZcpKH8HNkGkQE7MT4k2WNcKQl
         fQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=isH7Vk7qHdwpQC5dDfQilLDuJudbiNeerozGYXX9eeE=;
        b=H0XKx+IXAbvNNKvturPe7KHqTLddUW7Ljzsyy46OMdKmD2p1P1K3jrfqbgdXRABpVa
         txCerZ7aqgUUAn2SsA5xQK32IqC0dvasqh3lmpCbicwAL+AUJjGtuwOND5sLu+HbalXy
         1GfzfmJTnfwzG4hqi3elgZmRWGbwOSZXHHwlX9jmXT5KM7znhCoPOy7OaWwpg2QYblQT
         BrNSMzk+7CYpnuBeftr0lB75RP3xnlElhOVymV3joasZGq2IWeFjFlGm+sTOmiV7cp+C
         eChgco58BTSD1tyu2NKTuwyvT4Z5xZiJ4ClvJZA/w4FjBL6xTQFzFj5A/flCZMfDhIFI
         +13Q==
X-Gm-Message-State: ALKqPwfeD23fVgoVLg9o9orwfzbZEyIkRfK1fqX87UIk7oHuZVvVGUp1
        MXi8pNGuRCBy//6e/o9juQ6X59lzCejxl0hmkYB1w6af
X-Google-Smtp-Source: AB8JxZpRNWDhU6g+N1++a6Fg/3OwMMi17s5qb32/vuPagnZOLdLThMguKqPhXhsmTX7wlXgTg9IW41uHLitvI5sR0bQ=
X-Received: by 2002:a6b:ca46:: with SMTP id a67-v6mr16929180iog.53.1525876397913;
 Wed, 09 May 2018 07:33:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Wed, 9 May 2018 07:33:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 9 May 2018 16:33:17 +0200
Message-ID: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
Subject: Implementing reftable in Git
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I might start working on implementing reftable in Git soon.

During the last Git Merge conference last March Stefan talked about
reftable. In Alex Vandiver's notes [1] it is asked that people
announce it on the list when they start working on it, and it appears
that there is a reference implementation in JGit.

Looking it up, there is indeed some documentation [2], code [3], tests
[4] and other related stuff [5] in the JGit repo. It looks like the
JGit repo and the reftable code there are licensed under the Eclipse
Distribution License - v 1.0 [7] which is very similar to the 3-Clause
BSD License also called Modified BSD License which is GPL compatible
according to gnu.org [9]. So from a quick look it appears that I
should be able to port the JGit to Git if I just keep the copyright
and license header comments in all the related files.

So I think the most straightforward and compatible way to do it would
be to port the JGit implementation.

Thanks in advance for any suggestion or comment about this.

Reftable was first described by Shawn and then discussed last July on
the list [6].

My work on this would be sponsored by Booking.com.

Thanks,
Christian.

[1] https://public-inbox.org/git/alpine.DEB.2.20.1803091557510.23109@alexmv-linux/

[2] https://github.com/eclipse/jgit/blob/master/Documentation/technical/reftable.md

[3] https://github.com/eclipse/jgit/tree/master/org.eclipse.jgit/src/org/eclipse/jgit/internal/storage/reftable

[4] https://github.com/eclipse/jgit/tree/master/org.eclipse.jgit.test/tst/org/eclipse/jgit/internal/storage/reftable

[5] https://github.com/eclipse/jgit/tree/master/org.eclipse.jgit.pgm/src/org/eclipse/jgit/pgm/debug

[6] https://public-inbox.org/git/CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com/

[7] http://www.eclipse.org/org/documents/edl-v10.php

[8] https://opensource.org/licenses/BSD-3-Clause

[9] https://www.gnu.org/licenses/license-list.en.html#ModifiedBSD
