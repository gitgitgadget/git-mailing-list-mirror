Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AC5C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8391F61216
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbhIWNkl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhIWNkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 09:40:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BFEC061574
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:39:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w17so6148675qta.9
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UP5fHllOgKrcFEb2YYGeblKhuMGyxkbfPXSDRr6vMUk=;
        b=YmsB7h8MNPbzcNDxNli9zJpMfPhXkj+j4Jre0wPMjmcOAjR9Y3vrUGRFzIdSzClaql
         Qc1BNu7xym/0ofau7EOwOhOUlrS8LT6rtuUw/K1c/efYvuP0dQt2FqZDACwPc4S1Fv5/
         RrHT4EhBlvBpPFJ7DZdmg+QeLqS2zKNPRfsDMBM4Tk/YvfSQnAD+Vw2Q5SgJqtBgOQKH
         LmxoxSIV+apUBYFwdRBXQ18z7cWjhsck0Ay6y8IwWWj57C5TyNXWBuir05iKDPcXRnsc
         AmNYUeaIGWZbw7/47Y1jiOkt5EnFSm9g8BS/i1C4oyy90tNYTtDaJxWyePwiZAwC+VfD
         YrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UP5fHllOgKrcFEb2YYGeblKhuMGyxkbfPXSDRr6vMUk=;
        b=ORFWW2+T9/2/b41UhcxUDinSLRFeTMJuye1f4vJg0EhvgLlyktf05sx9IwSyzDpd1E
         lFCCt9dlaE8OOCb/y7OrDAdX5Lt903vy25l7q9b728e8ZtI32CltBvmVWwplEJt8q1yY
         YfGsiI3/sthodZA/VjdTnrPStUOYuSSkYNQzbeoTkRSyA+leGqKOiRcY5aXV+kODgjc0
         hdVqf3kq4Hn+LsUPjaSacFrCvfNqWUtJ/CQ05xxHHS7FV1ZkDYTMInlHwVspSRbrYkH7
         IFgFW2NzWxxzQhmcHJuPs0wtIl4Q4S8F7Nowz14+gAgu2tv+glJHuPvsU4511MxlelhB
         e/BA==
X-Gm-Message-State: AOAM530Ph21jbFf83zALvMxEir13tWqYeXcAXi8NDAY7XUqgm0nkmWML
        hVYQ7HL3hKM9iI9hmr1LJQg=
X-Google-Smtp-Source: ABdhPJwFekQAdWJXaSRFZET9PqBFGmH+fmhoqOxLQD9Mmk93vvJeVUG9pUA57lS/y+NnVG5E6cgJ7g==
X-Received: by 2002:ac8:720f:: with SMTP id a15mr4845418qtp.84.1632404348020;
        Thu, 23 Sep 2021 06:39:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b4dd:ad18:da7f:7cfe? ([2600:1700:e72:80a0:b4dd:ad18:da7f:7cfe])
        by smtp.gmail.com with ESMTPSA id x125sm4199735qkd.8.2021.09.23.06.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 06:39:07 -0700 (PDT)
Subject: Re: [PATCH v3 03/14] dir: extract directory-matching logic
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, matheus.bernardino@usp.br,
        vdye@github.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
 <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
 <b1f6468f9cdb7d16f6317c71b21f4459af158e87.1632159937.git.gitgitgadget@gmail.com>
 <xmqqwnn8430s.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <36475af0-1021-f59d-cb33-b3b402c13767@gmail.com>
Date:   Thu, 23 Sep 2021 09:39:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnn8430s.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2021 7:13 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +static int path_matches_dir_pattern(const char *pathname,
>> +				    int pathlen,
>> +				    int *dtype,
>> +				    struct path_pattern *pattern,
>> +				    struct index_state *istate)
>> +{
>> +	*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
>> +	if (*dtype != DT_DIR)
>> +		return 0;
>> +
>> +	return 1;
>> +}
> 
> The function name and parameter list have "pattern" but as far as I
> can see any "matches" or "pattern" comes into the picture.  The code
> in the caller after calling this function may be doing pattern
> matching, but not this one.
> 
> What this helper is doing is "signal if the pathname in the working
> tree is supposed to be a directory with the return value, while
> filling *dtype with what kind of thing it is."
> 
> path_must_be_dir_in_working_tree() or something, perhaps?

Yes, a rename would be prudent here. Thanks.

-Stolee
