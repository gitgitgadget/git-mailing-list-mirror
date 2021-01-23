Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6167EC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2996220663
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbhAWVDG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbhAWVDF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:03:05 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99334C0613D6
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:02:24 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id x81so6012251qkb.0
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AdMrW+VPtcfgNu/I9acQ3gKGnN1fmoIOabg/OfF9kYg=;
        b=eFZIDtp7S2VJrh27V7DSmmqHo4R5fiZ02QjvDMtTiyOKaORoKKUTRzZU7BxK2ZotVs
         XmC1Ve7O7y1CAs8L1hvFk/7V52jXc0ZvMdKPEOz3qnykg8L/wEvTTab9QLkmQt89eXn+
         pm5SHT1X7fPOOWedmGMDjPBdJ6N2Oif0A5pMoEjKpMqX0YDqccOZixl6EIVEVFhDxWy9
         48xpslIej1alLieUlvhDbzB+vp2mu/LBIbQCcBA6GRVI7anTbxUIPbYEF5lS+Blxrknr
         4lP6CwpETDxJtdf/ORA0+WjymcyfLIJqlkVhTu1ohuhuNhD+9rgQkwJ7lUws3lKCzegd
         RgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AdMrW+VPtcfgNu/I9acQ3gKGnN1fmoIOabg/OfF9kYg=;
        b=CYARYhrg9xjTagO6//BhCJD/S039UfnXfmEgQGeIfohg2AzkK4j6LlLSOR8WFSj12O
         i7gU++EnJahSWLBpwELBoauYlVm607eiJ5PtqBlyJXYcokY70+GHiZFnbn9rmboqvjeL
         QDVsOUmgWEAcPWJ68Req9L2Uk6iXwGysN8pGgQfGnO6UD6ZRl/c3BV75JE/kARsF8niO
         qeZQtrXdotj0rFdA9TSRtmEW9w5mNqg8BQi9MyGQBZd/CP48dcv6o6CSCsOr+i4OLaYY
         yhURnkUvaFUICUUsGmXhXQD+zz0fKK0edZ0kYTC5wySKCLwRtGB+oaGHVif7LM/+R3P8
         RHxA==
X-Gm-Message-State: AOAM533E9wzULHqwedNdyOdyVIktDWOEGOJ7eGBYmDucDq4VXFvgjL5j
        cPkkHIAWEvND5Ue+dKeZG7c=
X-Google-Smtp-Source: ABdhPJyyxsl32jruoWB4RQnAsEymcmfNPt59CLM1arFwiNQqphIWEtwqX0/4izNRnJ1BmsObh/MZWw==
X-Received: by 2002:ae9:f20b:: with SMTP id m11mr1941365qkg.464.1611435743464;
        Sat, 23 Jan 2021 13:02:23 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:98e8:103:e6ee:9536? ([2600:1700:e72:80a0:98e8:103:e6ee:9536])
        by smtp.gmail.com with UTF8SMTPSA id l20sm9000973qki.129.2021.01.23.13.02.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 13:02:22 -0800 (PST)
Subject: Re: [PATCH v3 2/9] cache-tree: simplify verify_cache() prototype
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
 <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
 <1b8b56800948339c0e0387555698bdfdc80a19ad.1611431900.git.gitgitgadget@gmail.com>
 <CABPp-BEsoWs5ZEhS0KTHankzc8eUdmpn0uoF7t1ZtN8b2gwvBA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d910be29-ba90-bbe1-fd96-523508b99781@gmail.com>
Date:   Sat, 23 Jan 2021 16:02:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEsoWs5ZEhS0KTHankzc8eUdmpn0uoF7t1ZtN8b2gwvBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2021 3:24 PM, Elijah Newren wrote:
> On Sat, Jan 23, 2021 at 11:58 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> -       for (i = 0; i < entries - 1; i++) {
>> +       for (i = 0; i + 1 < istate->cache_nr; i++) {
>>                 /* path/file always comes after path because of the way
>>                  * the cache is sorted.  Also path can appear only once,
>>                  * which means conflicting one would immediately follow.
>>                  */
>> -               const struct cache_entry *this_ce = cache[i];
>> -               const struct cache_entry *next_ce = cache[i + 1];
>> +               const struct cache_entry *this_ce = istate->cache[i];
>> +               const struct cache_entry *next_ce = istate->cache[i + 1];
>>                 const char *this_name = this_ce->name;
>>                 const char *next_name = next_ce->name;
>>                 int this_len = ce_namelen(this_ce);
> Makes sense.  Thanks for explaining the i + 1 < istate->cache_nr bit
> in the commit message; made it easier to read through quickly.  I'm
> curious if it deserves a comment in the code too, since it does feel
> slightly unusual.

I would argue that "i + 1 < N" is a more natural way to write this,
because we use "i + 1" as an index, so we want to ensure the index
we are about to use is within range. "i < N - 1" is the backwards
way to write that statement.

Thanks,
-Stolee


