Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B683EE49A4
	for <git@archiver.kernel.org>; Sun, 10 Sep 2023 22:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjIJW6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Sep 2023 18:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjIJW6q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2023 18:58:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F5188
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 15:58:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31f8a05aa24so1591852f8f.1
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 15:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694386720; x=1694991520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Qe4uwz7z3/07dWaW9ZKJ7IjFUjX+/RorK2AyIz24hI=;
        b=nzpo5xiOfnx9lQPYueu2KhVrevz5oTpxLDVHBUNd/Oh8750KmLC4+gv2JYQTRIqm1B
         xODSTOQqGUOtrnJM9Li8PmlydbhiafObJn6b6t7q4NwWxxbD6RGSMj0OGF6JjpXtJCsp
         4LViOQu8nlmMD6x6LZI8Nz9AdHRZjrKC9JdCHm+1QlPzr3iDEgydqcJmk/LmTd8MYaG4
         Ic9h/wYFTHU76FiU7LAiQWNN5M8UucXqTUHB+8HE6+O50IZHr2fB5FvZJULoxz4dz2+Y
         i39M6LGCO6tC4UTjL1+3TkVC8c0CoWVSwQq18YaCTsasDiy1JtaYB81ZTyMKrOLcwlv8
         hJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694386720; x=1694991520;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Qe4uwz7z3/07dWaW9ZKJ7IjFUjX+/RorK2AyIz24hI=;
        b=tH6EIHAa0ZmMBH93YVdm1erfNCHNwIZEu0XIyDufr+EVuVTOeE5tfIOIn2c3kufLXR
         6sZS4qWjxfL9bsOECCQ8aXYhNo9dS16llPTOrJhn+g5n5AlxqtABkwEo5Uqe2tg+X7oU
         J5YCVhs7SH8DGiqHtG9O5Juk86Va29Xhm21eYwOlRY67zE+M5dQs3/QnZ9NKgfKvwtd2
         k7qdB5pF1wFt0KJ9UPa9YSdC0bZx4pQxtrY8nfiKK3sKEhwVIgvHQDHj3MMQOZAZsA2X
         yO7lNKLC2d77vw5QJbUKO6dyBY5Pfd43wZrehzs3ZHEJYPN7QYyqlPU73j+vMc3DBlO5
         yFKQ==
X-Gm-Message-State: AOJu0YxsCjfp/qsOrU91mIq1chOzFuupAGGZj+2jsZAsiFwFQmxXaNwZ
        1iJSAkNhXrubG1r4elxO1M7m2ZIRgBo=
X-Google-Smtp-Source: AGHT+IH7ejnpyx5+oB1cuYe6YxefLv5yVMEIxtz/LH+RTQQbuhlM62OxRBRxIXfKneCMybBuDke/Kg==
X-Received: by 2002:a5d:65ce:0:b0:319:6d20:49c7 with SMTP id e14-20020a5d65ce000000b003196d2049c7mr6386336wrw.3.1694386719580;
        Sun, 10 Sep 2023 15:58:39 -0700 (PDT)
Received: from [192.168.2.52] (203.red-88-14-40.dynamicip.rima-tde.net. [88.14.40.203])
        by smtp.gmail.com with ESMTPSA id l18-20020adff492000000b0031f729d883asm8308305wro.42.2023.09.10.15.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 15:58:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] test-lib: prevent misuses of --invert-exit-code
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
 <1a60a1ca-0ef0-ecf5-d0aa-a28d7c148a82@gmail.com>
 <CAPig+cR+rZ4+Qyfz5YQVMixW0oC65iOzxymwOaUnPqSTVScW7g@mail.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <577cc92e-9f21-55a8-7389-5f94b1ae9a98@gmail.com>
Date:   Mon, 11 Sep 2023 00:58:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cR+rZ4+Qyfz5YQVMixW0oC65iOzxymwOaUnPqSTVScW7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/23 3:59, Eric Sunshine wrote:
> On Sat, Sep 9, 2023 at 7:08 PM Rubén Justo <rjusto@gmail.com> wrote:
>> GIT_TEST_PASSING_SANITIZE_LEAK=true and GIT_TEST_SANITIZE_LEAK_LOG=true
>> use internnlly the --invert-exit-code machinery.  Therefore if the user
> 
> s/internnlly/internally/

Thanks!

> 
>> wants to use --invert-exit-code in combination with them, the result
>> will be confusing.
>>
>> For the same reason, we are already using BAIL_OUT if the user tries to
>> combine GIT_TEST_PASSING_SANITIZE_LEAK=check with --invert-exit-code.
>>
>> Let's do the same for GIT_TEST_PASSING_SANITIZE_LEAK=true and
>> GIT_TEST_SANITIZE_LEAK_LOG=true.
>>
>> Signed-off-by: Rubén Justo <rjusto@gmail.com>
