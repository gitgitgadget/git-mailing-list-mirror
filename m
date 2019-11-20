Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE07C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 13:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C720A2246A
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 13:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrHBHvsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfKTN62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:58:28 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:46510 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfKTN62 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 08:58:28 -0500
Received: by mail-qt1-f180.google.com with SMTP id r20so28933104qtp.13
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 05:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8b+LhLPrU5WApD0+va9xAo8iS/oG6WxN4O/RmFJS4Ik=;
        b=hrHBHvskW7DW5hO2YqLyVxc4Ls5I6L2JL40Auuc0ti343XPbmd3mAF07dtScosOA6Y
         PB5IgFwG0FATs3pYG23xPoUJRezL5K+7HYupzDMGk3vhr71UxEEmQTSVEdgT0NRZrYEr
         lxjTo55TBsfIdJoepPCUElIvhdgjLs6is7bTBG8H17RhkRIr5WdYkqbZs3FDH0PwkkOT
         O0zm6GHoVFLjCIFtHFSDPJ2/ZG9JTBzwxMduFsRdRg146WbBcgi2IR7GIMq/uByYlwEa
         rbpObzZYnsAoStGrMpeJJ+qcepQ7Q5XPkNdw4/MyDkZGm+oD/5T6ynWh07FMXX9gjCkM
         cwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8b+LhLPrU5WApD0+va9xAo8iS/oG6WxN4O/RmFJS4Ik=;
        b=fGtCEhRKjxSZpiS57XbLJXi2m5rIPC3OE2TpqwK0ASj4fgMXzzuaIh58yqquNXDCnC
         /5sMCzL8NUjUd3fQJMEdFFaif3x3MFds/73IGZuS1UzVbgnbu3ZfhiDEDqQs6/xb9CXq
         u9rSTXwEJT1rmkGPpRS3Ws3X1MJlyTkkvJlNBt0fYVQ/0izPpcFfp4F614rbTMOETWKK
         uqhyWne/wX03avAETKehnQw+IS7XsETWmhutkETNt8KG4BkqPwHDQWiiKWp2fBkeDvo1
         gpTcCoI1jlqx57tCFXUW5xzrjl8UMmYnmLf9IJvgj5jOwxStFe3ddwRurqMyde7H3QNr
         wvww==
X-Gm-Message-State: APjAAAUDCjHDWFKwIyC3+7LxmnKhrHEr6l1yZg4BtKJxqDzCRQvjKsRU
        Wt80wfhhRmdmDJw9Zz0yIkiHoQss8D8=
X-Google-Smtp-Source: APXvYqwPGWWBhV0VFN7OFuei2Ktbgv2TKNqW+vU9lg8y5urPBibELKGh+DSR01zsjV7pu82eK3I5Bw==
X-Received: by 2002:ac8:3f67:: with SMTP id w36mr2497123qtk.99.1574258307099;
        Wed, 20 Nov 2019 05:58:27 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:18b5:9b8a:49ed:1bc1? ([2001:4898:a800:1010:c9ea:9b8a:49ed:1bc1])
        by smtp.gmail.com with ESMTPSA id j71sm11903136qke.90.2019.11.20.05.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2019 05:58:26 -0800 (PST)
Subject: Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
 <20191119175850.GL23183@szeder.dev>
 <xmqqzhgrcksn.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <039f7668-53e3-9c6d-d813-ca412c4d1ed2@gmail.com>
Date:   Wed, 20 Nov 2019 08:58:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhgrcksn.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2019 10:02 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> On Tue, Nov 19, 2019 at 04:05:48PM +0900, Junio C Hamano wrote:
>>> * ds/commit-graph-delay-gen-progress (2019-11-07) 1 commit
>>>   (merged to 'next' on 2019-11-19 at afa7c921be)
>>>  + commit-graph: use start_delayed_progress()
>>
>> This commit is incomplete:
> 
> Ah, this is also just 2/2 of a two-patch pair; I guess I was extra
> sloppy on that day.
> 
> It seems that 1/2 was also incomplete, so let me discard this and
> expect both of them to resurface later.
> 
>>> * ds/sparse-cone (2019-10-23) 17 commits
>>>   (merged to 'next' on 2019-11-19 at 1eb4b3a012)
>>>  + sparse-checkout: cone mode should not interact with .gitignore
>>>  + sparse-checkout: write using lockfile
>>>  + sparse-checkout: update working directory in-process
>>>  + sparse-checkout: sanitize for nested folders
>>>  + read-tree: show progress by default
>>
>> This commit changed the default behaviour of a plumbing command, and
>> the resulting discussion concluded that such a change is not
>> desirable:
> 
> OK.  I had an impression that it was something relatively easily
> patched to restore the plumbing behaviour without taking the
> remainder of the series with a follow-on work.  If it is not the
> case, perhaps I should revert the merge to 'next' and kick it back
> to 'pu'.
> 
> Thanks for stopping me.

That commit can be ejected from the series without affecting the
correctness of any of the other commits. That will require reverting
the merge at this point, though.
Thanks,
-Stolee

