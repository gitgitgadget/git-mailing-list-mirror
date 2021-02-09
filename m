Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C66C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A316E64EAA
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhBIEJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 23:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBIEHK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 23:07:10 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF1C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 19:56:02 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id u20so16815914qku.7
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 19:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0mlel9TQgrfojKn1NfgqOo7MNhbcBNAZDZjSgyqcqYI=;
        b=RzA1+oOzYBU4uGNzcahABR24nhBmB/77Dg0WjWngqjl/4x98oFlolR4PdrSfR7kV9N
         WqXlAwIMuyusAz982arlYMaBkxd2YTp6JsMQZitbpRNyX3p29E0/SICnegZ8bjdqQaar
         4NY5ptxzWNDaz0i/Thh8QhXWqOk3T7VVb8X9ToCML0cb9rQyCoCPfv4ahRNimMGOvWxS
         ZXAg5GBTZHPZn+juVp8Y9sJsWg3KyAKrBVj9wKl71GsdDegaCjWfBMXSf5HW90Q7pm1x
         ppiSxnwXhWUfChpGvXBM3SRCGEjl0ct944n1cFKzPvQOY5PHnklQ3GVIUAOWo0HDKfNZ
         85jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0mlel9TQgrfojKn1NfgqOo7MNhbcBNAZDZjSgyqcqYI=;
        b=Zg9ZgHfMXVKEAZNlG3eTEpTehEplV5O+g+hUeWaw0XL08P8Gj4SPa8aWQ10ULH6IIL
         n6Pm0rdpk/RzI6cSS2MUiwmQv5LMNhzpBxLL+6QEABi3PChxkxY7pr7akffoHhRTQX6g
         q6eHzR4JZ/thOR9+i7qp7zZGS5xx8JhPflG7B5z6OeOHH0eiko3I4R62fNXzM5aki/ua
         NATyOJOGy0ny9GNaZY2GI/Fh+WE9ooP2KrXFU7wLWHWKWPXjTvVxU+NQ3eJX+vyycmi4
         mQZzg4NgXJ35ZO03WY5tg2PZnwUOAI/HK0xIfoPuMm1kM9mHhk0do61lUS7+dV9I3HTv
         Mqig==
X-Gm-Message-State: AOAM533YAdzbnmbY7IEl1E5dUPraQte6kL+FkTW6YwZAuiV6A/mIfuud
        utAzW/1iYPyqF70AkdTkBLuLQKG+/jrqCCCR
X-Google-Smtp-Source: ABdhPJxIq0M6VaeyAn/NLHVlCvuQLMzbQ1fnxRMi0q6FmTf/DBcpttE8OeoTglhYPjRn8qW3+NZRlw==
X-Received: by 2002:a37:b2c6:: with SMTP id b189mr20375652qkf.363.1612842962019;
        Mon, 08 Feb 2021 19:56:02 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id u45sm13598003qte.3.2021.02.08.19.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 19:56:01 -0800 (PST)
Subject: Re: [RFC] [BUDFIX] 'git rm --cached <submodule>' does not stage the
 changed .gitmodules
To:     Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <periperidip@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        javier.moradesambricio@rtx.com, cousteaulecommandant@gmail.com
References: <20210207144144.GA42182@konoha>
 <xmqq1rdr8yl2.fsf@gitster.c.googlers.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <d76656cf-a7c6-e09a-0fa8-4bf33dd950bf@gmail.com>
Date:   Mon, 8 Feb 2021 22:55:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq1rdr8yl2.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

[CC'ing the original submitter of the issue]

Le 2021-02-07 à 14:30, Junio C Hamano a écrit :
> Shourya Shukla <periperidip@gmail.com> writes:
> 
>> So, my question is, do we need to fix this to make sure that the changed
>> '.gitmodules' is staged?
> 
> When "--cached" is given, the user is asking the module to be
> removed ONLY from the index, without removing it from the working
> tree, no?
> 
> So I think ".gitmodules" in the working tree should not be touched
> at all.
> 
> Removing the entry for the module from the ".gitmodules" registered
> in the index, when a submodule registered in the index [IS REMOVED], might be
> desirable, and what you say here
> 
>> And its entry is not removed from the file. What should be done about
>> this? I would appreciate your opinions.
> 
> may be related to it.

This seems to be what the original email [1] was about, i.e. Javier seemed to
expect that the changes to ".gitmodules" should be staged but the worktree version
of the file untouched. This would be more in line (I think) with the current
behaviour of 'git rm <submodule>', which removes the submodule worktree and
relevant sections of '.gitmodules' in some cases since 95c16418f0 (rm: delete .gitmodules
entry of submodules removed from the work tree, 2013-08-06).


> 
> But I doubt it is a good idea to let "git rm" be the one touching
> ".gitmodules" either in the index or in the working tree for that to
> happen.
> 

That's already the behaviour, at least for 'git rm <submodule>', see
the commit cited above, and the whole topic that introduced it,
b02f5aeda6 (Merge branch 'jl/submodule-mv', 2013-09-09) that added
some knowledge of '.gitmodules' to 'git mv' and 'git rm'.

> The reason I am hesitant to teach anything about ".gitmodules" to
> the basic level tools like "add", "rm" is because I consider, while
> the "gitlink" design that allows the tip-commit from a submodule in
> the superproject is a good thing to be done at the structural level
> in the core part of Git, administrative information stored in the
> ".gitmodules" is not part of pure "Git" and alternative designs on
> top of the core part of Git that uses different strategy other than
> what we have are possible and they could even turn out to be better
> than what we currently have.  In other words, I have this suspicion
> that the ".gitmodules" based submodule handling we currently have,
> done using "git submodule" command, should not be the only and final
> form of submodule support Git would offer.
> 
> That leads me to think that anything that touch ".gitmodules" should
> be done with "git submodule" suite of commands, not by the low level
> "add", "rm", etc.  Such a separation of concern would allow a new
> "git submodule2" design that may be radically different from the
> current ".gitmodules" one to be introduced, possibly even replacing,
> or living next to each other, the current "git submodule" together
> with ".gitmodules" file, without affecting the low-level "add", "rm"
> tools at all.
> 
> So from that point of view, if we were to fix the system, it may be
> preferrable to make "git rm [--options] <submodule>" only about the
> submodule in the working tree and/or the index, without touching
> ".gitmodules" at all, and let "git submodule rm [--cached]
> <submodule>" be the interface on top.  The implementation of "git
> submodule rm [--cached]" may use "git rm [--cached]" internally as a
> building block to deal with the index and/or the working tree, but
> the info kept in ".gitmodules" for administrative reasons should be
> dealt within "git submodule" without exposing any such policy to the
> lower level tools like "git rm" and "git add".

I personnally think this is not the direction I wish Git would go in.
Submodules are hard, and part of the reason they are disliked so much
is because they were not initially well integrated in the rest of the system,
and this "belief" has stuck despite major efforts e.g. adding '--recurse-submodules'
and flags and 'submodule.recurse' configs for several commands.

So I would really prefer for "core" Git commands -- as you call them, for me all
of the porcelain commands are on the same level -- to be more intelligent
submodule-wise, like in this case, adding functionality to 'git rm' instead
of adding another 'git submdule' subcommand.

Cheers,

Philippe.



[1] https://lore.kernel.org/git/ea91c2ea29064079914f6a522db5115a@UUSALE0Z.utcmail.com/T/#u
