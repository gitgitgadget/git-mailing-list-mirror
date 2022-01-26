Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A6FC2BA4C
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 10:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240351AbiAZKzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 05:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiAZKzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 05:55:42 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB46C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 02:55:42 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c10so70288208ybb.2
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 02:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+6FGWBTounpOysI71m1Z/op2tOKAzavknVfAgNZwN8=;
        b=g+gtNGiHhcGWTopaxI9SvK2WoWY6orqTI/9DxOwvH/LuB8MD9mHnYo/Xuaql3fLgpi
         NJ7qu4UDatgU9Uoss715LFxsrmPOIBICxyjdBFbAPlMCqV8O/SMPru/1+wz0WOAOdjc6
         2SSc2nXEMSvbTbjLaDMSO4K4BxmWTGjYnUUPnQrPsnBn0E0Y8fVqBvGPtCwB3WYKHYkJ
         UL9zGjQcvnfJJiB3OOldKbJnkYy5LDTeL2f0lo/0SalR1VZSw8hnGryeepgWslKMTjzG
         1Po1kimPxoID83HEWhNHsuSPzJNaV3/PkcPeRHc6UA0ucFBB9Eh881BFpqDNjubjvm2w
         1DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+6FGWBTounpOysI71m1Z/op2tOKAzavknVfAgNZwN8=;
        b=2jomgIkyiKh0/T3KNCgOpeZiJHqT3vhwRpkjqcgbpLOu75WHBoxpF5SRGrg3vjBsZL
         lgkMn9N5C0JjQCTb2WKAdr2XxLYNhWhn9woDPx8Z3tKCKhM39/bBIgeVnnXq+nMD66vX
         27uKd5AOVohCXAKq1UGslfqnC9K5QWMISumyVl11cZA5KMEDPKYNUsg2t2rph7nDwZz8
         qsP4yPXtdiWvTzNjdX9nhhSDrUUUB/GyWEaFJCA3TR7t0YMyEucq+Rh1QD5wr0Pg1XU3
         jMTNfeWsY8OxUPrKTlDx+/QZOU9C/z6QXlBUSZMXGqfEQb21J0MredAr3PIJbVmynUeD
         QDgA==
X-Gm-Message-State: AOAM531zQbXH/qBlKmkAi/PkBPR+GlvBlq8pJ7wtIx8rILHQDTQQv66t
        xanPCsXIFKq5EH+qDCCMDeZjCBTfcErUHsXqYmZkToTHvO4=
X-Google-Smtp-Source: ABdhPJyfo9S36oeXWTu34XKuDcznXIQ8lTeuzrEcaAJB9lv0/Ue7xkPZPNzAvh7fKyn3XCAn4+++Z25Z1/spe+wK1Hg=
X-Received: by 2002:a25:8883:: with SMTP id d3mr36847777ybl.404.1643194541335;
 Wed, 26 Jan 2022 02:55:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 26 Jan 2022 11:55:30 +0100
Message-ID: <CAP8UFD0+ui2uJtyNSQ3Cq4k+9SPpjT08=CBhMFNJ0ni2tLQQPw@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> After a merge, this function allows the user to extract the same
> information that would be printed by `ls-files -u` -- conflicted

This made me wonder if "-- conflicted" should be part of the `ls-files
-u` command. Maybe "by `ls-files -u`, which means" would make things a
bit clearer.

> files with their mode, oid, and stage.
