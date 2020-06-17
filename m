Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE40FC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B628920679
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 08:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0cXFBck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFQIO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFQIO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 04:14:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F66C061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 01:14:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d66so739959pfd.6
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xG3rartFlyyBWeIhg9IlDCaYJQwyz8UX1EbEDhvy7uk=;
        b=n0cXFBckH/E1nydzhjKIRrAC9WS2JDRm4Xt0HT2hxquw9aCW+X+x8JXYO/p6TJGQxv
         DqTJe28qUnQtDRS/220NuISOUn9z4+uTPqoXoYxvb6DQ0EwM8CdpjDUI2jgWjwqiOItZ
         3NegTOBy7M23kzHnCAqRV/gzvn82WTJFZRUOVNaAzNpNLRXZiAHu5x560TnfQzt+5LnM
         dAQNtNbHdiy/MCOKFO30nYZ4LdahdqMQYBXXRcDdR15s/MMKShTGAtOTnVUgXZWerQLA
         mxU2JDtDZ+DpzUY8OXP1zUqeJ+/QL+SslOaJwTl07auOu2QM1oKVto2XkxKwb0tt96x9
         Y8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xG3rartFlyyBWeIhg9IlDCaYJQwyz8UX1EbEDhvy7uk=;
        b=bpjYckEOsTxT8Dr820PjmCF/Xo5RRV0J2E/UR1+HUMPAiERW7i8sWZylqv/zx8CsfE
         EeXWX1f7OC8rKiXhNJnhGNtqcMv06ZZhjLgh4uDSNGuHcYq0nsNM0HDHAlXx5tWIo5K6
         Os/sYiomZ3t23NlPjo1m1HJMfEnRYPXGa7Pl61KowszKxDUhYVIitNtCN8zFQOzqis2E
         o2vtf4kgINICmhUBf3isqU2+XskqoYY+FQQ99WWvWTzIwl1+28AMr/c9moygMq1CK57l
         wikbmUF8romhxMwaaOkz6iMUN1X7M8l5bN12Gb8YEqJlqCq71jxpgsfaEIO8cWiU8ZOe
         UpxA==
X-Gm-Message-State: AOAM530OQ8KSCH7gj9NlG8GWqT0CsHarKxObAqZ9UTl0Pu8jz+Dph3f4
        zGZCys7GkWaIsXXl3es4dbI=
X-Google-Smtp-Source: ABdhPJzPtbDWHwnWtxCoMmTcNk+4wnRHTHpASGBUS5GTNFwjwFpt0ZS9R0JgrvyhEg5GJlZ5yxcrJg==
X-Received: by 2002:a63:541c:: with SMTP id i28mr5638869pgb.344.1592381668794;
        Wed, 17 Jun 2020 01:14:28 -0700 (PDT)
Received: from [192.168.208.37] ([49.207.128.224])
        by smtp.gmail.com with ESMTPSA id c9sm20046519pfr.72.2020.06.17.01.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 01:14:28 -0700 (PDT)
Subject: Re: What's cooking in git.git (Jun 2020, #02; Wed, 10)
To:     Shourya Shukla <shouryashukla.oo@gmail.com>, gitster@pobox.com
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
References: <20200617080740.GA11006@konoha>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <c360cc01-939d-11fb-b462-21dae3d7badc@gmail.com>
Date:   Wed, 17 Jun 2020 13:44:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617080740.GA11006@konoha>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17-06-2020 13:37, Shourya Shukla wrote:
> Hello Junio!
> 
>> * ss/submodule-set-branch-in-c (2020-06-02) 1 commit
>>  - submodule: port subcommand 'set-branch' from shell to C
> 
>> Rewrite of parts of the scripted "git submodule" Porcelain command
>> continues; this time it is "git submodule set-branch" subcommand's
>> turn.
> 
>> Almost there.
>> cf. <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>
> 
> I think we are done with the porting of 'set_branch'
> https://lore.kernel.org/git/20200602163523.7131-1-shouryashukla.oo@gmail.com/
>

A more relevant reference that addresses the mail mentioned by (cf.)
Junio would be:

https://lore.kernel.org/git/92bad281-dd38-aef2-9910-659b41cdd830@gmail.com/

... I believe.

> Could you move it to 'next' please?
> 

-- 
Sivaraam
