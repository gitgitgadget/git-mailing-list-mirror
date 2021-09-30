Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BB5C433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 09:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D45361528
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 09:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349471AbhI3JjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 05:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349453AbhI3JjS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 05:39:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD82C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 02:37:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so542057pjb.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=f8DBinmSthQL+z3H3wBzGzSYGcbDtwwOen+HTxq9Ql8=;
        b=DBkVdgmuNwOCnuRYeQG65sYiB21XTN+2RN8V5uCWxparzr5VAf3KkcAX+tNHPVcpbO
         mM6lQoA0iwiCZaDbqbIATvO/ClMdzm1WJukFfVromWxL9eZfAn3E/su3aGPRh6BgLRDT
         weGC8gkTuymHk0MtZhP2XvtotiLnwc5vbm88iQNr4BVOTcDZt0nQCOtvx43jwq+g5GxZ
         bieLtsuUdIC68ssKp8onOI4SLu/PEH5uic9lidAQ2CL7KRHaPHgGecym1usx4CeouMcq
         DdBPYjeC0WNfHFSr4uUW5oNNcx/n/h+04b2HxCCsHEQtIxGFq1q1w0PheM65PO7qS5uc
         CNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=f8DBinmSthQL+z3H3wBzGzSYGcbDtwwOen+HTxq9Ql8=;
        b=MDJhWefRRoG124dwr+ZM03xEgjz2xUtgweR/z1NINVLm34QvsTeY1lbI8z9wtINuL8
         HWV5oZIIgbwMvPbrTgqHTUiO2GDw6oKpqtVY59HHiPUUwyP3XzKujPrQldJYe7IgMvFF
         LESbmci9Ud5rvECeg31yEwZG8wEGij+/64VnrfnYb29kXRQ794QvrudUQz4GgqHw8zx/
         fofUbKUZ2FJ5ACShtUgBZy5xnw4JvyOeS4XirLCVN1TfAbkOTGRPEtj3AchpiEWEk/if
         0mrS+8vorWguZZehR3P/V/a1DmeCNpBPEHxAHL1XWb7zZ16x5ZveUiOYRjOeZ2Y5LmXq
         unxg==
X-Gm-Message-State: AOAM533OkP9Esn7KLUhm/P915RlcYMTaGtdVCLw8RaxlQorf/aguppLM
        PCaPtTjN62Y5zZ9FnJzZg7weA1Etgdca40iU
X-Google-Smtp-Source: ABdhPJxpD5VjJOWqaUVTyn6PbWOeQdWx2NNaTMpAtSygdRIntwKYkO2wMhmIdNv/4KreeSuvyOT7Zw==
X-Received: by 2002:a17:902:8543:b029:12d:461f:a6a8 with SMTP id d3-20020a1709028543b029012d461fa6a8mr3190067plo.1.1632994655842;
        Thu, 30 Sep 2021 02:37:35 -0700 (PDT)
Received: from [127.0.0.1] ([223.181.213.116])
        by smtp.gmail.com with ESMTPSA id u12sm4292906pjr.2.2021.09.30.02.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 02:37:35 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:07:33 +0530
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
CC:     Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Draft of Git Rev News edition 79
User-Agent: K-9 Mail for Android
In-Reply-To: <5973e00d-251f-101a-b3c6-34bc29e015e8@iee.email>
References: <CAP8UFD1necFT_wSzuu3Ua+d7zxeBuurys=ubp0ocbNR+4H0Q6w@mail.gmail.com> <5973e00d-251f-101a-b3c6-34bc29e015e8@iee.email>
Message-ID: <2882D89C-7CFF-4CCC-800A-B9A3E7533496@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,


On 29 September 2021 6:01:12 pm IST, Philip Oakley <philipoakley@iee=2Eema=
il> wrote:
>Added a couple of video links to the light reading=2E PR sent=2E
>

I'm trying to locate your PR at the following link but couldn't find it=2E=
 Anything I missed?=20
 https://github=2Ecom/git/git=2Egithub=2Eio/pulls?q=3Dis%3Apr

--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
--=20
Sivaraam

Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
