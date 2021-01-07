Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94D4C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59DE122BEA
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAGCEq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 21:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbhAGCEp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 21:04:45 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E29C0612F1
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 18:04:22 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id s19so1239614oos.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 18:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mWM1Do2OuQuMYsMRX8QS+mz25rN/Q0XQ0HpPRDl8mtg=;
        b=FLxvufheHjOnyu3JN2kFsom1DwBFee7/1+5UkcmWwExQI818k357jrxB2jmtf8ikp3
         oASrYqgFlMBRLCIVNothNnOMoarOLz/yai4qfY6bSXyMUdE5dI6kVfyvmj7XA8x/UlQW
         iC68owIdMjJ0egoeHjzP3vqUIfc1ABXmV4guErKcmVR1+vMpdcsuBOzD8mb9oGKun3EE
         i7kc0EXAgoYagMz5O4E6qn+qaxOfHb4wQQbFv7tdB/IOVFn1wmVhcxaG/y4IgaWXhpqq
         rBJR9X3BVwpiW5AoRtHTzHae1W16757vvtarpY3LSfffDhtl0wWVCj11Ai30neuu/gsG
         KNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mWM1Do2OuQuMYsMRX8QS+mz25rN/Q0XQ0HpPRDl8mtg=;
        b=tEo4dmz5RfeRvzeJKo6U+QHBplYsy+lDWzGv2u+PTZ+ly+8kjakJJEszJ76GLVtG0O
         nKUBODhIqos9/QdD0CcRcCUdQHbxyFaC4jWrYqRRlON37D2pehOnTdnSoBafcmItiIu1
         G3hUJhXgMaPMBS23w4VpTGNqS/lZa+F0ml9KglS91tTXvtyg5glyscBBDMocQ8DdLI6n
         n/Za/fm9MgnYMsD6a2Pdevw5TkKSUffu5aQ0dh8zPgt73IEpHe/mgiizipbEgoCCDvds
         Cn3QztAwwFJZJi73YzfewmDV8xz4rGStoA9NhCdw5ibFwcYE2r+oxHmbekNW8ka8kf9s
         odZw==
X-Gm-Message-State: AOAM532+i6C8HYxnH8mer6d4bSTALIfyoxxHY/VK4dQTxOa8f3oWJLKm
        lgVDEb91WYJAhcFBvALnLQI=
X-Google-Smtp-Source: ABdhPJxfVJUzGg401hEn2rJQcRBgBOrrKIYEkUiaeKh56XsiS7bWqAXVqPHdA2FlbX6Utu6HqHz3ig==
X-Received: by 2002:a4a:646:: with SMTP id 67mr4653587ooj.33.1609985062074;
        Wed, 06 Jan 2021 18:04:22 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id u3sm856096otk.31.2021.01.06.18.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 18:04:21 -0800 (PST)
Subject: Re: [PATCH] revision: trace topo-walk statistics
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.828.git.1609302714183.gitgitgadget@gmail.com>
 <xmqqh7nto7ck.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cbc17f1b-57fc-497f-f1ab-baa8cc84620d@gmail.com>
Date:   Wed, 6 Jan 2021 21:04:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7nto7ck.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2021 8:37 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/revision.c b/revision.c
>> index 9dff845bed6..1bb590ece78 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -3308,6 +3308,26 @@ struct topo_walk_info {
>>  	struct author_date_slab author_date;
>>  };
>>  
>> +static int topo_walk_atexit_registered;
>> +static unsigned int count_explore_walked;
>> +static unsigned int count_indegree_walked;
>> +static unsigned int count_topo_walked;
> 
> The revision walk machinery is designed to be callable more than
> once during the lifetime of a process.  These make readers wonder
> if they should be defined in "struct rev_info" to allow stats
> collected per traversal.

That's possible, but the use of an at-exit method means we only
report one set of statistics and the 'struct rev_info' might
be defunct.

It does limit how useful the statistics can be when there are
multiple 'struct rev_info's in use, but we also cannot trust
that the rev_infos are being cleaned up properly at the end
of the process to trigger the stats logging.

Of course, maybe that _is_ something we could guarantee, or
rather _should_ guarantee by patching any leaks. Seems like
a lot of work when these aggregate statistics will be
effective enough. But maybe I'm judging the potential work
too harshly?

Thanks,
-Stolee
