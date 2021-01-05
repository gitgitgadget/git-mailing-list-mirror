Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB99C433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA66E22CE3
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbhAEQqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbhAEQqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 11:46:03 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4846C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 08:45:22 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x13so243499oto.8
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 08:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CMaOnKI1QPZCGHFhJtj/yNte24SaoiGvIygjZQ53WUM=;
        b=kj9ErmWKrQAICuOsdAqadhMOD9clvCQL3mvP2QMX9CrRam/upaeFY5vHu5eINFL5jJ
         D3RFe3xI5D0aCn9AfSam9PNyojYrFqywzUndy1uFzCQyViWZaA4dFfyfdS2gO28Ylc/Y
         SlcZqnUfnXsyw7UnfKGIDgw6/jiPJXJygmx0C/eKIgFLrvOY7Xd/R6xlC9dZdfRfPUyo
         GN1ZSoZmELb4sEwx0AXEfDfaAMEvbgSo8GAttFYj9jTdBMDiIBVqWqevy7apay/MFmy/
         ZXHnpMA4DH3VPXMGTmI3gYvysBtebLcM3+cs4nJDRZnaWfN9Z0rX5spsjDCuPfNQEnH7
         hcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CMaOnKI1QPZCGHFhJtj/yNte24SaoiGvIygjZQ53WUM=;
        b=BdryrZd8LEBn46tVT2FbZcBqs9Qs0PtfXXyFE1W1XQy8Q3D0zu+NFzIoNhQZdo0IdQ
         MfltyV4J3L7BUwGmIEcT3DHrSwL10LPePbwTFjSPG9X0mx5gfY6XZpwfDXBMjORvHOYv
         jD8CjtOQPQlS1JZrhx7KsSUrthwt2M49iWdBMN2kRf3rJJzU88Eqv5MhTzuUSfa/q5QJ
         QeYD8r041Wljl/kv1bRGQw6Qun8ejRkGKwAvJskWvaP8C6NJVBazqADsPut87hxC25Zo
         BRISQtcNOeLlFcksh8ms7OUq44TGD7cP8mssbY87aK2LO8AUT90E7BcfEEP/BQqiU/DP
         PF5Q==
X-Gm-Message-State: AOAM530PHW0eCOLIl4uZTGOkKP6Rjj/3JkiByJ2vmm7McAIy4aZwkyih
        x8BLmKm+ueLC7cQrnyTk05U=
X-Google-Smtp-Source: ABdhPJwFAF8orHXJKPm1k7u4ZhR5uh9w65VgE5ldXn8R4pTpqnExzfQ2UBC+smQoUJznCb5b1ZzSOw==
X-Received: by 2002:a9d:3d64:: with SMTP id a91mr227875otc.144.1609865122082;
        Tue, 05 Jan 2021 08:45:22 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id v13sm3991ook.13.2021.01.05.08.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 08:45:21 -0800 (PST)
Subject: Re: [PATCH v6 10/13] merge: use the "resolve" strategy without
 forking
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
 <20201124115315.13311-11-alban.gruin@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8a0ce635-261d-3099-dc10-eabd7d41332f@gmail.com>
Date:   Tue, 5 Jan 2021 11:45:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20201124115315.13311-11-alban.gruin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/2020 6:53 AM, Alban Gruin wrote:
> This teaches `git merge' to invoke the "resolve" strategy with a
> function call instead of forking.
...
> @@ -740,6 +741,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
>  				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  			die(_("unable to write %s"), get_index_file());
>  		return clean ? 0 : 1;
> +	} else if (!strcmp(strategy, "resolve")) {
> +		return merge_strategies_resolve(the_repository, common,
> +						head_arg, remoteheads);
>  	} else {
>  		return try_merge_command(the_repository,
>  					 strategy, xopts_nr, xopts,
> 

This is a very satisfying change.

Thanks,
-Stolee
