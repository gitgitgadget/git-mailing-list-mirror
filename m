Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2E7C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 11:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbiAXLKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiAXLKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 06:10:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CEDC06173D
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 03:10:49 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h29so10203595wrb.5
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 03:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=KMIv1l+6cpJx5yTqG+dPbrzPR6YH9isja3uX5riRNDE=;
        b=Bdj354sgo3g8ewGJPTa4FgfOZ5LkSL9gkq9aYeW5fg8cvQyYKj5N20/0CR/2pzkL1+
         Vw1N9+vpTuPVMqjzBRCQ/rkF0o2W2/XkGCZLx6pVw4RssY8WRITcyZwVeN+lofrj30mJ
         OUDmHhjKDdSZgBjyDc/dgOxHnH18h/JwycTNod/teFz8cW4uvuQ0ei+M/SNaJvinHVXH
         ATsEZm54Rf612HqL4Njy8lp/GwxLxGCX1OnrLOeY1rT0YczkownnUrbiCnVH5ExFL7OQ
         HE/q52CENuYdnjqb5DQSufW+7jw4zhv3WZrMN8rtzODFM6QeQ94GA9OYV3dhEHxs1Ach
         j1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=KMIv1l+6cpJx5yTqG+dPbrzPR6YH9isja3uX5riRNDE=;
        b=3wYglYod+C9iOsMNnpGenEOHIHw/fAE8FmbqCwYcKLBaUd7qSduPs0pyrKRJ4RPb0Y
         w40uc7r2+rCS2TmCw7w/irKfV9yFuh06DnlilODCw0QKpvM6Sp5RBv6ytRXCcy4OXin6
         ok7xZjLwUdXEj60Phj2NCs2eXMNztQgSPc9PPBGZU2ya7iX7cqzBAHNJa16spBLDlbFD
         rPnZKUKMmUNl5fTc2xdhyHNDkv6w7bZI8edSxVjD6afac7+1HAdl+8Iw78x6P3FoKXXb
         MIOqxfqdOSyL+I8+wFH77dxBwkeUuFJPpG9bYAGcSSZzr5tYLKXxbPkn22BvqNm6BHTJ
         uhjw==
X-Gm-Message-State: AOAM5300ORlrMLrMjDdJQaIYeyBBpNzaVAsYpBLGcmEdDxo+xig06Dmk
        EzPG15M58SnkDntJSaQv1b3HW30unFw=
X-Google-Smtp-Source: ABdhPJynszGnm8NJy1T5inCtchSUIQj3YD6W8lGE370qm8E1RaZHHNzMMXp2mP5y6HIIcte2QB5hAA==
X-Received: by 2002:a5d:4567:: with SMTP id a7mr13560914wrc.363.1643022648391;
        Mon, 24 Jan 2022 03:10:48 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id a6sm6068780wrx.101.2022.01.24.03.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 03:10:48 -0800 (PST)
Message-ID: <649cfa82-5fbf-71f3-244b-bc37404c40ab@gmail.com>
Date:   Mon, 24 Jan 2022 11:10:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/2] builtin add -p: fix hunk splitting
Reply-To: phillip.wood@dunelm.org.uk
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
 <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
 <220111.861r1ezcxn.gmgdl@evledraar.gmail.com>
 <348d37a3-f01b-cda6-8ce4-1536e0bd3b06@gmail.com> <xmqqv8yovlc2.fsf@gitster.g>
 <47e7b23a-56a3-b533-63ed-a854503b59ed@gmail.com>
 <nycvar.QRO.7.76.6.2201220938360.2121@tvgsbejvaqbjf.bet>
Content-Language: en-US
In-Reply-To: <nycvar.QRO.7.76.6.2201220938360.2121@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 22/01/2022 09:05, Johannes Schindelin wrote:
> Hi Phillip,
> 
> first of all: thank you for these patches. I read over them and they have
> my ACK.

Thanks

