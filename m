Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E23C6FD1F
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCPQq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjCPQqz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 12:46:55 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB1467011
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:46:53 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c18so2407174qte.5
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678985212; x=1681577212;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8WBYOED3nC0LM8a8swcT3EWYMHDwH9V++i48qiLrco=;
        b=gkJoVeeLqcTkzPuR4zB8Rtpk2W65wTfde+qXmxu13MwQRt8n6GxXWjfWQW7QtHU5N9
         BI0s1alYEHC/euBX0lYJjf/b0IMl7Qso50dd3yuz0lza56XkYiUsJ73FdzBqIsdJInNH
         nl8ZkT6uVag1Zl63W33Meg9MpTLCTYRWIabG7FdrL8qR9/r08ivfQekO1ze4dVRlvXRE
         lT1U37WXUE/a6tyO4EPbjloRqpJScWMbUcB3ghG/KFOY2t+Oe4tj3/1tF4gHUv4gA1fR
         x9UKygVZ29Doheg9G83txOEb/hkQ48Q82ZLx1OWFGGTOQk2Bevf342pEojQZMgJu1jv7
         UmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678985212; x=1681577212;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c8WBYOED3nC0LM8a8swcT3EWYMHDwH9V++i48qiLrco=;
        b=cKqAs3VgdlifyIQ9w9rOoIRQMRstFyvKh+71sLUkv1v7zVsWORt2SjvkMvQMSxJTYO
         ziMPVZwX5IuJhcaKbqCKCWy5yBjzlU1gICt0BDuw+Rikg30S9PKK63ILWfPvHYrpFpf1
         G3ozwCECE7Y619lrRVVrudcvN/pD3iSCB0MGzMk6udSlpMrqXKTtj1+eGwpfM8L/oQXa
         iCqBCAUn7HSq9uZdqi3dvwEir6ZNZ0oAxUUxoPeyxo6IITOZZ6x0XtfncrrESJBXC/hg
         IjU0hwE+89BQszC22+J4KyhE1v6CcyIr5LFqmfr+YQBW2+AmDlT9mS/ch1tLs/iafHrR
         E0Wg==
X-Gm-Message-State: AO0yUKW8N+YBnEIp8bkUBE86V6m96LGixCfLXQmTMeW+CV/caXp24oZE
        Z3aPrBzt/OE4qYkomPKQ2YB9Hn59OMU=
X-Google-Smtp-Source: AK7set9uK3Hhp4H7a8oR2JXfwHuxBCR7F9Stw/eIXsZ8EK3ZZPHfzuWIGccHN2egKvS0VN3J1+GmnA==
X-Received: by 2002:a05:622a:189c:b0:3bf:bfde:91bd with SMTP id v28-20020a05622a189c00b003bfbfde91bdmr7417909qtc.5.1678985212461;
        Thu, 16 Mar 2023 09:46:52 -0700 (PDT)
Received: from [192.168.1.211] ([2600:4041:454d:2100:c108:fc00:b8e8:83df])
        by smtp.gmail.com with ESMTPSA id a3-20020ac87203000000b003bfa52112f9sm6016151qtp.4.2023.03.16.09.46.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2023 09:46:52 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: use HEAD for attributes when using bare repository
Date:   Thu, 16 Mar 2023 12:46:51 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <9E479AA2-2D54-4CAF-899B-B25894B746AA@gmail.com>
In-Reply-To: <xmqqy1nzoyqr.fsf@gitster.g>
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
 <0fc704cf1c0724473a61086098d44c3a82938b03.1678758818.git.gitgitgadget@gmail.com>
 <xmqqttynqnnj.fsf@gitster.g> <xmqqa60fqld6.fsf@gitster.g>
 <20230314193839.wevenngf324pijhb@pop-os> <xmqqy1nzoyqr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 14 Mar 2023, at 16:37, Junio C Hamano wrote:

> John Cai <johncai86@gmail.com> writes:
>
>>> Just for illustration, here is one way to do so.
>>>
>>> The implementation goes in the opposite direction from the more
>>> recent trend, which is why I am not making it an official patch, but
>>
>> Could you explain why this goes against the "more recent trend" for my
>> understanding?
>
> The illustration uses a global state.
>
> The recent trend is to reduce reliance on global states and use the
> repository object and others that hold such state through the
> callchain.

Ah I see--in that case, what would be a good object to put this state into? Mabe
repo_settings?

>
> But a new global variable that holds the fallback tree-ish object name
> was a so convenient way to illustrate the core of the idea, without
> having to change many callchains.
>
>>> with this you can do things like:
>>>
>>>   $ git --attr-source=e83c5163 check-attr whitespace cache.h
>>>   cache.h: whitespace: unspecified
>>>   $ git --attr-source=e2f6331a142^ check-attr whitespace cache.h
>>>   cache.h: whitespace: set
>>>   $ git --attr-source=HEAD check-attr whitespace cache.h
>>>   cache.h: whitespace: indent,trail,space
>>
>> I like the idea of an option that is global. For git-check-attr however, we
>
> I guess I shouldn't have used check-attr to avoid confusion.
>
> The point is that the internal mechanisms introduced by 47cfc9bd
> (attr: add flag `--source` to work with tree-ish, 2023-01-14), which
> taught check-attr the --source option and is reused by this
> illustration patch, was a good idea, but its UI was a mistake.  We
> do not need per-command --source option the commit adds if we did
> the global option from day one.  Yes, I think we can deprecate the
> "--source" option from there, if we all prefer the global option
> avenue.  I _think_ git_all_attrs() needs to be told about the
> default attr-source trick (which I didn't touch in my illustration
> patch) before it happens, though.

Good point. I think to have a global flag would be a better user experience.

>
> If you used the mechanism in the illustration patch I gave you, and
> adjusted the test part of your patch to match (i.e. "diff" does not
> learn "--attr-source" option, but "git --attr-source=... diff" is
> how you make it read attributes from a tree-ish), would the result
> work well, or do we need more work to make it usable?  How well do
> other commands (e.g. "git show") work in the same test repository
> you created in your version?

I think it works pretty smoothly. I adjusted my tests to work with this git
flag, and I also tested git show and it works well.

In fact, your proposal would serve the needs of my patch independently of any of
the diff code, which is nice.

>
> Thanks.

Thanks,
John
