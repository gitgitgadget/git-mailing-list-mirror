Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEB7C433E1
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55FBE20882
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 15:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQILJCpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgHSPKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 11:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgHSPKj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 11:10:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FD8C061383
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:10:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b79so21845539qkg.9
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ucYtYXUcWPnvcMJgGQer9qaxdDSfVsge+uKy+dot8aM=;
        b=pQILJCpdyuKIp93UeTwUW+C7+TB7NjVeU6w8ndycksG5yymYrrvFitMnzxYBC21yMn
         j3cdtkhHIZKQKsi5a0EWc7Uhu8+vHRSfmK+2JeltgmqAQjLAaA9z8G5FFie4/ggP+hag
         2mmzsIVzZp7jbcI6UZ1gKtvX3vEfRUk8eO+v6RHyZ14mNbo0ntwIZOBc24SS5OFfbJCj
         1vpyiySay03xLFl74k8FIszRzFDG3m+UBwZc2DTJtG/Z3TCpRh+tnXvJJnQobD6EUO3u
         RI/5x1af4yLCZSbf1x0tM+5HQbEOI6Q+kTEC/9UOQSKFA0N7gTMsih4Shn39fYADrVZh
         qp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ucYtYXUcWPnvcMJgGQer9qaxdDSfVsge+uKy+dot8aM=;
        b=cFD0647I5ieudR/BbtHH3ovAA/xf8QTsPWmOenZkmXl6ou+eZZe9lYrCDJyQckHh7W
         V/x09RB9jiBmFR8EKYLN0hVsFAzO9x2Diz8pnXBi9pcRXj0z1v2JcpNq5RaE2pe7dJ8R
         YV41e7FzyIhUfCz3wA8dU63mKAVbt8OfPogjZ9zLdLPCQ/NbBR1PGeTIprAC2NB49SnY
         huw1gxvjHrW6oWyXwdrmShWffYi26QD02WcxHDmcaCLGT2bhiWu5EQreoANkIOETB1ac
         3x+uKt30ATmrL4u3289M7gsD1dMaqtLrnHqgM2UAhFE8MDYzXYtMggIq8ZkNrLthInrG
         XT0A==
X-Gm-Message-State: AOAM531wGihNgi8T+gTrIjVica6Mpg3ENiJwk+sFdwX/ZssMPqNY4b8u
        MNwOjbynEEXEhAO4gf3GIPM=
X-Google-Smtp-Source: ABdhPJxzdiSvmUAZ1L0+6Gq4wt+kdNhw30X7+jcfEmKau2kUtyUqKa4JIg6XEsxxvmCN8t8Z37YhMw==
X-Received: by 2002:a37:674d:: with SMTP id b74mr22186209qkc.84.1597849837795;
        Wed, 19 Aug 2020 08:10:37 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:641b:4ef3:c176:5ed3? ([2600:1700:e72:80a0:641b:4ef3:c176:5ed3])
        by smtp.gmail.com with ESMTPSA id z24sm23251898qki.57.2020.08.19.08.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 08:10:37 -0700 (PDT)
Subject: Re: [PATCH v2 07/11] maintenance: take a lock on the objects
 directory
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        derrickstolee@github.com, dstolee@microsoft.com
References: <6f86cfaa94cfeaf7a2af417991ca07e41b6b0c3d.1597760589.git.gitgitgadget@gmail.com>
 <20200819000425.2840491-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2fb1fdf2-54b1-4597-4b58-96208bebeb6b@gmail.com>
Date:   Wed, 19 Aug 2020 11:10:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200819000425.2840491-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2020 8:04 PM, Jonathan Tan wrote:
>> If the lock file already exists, then fail silently. This will become
> 
> Maybe "skip all maintenance steps silently"?
> 
>> +	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
>> +		/*
>> +		 * Another maintenance command is running.
>> +		 *
>> +		 * If --auto was provided, then it is likely due to a
>> +		 * recursive process stack. Do not report an error in
>> +		 * that case.
>> +		 */
>> +		if (!opts->auto_flag && !opts->quiet)
>> +			error(_("lock file '%s' exists, skipping maintenance"),
>> +			      lock_path);
>> +		free(lock_path);
>> +		return 0;
>> +	}
> 
> As it is, this doesn't seem very silent. :-) If we do want a message to
> be printed maybe make it warning instead of error.

Sorry, it is silent when "--auto" is specified. The commit message needs
to reflect this properly. This could easily be downgraded to a warning.

> Other than that, the idea of having a lock file and the implementation
> in this patch look good to me.

Thanks,
-Stolee

