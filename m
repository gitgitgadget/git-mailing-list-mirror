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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317B7C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 06:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 076C160F41
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 06:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbhHKGMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhHKGMi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 02:12:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89802C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 23:12:15 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so1740631pjv.3
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 23:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lUoTCDZj2GnmQcRkfUeW92f3b9bS/jSUwR8AymP1xRo=;
        b=XM6lzttEIVVL3SEWvXm7ndOb4ZF2zoUBIPDdshhZySMhz7USx83oIsaruzMKwy8V8C
         dcW+geRZz6nO62+sfm2WCDfhPeWSlPtw7bnVejGiNlJ5XiMkmNbgvo10HMN1RHgZ3ysi
         oWw3B2UjMAyZsnxxQmj13tS0K7+KFvMwEiZ8aX8wpIuZm6fXvrZO2F1OPLfRxFzxxrmf
         47op5bZFMvDNFNwDs7+aAM6XDGhL893t2euu8ssFUVSAZUWo7YHX3ExMW0I1eD8yzd98
         u+C6VKq8q80UomXAjFQa+T1MzXd1AffD8LWFp2pTuPPBjEy8fLK3M9ouO9BtyEyTnacD
         tcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lUoTCDZj2GnmQcRkfUeW92f3b9bS/jSUwR8AymP1xRo=;
        b=HYa5Z/OIxPu/qV5yiHIoXywhIeyHBm1AZ2x0sl7QUBID5pkpTuJtfokQvA2v4lhSEV
         fOA7nRBkjeCVAs9rhmYIO+wT8Y75wrSsLKttfvKLP2Ulwkdtet0Z7oNwkRFNzvKRIVbe
         NhDP9YevXLLjL/34dI6Tia97jUMGA8KT98UWde9KtadSgwsvT6wKjXLxUlr0BLv0lMKi
         +H0FFsfAf4bjJ61MbSQwphk26yQltb5xGvKbhM11JR275ZN5XfxINVoPRMSzZ+7s6/Fh
         Jx2ACZqjjHRZBGlAbQyFfBu1muOS/IlMMR9a8V3YU/2YhEhw3h20GYi28OuC+u0QqeSZ
         rIYg==
X-Gm-Message-State: AOAM530ROgQY5PIa1vNeW+KnVGaG61t7PGyG2+ra68eGD1LJBaD4LPJh
        nQPH8lCKN0zm3+PP0INx5HE=
X-Google-Smtp-Source: ABdhPJwH2w334bgfJzpSFBKPTD8fkKQkkav3479Ysb3RntSlJuhbccfLrhuccgrcgKEGq/hLCQHflw==
X-Received: by 2002:a62:e405:0:b029:3c8:e5ab:ca94 with SMTP id r5-20020a62e4050000b02903c8e5abca94mr22344362pfh.5.1628662334999;
        Tue, 10 Aug 2021 23:12:14 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-14.three.co.id. [180.214.233.14])
        by smtp.gmail.com with ESMTPSA id j128sm27087120pfd.38.2021.08.10.23.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 23:12:14 -0700 (PDT)
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <20210811045727.2381-7-felipe.contreras@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
Date:   Wed, 11 Aug 2021 13:12:11 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811045727.2381-7-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08/21 11.57, Felipe Contreras wrote:
> @@ -12,6 +12,7 @@ SYNOPSIS
>   'git stage' [options] [--] [<paths>...]
>   'git stage' (-a | --add) [options] [--] [<paths>...]
>   'git stage' (-r | --remove) [options] [--] [<paths>...]
> +'git stage' (-d | --diff) [options] [--] [<paths>...]
>   
>   
>   DESCRIPTION
> @@ -32,11 +33,15 @@ OPTIONS
>   --remove::
>   	Remove changes from the staging area. See linkgit:git-reset[1].
>   
> +-d::
> +--diff::
> +	View the changes staged for the next commit. See linkgit:git-diff[1].
>   

Is it synonym to `git diff --staged`?

-- 
An old man doll... just what I always wanted! - Clara
