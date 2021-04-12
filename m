Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6695C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C1661287
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbhDLU0U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 16:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237251AbhDLU0T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 16:26:19 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584C8C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 13:26:01 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id bs7so6491145qvb.12
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Ax4bpsdNaM8Op8meLEpyPoclOzaZl+v534HsmGAst4=;
        b=EmJbdkvj/MmoLLQo+2YFGIOO7adEA/yfnY9v0ADK7+pwLhOTvWKil546/+52vkOFCD
         gaxHFSLArL0Basc/1eW3KOs15MSjC7mPN4Xwoiuq/7vKs+/+9dbLTBZ/ZBo8T4LnhqiR
         G91Gwo100jxI+91JvxvYMd/PeQ2FESCjO3JNjKBwRSqxjBjf22G45j1l+9RfBa+ufKoK
         q7pSTOQHZCqa/6epzrORR265+wK9k125n4SLzd1WSIOEtfVkeb2z/wtSj7obqagdqNjJ
         yZrJDusAmy96ojOVDRcSSWawG4BwPdo17X07QdTSvriFmF4WFSuJfwRr3f3RiAgCNgiE
         jH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Ax4bpsdNaM8Op8meLEpyPoclOzaZl+v534HsmGAst4=;
        b=NTjPQ2BbKzmsVr+YAll/cx/xLBYm+teFllvCmiYghqWTu7bB4taF4SIvRjYRMbtXjl
         u0Dx4kzkXKLMo76ZO7uzJ8w52ZoxjFdaKKA8BTdtZHNjJ3t5Dx2KSHVbc76Cc5C9lXJv
         5CPGsBosekx0HeyVcUChlxjGpsGwK2Se+m0rjeg67ZebIgLu10Do6qPZUxskEs+vElE2
         H7q+5Tr+e8OJxUHkrAmXKwNHwAqrSVgvf2eXj8FM3Q0+Z1KO8aKOk/uYVhjZZnb9pfA6
         e5srEgMh3LgrAb8jC9FgM/n5kFmuzy6kPv0IcyPw1wAp8TWL7mfVEhvfO/w8hYrgKpQU
         Bp/g==
X-Gm-Message-State: AOAM5333GEMN/5RgXSsJfBuvmj3V3zFkleiJnxiq3NewSLFbAaRXG0TX
        GczcFGBMKRs7xZ3+ga/v4Fk=
X-Google-Smtp-Source: ABdhPJzmVTphPyoDu6gWZcywlwu5nl6j0s7J1FUy3kcsdlsRwVTa2FWMJ5s7wo1qcSlv4XozZk8v8g==
X-Received: by 2002:a0c:ac4c:: with SMTP id m12mr28928688qvb.35.1618259160482;
        Mon, 12 Apr 2021 13:26:00 -0700 (PDT)
Received: from US0059EMPL003.northamerica.corp.microsoft.com ([2600:1700:e72:80a0:40c3:ffa7:673:48b6])
        by smtp.gmail.com with ESMTPSA id n6sm8080164qtx.22.2021.04.12.13.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 13:26:00 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] Maintenance: adapt custom refspecs
To:     Tom Saeger <tom.saeger@oracle.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.924.v2.git.1617734870.gitgitgadget@gmail.com>
 <pull.924.v3.git.1618020225.gitgitgadget@gmail.com>
 <xmqqtuodiowj.fsf@gitster.g>
 <20210412164805.pxq7acln43gbggkl@dhcp-10-154-186-72.vpn.oracle.com>
 <20210412172423.rjwv7gozmnnzcaep@dhcp-10-154-186-72.vpn.oracle.com>
 <20210412174113.g5iv4muedcklg7mv@dhcp-10-154-186-72.vpn.oracle.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e7f09182-3b75-f2a3-c9c7-0055cc377a32@gmail.com>
Date:   Mon, 12 Apr 2021 16:25:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210412174113.g5iv4muedcklg7mv@dhcp-10-154-186-72.vpn.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/12/21 1:41 PM, Tom Saeger wrote:> 
> Less ugly fix...
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 30856b442b79..5fbffbd17d7d 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -576,6 +576,8 @@ static struct ref *get_ref_map(struct remote *remote,
>                         if (has_merge &&
>                             !strcmp(branch->remote_name, remote->name))
>                                 add_merge_config(&ref_map, remote_refs, branch, &tail);
> +               } else if (prefetch) {
> +                       ;
>                 } else {

I'll give this a try, but with "else if (!prefetch)" for the
last block,instead.

Thanks for your diligent testing! It's helping a lot.

Thanks,
-Stolee
