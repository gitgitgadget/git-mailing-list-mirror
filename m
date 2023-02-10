Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDAAC636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 19:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjBJT3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 14:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjBJT3g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 14:29:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE7963109
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:29:35 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id nn4-20020a17090b38c400b00233a6f118d0so3923822pjb.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 11:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ik9tqsJI1ucKryRz2B9QD8fTeXD+yihLVf8ONhqf9LQ=;
        b=NKFyZC43atT8ujl8h+d878yea2yunjr/J40OOwfCi3SqUmXJMSHVHbs6K3FtrfjUO6
         UPL9nqxkZ5EQpMIelXDydXhuiizDDpVxSH8erMRSGXMh2G73igGgx1IMRZnGAygzNXDD
         0I4HyD0SCDhmKA3PrnoLsn55qDoGb+jZ7Po2SkGWo7Ot5jX0nMZ/BCvf6SpgXD31tw0V
         JrQ9AjrrgCHyXxEBjz6HIGM1ZJgqbKISYCt6BNt+ycCJutaXKN3ZT/yayxX2IXclVv+1
         X8Wda25n4ZTHOKTP4tNl8dJfYkrEaum5tKjRSk4VWZJ35XIjJ/2/dY0RdZZr5QokDi+H
         TybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ik9tqsJI1ucKryRz2B9QD8fTeXD+yihLVf8ONhqf9LQ=;
        b=jFFW2JzOvfSNAPkdkK16k5HRF4xNq1R9Xr8RLoEVzvwmn2YusCLlC/pAoh/6jr4Mk+
         kFSAFzZtiu8ycg7zBNaolC2OMWO5ME6KpfLywO7cTqIn29/9NvnOrRC7DNwkw2Zq6NXF
         tiRVJ69FBTOsQFL7ttdpvU9DcqGiGxmUsjdr3nlgVQNU2qr6lAZnlWCRp2E182o5VNfu
         ynI/uHgDRkdoIz1Az7y+3u7/DTj0sWZOLDRRrLokvsQ65izWRfmQHfLW1F3XlgoyDWNP
         /KF7Anpeb4ad4x5jGsSA+9UtkjAGdTG+7xgtdb4xQ8PHgxAl/+sNqYt4RX5Pj/IO0TGh
         6RFg==
X-Gm-Message-State: AO0yUKURpbOtfW4q76TKPcRSggaOttomxPkmx+hqH+Nk3TG39+lre9h+
        r406BfVSbaFX/gD0gJKK0bkbOVkkFNM=
X-Google-Smtp-Source: AK7set/Nxgz1J80A5bKDeoSJDPDN0uQ410OFU5wvhb1btHwyzI1rp+gMnt8N/ZowCCcv+dSktbWNLg==
X-Received: by 2002:a05:6a21:7890:b0:c2:4719:45c8 with SMTP id bf16-20020a056a21789000b000c2471945c8mr18813259pzc.27.1676057375077;
        Fri, 10 Feb 2023 11:29:35 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id g6-20020a63b146000000b0042988a04bfdsm3380566pgp.9.2023.02.10.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 11:29:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/6] builtin/rm.c: use narrower "USE_THE_INDEX_VARIABLE"
References: <cover-0.6-00000000000-20221215T095335Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230210T102114Z-avarab@gmail.com>
        <patch-v2-1.6-916761cb50f-20230210T102114Z-avarab@gmail.com>
Date:   Fri, 10 Feb 2023 11:29:34 -0800
In-Reply-To: <patch-v2-1.6-916761cb50f-20230210T102114Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Feb
 2023 11:28:34
        +0100")
Message-ID: <xmqqbkm1iajl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Replace the "USE_THE_INDEX_COMPATIBILITY_MACROS" define with the
> narrower "USE_THE_INDEX_VARIABLE". This could have been done in
> 07047d68294 (cocci: apply "pending" index-compatibility to some
> "builtin/*.c", 2022-11-19), but I missed it at the time.

It's a minor thing but can we stop saying "I did X" or "I didn't do
X".  It is not just your fault that this was missed.  Reviewers also
failed to spot it but we are not in the blame passing game.  "but it
was forgotten", "but it was missed", or "but nobody noticed it"
would suffice.

The patch is of course good.  For this kind of change, if it
compiles, it cannot be incorrect ;-)

Thanks.
