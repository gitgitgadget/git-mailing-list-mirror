Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120EC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 20:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiBPUaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:30:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiBPUae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 15:30:34 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273872A2286
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:30:21 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id fh9so4217171qvb.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 12:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=iI1aTvuzXJJ0gR5Z9/MkbaSibIh3zcdPqMYbheQ3pZk=;
        b=pDEhHl8ZjEj1Gpm6TZtYC/l3MefbKZsA8wyKsmFAmgrED053IsBuxSDypkjIbdO24+
         cy/6vco568U1hCq1O6JPgPcszFEsM14CjUIJvdk+JsPCnDQcrt0bB/BJ12+ozIArsS71
         xi2h5X1zF4gdyBtgINxklrSx42SFmGjkJjVpmpt53eLZrsCOXDnjmnX7A2Sse5oCFB+j
         UnHG+PntHN9lhgpz0lLnjOL4NJbqOLi2jgiYNGMNRarKYmG/Ishx5xi1xQ6SkJanEc/p
         KqYlE2M2+QaTBug34GDvTLzuFaWl4JO0Kv+T6WBeqB08Hlx337O7aDm3sRyuWIVGwGSf
         3cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=iI1aTvuzXJJ0gR5Z9/MkbaSibIh3zcdPqMYbheQ3pZk=;
        b=GMrDYLLVkToYUg+QPLFb8QQoGAYmbnLm2kUm9JTwXpaxlqNMxvlBawAhOsPFZYV2FH
         mFFXIBbPJTRHbyLkCArDkmgwDTOJPWZQ93v5uvGAaBD2se2AhVRZYPhM5ICVnekf+zCK
         afImjjmSNm+6OYWre08oxqmJc7EvPIdCmCa7UiJ90jnonZhmWIDYcUtH8U8yZje59svY
         4+DmsFB6rbI0xzzX8nprrM4wQp3UIyfEYdZ62BSU4I58x0u9TllC97giFD+c9IH2B1Ai
         2KXM50nY/+XBdS41lsRfi9hs2ATJtUZvCfsadUUdGoUK48Y5uLWhBpPqHavedQ4ZvmDJ
         oL7w==
X-Gm-Message-State: AOAM530X2Bq38FsuDOfsM/1teRa5Tp+So+1EUsAHI0e9ifgw/iiMvVZL
        MHvr39UT9DKwkm49F9eqv5Ou4eU1diI=
X-Google-Smtp-Source: ABdhPJzS9yvXfOELNwTgVUqwPGyJtPy9VOshqSPbxh9HVEe2fXnZr24x4DYTRPZItb3qTqFKkST6uw==
X-Received: by 2002:a05:622a:8:b0:2d7:ae4a:8434 with SMTP id x8-20020a05622a000800b002d7ae4a8434mr3379267qtw.212.1645043420199;
        Wed, 16 Feb 2022 12:30:20 -0800 (PST)
Received: from [10.37.129.2] ([2600:1001:b127:f167:4d17:c91e:4833:2ca5])
        by smtp.gmail.com with ESMTPSA id j15sm18091913qkp.88.2022.02.16.12.30.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Feb 2022 12:30:19 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v8 4/4] cat-file: add --batch-command mode
Date:   Wed, 16 Feb 2022 15:30:16 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <D2B37C47-677F-430A-9917-441D9FD647BC@gmail.com>
In-Reply-To: <CAPig+cQKRytC0xQBCMss0S6tAoVft8XhcPCws9x4PMx_STfcHA@mail.gmail.com>
References: <pull.1212.v7.git.git.1644972810.gitgitgadget@gmail.com>
 <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
 <8edf80574b8dd72ca8489df6e480cf6820b98070.1645023740.git.gitgitgadget@gmail.com>
 <xmqqwnhuu410.fsf@gitster.g>
 <CAPig+cQKRytC0xQBCMss0S6tAoVft8XhcPCws9x4PMx_STfcHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 16 Feb 2022, at 12:25, Eric Sunshine wrote:

> On Wed, Feb 16, 2022 at 12:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> As it seems that this code structure and division of responsibility
>> between the caller and the callee is confusing even to the author of
>> this code, it may make sense to make the caller responsible for
>> freeing.
>>
>> Then the caller becomes
>>
>>> +             if (!strcmp(cmd->name, "flush")) {
>>> +                     dispatch_calls(opt, output, data, queued_cmd, nr);
>>
>>                         for (i = 0; i < nr; i++)
>>                                 free(queued_cmd[i].line);
>>
>>> +                     nr = 0;
>>> +                     continue;
>>> +             }
>>
>> which is not too bad.  And then we'd free the array itself at the
>> end ...
>>
>>> ...
>>> +             call.line = xstrdup_or_null(p);
>>> +             queued_cmd[nr++] = call;
>>> +     }
>>> +
>>> +     if (opt->buffer_output &&
>>> +         nr &&
>>> +         !git_env_bool("GIT_TEST_CAT_FILE_NO_FLUSH_ON_EXIT", 0))
>>> +             dispatch_calls(opt, output, data, queued_cmd, nr);
>>> +
>>> +     free(queued_cmd);
>>
>> ... which may be easier to see what is going on.
>
> I agree that it is easier to see what is going on when the caller is
> responsible for freeing `line`. It _may_ make sense to factor out the
> free-line-loop to a separate function since the caller will have to do
> so after both calls to dispatch_calls(), not just the one inside the
> strbuf_getline() loop, but also the one after the loop. A separate
> function might be overkill for this two-line loop; on the other hand,
> it may clue in future readers that resource management needs to be
> taken into account.

Both of these suggestions sound good to me. Thanks for the help down to these details. These are
all valuable learning points!
