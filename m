Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C508C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 12:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358496AbiBDMe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiBDMeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 07:34:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400AEC061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 04:34:25 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jx6so19196911ejb.0
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 04:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+tUQ598yfoPzK1/07Brn+IpFRJ8L8+/HiIQvtbm36fo=;
        b=aO61F0eCTfZeosVcHp+GMMIsZYDLJPqFdxMSZ6+/hSiDjztoM71IismY3VtUVO1uAs
         M9NZMnP6gWf+Ve1efFSps82FYvYe7sH0D2FD6H5GiK/p0SDY+rhqe0fDnTpvP0hvyayJ
         EogffK5/5wiQwlOK5/4o7S8Z3fUT7gKFAWzUzLQYIEetG8uQ3tRElPxAbjW6eujmavJH
         s1r9NcgNv3eG6UgeYCA+Qi1k+2FuEXkfPUAo0bNNMfOWCpMtBWffgtkGPeiQnKobgjhe
         xh1nZazbMPq2ULjzYZBFTrMedxnlGCFACgkzKmQQRcF9biFJuRb84u7ZSfpX0zXGJYke
         bOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+tUQ598yfoPzK1/07Brn+IpFRJ8L8+/HiIQvtbm36fo=;
        b=L8/aTvmU5EzA9nIRamkpBlxnpmVSCOEn1bkXY4cCP/m8OD9VS+6czluXNK1jhAQcie
         D6PsPVS/x5Bd97NdxyYTdyCQArUSsNl96FOhpVyD7mWV9fs2QsncA61NJcBaO0IuZejY
         DHCkXJWwBvGjj1cOfRjl2eGHU2/hszMiRBAzvjqD/+H5CiZTtzdQlC5uMZBEkELTiDmZ
         8b2sXTABKJXxl/iUn8LHnkYk84dqGDlDTb6cgZDGwXH8XTXrkp4DHx1hKEs+v0E0kVeq
         UKbPq5dAL+l9OADAiZGFnMBObrwzf78JELLqEw33QoOXuadoPiol0EbP4N3OLjF1B9hc
         jfHA==
X-Gm-Message-State: AOAM5321q5/EokxAx7xoFoBCEzAtkYZy43Z5RN05M+W55Z2MyUpNyL4C
        8cihi/2s+CKKioHdMACr758=
X-Google-Smtp-Source: ABdhPJxH5YjqWxcoU53fP+8lsYkLdmPXOj0V1Scq+PvAj9SjN3FvO+Q3lH4W+62xXYIcOktYudBaQA==
X-Received: by 2002:a17:906:6a05:: with SMTP id qw5mr2321260ejc.90.1643978063699;
        Fri, 04 Feb 2022 04:34:23 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h15sm625267ejg.144.2022.02.04.04.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 04:34:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFxnC-0064VN-IE;
        Fri, 04 Feb 2022 13:34:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: ps/avoid-unnecessary-hook-invocation-with-packed-refs (was: What's
 cooking in git.git (Feb 2022, #01; Thu, 3))
Date:   Fri, 04 Feb 2022 13:31:53 +0100
References: <xmqqr18jnr2t.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr18jnr2t.fsf@gitster.g>
Message-ID: <220204.86ee4i3j5d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Junio C Hamano wrote:

> * ps/avoid-unnecessary-hook-invocation-with-packed-refs (2022-01-17) 6 commits
>  - refs: skip hooks when deleting uncovered packed refs
>  - refs: do not execute reference-transaction hook on packing refs
>  - refs: demonstrate excessive execution of the reference-transaction hook
>  - refs: allow skipping the reference-transaction hook
>  - refs: allow passing flags when beginning transactions
>  - refs: extract packed_refs_delete_refs() to allow control of transaction
>
>  Because a deletion of ref would need to remove it from both the
>  loose ref store and the packed ref store, a delete-ref operation
>  that logically removes one ref may end up invoking ref-transaction
>  hook twice, which has been corrected.
>
>  Will merge to 'next'?
>  source: <cover.1642406989.git.ps@pks.im>

I think so, I didn't reply but I consider the feedback I had on it fully
addressed. In particular the "is this the right direction?" comment
replied to at https://lore.kernel.org/git/YeUhMPSlC%2FX6HRBF@ncase/

I'm not digging it up now, but I think Han-Wen correctly noted that we
have a "packed" backend for no particular good reason, and much of that
is die/stub functions, we should really just have a unified "the file
stuff" backend.

So from an API perspective messaging upwards about loose->packed or
whatever is as irrelevant as having a psql backend and messaging about
VACUUM, which is essentially paraphrasing what Patrick correctly points
out there.
