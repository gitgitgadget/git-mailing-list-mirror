Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED354C00528
	for <git@archiver.kernel.org>; Sun, 23 Jul 2023 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjGWQ0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Jul 2023 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjGWQ0f (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2023 12:26:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D57199D
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 09:26:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so3137668f8f.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2023 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690129560; x=1690734360;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rb2CapuY7NkdyvjCYvxjTRP2RIo8/EEvBhYWvIwy70Y=;
        b=RkyDr99aYOD1Tam7tYlLT+stX7NdZT9mpjsCu/nS1bynwM7Wgg+Abqln0y7FeTJAdQ
         Lhu/MR6rz2pqiX0rjhVRSwJIx/xKcxorumWpBpKwDUIa2AF2CiyMeaxNgX83nvUufRvK
         Z8QHPDCv2/dPuZh90qXg4pZQPQF70LGo8nTz4rVDC5XX7wnuAChWhsjhhoNM0k0Xoxsb
         VmFyfzx3L0pGDyPXxGk/bwh3m7axP8zd+ahzODqI9aHKugjdOsSJNs71Jc67mYEqmpk6
         u3hkhIBczFwn8eB7rApzSBGoTbVDp8pmTZzErcyfsHgCNH2b7ArdlhnGD+hFMD3GyHIO
         l1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690129560; x=1690734360;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rb2CapuY7NkdyvjCYvxjTRP2RIo8/EEvBhYWvIwy70Y=;
        b=l3Hx1muA0SmPYN54mV/mLvxzXwWkw5c9znPUlZeUfdraAg4nGWmEE3+kfSC4CvVJ7s
         cLl/KnVqdp29WgxQCO/84rQzh5YS7NCEWudfWhN2FXbfghP2Ro2mj8vpBnNCTFNmUD7T
         lm6FOea9W1HY+D3CVfzhTvjCN9GZbROAmRyby7nzLI5KkWhnHzo8lTUrrRfHz/LTTWkC
         v7xO4xAHvDImUxjS4pd7Usabr9yv4uuuI1ohGYUdB2iPLYp7sajEqaWht3mNalSvheOv
         8YCzMjpfvuktjyJeWpOWCdxbB48r0+PjZjrR868Xcly3eVFbgLitjqfreMQP1Nzb/HPT
         KCyg==
X-Gm-Message-State: ABy/qLa41hYDwWU/KWvjswdsjBnTXtjtvWMZSycD0cQv9E1fjn6gPtsJ
        dCX3xYSNzJP6uwYkvwspLlf51Nm/n49/tA==
X-Google-Smtp-Source: APBJJlHjpR8SwaMPh7xrOjOCu5+eP2BT5yWzswODZf6YUwQ249GOuGOlvGFfaqQQ51JMU1NXfXj/AA==
X-Received: by 2002:a5d:6783:0:b0:314:33a2:78fe with SMTP id v3-20020a5d6783000000b0031433a278femr5998615wru.29.1690129560091;
        Sun, 23 Jul 2023 09:26:00 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id l19-20020a7bc453000000b003fbc681c8d1sm10780769wmi.36.2023.07.23.09.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 09:25:59 -0700 (PDT)
Message-ID: <783011d8-53ea-15cb-a9c7-6cb0c15bd5aa@gmail.com>
Date:   Sun, 23 Jul 2023 17:25:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>, Andy Koppe <andy.koppe@gmail.com>,
        git@vger.kernel.org
References: <20230715103758.3862-1-andy.koppe@gmail.com>
 <20230715160730.4046-1-andy.koppe@gmail.com>
 <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andy

On 19/07/2023 19:16, Glen Choo wrote:
>>   	case 'D':
>> -		format_decorations_extended(sb, commit, c->auto_color, "", ", ", "");
>> +		format_decorations(sb, commit, c->auto_color,
>> +				   &(struct decoration_options){"", ""});
> 
> I don't remember if C99 lets you name .prefix and .suffix here, but if
> so, it would be good to name them. Otherwise it's easy to get the order
> wrong, e.g. if someone reorders the fields in struct decoration_options.

That's a good suggestion. I think this would be the first use of a 
compound literal in the code base so it would be helpful to mention that 
in the commit message.

We've been depending on C99 for a while now so I'd support adding this 
compound literal as a test balloon for compiler support. Ævar reported a 
while back that they are supported by IBM xlc, Oracle SunCC and HP/UX's 
aCC[1] and back then I looked at NonStop which seemed to offer support 
with the right compiler flag.

Overall this is a well written, well motivated patch with a good commit 
message.

Best Wishes

Phillip

[1] https://lore.kernel.org/git/87h7e61duk.fsf@evledraar.gmail.com/
