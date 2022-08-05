Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69143C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 09:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiHEJC6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbiHEJCp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 05:02:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1821A05F
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 02:02:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gk3so3860665ejb.8
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=Kn0oUy/apl9IMjp6u7JosNqe4tHpzgq7P7cOroqfGWk=;
        b=ig47SaikGDkuY+wLsUuval/w4gc9htHSYZTZY9rrm6PkvAGPtJTRlpeP/9ppFSuoeR
         DFuthjZ1Z8nzyh1zIPgcQyyUmV0bUK0tzvtJJVAqurvHrCKS5yLwro089f2DAZBwacYs
         +kqHtkHBa7kjQuEueCyOWhRs1J0ustr/+2/DonxoAnGM259Gs04nqbzck9w57dFNP2nl
         Jz8Nh4NOeKEnzGYWJv94b2gb8/t4CYfkihil7xGEuMFhJEvQKnPP1UWR1USG6Q/3pOgK
         +ZH3ZaMkPTlqXd6HdrUvpCyg0wTGTLV1CkNhq1wYuOkBLkk/ASkeAzxHO8N5e2GWaeMN
         4ARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=Kn0oUy/apl9IMjp6u7JosNqe4tHpzgq7P7cOroqfGWk=;
        b=a0ARbFcIuXWcmSmUthpdYPVmJx6Ek/tUP9IiMHtMwrgUPFYKd9jPdN63K3higjJvhX
         hrkLkh29ocwar9BifcPxnmxnenKBs0cmHsa0BIJaJUaL2ZarxzPRJ8e7WTa6ywsCDTtB
         1K5jQsWODudE8mE02ge1UG1fT0VFiau7cdcoR5wLp5zh5WLgSV0t0HpfHy9HQAX8VvK5
         /BYKsA0ZAsqYZCPMIbyPBLSHAF7dyOtm0e2EKTCboyuQFC9vyZxrFcWGVHFzFfvTS3A+
         XPEDY80KNdLscLNGpyd2HE/dl/yDK+qd+SSEQ5ogpuVP3J2/gghzeMUDXLpt31nV2uUl
         R3WA==
X-Gm-Message-State: ACgBeo23GektsQCenOGK35HdNK3e8xt2sYCqqKhDFQmjm3ot3vqw6frf
        kuJlaXBYbVb3IaXgpQL1Imo=
X-Google-Smtp-Source: AA6agR6ge02r9k49uCycLFjjXCNJHhhAttXO7pGX/ULuzfCd8+LUKmknvP6tc2kfEOK/nGmN4qZRCA==
X-Received: by 2002:a17:907:75d6:b0:730:7000:6061 with SMTP id jl22-20020a17090775d600b0073070006061mr4642456ejc.234.1659690162110;
        Fri, 05 Aug 2022 02:02:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f17-20020a056402005100b0043ceb444515sm1766917edu.5.2022.08.05.02.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 02:02:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJtE8-000T2n-2N;
        Fri, 05 Aug 2022 11:02:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/6] log: refactor "rev.pending" code in cmd_show()
Date:   Fri, 05 Aug 2022 11:01:58 +0200
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
 <patch-v3-4.6-fd474666e7c-20220802T152925Z-avarab@gmail.com>
 <xmqqo7x19pif.fsf@gitster.g> <220804.865yj8e93t.gmgdl@evledraar.gmail.com>
 <xmqqy1w46luv.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqy1w46luv.fsf@gitster.g>
Message-ID: <220805.868ro3rrkf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> [...]
>> ... or in any case we'd want to re-rest that the compilers we
>> care about similarly optimize it.
>
> Perhaps.  Using struct assignment only when we feel an urge to use
> memcpy() in a new code (or in the postimage of a newly rewritten
> code), instead of doing a bulk update, would give us a chance to
> start small and vet the result with compilers of such a small scale
> rewrite carefully to build confidence, hopefully?

I think it would make sense to set out a baloon for it, but as some of
it (and I'll note this in a re-roll) involves some new C99 support I'd
prefer not to conflate that with this series.
