Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA0C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AEB20719
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 19:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4gaE2HP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbgDBTFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:05:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33081 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731715AbgDBTFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 15:05:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id z14so323898wmf.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 12:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YDuLTlPbfpbnNyReXyHk8qypvwbz4JriVBTOLpMdld0=;
        b=o4gaE2HPSKeJouYldFWQh3cu4RFMUc9JFABNGia0NPmb+TF41QShj8Cb5g5SEUuauJ
         t6Q/J07n2N4FeTAmE5Un0o71ZTdoAox5WOdbThibnBLT0WmfLlHk/xwpF8/262JFLEiO
         ScoQ0UXHYyiSKeD74aYnoP2ksLdeqPJlsh1g3dKavQD3j96Sjy2vajVUmHrrgNemYQpC
         QcwWV693fvNpa3g1EG0mjQW+O/n92EequD+5YPTStuIo5cTYKzSV+xDdglV9w901nChN
         6iv2z8btODInk4aQ/F5FITshOdqIBH0Dwx5Ow6Kg0TvXJbxuO4fqn4PIWuU7Kkuv2pL1
         Kv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YDuLTlPbfpbnNyReXyHk8qypvwbz4JriVBTOLpMdld0=;
        b=gSERSJsOfmmkr5VLD2DLwxQDQ/DekQumYar+EV24RAv33sDHQ8UplFrYVE2fmvldn+
         no93NopGP/QY/Ed2AHSSXZzyP7a1Sm3vYD96fFa0UzIT+bt0AXozUkNJ6E3+4Uf6aDqp
         /2ppe0nyGfehbSynmfW/i1bfVcVKkeTOAxJDYjFJ9UChCyd9CY+Fis6mghvY9UBdNtOZ
         hvcg2vEF1WV/QX4x3QOpErglhiKK/KPjiOdonoyWhhWWI/A7PpRqtBn/0uvRqblpFknD
         fA3hjZTlfcaYfkjLOvAEqCvynKQCIPZuoGYwj7ZGKD/wzVIXc8GPH4BfxDGTnEeC1hRP
         c8MA==
X-Gm-Message-State: AGi0PubeXOCoABF1S5qzBlSAQyy79lnYDMXbt9WtyP8d2SNrSeecdKqA
        y5HIKD7oDRa1CqsG++2+yIY=
X-Google-Smtp-Source: APiQypJ253xiOTTCMcE4e5wn2+v4VAotZXh6+oQZL7MLkQHwgNs9gXKWMorwmHZKX5AorIAhxSqLZw==
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr4760411wms.188.1585854319411;
        Thu, 02 Apr 2020 12:05:19 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id z203sm8342427wmg.12.2020.04.02.12.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 12:05:18 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: honor GIT_REFLOG_ACTION
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Paul Gevers <elbrus@debian.org>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.746.git.git.1585773096145.gitgitgadget@gmail.com>
 <b187cb5f-a6c8-2908-e3fd-e1210e6970e0@gmail.com>
 <CABPp-BE_mimSRg5wf0Yzn2s-dX=64ZS1jGszqwHzr3aju0bj=A@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <09397e37-a22b-5159-b760-bae238ae3ed6@gmail.com>
Date:   Thu, 2 Apr 2020 20:05:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE_mimSRg5wf0Yzn2s-dX=64ZS1jGszqwHzr3aju0bj=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 02/04/2020 18:01, Elijah Newren wrote:
> Hi Phillip,
> 
> On Thu, Apr 2, 2020 at 2:25 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Elijah
>>
>> Thanks for fixing this
>>
>> On 01/04/2020 21:31, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> There is a lot of code to honor GIT_REFLOG_ACTION throughout git,
>>> including some in sequencer.c; unfortunately, reflog_message() and its
>>> callers ignored it.  Instruct reflog_message() to check the existing
>>> environment variable, and use it when present as an override to
>>> action_name().
>>>
>>> Also restructure pick_commits() to only temporarily modify
>>> GIT_REFLOG_ACTION for a short duration and then restore the old value,
>>> so that when we do this setting within a loop we do not keep adding "
>>> (pick)" substrings and end up with a reflog message of the form
>>>       rebase (pick) (pick) (pick) (finish): returning to refs/heads/master
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>       sequencer: honor GIT_REFLOG_ACTION
>>>
>>>       I'm not the best with getenv/setenv. The xstrdup() wrapping is
>>>       apparently necessary on mac and bsd. The xstrdup seems like it leaves us
>>>       with a memory leak, but since setenv(3) says to not alter or free it, I
>>>       think it's right. Anyone have any alternative suggestions?
>>>
>>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-746%2Fnewren%2Fhonor-reflog-action-in-sequencer-v1
>>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-746/newren/honor-reflog-action-in-sequencer-v1
>>> Pull-Request: https://github.com/git/git/pull/746
>>>
>>>    sequencer.c               |  9 +++++++--
>>>    t/t3406-rebase-message.sh | 16 ++++++++--------
>>>    2 files changed, 15 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index e528225e787..5837fdaabbe 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -3708,10 +3708,11 @@ static const char *reflog_message(struct replay_opts *opts,
>>>    {
>>>        va_list ap;
>>>        static struct strbuf buf = STRBUF_INIT;
>>> +     char *reflog_action = getenv("GIT_REFLOG_ACTION");
>>
>> Minor nit - you're using a string here rather that the pre-processor
>> constant that is used below
> 
> Yeah, true.  However, using a mixture of both styles is consistent
> with the current code's inconsistency about which one should be used.
> :-)

Nice!

>>>        va_start(ap, fmt);
>>>        strbuf_reset(&buf);
>>> -     strbuf_addstr(&buf, action_name(opts));
>>> +     strbuf_addstr(&buf, reflog_action ? reflog_action : action_name(opts));
>>>        if (sub_action)
>>>                strbuf_addf(&buf, " (%s)", sub_action);
>>>        if (fmt) {
>>> @@ -3799,8 +3800,10 @@ static int pick_commits(struct repository *r,
>>>                        struct replay_opts *opts)
>>>    {
>>>        int res = 0, reschedule = 0;
>>> +     char *prev_reflog_action;
>>>
>>>        setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>>> +     prev_reflog_action = xstrdup(getenv(GIT_REFLOG_ACTION));
>>
>> I'm confused as to why saving the environment variable immediately after
>> setting it works but the test shows it does - why doesn't this clobber
>> the value of GIT_REFLOG_ACTION set by the user?
> 
> The third parameter, 0, means only set the environment variable if
> it's not already set.

Ah thanks, I thought I must be missing something fairly obvious but 
couldn't see what it was

Best Wishes

Phillip

