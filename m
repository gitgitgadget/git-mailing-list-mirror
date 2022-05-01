Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91B9C433F5
	for <git@archiver.kernel.org>; Sun,  1 May 2022 17:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352805AbiEARZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 13:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiEARZi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 13:25:38 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DE447AFF
        for <git@vger.kernel.org>; Sun,  1 May 2022 10:22:11 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nlDGq-000AGN-CW;
        Sun, 01 May 2022 18:22:09 +0100
Message-ID: <d996dc46-ae9a-6506-8043-0ac5468d9dd4@iee.email>
Date:   Sun, 1 May 2022 18:22:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
Content-Language: en-GB
To:     Elia Pinto <gitter.spiros@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
 <20220430041406.164719-2-gitter.spiros@gmail.com>
 <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email> <xmqqpmky70jb.fsf@gitster.g>
 <a3e06290-052e-af36-4170-301e567d561d@iee.email> <xmqqr15e5fm3.fsf@gitster.g>
 <xmqqmtg25cjw.fsf@gitster.g>
 <CA+EOSBnx3-G02=zXGUrRuKPTDPBSYoBY=rERCORe8NtywEOiGg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CA+EOSBnx3-G02=zXGUrRuKPTDPBSYoBY=rERCORe8NtywEOiGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/05/2022 18:04, Elia Pinto wrote:
> Il giorno dom 1 mag 2022 alle ore 02:20 Junio C Hamano
> <gitster@pobox.com> ha scritto:
>> What I found curious is that the result of applying these patches to
>> v2.36.0 and running coccicheck reveals that we are not making the
>> codebase clean wrt this new coccinelle rule.
>>
> It is possible, I did not use coccicheck to apply the semantic patch
> (on next)  but i use a my script which I think is slightly more
> efficient but perhaps it is not so correct. Anyway, given the
> discussion that has taken place so far, what do you think is best for
> me to do? Do a reroll (perhaps with only 2 patches in total ) or wait
> for the "right" moment in the future as foreseen by the Documentation
> and dedicate the time to more useful contributions for git? Thank you
> all for the review
>
Hi Elia,

Given Junio's comment regarding the potential for patch churn, it may,
as an alternative, be possible to create a script that will
check/extract just those those changes that are either:

A) mistakes in patches between say master and seen `master..seen` so
that they aren't incorporated, though `next..seen` may be more appropriate.

B) detect 'while you are at it' fixes that could be applied to a file
that is being modified with the same range query. The file fix-up patch
could/would then be inserted as preparatory step to the relevant series
(i.e. fed to the series author), allowing easy reversion with/without
the fix-up.

C) suggest to coccinelle that maybe they include a similar Git based
range check option, to avoid needing a fancy script [using Junio's
rationale].

D) more clearly identify _why_ the particular instances that are
corrected are _worth_ changing now (e.g. fixing _one_ may be a worthy
GSOC or Outreachy activity, or .. <insert own reasons>).

 Hope that helps.

Philip

>> diff -u -p a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
>> --- a/compat/fsmonitor/fsm-listen-darwin.c
>> +++ b/compat/fsmonitor/fsm-listen-darwin.c
>> @@ -342,7 +342,7 @@ int fsm_listen__ctor(struct fsmonitor_da
>>                                            data->cfar_paths_to_watch,
>>                                            kFSEventStreamEventIdSinceNow,
>>                                            0.001, flags);
>> -       if (data->stream == NULL)
>> +       if (!data->stream)
>>                 goto failed;
[snipped]
