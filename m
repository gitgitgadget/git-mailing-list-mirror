Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA27BC4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 02:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDA322D6F
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 02:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgLTCOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 21:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgLTCOE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 21:14:04 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B566C0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 18:13:24 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id c14so4428126qtn.0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 18:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zNt0Q0ZM225bI5AyABOt5EpDbY0H62aHOS6cgDzAP2c=;
        b=lFqKWyHhoKE4WbkmLn0FQhqFfE2IIOG8DEq2IgLOmdjCidPYR8u4EP9154vznz6Jyb
         HOc28hr2t2vtnJRBMBVsbeDq6tmdYuNw5CfKnqj/HtMilZKqktNVLQWzjj214zV2yfjH
         +7FwYGFGePUhEv8ufIYpJnFxQSLCwWXqhPtunk0MO4bR4khVnnZVKcIbM0Yiz0jbZqU2
         nwzQc2KNCLejRoB+gQ6j/QMaepoaeqIviFeN2H5sW7bxFcK4wvIWWNQWBU7fAQftqJdN
         yiPdFuQfZoeNExRuUfUsunlBTtKmHo5dKYNVItxGQGsC7YZTQXzCk3K5kTNw63Jh8BU0
         FgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zNt0Q0ZM225bI5AyABOt5EpDbY0H62aHOS6cgDzAP2c=;
        b=W9zvy0CmVCc/ztF1h+wXEF16OE5ILstUm0H1DYhhERfIQ96/h+/V3A0jvup4MamRPO
         uZR997stXQF+Cjt1e9xn9XurumMseaIv9XoIUwX2jIuqCGX+iVoZfOaQ4kC++FOLdhUv
         XmCI6qOdv0M5nwnIUxsdut4JMmq3WuGSdSZJ+pDY7Q40KfXUpW7dCPJiDI4IV3A6/wEN
         mVpASwmvQ5/kHxTKdUwvbFPYDjqPGip4FFRQ3fJFFiU2TcvcJG5r7sGjio45p+PSI1HY
         tYzQEATgzpo+HgcgVJtYjoEQNyrbj4DPEhL/efuc0DjYE0vLiBMP2UxVY9RJsE98T5To
         TbZA==
X-Gm-Message-State: AOAM5314HpM2pQWXq7b/K1h5htXg6Lr3uke+vOxUM5xvVy6zRXEvvNz4
        9uX12ls3aCmgKX7DHcHB7Ek=
X-Google-Smtp-Source: ABdhPJzqwV1zLarkT8XuA3mxr4tXnq9cFVyxIQZ4mskZ4xS7LtlSr2vKnLZgu7eSKH2QOmW2R1Zy9Q==
X-Received: by 2002:ac8:5a0f:: with SMTP id n15mr11500893qta.88.1608430403081;
        Sat, 19 Dec 2020 18:13:23 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id g10sm8679790qkb.8.2020.12.19.18.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 18:13:22 -0800 (PST)
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>, pudinha <rogi@skylittlesystem.org>
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
 <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
 <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
 <5fddeda8a5a92_1de0de2088a@natae.notmuch>
 <xmqqsg81pvm8.fsf@gitster.c.googlers.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c4f2330f-715b-1745-5ad7-5477f4e833db@gmail.com>
Date:   Sat, 19 Dec 2020 21:13:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqsg81pvm8.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
Hi Felipe,

Le 2020-12-19 à 12:13, Junio C Hamano a écrit :
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>> How about this?
>>>>
>>>> --- a/git-mergetool--lib.sh
>>>> +++ b/git-mergetool--lib.sh
>>>> @@ -46,7 +46,7 @@ show_tool_names () {
>>>>                  while read scriptname
>>>>                  do
>>>>                          setup_tool "$scriptname" 2>/dev/null
>>>> -                       variants="$variants$(list_tool_variants)\n"
>>>> +                       variants="$variants$(list_tool_variants)"$'\n'
>>>>                  done
>>>>                  variants="$(echo "$variants" | sort | uniq)"
>>>
>>> Ah, I didn't see your variant before sending mine.  $'\n' would work
>>> with bash but we prefer not to rely on bashisms here.
>>

Thanks for both answers. Felipe's solution does the trick, but Junio's does not;
it seems we do have to have a newline there. The following also works, and I think
is portable:

diff --git i/git-mergetool--lib.sh w/git-mergetool--lib.sh
index 2defef28cd..6f03975493 100644
--- i/git-mergetool--lib.sh
+++ w/git-mergetool--lib.sh
@@ -46,7 +46,7 @@ show_tool_names () {
  		while read scriptname
  		do
  			setup_tool "$scriptname" 2>/dev/null
-			variants="$variants$(list_tool_variants)\n"
+			variants="$(echo "$variants" && list_tool_variants)"
  		done
  		variants="$(echo "$variants" | sort | uniq)"

I figured out what was different between the different Ubuntu versions I was testing:
the Ubuntu 14 and 18 systems have Bash as /bin/sh, but my Ubuntu 20 system
has /usr/bin/dash as /bin/sh (the default for Ubuntu these days).

I'll try to send a formal patch with the diff above, time permitting...

Also of note: I was wondering why 'araxis' was showing up in the list of available tools,
as Araxis Merge is macOS and Windows only (!). Turns out that the imagemagick package installs
a /usr/bin/compare symlink to /usr/bin/compare-im6.q16, so since Araxis merge is registered in
mergetools/araxis::translate_merge_tool_path as 'compare', it ends up in the list of available
merge tools... I think we could do better here but I'm not sure how.

Cheers,

Philippe.
