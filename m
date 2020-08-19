Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92190C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD622083B
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ4Pnmwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgHSOvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgHSOvc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 10:51:32 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3337C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:51:31 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id f19so13466435qtp.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AU5S+WZNVq04TDak6d+kuQghpBeaMo5OuryaXsE6htc=;
        b=IJ4PnmwyRehD9/6ARA2uoAQlzpAciSLn4UKN/pzgkhwA1nYhRu667YwesFZuLBeBQN
         LdTPuiDODmfFVih7cInKrYVe6yvY/0d3TYLjc/ffpD7ss4zVHwADRgkdtrRbolBBH6Li
         srKRcj3OyXSnYkGI60h5u5Ko8pXgFbPF86ht8moRGlORbDm74n6ExLiw/NuQeT0kS5PH
         JOiUCsXjqlYac2bp5hGQhAhZf7LDK3hiyR1ZtHF37XcqDB7NwI71nmrLut7dyH3yaKtP
         2zKun4YuH+t87beFJKUI5mshVHy+m30Dz6Ajd0BL4mjLpsdQEjaA5mf8KmsbfZdCkjYz
         OObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AU5S+WZNVq04TDak6d+kuQghpBeaMo5OuryaXsE6htc=;
        b=kJuk8wdi+57UrFZQsO/02VSFqUEO82hyjzTH6rD5cr4/ivyZZahM6Vg3/RS6tu5HZW
         AMDR8rXciBNXYoKzkyMJDCuaFENm9zCe4Xc01O1BoJhxv0YapW0xWtRSs8dy2hmEaexZ
         7EFjhf0t/TCtPuNvkc3c+rVANlhoAbA2aYO8MMYJ0NoZ9gHh29RL8VGYO7RLs+5dJyVE
         vyF7QDd/VhF3C4v0TE5kV0fWiw5l8Wfteag0y2d8AjrbH1lCq0fmm/rbbyFbsUVFwzZd
         9/cwdE4Vm4iMKljotr4vXj/L653q04m0o4MZ8QYt67AncShxydkeOyEWCC49NPlGV4k+
         eJvg==
X-Gm-Message-State: AOAM531aRgiYEzmTcBgvel7cgWYtkH32Ggu0zmXGHONNfvgtU9BEuq/d
        f/7CNHSVC1eT8ZUeUEipkyM=
X-Google-Smtp-Source: ABdhPJwFcUmiSZOtN0ZOvJAYKf4AkckOPUUp3aV451GXFRjFfXuudGbIhl7Ckp/dXkt/6DxoqTj4Ug==
X-Received: by 2002:ac8:306f:: with SMTP id g44mr22899245qte.177.1597848690806;
        Wed, 19 Aug 2020 07:51:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:641b:4ef3:c176:5ed3? ([2600:1700:e72:80a0:641b:4ef3:c176:5ed3])
        by smtp.gmail.com with ESMTPSA id t127sm24966705qkc.100.2020.08.19.07.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 07:51:29 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] Maintenance I: Command, gc and commit-graph
 tasks
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
 <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
 <xmqqa6yryag0.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0d69af08-5d90-aa3c-80d5-2eb2ade57f8d@gmail.com>
Date:   Wed, 19 Aug 2020 10:51:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6yryag0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2020 4:18 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series is based on jk/strvec.
> 
> As jc/no-update-fetch-head topic seems to be getting popular for
> some reason, let's do this:
> 
>  - recreate jc/no-update-fetch-head topic with patch [1/9] of the
>    maintenance-2 series directly on top of 'master';
> 
>  - fork ds/maintenance-part-1 topic off of jc/no-update-fetch-head
>    and queue these 11 patches;
> 
>  - fork ds/maintenance-part-2 topic off of ds/maintenance-part-1 and
>    queue its 8 patches [2/9 - 9/9].

Sounds good. I will update my branches before their next versions.

Thanks,
-Stolee
