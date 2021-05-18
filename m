Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93599C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6A860231
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbhERD3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbhERD3B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 23:29:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A799C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:27:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t30so6024450pgl.8
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d+x/6QXUfFC/EOW/csIQeS1h3DvNWFA8kKzzZb9Ik8w=;
        b=WxybXpvyYNvRD3Sc27Fxr+/po4nBOAnYOyFVUJ9xXN9r7IENsaUxjuXXEWowljuShG
         kLvypd+yovSTpYoh/YWpWBQLCvJ7ulPvsPP5V8csjwjfTaQ5SKTotg/RfjUx8zZY6+B4
         iIh5+ropEOITAit0jqpVWtyheOAnIM5E6PCxCY/+9Grn/WrDgomTBHskkmU0ya77p7xM
         PPEiSzHwc/fwywLu+z8Eaun1fkO5tba7WOAZM9jGMe2ci5yI2FeX8MMcy3X3XDZC08Xs
         xxpwURoXBSMVydz47iAnKaSDarG0CgARMdzJ5n8YUVaMxWmZQEuFwtlUjPGQYv37AEta
         tw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d+x/6QXUfFC/EOW/csIQeS1h3DvNWFA8kKzzZb9Ik8w=;
        b=oVd9xHPu53L3Rouy5slZjaW8GQpwIfvx8kE3jWYMjuL81RyJ5y2C2013x7kS91FBJ2
         FPRuhyHlUr1JETgpVoEoWjb68m6gogVvnu1hbzJNK1IvKAvTICe6XhVW8iEHUG3AAz6y
         gVq+MqyPZVJ3l+pGyrnKbkdnw+za6ZNsP31lJTIoVDfSFWqtNBufnj8Am5FZNOrElYV6
         i2H+CplfHeTIu0IAm8Vd2tvJ60HkfHqEtDp9ZUjX2rxuJYvh0sQboApgGL8QSW3L4nCA
         xBeoeK3Ob8JqTUbOH1sTN2YogfvjTMMls7jb7+1EX/azd/GE859459eXGs76uozcvUR0
         U+Eg==
X-Gm-Message-State: AOAM5326r3lK0+rJyG8dN5iPg874NjordvEUN+0B82qiIWzWfJgxjfe1
        Zi3tC57SQ4IRjBJpe1KG3vY31ySBlKhzT64j
X-Google-Smtp-Source: ABdhPJz1PiELKvB+GeJB/u+TlxFSkj+s8dWAtIpdD4tXtSDHs8Mdkue4DwYU3sUGCSkrfL7WHxr56g==
X-Received: by 2002:aa7:8686:0:b029:2db:7eea:8fb4 with SMTP id d6-20020aa786860000b02902db7eea8fb4mr2822868pfo.34.1621308463572;
        Mon, 17 May 2021 20:27:43 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-88.three.co.id. [180.214.232.88])
        by smtp.gmail.com with ESMTPSA id cv24sm11709995pjb.7.2021.05.17.20.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 20:27:43 -0700 (PDT)
Subject: Re: [PATCH v1 2/9] t4013: test "git -m --raw"
To:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
 <20210517155818.32224-1-sorganov@gmail.com>
 <20210517155818.32224-3-sorganov@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <1a78e837-13a0-f9bb-1ee2-a54534af37b1@gmail.com>
Date:   Tue, 18 May 2021 10:27:39 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210517155818.32224-3-sorganov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/05/21 22.58, Sergey Organov wrote:
> This is to ensure we won't break different diff formats when we start
> to imply "-p" by "-m".
> 

This patch, and patch 3, have the same commit message (and thus the logic),
so these can be squashed.

> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>   t/t4013-diff-various.sh          |  1 +
>   t/t4013/diff.log_-m_--raw_master | 61 ++++++++++++++++++++++++++++++++
>   2 files changed, 62 insertions(+)
>   create mode 100644 t/t4013/diff.log_-m_--raw_master
> 
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index e9f67cd24351..1809355f9bb1 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -337,6 +337,7 @@ log -m -p --first-parent master
>   log -m -p master
>   log --cc -m -p master
>   log -c -m -p master
> +log -m --raw master
>   log -SF master
>   log -S F master
>   log -SF -p master

In near future, we will switch default branch created by `git init` to
main. Had the test be prepared?

> +:100644 100644 7289e35... 992913c... M	dir/sub
> +:100644 100644 f4615da... 10a8a9f... M	file0
> +:000000 100644 0000000... b1e6722... A	file1
> +:100644 000000 01e79c3... 0000000... D	file2
> +:100644 000000 7289e35... 0000000... D	file3
> +
> +commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:03:00 2006 +0000
> +
> +    Side
> +
> +:100644 100644 35d242b... 7289e35... M	dir/sub
> +:100644 100644 01e79c3... f4615da... M	file0
> +:000000 100644 0000000... 7289e35... A	file3
> +
> +commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:02:00 2006 +0000
> +
> +    Third
> +
> +:100644 100644 8422d40... cead32e... M	dir/sub
> +:000000 100644 0000000... b1e6722... A	file1
> +
> +commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:01:00 2006 +0000
> +
> +    Second
> +
> +    This is the second commit.
> +

The rest of commits only have commit title, why do this second commit
have also commit message body?

> +:100644 100644 35d242b... 8422d40... M	dir/sub
> +:100644 100644 01e79c3... b414108... M	file0
> +:100644 000000 01e79c3... 0000000... D	file2
> +
> +commit 444ac553ac7612cc88969031b02b3767fb8a353a
> +Author: A U Thor <author@example.com>
> +Date:   Mon Jun 26 00:00:00 2006 +0000
> +
> +    Initial
> +$
> 

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
