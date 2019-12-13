Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09592C35251
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC862475B
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqzSATld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfLMNmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 08:42:24 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32820 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfLMNmX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 08:42:23 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so841498qvn.0
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 05:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7cAztamKC0jqLneoVNvA+Y//2pZg41eYAxXYftm6ChI=;
        b=kqzSATldn8vsUUIoeR3AV1g1rZqJsJh1zaTVfAQyPdm5rBS8R0VQPjAoM0VrJhcGZu
         u5y5mg5oGIgUPAnnrxGzw36KKgxpxPF0hbiFz5Owt5BCtoN8dZNy+usrz6/a6T/jJHwQ
         ZIs4SkzT3mTyyAmLuPltWjScUEv6GiGx6x1nKEkXRMjPgZ3ZlTch/Me44boqYqPHKE+O
         fCuyUVCtrfTLZhQkdeFDff4BcsygfkM0jXWGjpz4blxioKD49dzyAV02K81f0q5tgxqH
         RFx68Jk+jBj3gqVLjYrJh5LHrelL+kPgfunYea5fng9YU8GrjsPi60yw0X5p1luMCK06
         4y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7cAztamKC0jqLneoVNvA+Y//2pZg41eYAxXYftm6ChI=;
        b=p+MDvP0MwePdtVOYebhVrkNewnv1PfgXiabDWAhFx3D049dp4aanYNCM/23IuE5cHf
         ZprrqTjfJk1qqGq5nM3rALCV5c2HTm2vA8FChhWXazBEBfk9j+NnhJqUezCYgPYqozeL
         P5v8k3yPYX4FOAqpR4FPEmdJLPe0sC3T2U15ls6ksxfCjt+5zC8okY0EJ4oPjOOWeQ1+
         DmxyHvkcOIyQogn4ORogNFsZPlaQS03kRbr4s2isOfuqb909035G/pYLgIuHnK6DGhCf
         Jy/4tkCFPjBxRCayRPV9UV0FRmEPy9NLJqvMQcbzPBbYxoUw9V1qYcSS027gRWXy9nG4
         2BiA==
X-Gm-Message-State: APjAAAXXknd4Q2lMbKLp9CoLGsS9SiOzg+ubzzKc+wQF/RAZvKWy9Lri
        emzY8ONGDFG0BzP6iWtY4Gs=
X-Google-Smtp-Source: APXvYqzStn7OtpqsBtsJm5KuLxhcJ7kq17aZO/HD6PSaHNgE0TpV3J4Rki3RMIq287mOslbOJqJHLQ==
X-Received: by 2002:ad4:46c3:: with SMTP id g3mr13069069qvw.60.1576244542533;
        Fri, 13 Dec 2019 05:42:22 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id k21sm819383qtp.92.2019.12.13.05.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 05:42:21 -0800 (PST)
Subject: Re: [PATCH v3 1/4] git-p4: yes/no prompts should sanitize user text
To:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
 <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
 <fff93acf4430e2e7702ae1345f9899244a9867aa.1576179987.git.gitgitgadget@gmail.com>
 <20191213014537.GA13064@generichostname>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <0afed92d-6efb-380e-cf02-d0a5d35e63a7@gmail.com>
Date:   Fri, 13 Dec 2019 08:42:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191213014537.GA13064@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/12/2019 8:45 PM, Denton Liu wrote:
> Hi Ben,
>
> On Thu, Dec 12, 2019 at 07:46:24PM +0000, Ben Keene via GitGitGadget wrote:
>> From: Ben Keene <seraphire@gmail.com>
>> ...
>>    * choices are extracted from the prompt text [.]
>>        a single letter surrounded by square brackets
>>        is selected as a valid choice.
> Maybe something like this?
>
> 	* returns a single character where valid return values are
> 	  found by inspecting prompt_text for single characters
> 	  surrounded by square brackets
Yes, that is much more readable.
> ...
> Aside from the one comment at the bottom, I reviewed the rest of this
> patch with `-w` and it looks good to me. Unfortunately, I don't use or
> know p4 so I haven't tested it.
>
>> @@ -4170,3 +4175,4 @@ def main():
>>   
>>   if __name__ == '__main__':
>>       main()
>> +
> Spurious trailing line. Perhaps we could make GGG error out on
> whitespace errors before submissions are allowed?
That is a good idea.  I obviously missed that and it would
help if it reported the error before submission.
>> -- 
>> gitgitgadget
>>
