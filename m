Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0FEC433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 06:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D92A619C2
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 06:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhCYGXN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 02:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhCYGWm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 02:22:42 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67282C06174A
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 23:22:42 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q5so957588pfh.10
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 23:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VCKkh/a7na6jxobubZBxQkQ5LmttQ71iMp6VkoO+Ymk=;
        b=iSX6886D702kLoKbbHEQCHhHicDaPBnJxL0qRCJkgd5uzLPrzeOxjrT4ZsdRmvdZe/
         em3n8CMQOaC6yXEELCQL+nWh496ifxlhOv4mjuIKbTb+nkRzOQnn9G0MILM+r6UPpVza
         mapevOnMxYFOQyrWYMmUaYMwoSixlYw8/B0PkoH32hW4zoJRXNjiqF8Oxk74UaNpxTDc
         nXPHoYAU+8llxyjRWW6xnFgcAIfBvetP4RM2mQlQnmcD8UHeTIgJEtZJ7TChNhUEQtLc
         Dd5zoiMfucOIitSWhyNYc4apyT9jJQEMB2oK5EQQuxbFZheccMzVXtKXDIa88n4KJUsT
         TPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCKkh/a7na6jxobubZBxQkQ5LmttQ71iMp6VkoO+Ymk=;
        b=mD94pXjzac5eA0nVYFP0sAWi3gwVlTk3P4Nw4+CtEW3IJOVhSJWIWj5pulmgit5C9P
         jynt3gAf6Lv5JyZN4+R5AL3Y3sXRjuxwaDoxKvz7fEnxfgNSMhvP9Kc8E4/yxnN2gE8w
         3hEQnAed1aKRs4UDPMALyng6JXFHK8+pWEH6FtmSOxwbYOLzkfzfc5h3UI9B8StqNjLl
         kiUqrfYlG9pWi9ViQDCIb8nvamR8vqKQG1i0Ki/M/5yo7Cyxy4G98ia+dje+pWPFZjX7
         Sbs5E+zdzSyARca1G4C1INHXHDNsJXtY6pdTJuuTKjbm8xZesNucZqFonq2lue50wW5f
         a87g==
X-Gm-Message-State: AOAM533Vg7XhW2j7gRGlLGIsVNhInJWw8Tz10sz9Y4J1hE1W6GQ8Jh0I
        U2lU9tTx9vw4fa+wZhO43gQ=
X-Google-Smtp-Source: ABdhPJwx4hG93qkSB5X5iK1WlGyv1YuTPOYDb3VVzg+ZuvNDOwMU2CJuDrDPsJ2Sr4+Se/MMcqTTYA==
X-Received: by 2002:a63:1266:: with SMTP id 38mr4567598pgs.427.1616653361899;
        Wed, 24 Mar 2021 23:22:41 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-30.three.co.id. [116.206.28.30])
        by smtp.gmail.com with ESMTPSA id k5sm4673352pfg.215.2021.03.24.23.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:22:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] git-format-patch: Document format for binary patch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210324123027.29460-1-bagasdotme@gmail.com>
 <20210324123027.29460-3-bagasdotme@gmail.com> <xmqqa6qszbdv.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <678c0fa9-8ae5-f8ae-b93a-3d68c7c11c8f@gmail.com>
Date:   Thu, 25 Mar 2021 13:22:37 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqa6qszbdv.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/03/21 00.53, Junio C Hamano wrote:
> I do not think this is all that useful; it clutters the description
> for a reader who is not interested in reimplementing an encoder or a
> decoder from the document.
> 
> And it is way too insufficient for a reader who wants to reimplement
> an encoder or a decoder.  For example,
> 
>   - It does not say anything about what the delta is and how it is
>     computed.
> 
>   - The 'z' is redundant; the more important is to say that the first
>     byte signals how many bytes are on that line and it is a mere
>     artifact that we cram up to 52 bytes on a line.
> 
>   - It does not say anything about how the binary patch ensures that
>     it is reversible (i.e. can be given to "git apply -R").
> 
> Thanks.
> 
Hmmm...

I write this patch from "naive" observation of git format-patch's
behavior when given binary files in the commit.

Perhaps someone which is more familiar in base85 {en,de}coder and binary
patch in general can write better documentation than what I send here.

-- 
An old man doll... just what I always wanted! - Clara
