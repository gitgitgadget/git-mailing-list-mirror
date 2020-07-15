Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E21C433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DB820657
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekcnuOeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGOSk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgGOSkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 14:40:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B68C061755
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:40:55 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so1347312qvb.13
        for <git@vger.kernel.org>; Wed, 15 Jul 2020 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RbxOUS8Bqg0M5fNohV2Qq1miGaXNWXvFMsOS13/5upE=;
        b=ekcnuOeOxcun4miLhAEPuq1F6W96JV8Fo+t7t9GiTQmSaWCtXNJwkgq3kbSPIjow3W
         F8/lIbYtan5t7UiuKaWJTUwrMSSp3rntkGqleiTPAmELZ9NuJMsNQGqaE0AMp1t4m6kq
         GeTOSQUWe/TD/NPWMHH+g9qff9BKFwD0A1/t/UYUYSivYHmudCKNimMB3hw7TG2EbeY+
         +N7CUyOIyu6nJpv5ww231HOunshm71tynNbQN43M6k0vjX6o9EkhSyTdamjTuZFq/hVr
         bhChW12lBgwIGkIclvNo4PkuDj+oUMTR3cbJflUPEZ5Mkib/VImpwkAlGxQYv/QvBFT/
         I2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RbxOUS8Bqg0M5fNohV2Qq1miGaXNWXvFMsOS13/5upE=;
        b=UUmBK8+pOr50zX4C/l1WWjvPNu7YCBXVXAhjMmTKofe+0WjTzvI2hHW6Q20CeFZjr8
         MWxHTSOASw2CCEZLxg3dv373kc2H4BzKAwPI7PUbnEvTMc1BmLrAd5iH8BbtJG9B2Hlo
         deeIA7hwFfL/n+cSCjNbnTU3VKy5m4VZ4uOrrkCZ5hvQZR1PTiK4uh+qfBgVavMWZF24
         YkZpuTyp1T905KUzm6Oza0vDTVTCg752hnvFbneLutUbZ8YtVmEbJf/sE2N8IkS4XLMC
         HNwNod1ZHgUGxVYxBpmItvLvSbWfYalAMMWNCGGQW7iQjEq2JODpm9LIJGMS9qTypmHm
         LP9w==
X-Gm-Message-State: AOAM533SURq5hREE8XbHKVxVIeDiZD4DeoRKIEaWPON29+pRX/K6CXhQ
        /oY95MHy5+cwMjgiBhqUZRqx0URYYHs=
X-Google-Smtp-Source: ABdhPJyH9Ba3s4/ZhcF4CCDOIdZiyqtelTV5u1ujxyuOPEkOmfhiTbB8CTkSYOXBS46AauuavXbPHw==
X-Received: by 2002:a05:6214:734:: with SMTP id c20mr721886qvz.118.1594838454292;
        Wed, 15 Jul 2020 11:40:54 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c80sm3572436qke.26.2020.07.15.11.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 11:40:53 -0700 (PDT)
Subject: Re: [PATCH] setup: warn about un-enabled extensions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <xmqqlfjkk8zv.fsf@gitster.c.googlers.com>
 <31f52913-8745-18b4-63fc-37d2a9aea8d0@gmail.com>
 <xmqqh7u8k5va.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3544e544-0ed5-c2d7-ff25-ad6d9349905e@gmail.com>
Date:   Wed, 15 Jul 2020 14:40:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7u8k5va.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2020 2:09 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> Your previous diff had this comment, which I thought to be
>> helpful: 
>>
>> +		/*
>> +		 * Extensions are added by more "} else if (...) {"
>> +		 * lines here, but do NOT mark them as allowed in v0
>> +		 * by copy-pasting without thinking.
>> +		 */
> 
> Yeah, but it felt somewhat strange to have it at the end of one
> entry, like this:
> 
> +			unallowed_in_v0 = 0;
>  		} else if (!strcmp(ext, "worktreeconfig")) {
>  			data->worktree_config = git_config_bool(var, value);
> +			unallowed_in_v0 = 0;
> +		/*
> +		 * Extensions are added by more "} else if (...) {"
> +		 * lines here, but do NOT mark them as allowed in v0
> +		 * by copy-pasting without thinking.
> +		 */
> +		} else {
>  			string_list_append(&data->unknown_extensions, ext);
> 
> 
> In any case, I updated the comment in front of the if/else if/
> cascade to essentially say the same thing, and with test updates
> this time.

Thanks. I applied and tested this version. LGTM!

I'll also review Jonathan Nieder's patches when they arrive.

Thanks,
-Stolee

