Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F58C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5BC60F11
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhINN2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhINN2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 09:28:37 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A40AC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:27:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so15190114wrq.4
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F/J/iGbRjoAR/LP28GwvsAKr4c9nGno+zlghY/zmryo=;
        b=OQ1Vh7lCdJHyhl0/LmNxMRgu+Y915UyqvGQVovlrEV/3ybRuIFRJw1AlC5sc6t149K
         7ez+KjsFSUSkc8M8vbWKpSrhDKDc2NWtF208nekNQ2h6AbvgBwyHbmX1cs7w0vNB+EH9
         ALcbIv2gWrUIVM1f38AZkEu3m1zaDDjDdTUrLFPTPzBlYtnGc2lnyvF6xfcXH1RL9tFl
         VKjiaQrdyDfgdkfg+IhJlKuN2w1CCD4MyOKXyhMNq+lGWmpORnwSXNPrfRC6svYWy2Vn
         EUxgPYL2AT7m/tyog85DPOj+eFSowc2L630veowfG8b1f/DIiA+gk16GjeS/KqLpO9ne
         6CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:from:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=F/J/iGbRjoAR/LP28GwvsAKr4c9nGno+zlghY/zmryo=;
        b=7c9QB6FqCpWBGahd4yTLz0jY1xWerSNvAiWMzy7VIXlsevQgI+NvnzrR+WoJmYad27
         NGPbKhp5oyKc+c18ySyKGvpNLvgkV5Lbn5bYXeWoPQOea3nmdXmwisqbsTeerV7MMPyf
         NohwgAfVzn2SwtFA2F9lgYuw4i62z4P4CYNcUr5i9d40RZQHWEjuCh4vxUzyMgCn7UM9
         tw7Xort0DVSfka8a/Uw27vp9hCRXeEXgvDF5Qwd8Zv1zC1eWwV1tcqew0iwXdJvmPH2f
         rZwOVrnD/R3NIDfXoDeeB7QumKbiGNVOOxkU8NI6AIYEU4Su7sFHp9Yov1Fyg/dd6wEy
         NyqA==
X-Gm-Message-State: AOAM532KWErV5cQAfRWmnXSayAL8su4EJnzl2dAxd4YwI07q5cCnI1Wy
        VqZXxQblAf0wAqDSNQKi/sY=
X-Google-Smtp-Source: ABdhPJxSuVQzfoSkRtlQsJYUVBK50VKcPbrOywq5Ojch/tCv7zUXluDpAvpFPzH4JzLowqFztQsGgA==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr18797393wrs.271.1631626038447;
        Tue, 14 Sep 2021 06:27:18 -0700 (PDT)
Received: from [192.168.1.240] (46.107.7.51.dyn.plus.net. [51.7.107.46])
        by smtp.gmail.com with ESMTPSA id l2sm1868514wmi.1.2021.09.14.06.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 06:27:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 11/11] rebase: dereference tags
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
 <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
 <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
 <xmqq5yv4ccc0.fsf@gitster.g> <5ef402a4-3477-6227-e08c-041ed373313e@gmail.com>
Message-ID: <8c78eac4-676b-7bd1-0282-d52eb20f87ce@gmail.com>
Date:   Tue, 14 Sep 2021 14:27:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5ef402a4-3477-6227-e08c-041ed373313e@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/2021 11:17, Phillip Wood wrote:
> Hi Junio
> 
> On 13/09/2021 23:58, Junio C Hamano wrote:
>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Aborting a rebase stated with 'git rebase <upstream> <tag-object>'
>>> should checkout the commit pointed to by <tag-object>. Instead it gives
>>
>> I am not sure if "should checkout the commit pointed to by." is a
>> good description.  It does not seem to be sufficiently justified.
> 
> My logic was that as we handle commits here it would make sense to 
> handle tags as well - I discovered that this did not work when I 
> happened to use an annotated tag as the <branch> argument to rebase the 
> commits pointed to by the tag and was surprised it did not work when we 
> happily accept tags for <upstream> and --onto.
> 
>> Did we auto-peel in scripted version of "git rebase" and is this a
>> regression when the command was rewritten in C?
> 
> As far as I can tell we have never peeled tags here

That's a bit misleading. We have never peeled a tag given as <branch> 
when we parse it. In the scripted version we just passed the tag oid 
along to rev-list, checkout and reset and they peeled it. So I think 
this is actually a regression in the builtin rebase. I'll update the 
commit message to reflect that unless we feel that allowing a tag for 
<branch> is a mistake and we should be erroring out to avoid the 
possible confusion of the tag not being rebased, only the commits it 
points to.

Sorry for the confusion

Phillip

>> If that is not the case, this topic is perhaps slightly below
>> borderline "meh" to me.  The optional "first switch to this <branch>
>> before doing anything" command-line argument in
>>
>>      git rebase [--onto <there>] <upstream> [<branch>]
>>
>> was meant to give a branch, and because we treat detached HEAD as
>> almost first-class citizen when dealing with branch-ish things, we
>> allowed
>>
>>     git rebase master my-topic^0
>>
>> to try rebasing my-topic on detached HEAD without losing the
>> original.  In other words, you had to be explicit that you meant the
>> commit object, not a ref that points at it, to trigger this "rebase
>> detached" feature.  The same thing for tags.
>>
>>     git rebase master v12.3^0
>>
>> would be a proper request to rebase the history leading to that
>> commit.  Without the peeling, it appears the user is asking to
>> update the ref that can be uniquely identified with "v12.3", but we
>> do not want to rebase a tag.
> 
> I wrote this patch as I felt it was an artificial distinction to require 
> that <branch> is a branch-ish thing rather than a commit-ish thing. 
> Rebase already peels <upstream> and --onto so it feels inconsistent not 
> to do it for <branch>. I guess the counter argument to that is users may 
> be confused and start complaining that the tag itself is not rebased.
> 
>> It would have been a different story if we had a problem when a tag
>> is given to "--onto <there>", but I do not think this topic is about
>> that case.
> 
> No "--onto <tag>" works fine. We also accept a tag object for upstream 
> without requiring the user to peel it for us.
> 
>> Having said that, even if we decide that we shouldn't accept the tag
>> object and require peeled form to avoid mistakes (instead of
>> silently peeling the tag ourselves), I do agree that
>>
>>>      error: update_ref failed for ref 'HEAD': cannot update ref 
>>> 'HEAD': trying to write non-commit object       
>>> 710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'
>>>
>>
>> is a bad error message for this.  It should be something like
>>
>>     error: cannot rebase a tag
>>
>> perhaps.
> 
> We could do that if we're worried that users would be confused by the 
> tag not being rebased if we started automatically peeling <branch>. (I'm 
> kind of leaning in that direction at the moment having read your email)
> 
> Best Wishes
> 
> Phillip
> 
>> But if we auto-peeled in an old version, I do not mind this series
>> (but let's drop pointless "clean-up" that is not, like what was
>> pointed out by Réne).  In such a case, the first paragraph should
>> say, instead of "should checkout", that "we used to do X, but commit
>> Y broke us and now we die with an error message".
>>
>> Thanks.
>>
