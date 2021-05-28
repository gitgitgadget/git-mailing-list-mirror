Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB28C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 06:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5306135C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 06:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhE1Gb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 02:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhE1Gb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 02:31:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9121C06174A
        for <git@vger.kernel.org>; Thu, 27 May 2021 23:29:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id o5so3577996edc.5
        for <git@vger.kernel.org>; Thu, 27 May 2021 23:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ll87+/zNK4rlO7J+tyt85yNN+1b4q5yrhH9RFXWEFmI=;
        b=gA5v01lJReISJJI4119PeFcQTnWqQ+Fbird4I2SSEzeXOVbLjqjuUZjcredf13cT8R
         sw6JiVmQt7xu9EN4WdXGfy+jP28krqTkzRn+C93Fw6kbdCTPBttW1z8kAmM7gVXg0Kje
         th+Sn1ivYZFqMG4Jd1A2bbN6VYFS/8uSx02Woh4ImtASQFJu3PfKVxUj/CuBvw1fzeDl
         zkiC/qVwmm8VzAlTZMax3riKrT0yqbsMVZ5ggPyn38t5jfAaUiaTSH6WniR34JTWkQxp
         TAq0evtgKgKZZ2HA9DlJ7Jc2rtu81iHAjmRfO4lDxEgn29MEK2BUKbdJW067hhvFm901
         N2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ll87+/zNK4rlO7J+tyt85yNN+1b4q5yrhH9RFXWEFmI=;
        b=ImLeS9tA+gHZvz4OMDJDwbxQTty5Zef+l1o+77L3NpQOA2wwuB65wtZTIxtU1OPa2N
         pdXHtoh9LNkFgNE4sLTOdytkz5xKqCYvIrNEvMUYDAW6ovdeXX2pkXTIdwqKJjUayIWH
         b0dJTvhhmtd4Da3RBt5AWkBYYI4h4OC3n3Uq8r52eVYsLPIZXDQGB5jaA+/wMbioGA9x
         3mCNoEoLhkm3bjpzfdt5xu12Kffr7DrC+12OzMXIjzArfcycD0awZICt6F2N8q7DqrbB
         hjQRv8GJuzHJ1gSkcVrT8ZerMXCrqSopqeNN6cYE5CF3BtueeGkrvqGfJG2LYZdfzM8M
         o31A==
X-Gm-Message-State: AOAM533nOdRqaElu1UlRVKbWAg7xtQYPeUvdKOAz2Q+q3QIpqFm9/gQ/
        YtUir5tqvkCHutT4qlEH0KCXKRLr9aw=
X-Google-Smtp-Source: ABdhPJzoVGcbAcxixX6Qy3ro2Ki1YDRUsrPetzrjRtaVyl1t0+Wbk4m4nUx4ZeVrjL+xlJWWjbO/ug==
X-Received: by 2002:aa7:c693:: with SMTP id n19mr3755116edq.35.1622183391058;
        Thu, 27 May 2021 23:29:51 -0700 (PDT)
Received: from ?IPv6:2a02:8388:e002:8cf0:b0b8:f178:ae9f:6d19? (2a02-8388-e002-8cf0-b0b8-f178-ae9f-6d19.cable.dynamic.v6.surfer.at. [2a02:8388:e002:8cf0:b0b8:f178:ae9f:6d19])
        by smtp.googlemail.com with ESMTPSA id kx3sm1881726ejc.44.2021.05.27.23.29.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 23:29:50 -0700 (PDT)
Subject: git push doesn't use local branch name as default
References: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
To:     git@vger.kernel.org
From:   Mathias Kunter <mathiaskunter@gmail.com>
X-Forwarded-Message-Id: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
Message-ID: <fcf30899-8e64-5417-f478-14d6aca72544@gmail.com>
Date:   Fri, 28 May 2021 08:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3b9bc214-a30a-ba49-af96-7eeaf37b7bbd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-AT
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe,

thanks for your reply.

> Sounds like you want to change the default to `push.default=current`.

Yes, but shouldn't `simple` pushing also work? The documentation says 
about `push.default=simple`:

> When pushing to a remote that is different from the remote you normally
> pull from, work as `current`.

If there is no upstream, then there also is no "remote I normally pull 
from", and thus, according to the doc, `simple` should actually work 
like `current` in this case. Am I wrong here?

If `simple` pushing is used, it doesn't seem to make sense for me to 
fallback to `current` on branches which *do* have an upstream, but to 
error out on branches which do *not* have an upstream.

Cheers
Mathias Kunter


Am 27.05.21 um 21:51 schrieb Felipe Contreras:
> Mathias Kunter wrote:
>> Hi all,
>>
>> at https://git-scm.com/docs/git-push#_description it says:
>>
>>> When neither the command-line nor the configuration specify what to
>>> push, the default behavior is used, which corresponds to the simple
>>> value for push.default: the current branch is pushed to the
>>> corresponding upstream branch, but as a safety measure, the push is
>>> aborted if the upstream branch does not have the same name as the local
>>> one.
>>
>> However, on a branch which does *not* have an upstream branch
>> configured, the command
>>
>>> git push <remote_name>
>>
>> doesn't use the local branch name as default,
> 
> Yes it does, but only on the src side of the refspec. Something like:
> 
>    git push <remote_name> <branch_name>:
> 
> (invalid refspec)
> 
> Note the remote side is missing, so git doesn't know where to push to.
> 
>> Note that it *does* work if the remote branch name is explicitly specified:
>>
>>> git push <remote_name> <branch_name>
> 
> In that case git assumes you mean <branch_name>:<branch_name>.
> 
> Sounds like you want to change the default to `push.default=current`.
> 
> Cheers.
> 
