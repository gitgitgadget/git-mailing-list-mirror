Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1DDC5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 13:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5484220731
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 13:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7zlW8N7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKVNXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 08:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgKVNXf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 08:23:35 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15845C0613CF
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 05:23:34 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d20so4154930lfe.11
        for <git@vger.kernel.org>; Sun, 22 Nov 2020 05:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WcZg4uR5A0Upfbv6ih/aMzL5v35K3U48EggaLkQbAvo=;
        b=k7zlW8N75T/WROF6ApYL8kd8pBS+u/3US8iFzMQ/Hv/uDrnjad5oxhWWUBOS87bwRn
         LBnvaGSj3w6fi8fXlQMM/xE+KNNXOxCsgTOaTjEcmvZAZ6KxibDItz1XsCAzftXjlfNk
         uGuZzf2qOw7V8XUPyl/5zpoOocOVxbkpFnhcy/lyDXXkSTuNCFgPJl5KeBnTeE0uD1vn
         8Bt6QmUZDH057BlQVPwpF/wWeXfpM4uEf5ckNzofrZqhu1zkDIw7mKQd8fc3X7FAdj5L
         92svHdbtP4CvbRTTLxoCXwd+MwJTYSAeoGb9OlPCGmFkTJUKthhC5JQ+YtpQ/I/rfYta
         8gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WcZg4uR5A0Upfbv6ih/aMzL5v35K3U48EggaLkQbAvo=;
        b=un+5eW16cSO/TKqwI+lpbEHEqaRann4nOXtxuzDY1naqKGOScMnbTfgvvgVU5klZsl
         SAZ5kbulssMsHOi3TDqgk5o3GGonQYCvYvKSHaPbfTBbdEX3AjeTfOeTf02vFlX+hT+c
         /GVWu+cw0yXLDKMyIH9UZjtvxPEZ4FMhNS+w9f3IphnzaAdMB3A9wCY4Erk7x7Z1Kkdb
         g8I/VkdnE6E4BdDyWGY8LeGDtq40bKD/x/i7Ls/n0HnI4fEc4HUvgglq36Gku7THCn2O
         az/SeRCG/faA+msHKO83t3iQ6NWLKHcamAm3WBU4QPOSruMagsOouptxxjD/qpLpPicV
         ti8w==
X-Gm-Message-State: AOAM531PYdVYLDJxiCi38J9IQ02Yt7Y45I91/2hwoIwKvsZqM6uyf5sP
        ye/x6NlZxRMVaheQW0wHeEc=
X-Google-Smtp-Source: ABdhPJzDCdpZWyuyWAOAu7sYJhGSfXYwrsjxL7jzItg7CTsMXOh+DVPbLF1COgt4TH7ObgnBlGzNsQ==
X-Received: by 2002:ac2:4c9c:: with SMTP id d28mr10922404lfl.278.1606051412275;
        Sun, 22 Nov 2020 05:23:32 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r12sm1074930lfc.80.2020.11.22.05.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 05:23:31 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
        <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
        <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
        <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email>
        <871rgpr497.fsf@osv.gnss.ru> <xmqqpn46qppl.fsf@gitster.c.googlers.com>
        <87y2it8zfm.fsf@osv.gnss.ru>
        <9be54e8e-a702-0eb9-97c9-7a1fac82ed5d@iee.email>
Date:   Sun, 22 Nov 2020 16:23:30 +0300
In-Reply-To: <9be54e8e-a702-0eb9-97c9-7a1fac82ed5d@iee.email> (Philip Oakley's
        message of "Sun, 22 Nov 2020 11:20:26 +0000")
Message-ID: <87zh397cfh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 22/11/2020 10:21, Sergey Organov wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sergey Organov <sorganov@gmail.com> writes:
>>>
>>>> To me "not on a branch [tip]" is also confusing, as in fact you are, as
>>>> is easily seen after you perform a few commits, and now HEAD points
>>>> directly to the tip of the branch (that has no other references).
>>> Aren't you confused about what "on a branch" means?
>> I believe I'm not.
>
> Isn't this one of those "implementation detail" viewpoint arguments,
> combined with some incompleteness in various places.
>
> From a naive english user perspective , 'on' a branch can also mean
> anywhere along a branch and not just at the tip. Being at a commit along
> a branch can be tricky to appreciate (that on/at distinction isn't
> immediately obvious..)
>>
>>> After either of these two operations, your HEAD may point at the
>>> same commit, but the former is on a branch (the master branch), and
>>> the latter is not.
>>>
>>>     git checkout master
>>>     git checkout master^0
>>>
>>> The difference between these two states does *NOT* come from which
>>> commit HEAD points at.
>> Sure.
> From an implementation perspective one can go two ways, and we tell the
> user which way we went, even though, ultimately, we look at the same
> commit.

AFAIU, the only difference is that HEAD points to the commit directly in
the case of "detached HEAD", while it points to the commit indirectly
through the branch reference in the usual case.

>
> Though, for an unborn branch we don't have a null commit value (c.f.
> empty tree) to help in being 'detached at nowhere'.

We can pretend we have a null commit for the sake of regularity, even
though Git implementation has none.

Actually, it looks like a few things would be easier if Git got the
"Adam" commit that is the ultimate final parent of everything in the
first place, but it didn't.


>>
>>> The difference comes from what happens when you make a new commit
>>> starting from that state.  The former (i.e. you are on a branch)
>>> grows the branch.
>> Sure.
>>
>>> The latter (i.e. you are not on a branch) does not grow any branch.
>> That's one way of looking at it, resulting in this "detached HEAD"
>> thingy that is too technical for the git user proper, I think. Moreover,
>> it immediately raises the question: if it doesn't grow any branch, /what/
>> does it grow?
>>
>> Another way of describing it, that I prefer, is that you /are/ on an
>> /unnamed/ branch and new commits grow this particular /unnamed/ branch.
>> No need not only for "detached", but even for "HEAD" to be known to the
>> user to get the idea, I think.
> I don't think we can start like this and continue with a commit on top
> of the orphaned 'unnamed' branch. (Not tried it though..)

I rather believe we can, no problems, and that's why "detached HEAD" behaves
exactly as unnamed branch would.

To make it obvious "detached HEAD" is in fact a subset of the usual
case, imagine that "detached HEAD" is rather first implemented by
pointing to a branch reference with a hidden name that in turn points to
the commit, and then this "incognito branch reference" is optimized-out
as being invisible anyway, so HEAD now points to the commit itself.

-- Sergey Organov
