Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF3C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A546187D
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 15:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhJAPDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 11:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354741AbhJAPDP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 11:03:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5D9C061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 08:01:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ba1so35876245edb.4
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SuCdUZejew8EqjhYVsaSCj96PS7PiYVHDYcAIrE5NCI=;
        b=Isw95Iw+llGn/8zUIrvLpehbLbWhVs/av3aiq1UoRqD8siRYGegBZzTQTKQXZDKFs2
         QRpceSwGCQ7xWuppjyCbbEpIB8cvjFjBFq0z30Q04JxYjgPRyDy7cpTL3VeYp9XoF86c
         oZoQ1DWqi9K6cK5w/ZXKgHwuNKSl+Zmq1QHVzSRYhwtp5j1NxcGstS6P6Nda2CyloALL
         RNDZ3l8/tJSJQRVQxRm547W76NeNqQNPNvHrT8NL1ki6rf5f2tWd65cRgW+k+W6CzR2D
         +3OP7sb2Y6olSCP9WumJIv+Z+WGyqdT39BgtrKZc9wD4vuYIYCrLMStEwzJ+qR5o8ktS
         uQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SuCdUZejew8EqjhYVsaSCj96PS7PiYVHDYcAIrE5NCI=;
        b=ofRWTUJeWyp93uaKzhygVAbJx8KNxr/j/57CbgzWcwmpBZOpl5HUWO9n/Z+XN9P9Wn
         bkZuL2dy6tC+6M5PH6/a2Ndx1TPgtpequCnZW20kq5HXhTI9WbOrbAZFcpUbzCntwHXf
         TVHnxBDivyKMc8iJZFMoljmJVmVKhvSJjCnDG/x5YYI1EGkEJ4qPhId4l38otRmmgaca
         fWtulpoJfGFPUOAR8Gwacr55nlwpAzVBBIbxn+F4t0JineNcGIuFSVBoRRlcMHPVYoRG
         wIhGRZBYBQSQx1cnLBCVWDSBFGq1e8VL4+KvELn3BfFIzJYq01dRPZpgI8KMXHdtplfT
         YFsg==
X-Gm-Message-State: AOAM533evzsJkwcEWJhuafF8ucUkvlufJZClDvNqkp8KF0U7s2OJyrmL
        a4cvXaZ0SBj7f2+bY2C57j8=
X-Google-Smtp-Source: ABdhPJwmpy8vwp26Mw65nLl+omzEcyDJ21NoxI7i2P+Sxeg+QnjE3j49J6Lrt2vJSP/5hs7EnRzEsQ==
X-Received: by 2002:a05:6402:5250:: with SMTP id t16mr14687967edd.227.1633100482040;
        Fri, 01 Oct 2021 08:01:22 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b13sm4400338ede.97.2021.10.01.08.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 08:01:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: ab/refs-errno-cleanup
Date:   Fri, 01 Oct 2021 16:48:56 +0200
References: <xmqqh7e18soj.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqh7e18soj.fsf@gitster.g>
Message-ID: <87ee94rdq7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 30 2021, Junio C Hamano wrote:

> * ab/refs-errno-cleanup (2021-08-25) 4 commits
>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>  - branch tests: test for errno propagating on failing read
>  - refs: add failure_errno to refs_read_raw_ref() signature
>  (this branch uses ab/refs-files-cleanup and hn/refs-errno-cleanup.)
>
>  The "remainder" of hn/refs-errno-cleanup topic.
>
>  What's the status of this one?  Meh?

I'v got two topics that have been waiting on ab/refs-files-cleanup &
hn/refs-errno-cleanup graduating:

A. Post-ab/refs-files-cleanup: cleanup builtin/reflog.c for the state of
   the new API, I did a bare minimum of fixes there in
   ab/refs-files-cleanup, but the end-state doesn't make much sense if
   you aren't considering the history of now-gone OID locking "features".

B. Post-ab/refs-errno-cleanup: Reach the end-state of no refs.c APIs
   relying on, or pretending to rely on "errno" being returned
   upwards. This was previously submitted as[1], but the topic was since
   slimmed down into the current ab/refs-errno-cleanup.

The "B" needs this ab/refs-errno-cleanup. I think (and I think Han-Wen
would agree) that it leaves the refs API in a much better state for
reftable integration.

1. https://lore.kernel.org/git/cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com/
