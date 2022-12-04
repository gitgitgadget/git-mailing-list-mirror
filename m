Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF69C4332F
	for <git@archiver.kernel.org>; Sun,  4 Dec 2022 00:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiLDAp1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 3 Dec 2022 19:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLDApZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 19:45:25 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777D41A3A1
        for <git@vger.kernel.org>; Sat,  3 Dec 2022 16:45:25 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id jl24so7820914plb.8
        for <git@vger.kernel.org>; Sat, 03 Dec 2022 16:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/S6oCbWFp3tp+QYYlhXTz95o6rQUh74GfrG+u0Ead9U=;
        b=ous4sdLpV80bT6EwkL/RZEwC6nqJ6Cm/VjH31ZnplPzs2lcoC1yxmUG6qctYxl8M2Q
         Nq7TUHxkcy/hqgMAuuznFcJHWDDW++BXu/2CcgWR2/RYiZJrl4+xxKB6+EC3SoNoarGt
         c2iZDHoAYjc6VoZjBJjBZ8OBSyS+6V+2yP0WZ9apD3ykOFWOYv10DVaZxEWO/CT0YbWF
         /w9PrvyfYNyttWV81mz5WS9C6UE0bg3ylANxjwM6b4CffwBoHKs9HcavwL98dTohcoxA
         jiYNNMRVObRmRRyUhj0kjaWI3tTS2pbpn+2ZZhdBc9Gb6OSWMKWtd6J+dAYrxjwugI9S
         xwZg==
X-Gm-Message-State: ANoB5pniq+YX1hC8yDtJcvSgiR7NdOafznBzRQaE7QSCsrBZKNNYJPbG
        DFo2LYAdGqZk2eBrr8uW/IhR7cxoGfRuZ9w5Tdc=
X-Google-Smtp-Source: AA0mqf5a/prxoUQo0RryeUC+96ymGZLng2kniT7yJOVOPipzRece8qF471cIWVscHZ0XGM5CeP3OBnYixj/VmB09hmk=
X-Received: by 2002:a17:90a:9f46:b0:219:b1db:f7e3 with SMTP id
 q6-20020a17090a9f4600b00219b1dbf7e3mr3538821pjv.64.1670114724941; Sat, 03 Dec
 2022 16:45:24 -0800 (PST)
MIME-Version: 1.0
References: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com> <patch-v3-4.8-c080899dd5f-20221202T114733Z-avarab@gmail.com>
In-Reply-To: <patch-v3-4.8-c080899dd5f-20221202T114733Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Dec 2022 19:45:14 -0500
Message-ID: <CAPig+cTm5GbpbeSRajEe+uP4MwbAwACL2Q19o1RSLgHQ+eeKKg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] t/lib-patch-mode.sh: fix ignored exit codes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 6:53 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Fix code added in b319ef70a94 (Add a small patch-mode testing library,
> 2009-08-13) to use &&-chaining and the newly added "test_cmp_cmd".
> This avoids losing both the exit code of a "git" and the "cat"
> processes.

This still talks about test_cmp_cmd() which is no longer present in v3.

> This fixes cases where we'd have e.g. missed memory leaks under
> SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
> discovered it while looking at leaks in related code.
>
> The "cat _head >expect" here is redundant, we could simply give
> "_head" to "test_cmp", but let's be consistent in using the "expect"
> and "actual" names for clarity.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
