Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC9AC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE58461176
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbhDMOXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhDMOXh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:23:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EEDC061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:23:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g5so19540930ejx.0
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yAvE6C1yegPmoQgHh1PeZdOVh6ax6rbO4lDplFAr+XQ=;
        b=K1v3XBq0Zaf/NatAP9E0k8T1xEaufVHqIQ/GN3xCcXkZ1pzjVBXZLKcQ37dwomJtW8
         C/bwYn/5GRpB8ipxQIZaQl7BBzGWHv77+/4r1iZy1DDgaqqQQq/6bTyV9yvFd4S7lVFk
         7scIzN1XnKjpGVEnm7hFT8uPYmGp0lEykvIKMI2WZjiAS1p1kyyc9YRKRcVgILplbA+1
         yR794UX6UIFE7YK4iAS60CwrxoCKQGUAYDCAY1YhzshYsyOK1DVC6R8Q6ICitVBaJeG2
         Rgd6ICmpljZe1Y+4zK++yPO3bhSB6yjakyGU3oRprFpzzFHo8VfQFertNrTzYk+1dIml
         OZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yAvE6C1yegPmoQgHh1PeZdOVh6ax6rbO4lDplFAr+XQ=;
        b=IqbWO8LhUU1Hqq8gtZH3VaUcB1b0NXYCTuRx+rFehS/9Gwtx6liba7L54U1xYsqnyJ
         qQTIknHMmva6hbklEYSFDqu6qC464U5YQ/2BrETAi0vCHy3+PtM/JcRHSGTu6AlRGa3T
         taznD3xmm8SZpQpSbzoc3NyPn3taujML7cmoo5EuTBQXl1mXRl9LK277o3gTkK/RgauC
         IyqgjMtAuO8TjBGKc33H3TI2Y5R9bEuSQJ8j95vrsJg67Tl77jjx3hAJq1INj0kl9gGT
         OqvK3nhXziS5sdGmvI4YVD5RBSDz0ft9Asj0sojrmvXeenNmLxc2F49uKgpZTiN46fvP
         rXAg==
X-Gm-Message-State: AOAM531X6DNxgy/q5xyyAhpwC4+IprhfwpahEsfn0kmx/77oiRFo1+i5
        rQ3DYWbQOIrKo/6wKTCpNBmiUW8jIG+Bmg==
X-Google-Smtp-Source: ABdhPJzAiynrfmw9xEMjGHxcSnmgVqgt+QYoZH+Rab8M3pnx5qgynnL5uXltMcWlFFogfmxXj3avhA==
X-Received: by 2002:a17:906:d154:: with SMTP id br20mr7451725ejb.28.1618323796211;
        Tue, 13 Apr 2021 07:23:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id k9sm9668704edv.69.2021.04.13.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:23:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff tests: remove redundant case statement
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
 <patch-1.2-35e77153831-20210413T122645Z-avarab@gmail.com>
 <CAHd-oW5nwzg4iiDheMPLe_M19SXO9hPhGeJK8dWfZ-yTKkPVmA@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAHd-oW5nwzg4iiDheMPLe_M19SXO9hPhGeJK8dWfZ-yTKkPVmA@mail.gmail.com>
Date:   Tue, 13 Apr 2021 16:23:15 +0200
Message-ID: <87im4q2rho.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 13 2021, Matheus Tavares Bernardino wrote:

> On Tue, Apr 13, 2021 at 9:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
>> index 6cca8b84a6b..67f6411aff9 100755
>> --- a/t/t4013-diff-various.sh
>> +++ b/t/t4013-diff-various.sh
>> @@ -220,13 +220,7 @@ do
>>                 then
>>                         process_diffs "$actual" >actual &&
>>                         process_diffs "$expect" >expect &&
>> -                       case $cmd in
>> -                       *format-patch* | *-stat*)
>> -                               test_cmp expect actual;;
>> -                       *)
>> -                               test_cmp expect actual;;
>> -                       esac &&
>> -                       rm -f "$actual" actual expect
>
> Was this line removed by accident? It doesn't seem related to the
> described change. Shouldn't this line be left after...
>
>> +                       test_cmp expect actual
>
> ...this one?

Yes, it should be in 2/2 where this gets turned into a
test_when_finished "rm [...]", sorry.
