Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E325C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 07:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbiDNHlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiDNHlT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 03:41:19 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957345640B
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:38:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d4so2608202iln.6
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fgLGXXHWqxiqQ3mSRyIgY0aOYpLzkpdyRqSwfgqiTdk=;
        b=nwklqx1HXD8UnPkLIVLBMaSR1AKmc8HFwu8hFl4I68+csjkFDsN3TNTfHf9iXU+kAt
         K+Wlh8IwabViKcuQqW3X1aKHp7fNpEBWuf7ijjiYQKKK8njZpqH6lUhDmWjgYKHk10Jn
         q2+PPkHzzM346eeKtNmwQk1CLHx12FHXEK4GoHZwkR2I8Ql8BQ60JqlW2vAN2Y3Xi3tj
         QI8UkyT3FVoyCnOdseOF99G4Pw781LXTPWIM1r9eNlcvD7SH3GxHTm/943Ueuy1cC1sN
         gGK39szA4aac0uUL/kOGbTKPCgtOvF7sWtsdeGoqbHhY5MB++BUH6YBnSTojaK4yny75
         K4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fgLGXXHWqxiqQ3mSRyIgY0aOYpLzkpdyRqSwfgqiTdk=;
        b=EIO7YOJ3Gzev2gwXhKElPl/zpb96z4S6xCKPdOMXqjaeCKTgEMzzSuIUwmRV2/uzNK
         A0lF7ywAvSV1tTOC8YcLsMFL1ISbkdTiOwIsVPThXVHEuVgOO2aiJe/GfelLgx5Q0Cvw
         w0o5vMQFY579FxlSefhBN4ovyMFDo9Ini/Aj7jEsmtTn1q+J6SNHDnmNJ/b2L52O6Bmm
         DgW7YE6S4eHExSVYESNdRzmvcvzqMBV8TKF3TQXqjk70rxt+sHlbv1atejAKTnNu+tRZ
         JzPnZxjI9j9Fxux6337zxCSbN9LGdWY2Tfqz7hxI9vBd88/jY2vF1w4jxiI/juUOLCKW
         JxSA==
X-Gm-Message-State: AOAM532zismrpznjPpZ9aKFpdHz1MmaB59F6bYYzIBCJg29VrODi0B+/
        jvm+i0NnwkkiYt0QfGp790A=
X-Google-Smtp-Source: ABdhPJyNtXdwYGwSOQJbP0BUkfm29tipFMxbGTNkG25DH5tGqXkCvvxV0vXrCG2KNgl0TLXwSgNxAg==
X-Received: by 2002:a05:6e02:12b4:b0:2ca:e755:ee4a with SMTP id f20-20020a056e0212b400b002cae755ee4amr586510ilr.65.1649921932878;
        Thu, 14 Apr 2022 00:38:52 -0700 (PDT)
Received: from [10.11.12.100] (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id a3-20020a5ec303000000b006496b4dd21csm763517iok.5.2022.04.14.00.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:38:52 -0700 (PDT)
Sender: Eric Sunshine <ericsunshine@gmail.com>
Message-ID: <5e828906-964f-c328-6142-2fa05eaf596a@sunshineco.com>
Date:   Thu, 14 Apr 2022 03:38:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v3 25/29] CI: set CC in MAKEFLAGS directly, don't add it
 to the environment
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com>
 <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
 <patch-v3-25.29-1268792233f-20220413T194847Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
In-Reply-To: <patch-v3-25.29-1268792233f-20220413T194847Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/22 3:51 PM, Ævar Arnfjörð Bjarmason wrote:
> Rather than pass a "$CC" and "$CC_PACKAGE" in the environment to be
> picked up in ci/lib.sh let's instead have ci/lib.sh itself add it
> directly to MAKEFLAGS.
> 
> Setting CC=gcc by default made for confusing trace output, and since a
> preceding change to carry it and others over across "steps" in the
> GitHub CI it's been even more misleading.  E.g. the "win+VS build" job
> confusingly has CC=gcc set, even though it builds with MSVC.
> 
> Let's instead reply on the Makefile default of CC=cc, and only
> override it for those jobs where it's needed. This does mean that
> we'll need to set it for the "pedantic" job, which previously relied
> on the default CC=gcc in case "clang" become the default on that
> platform.

s/reply/rely/

> This partially reverts my 707d2f2fe86 (CI: use "$runs_on_pool", not
> "$jobname" to select packages & config, 2021-11-23), i.e. we're now
> aiming to only set those variables specific jobs need.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
