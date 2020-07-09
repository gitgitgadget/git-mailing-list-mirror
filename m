Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F1AC433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 13:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C16B20708
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 13:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozgqkidR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGINPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbgGINPh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 09:15:37 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5CC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 06:15:37 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so868334qvb.13
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HoSjdINh72KAOi6X9iwrO5L8H4vYcDkak9su/XzXQE4=;
        b=ozgqkidRYOz2Xm7f0K4NeyPpcQq3/6Ty+ff7um+KI2nmr4LFqTkZ1aLl4hOPplMAPi
         IaZWe7I/uKUtsFwqZq0+SWE0Er4bKgk06jrsSTlnXL47kHYJM6OF4No3L4iRHG/RSIEs
         hRWsFR9fkrAcetTAVwGxVIWmIXgFrdgeSzOZj+TluPp2cZrYhlyHvgBS+muLK99hOt3J
         Knl1idXNoT7667xPvHEbxc0vuessVLwLKzDG+YtFYbIgWb5rMd1anoxFDIUJGMZOUtij
         4VifUrXvc4yB3W479tPf9IZ8sBr7vr97q7JRJVTHae4iP63sOopqAW1z/VSuqQG3iyoj
         9+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HoSjdINh72KAOi6X9iwrO5L8H4vYcDkak9su/XzXQE4=;
        b=MhaREXmlvBHTBUdybDDuo6af7IC9OWMLHiccacelvQ+lFosuSio8+xmlk7IVotai9I
         UOkzQ0kCFrHW4IZSWjZzHVjvvf2kNCI8KuDzM21NEU0PjpjTgz5B56wBTW1lm5nY3ss7
         /YQBNncpewif17TWlFHN69CympWoiwpvz6opuA6yA9+5KR1A8EuD/0H5jXQE4gbq7ztM
         N0dG1C7qqc5aSbiiU7jF8+KP2yHCn7N+0eF+ortY/EkM//80IzKNlY+P3zNzQdEEmjlu
         twwxijY2O7a3pQrlZpncAVQtLwi0Tc505Q+Q8IZylVcm48+9WRlcvRA8aS133aS+BDxo
         TZXw==
X-Gm-Message-State: AOAM5307YRQ/qLupEWMz8jP0Q7fjvnklW6MHiK+7hq3u/IgzZSxPjl97
        TpI5qU3xrm9POxGAWXwKAdM=
X-Google-Smtp-Source: ABdhPJxSu+KJE8ODa+jjjr1VaeNXqTK2HgvF/5+bf/FP2DWNavWHoNYeKg4d/swirBIRnTjo+7H4pQ==
X-Received: by 2002:a0c:dc93:: with SMTP id n19mr60943763qvk.242.1594300536749;
        Thu, 09 Jul 2020 06:15:36 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x34sm3358675qtd.44.2020.07.09.06.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:15:36 -0700 (PDT)
Subject: Re: [PATCH 08/21] maintenance: initialize task array and hashmap
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, derrickstolee@github.com,
        dstolee@microsoft.com
References: <5cdd38afa60cdf768dd194f90ae0b2190123fdea.1594131695.git.gitgitgadget@gmail.com>
 <20200709022519.38407-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <329a6be3-df8f-971d-14ac-5d4f9377a25f@gmail.com>
Date:   Thu, 9 Jul 2020 09:15:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200709022519.38407-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/8/2020 10:25 PM, Jonathan Tan wrote:
>> This list is also inserted into a hashmap. This allows command-line
>> arguments to quickly find the tasks by name, not sensitive to case. To
>> ensure this list and hashmap work well together, the list only contains
>> pointers to the struct information. This will allow a sort on the list
>> while preserving the hashmap data.
> 
> I think having the hashmap is unnecessarily complicated in this case -
> with the small number of tasks, a list would be fine. But I don't feel
> strongly about this.

You're probably right that iterating through a list with (hopefully)
at most a dozen entries is fast enough that a hashmap is overkill here.

Now is the real test: can I change this patch in v2 without needing
to mess with any of the others? The intention here was to make adding
tasks as simple as possible, so we shall see. :D

Thanks,
-Stolee


