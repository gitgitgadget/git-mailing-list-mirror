Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0665C2D0B1
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 14:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846DB217F4
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 14:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM5NEeKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgBFOAU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:00:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46597 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgBFOAU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 09:00:20 -0500
Received: by mail-qt1-f195.google.com with SMTP id e25so4486491qtr.13
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 06:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cRo9uLY6Z01Nt1BQ/6IKU3cmXE4DbuS5GBROjWjhhcI=;
        b=GM5NEeKnRk0rcl4Y129YJ2aEE88M1u1jONUaze6HU+4IpfjJDq+7yef8+GBkdmezex
         zCkCOJOYlBAYnqhQoZ+d1dBdPA2SBLuKrxw7a317ZvA8H28dTD+w4gvRnNtD2tCu/Rgl
         t3E+Vy4SXIJ93BUptMAtJWwzZWNNDqid9zbNRqqvGtpITJETFsyNhbxCjFk13QoHWsAb
         zy0W3NtHjCktwhdPODO5tmbPy7akxOE6peAFmq7o77WNp8lgVoRc7PoszSCP/5c99RLJ
         Dl3OGTJ9sRXvcMPH7tzx71zRzisqbDGYDIxcm03tDnGqMCIhZFcbg1rMKNDZVOBHvsYw
         xgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cRo9uLY6Z01Nt1BQ/6IKU3cmXE4DbuS5GBROjWjhhcI=;
        b=lpZA5LV13Pbvt8cdUobeKlGKQKYl3xU3YUfOPOm1Z88IFnFVDheW0BrXgvZu7583V6
         Oxucv015IUjnNiP/2xE6MSktFiJxdC4N/sHtdZGOH2NXipHjfPjORF2lgLMOE/vssPox
         HQWkoyYxhjuutNmgCS6w+AFtjv9IhZj0WykflwAOJK0juNgv+zSytOUnNCWWUvhyOu4D
         /iDaG7pakLtK9hS2wVnNnj3pQBjUxOUYzl1ewVIToD4V/8vWlFr+q5ZXRu6KZ1OK4L2t
         yL+K27O6CMYBpv4dy2KZFcKWHHJN+bgg9tMhV8JEQazMNUwasO4QyvMX+7EO1NG97tB8
         0cDA==
X-Gm-Message-State: APjAAAUl383uXxh2BriuY/pTchJq+VzWHm0ywTRaYVn+DG32z5D6jV9S
        ThBasSYTha0ks8zdNG3fEvGI3U10UCuKPA==
X-Google-Smtp-Source: APXvYqwzmjKJo5jF10riiRfVeOE3IVeBgsszuFqtoiOwyV6e029FY+bqwI1XxdjXPr0BAD3ReMzqIw==
X-Received: by 2002:ac8:6bd9:: with SMTP id b25mr2691443qtt.347.1580997618652;
        Thu, 06 Feb 2020 06:00:18 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id l17sm1472811qkk.22.2020.02.06.06.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 06:00:18 -0800 (PST)
Subject: Re: [PATCH v2 2/4] git-p4: create new method gitRunHook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
 <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
 <f1f9fdc542353196612f8dd6b996d4fbd1f76c73.1580507895.git.gitgitgadget@gmail.com>
 <xmqqr1za6q83.fsf@gitster-ct.c.googlers.com>
 <ac44531e-b02d-5a98-3e25-a305b1250cf6@gmail.com>
 <xmqq36bohfsi.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <9cf8790e-6d13-4653-cddc-f5328f22b0df@gmail.com>
Date:   Thu, 6 Feb 2020 09:00:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqq36bohfsi.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/5/2020 4:42 PM, Junio C Hamano wrote:
> Ben Keene <seraphire@gmail.com> writes:
>
>>>> +        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
>>> This assumes that the process when his function is called (by the
>>> way, even though the title of the patch uses the word "method", this
>>> is not a method but a function, no?), it is always at the top level
>>> of the working tree.  Is that a good assumption?  I don't know the
>>> code well, so "yes it is good because a very early thing we do is to
>>> go up to the top" is a good answer.
>> I'm not sure what you mean by top level of the tree unless you mean
>> that it is not part of a class, but a "Free standing" function?
> No.  The discussion about function vs method was over immediately
> after we left the parentheses ;-)
>
> The "top level of the working tree" is the directory where the files
> you see in "git ls-tree $commit^{tree}" would appear in.  In our
> project, that is where the primary Makefile, COPYING, Documentation/,
> etc. hangs from.
>
> The code in your patch (quoted above) says that "When $GIT_DIR is
> not set, '.git/hooks/' is the directory the hooks live in".  That is
> true only when your process is at the top level of the working tree.
> If you chdir'ed to a subdirectory (e.g. Documentation/ in our
> project) and then let the quoted code run, hooks_path is set to
> ".git/hooks/", but from the point of view of the process running
> inside "Documentation/" subdirectory, it should actually be
> "../.git/hooks/", right?

Okay, NOW I get what you meant.  Thank you for the explanation!
The hook directory resolution is what was originally found in the
git-p4.py script.  I just tried to describe what it is doing
because I moved the code around.

As best as I understand the mechanics, and I haven't examined the
source code of git, this is just experimental, the GIT_DIR environment
value is set (at least in Git for Windows) when the program is
executed, so this always has GIT_DIR set, which may be why this
wasn't an issue in the past?

Does this prompt the need to search the hierarchy if we don't find
the directory?

>> And
>> yes, it returns a value so it should be called a function. I'll
>> correct that.
> This is an irrelevant tangent ;-) but yeah, it is a function, as
> opposed to a method, because it is not attached to any class.  I did
> not think Python differentiated functions that return a value and
> ones that do not (e.g. Pascal call the latter "procedure").
>
>> I chose to not put the function within a class so
>> that if other hooks should be added, it would not require a refactoring
>> of the code to use the function in other classes.
> I think that is a sensible design decision to have a free-standing
> function to execute hooks.
>
> Thanks.
