Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BFDC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 23:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbjDZXgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 19:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbjDZXex (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 19:34:53 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD352715
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 16:34:50 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f8d59a8a9so94603657b3.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 16:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682552089; x=1685144089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=chmR/Hy1ZEht2DUMbsV7v26d1RMoy8sv5/OnLJ4Qiow=;
        b=w4O4h/07em5vYh2BSU3DhyoerUPuZeWnDIxynCwguC4f9XF+YpBU/sRiaqe8QMpByE
         E5fvIWFl+PPr/Qm0t3TguvXB3hOiPzlKDefr6njNYaE/ekkqcz5IEwDBFUs1lb3m1w5h
         zTUAyEgCHC2xHcisi4A8v6LUjMTbSnHqgggHi1CwCvX9wf6f3Wn68S6Ld1OpPXVhrkwT
         9ymMxL15+dkqlWQFjjYfncwBAkwjNSXsqEsEB9yQ6k6tbxTO1Ot0WiyTo0jihAWGvOPT
         AckBxvwILpnr+a5Ovhxcr9y+abbUgdOLbd4Te83RtN0ALXU3ZsLW0RVCPjr8kYFuEXxa
         UqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682552089; x=1685144089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chmR/Hy1ZEht2DUMbsV7v26d1RMoy8sv5/OnLJ4Qiow=;
        b=GGUUccIER/CkL3w/vH+56ZZT0Lyr2DNYNxvyUnYnio10VVJ3pJb6+chW87sbtf/W3K
         MpKvlGcLA36Uh1/GhJxtZ32x9SZVLUHvvBflaPlTaOdOWG+FHu2YeXnpt1e8o402fjJA
         8PsupA30z3SLNJEe8bHKAxX084YHN8fpV3F7be495B5+6bPAnrGjTLqrfkY40fFSTknM
         mgi55Wdh4FSoDvAG9PIAAF87VNBxkQW4kJPTmVvFL02Fqxr9jtVhZTpDnaVgjZkStqjS
         Ghs3XNCy49CHbDAjOM2RH4BRmufaOYbir8u/Q5QdUNrSGMLMOdUQPPVzGRTc0tg4MjMb
         uCUQ==
X-Gm-Message-State: AAQBX9dXy5b1CLxAd1hpjI3/z2b4lirsgg7JiAEQRBLujXA1KpfTSI45
        mX3bIcUuVmtSFwZa3mUjJYyeJZR7y4BN2T8S2vzFqg==
X-Google-Smtp-Source: AKy350ZkBpnuJ81gWE0ufAE95+aJZgi9Mtm++W7xNA26wtRHbInG8sLOjf8owRnTMeWf74VHT7uT9g==
X-Received: by 2002:a81:4948:0:b0:54c:1d2e:f371 with SMTP id w69-20020a814948000000b0054c1d2ef371mr13903726ywa.27.1682552089157;
        Wed, 26 Apr 2023 16:34:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p203-20020a815bd4000000b00545a08184fdsm4415146ywb.141.2023.04.26.16.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 16:34:48 -0700 (PDT)
Date:   Wed, 26 Apr 2023 19:34:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: tb/ban-strtok (was: Re: What's cooking in git.git (Apr 2023, #07;
 Tue, 25))
Message-ID: <ZEm1F78kF7rMWyFb@nand.local>
References: <xmqq354nxzqr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq354nxzqr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 05:18:20PM -0700, Junio C Hamano wrote:
> * tb/ban-strtok (2023-04-24) 6 commits
>  - banned.h: mark `strtok()` and `strtok_r()` as banned
>  - t/helper/test-json-writer.c: avoid using `strtok()`
>  - t/helper/test-oidmap.c: avoid using `strtok()`
>  - t/helper/test-hashmap.c: avoid using `strtok()`
>  - string-list: introduce `string_list_setlen()`
>  - string-list: multi-delimiter `string_list_split_in_place()`
>
>  Mark strtok() and strtok_r() to be banned.
>  source: <cover.1682374789.git.me@ttaylorr.com>

This one is ready to go. Peff took a look[1] over the latest version and
I think we both agree it's in a good place.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20230425062708.GC4061254@coredump.intra.peff.net/