> On Wed, 19 Jan 2022, Phillip Wood wrote:
> 
>> On 12/01/2022 18:51, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>> I'm not sure I want to go with your extra changes. I've left some
>>>> comments on them below
>>>>
>>>>> @@ -488,12 +499,12 @@ static int parse_diff(struct add_p_state *s, const
>>>>> struct pathspec *ps)
>>>>>     else if (starts_with(p, "@@ ") ||
>>>>>       (hunk == &file_diff->head &&
>>>>>    		  (skip_prefix(p, "deleted file", &deleted)))) {
>>>>> -		if (marker == '-' || marker == '+')
>>>>> -			/*
>>>>> -			 * Should not happen; previous hunk did not end
>>>>> -			 * in a context line? Handle it anyway.
>>>>> -			 */
>>>>> +			hunk->splittable_into++;
>>>>> +		/*
>>>>> +		 * Should not increment "splittable_into";
>>>>> +		 * previous hunk did not end in a context
>>>>> +		 * line? Handle it anyway.
>>>>> +		 */
>>>>> +		complete_file(marker, &hunk->splittable_into);
>>>>>       ALLOC_GROW_BY(file_diff->hunk, file_diff->hunk_nr, 1,
>>>>>          file_diff->hunk_alloc);
>>>>
>>>> I deliberately left this alone as I think we should probably make
>>>> this BUG() out instead of silently accepting an invalid diff.
> 
> FWIW this was overzealous defensive programming on my part. More on that
> below.
> 
>>> As we are reading our own output, I agree that such a data error is
>>> a BUG().
> 
> Indeed. I was less worried about the output format changing, and more
> concerned with bugs in my parser ;-)
> 
> Although, having said that, I had meant to verify that `git add -p` cannot
> be asked to produce and consume diffs with `-U0` when I wrote that
> comment. Now I did that, and I am now confident that there is no way to ask
> `git add -p` to generate and use context line-free diffs: we neither add
> `-U<n>` in https://github.com/git/git/blob/v2.34.1/add-patch.c#L398-L417
> nor do we call the user-facing `git diff` command that would interpret
> `diff.context`, but instead we use `git diff-index` and `git diff-files`
> (which ignore that config setting).

I did think about zero context diffs but realized that they can never be 
split so we don't need to worry about incrementing hunk->splittable_into 
in that case. It does mean that hunk->splittable_into will be zero in 
the -U0 case rather than one but I dont think that matters as we only 
care if it is >2 for splitting.

Best Wishes

Phillip

>>> In any case, a helper to see if the file ended without post-context
>>> is one thing, and a helper that specify what happens after we are
>>> done with a single file, before we move on top the next file or
>>> after processing the last file, is another thing.  The latter may be
>>> able to make use of the former, but the latter may want to do more
>>> than that in the future.
> 
> If you are concerned about the name of the function: maybe a better name
> would be `maybe_increment_splittable_hunk_count(marker)`.
> 
>>>
>>> As complete_file() is about finalizing the processing we have done
>>> to the current file, it should be used for that purpose, and nothing
>>> else, I think the hunk I see at
>>> https://github.com/git/git/commit/c082176f8c5a1fc1c8b2a93991ca28fd63aae73a
>>> (reproduced below) is simply a nonsense.
>>>
>>> Stepping back a bit, though, is this helper really finalizing the
>>> current file, or is it finalizing the current hunk?  If it were the
>>> latter, then its use in the hunk I called "nonsense" above actually
>>> makes perfect sense.
>>
>> Even if the helper is finalizing the current hunk then I think that "nonsense"
>> hunk would still wrong as it would be calling finalize_hunk() on _every_
>> context line in the hunk rather than just being called once to finalize the
>> hunk. We could call the function something like update_splittable() but then
>> we'd need to explain why we were calling that function at the start of a diff
>> and at the end of the loop.
> 
> Right. The point of this check is to see whether we missed counting a
> splittable hunk. Then it makes more sense to call it at the beginning of a
> file, at the end of a file _and_ at a context line.
> 
> Having said all that, I am really fine with what landed in `next`.
> 
> Thank you,
> Dscho
