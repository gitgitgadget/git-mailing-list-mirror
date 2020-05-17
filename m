Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55B6C433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A452204EC
	for <git@archiver.kernel.org>; Sun, 17 May 2020 15:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiWI2bSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgEQPV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 11:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgEQPV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 11:21:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D8CC061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 08:21:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w19so1325446ply.11
        for <git@vger.kernel.org>; Sun, 17 May 2020 08:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=doZGfPhPc2O0UZdT5ntMC61I+6z6rWqublwpjxm7o7k=;
        b=QiWI2bSRqgb48olt8cZr8Fnw/JutRezgIqksY73zuYow3qwg4sUds/ds1vydEslHGh
         stDGvnAu5oydcYlaijw4rpeaOPzWMCpiDqP/p1qTGGHOoL6nCHs+Lc+Qb3cM9flYBSBY
         RG76NTp9vfiyH6dZ9Mos16CXCAiiUBQ0ycBPHN3gcRm9EzecA0NXGjBxMU26WDigsp9O
         DIK+cX6Lz2y0nR/c1mxXooVAx4R2lBz0TDj5uYnMeqYC2jxWGV5ibr2nr/yrjseGYb2C
         ESuzLJ2KuAGD7LB6mefbMxHH4X46FGsQAAOt8NbnQ9sYUlnXaWa/6yXXRed3Zd9sbSHK
         u07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=doZGfPhPc2O0UZdT5ntMC61I+6z6rWqublwpjxm7o7k=;
        b=Ozxo6wgisZZq/fpu93WzfFfZJUru1sABtw52J5nS+RRO7ShcGCChLcC+yMsHYK36ZM
         i0OgXNjjP2gg2vFNyinhf4CW+E/FRK2c1lDM5UqwqB4wdlcS/U3yrHOuhbRbIs70fYix
         yt/cyUUtX73G6LaFHzh6ixYn2iF9eZH5fnZ8Xs8g4CzIP4CAnQvUiAWR0fqy6qeM4JNQ
         i6z9LwbDHbFC4BkhOrGkX0U38ehj/17GsyB64zMU2gY182mSGkBxxLDMce1j+xqOeKhr
         TcBU2NJ/EKfQWrW6DstAXHFkB3CI9iBrA/tc2O+Utc2mvKuQKy+YDq2wLYYEGg+u9+RH
         CRBA==
X-Gm-Message-State: AOAM533Flrg22FFjgjbIZ25C1tT0sSScsDqRRg0Pas1RoCSRo8fPVm72
        /LKoyw2+1vOqUXbpotgWKdA=
X-Google-Smtp-Source: ABdhPJwuOFJiINw2CzLKp9vEAq45hN0Pb27S/+JTvMDC602SCz3OL4vLN7T11owsQBIjdtyKWIy9wA==
X-Received: by 2002:a17:90a:2a0d:: with SMTP id i13mr2576720pjd.94.1589728886284;
        Sun, 17 May 2020 08:21:26 -0700 (PDT)
Received: from [192.168.206.104] ([117.242.91.225])
        by smtp.gmail.com with ESMTPSA id y22sm408557pfc.132.2020.05.17.08.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 08:21:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] submodule: port subcommand 'set-branch' from shell to
 C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, liu.denton@gmail.com
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
 <4e36c8a0-4f43-79f8-137f-5fd080066af6@gmail.com>
 <xmqqtv0e7g8q.fsf@gitster.c.googlers.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <b9c28f5c-d0da-7b54-7e9b-2e8cdce8b838@gmail.com>
Date:   Sun, 17 May 2020 20:51:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqtv0e7g8q.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17-05-2020 20:36, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> For those who lack the context, during the conversion of the script
>> Shourya faced an issue where the '--branch' argument did not work as
>> expected. He described the issue in a private e-mail where Christian
>> pointed out the following (quoting his reply hoping he doesn't mind):
>>
>>> On Tue, May 12, 2020 at 5:55 PM Christian Couder
>> <christian.couder@gmail.com> wrote:
>>>>
>>>> In your commit (in submodule.sh line 781) there is:
>>>>
>>>>          `git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix
>>>> "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet}
>>>> ${branch:+--branch} ${default:+--default} -- "$@"`
>>>
>>> Actually the issue might come from the above. I think it should use
>> ${branch:+--branch $branch} instead of ${branch:+--branch}.
>>>
>>> See: https://www.tldp.org/LDP/abs/html/parameter-substitution.html
>>
>> That's why Shourya mentions the '$branch' as extra. Of course, that's
>> how it is supposed to be in the first place :)
> 
> Perhaps all of that should be removed from the log message and
> instead go after the three-dash line then.
> 

I believe it's already after the three-dash line. The log message reads:

 > Convert submodule subcommand 'set-branch' to a builtin. Port 'set-branch'
 > to 'submodule--helper.c' and call the latter via 'git-submodule.sh'.
 >
 > Mentored-by: Christian Couder<chriscool@tuxfamily.org>
 > Mentored-by: Kaartic Sivaraam<kaartic.sivaraam@gmail.com>
 > Signed-off-by: Shourya Shukla<shouryashukla.oo@gmail.com>

It might use more explanation, maybe.

-- 
Sivaraam
