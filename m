Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CBDC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 16:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2301D6195D
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 16:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhC3Qg4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 12:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhC3Qgt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 12:36:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A4EC061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 09:36:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w11so6454097ply.6
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 09:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=1GxjyxRtSfuplB56Q/Vd/JOS+ycy2LBivx3d8hjJNKQ=;
        b=jBBK/WHh6Tm5FhInIG+8RiHXh4uuhr5ZCA/4rg4X+Oe2cFA/0hjk6NIFywCqkpFqQM
         FUeQKZ3IkNRAtPtpbGTAkTEMna0yhSKrD1Pltcbcd+Op57Ce7y8XzUw5jhW9/WE45JfO
         7Y6/8098fJ7Ya+bIAtK4fUu8wTALi+j+aIwvn3GpgdPtaComS5bPUXOBtfqhU+FtXQPW
         jJulvbL4MPTbgMsqYfXymj0ATKSvgYGyysKxrZuPpAVku2hJGI3u2y0fB1Qc+0Rps1Qp
         vLUw4VTBph7EQua2+gYro8wah1u0Q6nA/ZKmQvfrU8xWfZAZbBgleVpWyu+K6Z+ZXtQ+
         kAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1GxjyxRtSfuplB56Q/Vd/JOS+ycy2LBivx3d8hjJNKQ=;
        b=YqRcOSsf6vF/Hv4mhL/mZk8clAO0la3Tnx1s/eAuP5pdsBAgV31G3I+mgk7ul4uAiZ
         zshw4pSvMnwk3YUXIu3YOVZh0FvBYGxu9eRbtk1Jd13+ZaivSFdyEd69V/tqB4p2C/nA
         3X7TIC7ozwQozCWkoH4KTRVXN4IxcEVka9HzuxhGRil+H/IspFRhpixiCWX8KzYAmAja
         inYazGmkKbfmEIXOPICf4uuc1BlxKebKv/a7omV2xgRNAvJDKvPYlFfL0zrVlzS7tUWM
         kOaGlq2UUYo0b7KSDDRr0czhcDvHCzTzI0i+KeibBmh2iGCX2BhwjW9hF3rh9gDlPSxp
         AmtA==
X-Gm-Message-State: AOAM5312whU+bFGKsO399l1NJpmF6k1iGhs3h6M9RAeMk6rhVRnWmYcN
        huOjVJVyZlUKUMByeuX6wj4aryvRUV8O0Tk3
X-Google-Smtp-Source: ABdhPJwOAUnzhS4TdLj5To5mGYs397P3B/BGN9BZ3aRJiaTlLVMHzdbJZJumKUE53lO2/Z6H28LSlA==
X-Received: by 2002:a17:90a:d507:: with SMTP id t7mr5223124pju.54.1617122208671;
        Tue, 30 Mar 2021 09:36:48 -0700 (PDT)
Received: from [192.168.10.22] ([125.21.249.98])
        by smtp.gmail.com with ESMTPSA id h7sm19410105pfo.45.2021.03.30.09.36.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 09:36:47 -0700 (PDT)
Subject: Re: [PATCH v2] Documentation: updated documentation for git commit
 --date
To:     git@vger.kernel.org
References: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
 <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com>
 <xmqqim59irba.fsf@gitster.g>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <f0200d12-2c0f-ee36-551f-f8133a4dea20@gmail.com>
Date:   Tue, 30 Mar 2021 22:08:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqim59irba.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 3/30/21 2:57 AM, Junio C Hamano wrote:
> All of that can be read from the patch text.  What an author is
> expected to explain in the proposed commit log message is WHY.
>
> Why is it a good idea to list possible arguments --date can take?
>
> The reason can include "because so far they are not explained
> anywhere."
>
> Documentation/SubmittingPatches::describe-changes, especially
> [[meaningful-message]], is a good source to learn what a title and a
> proposed log message of a patch should look like in this project.

Okay I'll update the patch with proper commit message.


> I am not very strongly opposed to extending the tail end of the
> existing contents of the file, namely:
>
>      ifdef::git-commit[]
>      In addition to recognizing all date formats above, the `--date` option
>      will also try to make sense of other, more human-centric date formats,
>      such as relative dates like "yesterday" or "last Friday at noon".
>      endif::git-commit[]
>
> and explain what "such as ..." is, but I am fairly negative on
> teaching 'tea' to our users before we talk about 2822 and 8601
> formats.  I actually think the above three lines strikes a good
> balance---we do not want the users to be surprised too much when
> they see "--date yesterday" to work, but we do not particularly
> want to encourage them to use "commit --date noon" [*1*].

Okay so I guess it's better to just extend the tail of the file

to explain a little bit about the relative dates and leave

out the Easter eggs and formats like 'noon' and 'midnight'


> Likewise.  I am OK with adding (see date-formats) but against
> listing the easter eggs as if they are more important than other
> forms.

Okay I'll just add the (see date-formats) and leave out the

exhaustive list.


>
> [Footnote]
>
> *1* The approxidate is useful when a rough "around that time"
>      specification suffices, e.g. "git log --since='last.week'".  The
>      user is OK to see commits down to roughly a week old, and would
>      not be upset if a commit with a timestamp that is 9 days old
>      shown.
>
>      On the other hand, it would be unusual that somebody cares
>      enough to use "git commit --date" but yet it is OK that the time
>      recorded is fuzzy.  For that reason alone, I am in general
>      negative on the direction this patch tries to take us in.

So according to you, is it a relevant/worthwhile change

to add in docs?


Thanks.

