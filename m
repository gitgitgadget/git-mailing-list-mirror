Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61EDECAAA1
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 01:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIQBAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 21:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIQA76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 20:59:58 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560A82529C
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 17:59:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w28so9865016edi.7
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=bsA+zl9ybodnx3Ov6P21KIJR/S7/oqY3zaOV0RRcQgo=;
        b=WXkBBSt68VtqTEaDPNbp0tFGSOfq/pCcMBu5vSkhS7wX8F+SRpztWQhfLzXmjUWePD
         3nVydEBLjdRoJCdp0N+PZqV9WvddHZr/plpXkb5Es/elnwCX8pODIt/jgNgHg0Md0alK
         p2JC3dQFkqNFSZwGEMJ0RyhQolEDGBBP2Hjo8Dj0rRBQci9xOk0ngBapLkCZc9sd8cCl
         d+C+tMk9STCtUyMzpZKAeHpE2TvSlsWP9nSsVcotg9GDw44+QX+l9NFaBtkXoDUrNBkb
         AlhMN6G6xvaiSHqXPQJKlyxrbFcUKVlSFduFFd3UGS7jAYFEVxT6QczdiPjBYNheaScy
         IXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bsA+zl9ybodnx3Ov6P21KIJR/S7/oqY3zaOV0RRcQgo=;
        b=GcHofv+2T3ZLHMKn2s6FAXYnm0XDgekMYIm2NxZIbcXOoUK5otOPd3kIYpAAkMIkAr
         QFaM68U/AtHHEMUexmW6D2qUVQvKmSYMvSBTuaMdU3bvlwBjMkh0IvJAJ6BLBlqd/OfY
         zjdicANMbfIYAVBuTeC2bZMB/UZdKH3z6QTUSDEq6NfuD+BsgxSTLmV6NrEHhY51Cx2Q
         ZMkHCi6agADOysn279zqtLpjtjYu7BjfycXsyZWaJ2OTt+NjHwV1QxEMBFwRlqcr7h1U
         MD+9f05WKcuDv+jXN/pKhZy4UtP+cctqWn9gTzAv0Gh75SehKIvJBwLFxJ5PRaEYl2C7
         k4Qw==
X-Gm-Message-State: ACrzQf0Rl7eCViO90rxcU6jjpF/q7TzWIHSLltmrE7HFuHn7Ka2tlaWW
        FLRy+RE0d5vmLpCKwVfoGbqYecy4CiH7zEzNt8qNQrAw
X-Google-Smtp-Source: AMsMyM4Bn3+eguv0+wYbgYYAV+BnAqJiEDv/ssCbz+N7cy4dTef7PNgryCDpYwMtqKPK8pC1SBpc23uUyVN6vm3BecQ=
X-Received: by 2002:a05:6402:4011:b0:44e:b8b5:f52e with SMTP id
 d17-20020a056402401100b0044eb8b5f52emr5955952eda.352.1663376395758; Fri, 16
 Sep 2022 17:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de> <9baebb3d-8f2a-33eb-3f42-3e1755883d19@web.de>
In-Reply-To: <9baebb3d-8f2a-33eb-3f42-3e1755883d19@web.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 16 Sep 2022 17:59:44 -0700
Message-ID: <CAPx1GvcdQFBMyyD2gX7rYSJk58eEm5rREhoTz4XwVac-Y=nK1Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] revision: use strtol_i() for exclude_parent
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2022 at 7:51 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Avoid silent overflow of the int exclude_parent by using the appropriate
> function, strtol_i(), to parse its value.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>

Nice (albeit small) improvement regardless of anything else,

Chris
