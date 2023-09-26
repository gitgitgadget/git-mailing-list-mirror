Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196BCE7E654
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 18:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjIZSaZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 14:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjIZSaX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 14:30:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D188E5
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 11:30:16 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bc57401cb9so1260005a34.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695753016; x=1696357816; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZFihn3TU8pNjS200MCWWrq15tInuqsZOor6rPMorHQ=;
        b=EPrnu4nCUs8BXmP9W2/4Mdz0yeaU3DlxpSQ29Cc6HgUtD+8icsOqCzY56kFj9GM1Yt
         EUzTnTemQYHCqMKr5mIAe3jbBZ2Q2Kdp1V7PVFeX70To40YfB6hM5QMwROaTAbJZWK3W
         VZUUgHZuXVIdlMKZ5PKxge7lGK+ieLecFrB/yzzFafNQjf8ium8itLzYajMFJeeiwFBv
         T+6vNBxEbSfjzFHqFC0fRSK6Pl2IUfqCf2XKT7la5o/q9kbcqeR6AfYn3MoH9Hzsne+I
         +YKwtkxi8+5rGlU7jN7p8CjO11mGn+yyh7aMk0Iu8AUPJyqR/3MWHchm16y2lpdKCvE5
         X9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695753016; x=1696357816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZFihn3TU8pNjS200MCWWrq15tInuqsZOor6rPMorHQ=;
        b=a+43rweTGmXOq+YkjaoCUdbcd5pE6v6QRNHHAkn5T6S8xVQDN/aMpAbbBlLf8fkR4I
         BHsA2H8Qr5KxjnATylT4mdZynlXCFNSAR/POReZBlMCjMoXxY1yxjcghp/5xU5Jtcrcc
         LnUDO7syczYXeIssKHOWuI9ZGaFofQ6nTIogDJFrGWgnnjQrzx3ZDYRJ8v4ulecHsnLB
         T1QqGurJLtv4hAY7++rwp/gFrTQtYkflrB9PY/+BfbeKmWhMcXvq+SPnJRabf4Fac0ji
         qGTyI30ItwLYvvJRbhBrmxV3JgjRSwUA5Cm8Cs/bEYeCgo7ACRXrSv2ZoDfjYVlmD7JC
         ih3A==
X-Gm-Message-State: AOJu0YwaDdRorfyRJDyZHEkNx/YKOTSUfffSM4sCY9uQIszsrEWZ4FHj
        RovbBlCNDh7CacCd/aXWEE3W+hmOZvc=
X-Google-Smtp-Source: AGHT+IFovwWv1Yj5++fmnrBflwz1Zss6jll9ULqcc/7Ir+YX2Y+g54+ysV3FRrfjxGcz5D4sLLOM7w==
X-Received: by 2002:a05:6870:c587:b0:192:6fce:d3be with SMTP id ba7-20020a056870c58700b001926fced3bemr11171904oab.1.1695753015811;
        Tue, 26 Sep 2023 11:30:15 -0700 (PDT)
Received: from [192.168.1.181] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id c26-20020a05620a11ba00b0076cb1eff83csm4916944qkk.5.2023.09.26.11.30.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 11:30:15 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] attr: attr.allowInvalidSource config to allow invalid revision
Date:   Tue, 26 Sep 2023 14:30:14 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <000AEFB0-0694-415D-94CB-9BB437E1A9FA@gmail.com>
In-Reply-To: <xmqq1qer7vrv.fsf@gitster.g>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
 <xmqqfs38akx5.fsf@gitster.g>
 <20230921041545.GA2338791@coredump.intra.peff.net>
 <xmqq1qer7vrv.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 21 Sep 2023, at 4:52, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> In an empty repository, "git log" will die anyway. So I think the more
>> interesting case is "I have a repository with stuff in it, but HEAD
>> points to an unborn branch". So:
>>
>>   git --attr-source=HEAD diff foo^ foo
>
> This still looks like a made-up example.  Who in the right mind
> would specify HEAD when both of the revs involved in the operation
> are from branch 'foo'?  The history of HEAD may not have anything
> common with the operand of the operation 'foo' (or its parent), or
> worse, it may not even exist.
>
> But your "in this repository we never trust attributes from working
> tree, take it instead from this file or from this blob" example does
> make a lot more sense as a use case.
>
>> And there you really are saying "if there are attributes in HEAD, use
>> them; otherwise, don't worry about it". This is exactly what we do with
>> mailmap.blob: in a bare repository it is set to HEAD by default, but if
>> HEAD does not resolve, we just ignore it (just like a HEAD that does not
>> contain a .mailmap file). And those match the non-bare cases, where we'd
>> read those files from the working tree instead.
>
> "HEAD" -> "HEAD:.mailmap" if I recall correctly.
>
> And if HEAD does not resolve, we pretend as if HEAD is an empty
> tree-ish (hence HEAD:.mailmap is missing).  It becomes very tempting
> to do the same for the attribute sources and treat unborn HEAD as if
> it specifies an empty tree-ish, without any configuration or an
> extra option.
>
> Such a change would be an end-user observable behaviour change, but
> nobody sane would be running "git --attr-source=HEAD diff HEAD^ HEAD"
> to check and detect an unborn HEAD for its error exit code, so I do
> not think it is a horribly wrong thing to do.
>
> But again, as you said, --attr-source=<tree-ish> does not sound like
> a good fit for bare-repository hosted environment and a tentative
> hack waiting for a proper attr.blob support, or something like that,
> to appear.
>
>> But what is weird about this patch is that we are using a config option
>> to change how a command-line option is interpreted. If the idea is that
>> some invocations care about the validity of the source and some do not,
>> then the config option is much too blunt. It is set once long ago, but
>> it can't distinguish between times you care about invalid sources and
>> times you don't.
>>
>> It would make much more sense to me to have another command-line option,
>> like:
>>
>>   git --attr-source=HEAD --allow-invalid-attr-source
>
> Yeah, if we were to make it configurable without changing the
> default behaviour, I agree that would be more correct approach.  A
> configuration does not sound like a good fit.
>
>> ... And I really think attr.blob is a better match for what GitLab
>> is trying to do here, because it is set once and applies to all
>> commands, rather than having to teach every invocation to pass it
>> (though I guess maybe they use it as an environment variable).

Between adding an --allow-invalid-attr-source, and adding attr.blob and
attr.allowInvalidSource I think I like adding the attr.blob config more.

>
> True, too.
>
> Thanks.

thanks
John
