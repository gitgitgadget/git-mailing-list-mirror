Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36ACC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 05:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C742B6128B
	for <git@archiver.kernel.org>; Fri, 28 May 2021 05:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhE1FnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 01:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhE1FnY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 01:43:24 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A25C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 22:41:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i14-20020a9d624e0000b029033683c71999so2480422otk.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 22:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HHCn+BWV1ldwrBGRdDawRflDqRxdGRn3L2Zl4dCW8r8=;
        b=tK9cIQCD8NleZZwIJzeKqmZjdzAaTTPDl7FALDcjHoVj82q1jFz3IM7r2tfaNIxJHn
         xa+nPR7zq/YvRcSEwHmeryKdkQJBpggrZJQ86xDoNMhuTPm7mB+QudyswtXm8d1SjPJv
         bjXOggiHgLD8tWWrLZjFzPLyneOwv50MtkYm+pPj0GdEGWkZZukHKpID7pDdqF1fj11L
         yajkNLrnAQjJq5JoGuTdrF9NL2VM5YG01czvYdvUn+PBpBcG2E3KK3sQk8E5zZIIj2zj
         BT3d/D/P9PX4jGxt8dfoNIDjQore5zzm2PKgjck68M/h0GpepMCZbz79bYeW1c2xis5U
         2d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HHCn+BWV1ldwrBGRdDawRflDqRxdGRn3L2Zl4dCW8r8=;
        b=uMPjNr9+q767LYxMyunxB6ehSF0u9NLGmm+D0WmE/uoh5EilAaBy5bd1BX4GUAAnya
         9P5KWuUOKqlcpsLjdJ2EP8NVro+6W8+alROycDS3ZJ4MrCPcZ/iKeRKTEj4E3L278nfr
         xRNRjJGQImBnFwflddEfgEStMEybhajLtgrEJGuxXQ0gWyWwd39j9ewZkfw0lzdKgAqd
         cBDdL4LRGyUTBxnivAOi5jKkpV6hQTJoWRRjV1HdzRH+Pn7knqb0OuCCWNXZ8Hq9kWkn
         TEH/TKhX9sd5KCAHpyzEM98+XH1jnEvJRFX9KfISjBu/7+/AHNc2FBuVVl7BGHF+WHor
         MNog==
X-Gm-Message-State: AOAM5315+Z3v6mh7IHjO0EoAw07/IUPTdIdq65b0kznoCPS/vR/Pow82
        kuPPn0zw40C+zTI7yCIVxK0=
X-Google-Smtp-Source: ABdhPJx6TXg6EvulmCEOAXHaZBqXE23y1bWE6SVnxOQ6rxVNLHd0I6dyFTr7qbMU5tvi5WC2JLRwXg==
X-Received: by 2002:a05:6830:1bd4:: with SMTP id v20mr5875207ota.101.1622180509302;
        Thu, 27 May 2021 22:41:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id s187sm977748oig.6.2021.05.27.22.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 22:41:48 -0700 (PDT)
Date:   Fri, 28 May 2021 00:41:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net, j6t@kdbg.org
Message-ID: <60b0829b6eed1_4a64b2084c@natae.notmuch>
In-Reply-To: <xmqqim3390d9.fsf@gitster.g>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
 <20210527170832.2669483-1-jonathantanmy@google.com>
 <xmqqim3390d9.fsf@gitster.g>
Subject: Re: [PATCH v3 00/17] fsck: better "invalid object" error reporting
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > My main comment as a reviewer is I think that there are a lot of
> > unrelated changes in this patch set ...
> 
> Thanks for reviewing.  I share the same feeling, not specifically
> about this series, but I find that "doing too many while-at-it
> changes" is shared among the topics by the same author, and I often
> wish each topic were more focused.

The author has a name.

I understand why as a reviewer you want a small patch series, but as a
patch-writer you want your code to land on master.

Perhaps if there was an actual incentive to split a patch series more
people would do so, but in my personal experience that has not been the
case.

If I had to name the reason why some of my patches have landed on master I
would say it's *arbitrary*. Maybe you catch reviewers on a good mood, or
the maintainer in-between release candidates. But regardless of the
actual reason, patch-series' size doesn't seem to be a huge factor.

As exhibit I can five two patch-series of mine:

  1. https://lore.kernel.org/git/20201223144845.143039-1-felipe.contreras@gmail.com/
  2. https://lore.kernel.org/git/20210426161458.49860-1-felipe.contreras@gmail.com/

The first one is 4 patches. The second one is 43.

The second one receved feedback from the maintainer. The first one was
complerely ignored. Neither were acceped.

This is not intended to point fingers at anyone, merely to state the
a mathematical fact.


Splitting a patch series is usually more work. If there's no real
incentive for a submitter to do so, why would she/he?

Cheers.

-- 
Felipe Contreras
