Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54DEC433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 01:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbiEaBbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 21:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbiEaBbn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 21:31:43 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39731E000
        for <git@vger.kernel.org>; Mon, 30 May 2022 18:31:39 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c12so1670086qvr.3
        for <git@vger.kernel.org>; Mon, 30 May 2022 18:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JoGdzf9zfPliJc4rfatg51x5jEzMiUcG9Ft9oHvLlDI=;
        b=l1gk1hbhYRWbEuYc/4CjGXgv5VncjvRTdzJ4UbT2iYd1kEhmm3uf19dtdfZbU/KCpt
         t+Vm59KT7sfda5KMFY3wiLrKFcPwg9qKun4pAQH6CVls+1F2FLcpKZXFotnFrJWBblS0
         Iyo9H58x7OCuZhzqRZ5Ph+TsK25fWxsnckEgDC05WQ45+2kaLyKopJdtMFjoaOgkiMdA
         F8RuBVW4hC9FhldhmWcshsavQL/KJS6Lq3zH/Z+xizhZekmEBaxZ4Ay9xUBQNkwmhLTN
         5d6DbKQD508gzbgkL6siZytPqF/xCPOuz1N5l8QJBjgYqRW7/O2r5v+0ngylolw49ptS
         56AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JoGdzf9zfPliJc4rfatg51x5jEzMiUcG9Ft9oHvLlDI=;
        b=YaIjV6Uipb+DOOan0RthvVUs4IhPT1wRoybtEQrHt+jgX4X71titQIhZt6yv49g9hO
         Yu0tuh0Z/WWpCFG7vbEf5xwlDhnV8uwVKvfW1VDs7gg6zvmEFcv8tpObE+Gld0J3HA2U
         O6Z8feSAzQsCiA5AbQPNisP/Qd7Xc7t4orDjnhzoazyrB8eR4GhPgCdjhskSG+88PwnO
         kmCAViqXsl9wYPNwGDWhRzrjIl77hMXmSr0TbxAfIZIXKC6bEfdjqKkSVk3qqt2HJ0vr
         BHi98UkCt551pDLMob9xvMBcMbbuIqfD3G+LnD+dbz5GrBlk+aGI6nnAsBIx3VMI+Fvj
         SNjA==
X-Gm-Message-State: AOAM530MgKUIHoA/TAtJ0wknJKmQsoZhqmXJ2vCNIUBCcXTcVuuVQLs0
        zqqW7+gMhZNRsq85CivcAsbUgreteN1KRA==
X-Google-Smtp-Source: ABdhPJz7cHvjby8VnTYIjKG36svp5+/+R9vVsqOeb+hnuQWRs80Cplu1Bj5L8TPFadvCCnnDTHlgSQ==
X-Received: by 2002:ad4:594b:0:b0:464:5ef1:43f8 with SMTP id eo11-20020ad4594b000000b004645ef143f8mr989537qvb.94.1653960698741;
        Mon, 30 May 2022 18:31:38 -0700 (PDT)
Received: from [10.37.129.2] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id g18-20020ac84812000000b002f93aeaf770sm7884496qtq.92.2022.05.30.18.31.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2022 18:31:37 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] hook: provide GIT_HOOK for all hooks
Date:   Mon, 30 May 2022 21:31:37 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <FB3E687E-C381-4C9E-A1B4-13CBE3A48B7A@gmail.com>
In-Reply-To: <xmqqr14dzi2o.fsf@gitster.g>
References: <pull.1271.git.git.1653684771998.gitgitgadget@gmail.com>
 <220528.86bkvh3b3q.gmgdl@evledraar.gmail.com> <xmqqr14dzi2o.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28 May 2022, at 13:24, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> But the commit message & documentation here really should be updated to
>> reflect that this is currently superfluous to inspecting argv in the
>> hook process, and that we're providing this anyway for XYZ reason.
>
> Or this probably is better added as part of the series that actually
> adds the mechanism to trigger hooks defined in the configuration
> file.

I don't mind including this as part of Ævar's config hook series. On the other
hand this patch could allow the config hooks series to be smaller and more
easily reviewed.

I'm okay either way--maybe Ævar can speak to what his preference is.

>
> Then "we do not need it now, but we will in the future because we
> will do XYZ" does not have to be said, which is a huge plus.
>
> Thanks.

thanks
John
