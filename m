Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8776AC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660B460C3E
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 20:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhHNUD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 16:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNUD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 16:03:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7DC061764
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 13:02:57 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v4so10821679wro.12
        for <git@vger.kernel.org>; Sat, 14 Aug 2021 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vm+AqaEOmH2vynBX1YlN9O9ey6K6uZgO3zGu6bKXXgA=;
        b=EnBjpqJ9vi/XkE3fHoCjucfHlTAwdA+RV+f7B2xYfg1mjEBWUjgDd1U1Kdjr2qFuNw
         T3O6Pn3WtDTJNai/iH0ZV1Q6Ym2BsdLKQt+ReumGwJlmhMcmjr8qhD5l/oWyXluaPHE0
         FOs3G9CqTq3XMpTHl6xT2RxjAgpu5b6JMOrrEfXsQEF2WAtYAIqAXjXheiUv68sGy7QF
         yuTaj+v41DChctpxPmFNhfnUCpfcuQc+uerOfvFavDQpa3WbjFQxYfixMMAPwcpvlEch
         4uN9J4PCnP4JgDzhIkqQwB08gAdSsFZp6cSd0WDsG6/Fq2Ju81VfXsOEijUdBz7MV2BC
         jXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Vm+AqaEOmH2vynBX1YlN9O9ey6K6uZgO3zGu6bKXXgA=;
        b=r7yt6NfrPGpvaZ+fvm1DEGExOOd/GMqGuDzbQfzL5wcT8JH7fPomCHjPmD8XGewEEB
         otctQXb1Dz+re3ZbDOSkAK5fBqjUcLKEiYx8a/Y6jYL5gFpqC2bioBxGZtktfLR4J0mG
         HO6ryLTd8J36+6z2JLSUz5ULwn9fZ6m0A+XHy5xC2BkIFSK+ooQ7CkOWCF+kmdhGS5ZS
         EPTlE7gBwnhGdXAV+h+nFAG4C+GCr+Jd0Jd1rjBB1/0vqCcIZb3cucKGMwUlec4lFiAi
         YmncLnVvcxrynh4DlhAzD7k9wkIkacNi3nkYBS52hbP6dh7oPb8AuKg0oqav4wXdHx5A
         LfDg==
X-Gm-Message-State: AOAM533ltWHVCK8mlM5BBhgKue2LGOzP94r1wetEc7s9iQ8nEMgrdiYm
        bHhDthYVh3pryoC3LiqfyrJ/ffbEdUc=
X-Google-Smtp-Source: ABdhPJynL+osOGjy0gsWTViWOkU6aBHf94KOcEc267FSgzitgv9eCXDammVzMJP/+dzkOVD80WX5yQ==
X-Received: by 2002:a05:6000:100a:: with SMTP id a10mr9954587wrx.42.1628971376546;
        Sat, 14 Aug 2021 13:02:56 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id f10sm5562936wrx.40.2021.08.14.13.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 13:02:56 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] rebase --continue: remove .git/MERGE_MSG
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
 <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
 <CABPp-BGHmCCeY7j9hVDGZPuLU8gR-ka3iEzUjK0wvkSUSYdNxA@mail.gmail.com>
 <xmqqim09xswt.fsf@gitster.g>
 <CABPp-BHi2GG8zmFEHHhMOUjkmmUfmj+ODT+KYUAXrXcgypRVYA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d9408804-864d-22e2-abef-d8b95198cab1@gmail.com>
Date:   Sat, 14 Aug 2021 21:02:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHi2GG8zmFEHHhMOUjkmmUfmj+ODT+KYUAXrXcgypRVYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/08/2021 18:21, Elijah Newren wrote:
> On Fri, Aug 13, 2021 at 8:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> Thanks, this version looks good to me.
>>
>> Thanks, both.  Elijah, can I take that as your Reviewed-by?
> 
> I typically do a bit more checking when adding a Reviewed-by and had
> just a short time available yesterday.  But I've done the extra
> checking now, so yes:
> 
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks

