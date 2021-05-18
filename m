Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374E8C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A43960698
	for <git@archiver.kernel.org>; Tue, 18 May 2021 18:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346951AbhERSSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 14:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242744AbhERSSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 14:18:08 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9543CC061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:16:50 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso9455397ots.10
        for <git@vger.kernel.org>; Tue, 18 May 2021 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UcsGy/YyUh/8vKnOnYc0rI+RWus6JA7OmIZrxX8rRGE=;
        b=ak2f7Ni+Sy94QHMDZCgqmMu4KKvjqnJUhW5DuTn0OqEliwiqP2+pMzXWJ0D+AWyLft
         /PoTabB04ZIJEaIQarKqJVbU471eYRVWOD0MUEZs+AiZwmM1mG4z5lkCBTl57QdlAuCu
         r+zpjqJZ6Tt4gpqJ3oFxfC2jgXQ03lJW+FnkGnPCA6GKG0zKM/dhajMdnTjkSSMtasuH
         hBTTKI+OOq4QNB4U/DW+HOUpGM7kmtZNtNVZuP1fxGqJVuVt9l+m3DxZQnmlSKOIvVsK
         xFtP5BcNnGGV3tg2+nkQ1W593jMo3PIH5Z988snmjc9Z2l/o0Ji13BaobBqn7ng6SjKu
         cA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UcsGy/YyUh/8vKnOnYc0rI+RWus6JA7OmIZrxX8rRGE=;
        b=ZCOlGHeQcyvb/Algnaa8e9Dk3MnZqrZ9kNtFgjVL4JorzKXBD8C2Sl8WmEqiN2TfKl
         OJK5Y27032tmF333hpJTF7wzsvay7DVHJNFMwxp/vEgIBLT/ldrPdoAgQu+NMucHME5L
         Xyp+oAcRPvcAT84847hmA7O5bMBaITvsxksD01dmw8W2s4CtjGf6mB4rvuvmI6XaQoyR
         Oc5fi/jP7ES1ZHPyaHy9B+QdjZd1zIZhqjwkV17F+sLs6fZR+YMmooALrCe+sWFb3JlX
         aTSax+mNqqMS5tf4iyc4meBdKD/t9dQ8l4X57fTXPaKNoKA8+dSLsLDR02LZtJE75UmB
         cRCA==
X-Gm-Message-State: AOAM5311LgI86BnZ4G2pIDfoudoqua/4WjLfJDs7wrrJnTaJyDchyBh0
        OydBTZhLMiP2EUo8sbdQIzk=
X-Google-Smtp-Source: ABdhPJw/OrmcrPcDFSC7INFiSySI/X2YmWkMw/fb7YwQFsSyhD7n3kJP+Y7c9cKJwHVMlEG2oJVUzA==
X-Received: by 2002:a9d:404b:: with SMTP id o11mr5506954oti.220.1621361809961;
        Tue, 18 May 2021 11:16:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id b8sm3859240ots.6.2021.05.18.11.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 11:16:49 -0700 (PDT)
Subject: Re: [PATCH v3 02/12] sparse-index: include EXTENDED flag when
 expanding
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
 <8aa41e749471df3bd9d593b8f55db6506eafea12.1621017072.git.gitgitgadget@gmail.com>
 <CABPp-BFx9=7j5LrLnQwzxba+i7_cAEXngzyt9rfOJfBuqOPBsw@mail.gmail.com>
 <ddeda8ec-bc21-1f62-5d0e-839be74f1ec8@gmail.com>
 <CABPp-BHXNLTcQC=XmPoaVoy8xLKpru3yuJU1DfJVpOf_tJy8Yg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cb9161ca-dc6e-b77b-1a41-385ed8920bb2@gmail.com>
Date:   Tue, 18 May 2021 14:16:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BHXNLTcQC=XmPoaVoy8xLKpru3yuJU1DfJVpOf_tJy8Yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/18/2021 1:48 PM, Elijah Newren wrote:
> On Tue, May 18, 2021 at 7:57 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 5/17/2021 9:33 PM, Elijah Newren wrote:
>>> Is it possible that the setting of CE_EXTENDED is just a workaround
>>> that happens to force the index to be written in cases where the logic
>>> is otherwise thinking it can get away without one?  Or is there
>>> something I'm missing about why the CE_EXTENDED flag is actually
>>> needed here?
>>
>> This is happening within the context of ensure_full_index(), so we
>> are creating new cache entries and want to mimic what they would
>> look like on-disk. Something within do_write_index() discovers that
>> since CE_SKIP_WORKTREE is set, then also CE_EXTENDED should be set
>> in order to ensure that the on-disk representation has enough room
>> for the CE_SKIP_WORKTREE bit.
> 
> Yeah, I think it's this part:
> 
>         /* reduce extended entries if possible */
>         cache[i]->ce_flags &= ~CE_EXTENDED;
>         if (cache[i]->ce_flags & CE_EXTENDED_FLAGS) {
>             extended++;
>             cache[i]->ce_flags |= CE_EXTENDED;
>         }
> 
>>
>> I suppose this might not have a meaningful purpose other than when
>> I compare a full index against an expanded sparse-index and check
>> if their flags match.
> 
> Ah, you're just setting this flag in advance of do_write_index() being
> called so that you can compare in memory values and check they match
> without doing a write-to-disk-and-read-back cycle.  Makes sense, but
> it'd be nice to see this in the commit message.

Will do. Thanks,

-Stolee
