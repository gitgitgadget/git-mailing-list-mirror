Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63EDC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 17:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjBHRW6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 12:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjBHRW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 12:22:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3A30D0
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 09:22:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so3019695pjb.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 09:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=grDKVkGFlWXEpi18swCKeGkqfMkLiyiZN0JYJcUYi9E=;
        b=P5PHYsC0QIBamHttOsR1FULBWZeeG8q3b076F43UeEU77+17fBJ+AHdC3SK75ugvhL
         rFMYfZXxAFdqbmTyVkWZtBIidwTyreGgvppqwwiZzgHb6BZEetlyF89U6qIbLUAIbLLN
         k8kYMgHo2rEG1O9lsEkZSZxyKhBktIJfkI8LQ4Sswzw0WzsTygSn+3YNtPS/YtSqGQnq
         UeRbu3qOdlwdUSG8EnyAuLeY97LYxrP4jladqX+00b1Kxs3rrdp+4iZj4G1b6uRL9MtC
         BjmsfX2b6w4g9vfrTDFFBddYWNlI3CSeTQT3inPoTspOFtpGr+Plz8ojqZWZD075S6ST
         RmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=grDKVkGFlWXEpi18swCKeGkqfMkLiyiZN0JYJcUYi9E=;
        b=neqAiGFBeMAclA50zLC3qRm9gijdiOALV6dxMcStDyBgwoB52tb6AaX6SLkpjB5S1o
         lOU/ZviXWjQ7BhTSLtA9zhw0KQtSmcTDTSc6Aq3voGXpgY7Oaowegkzj8JUSNJ89eXnt
         JFN6kft/KpfA/5AvV5XRmvR0/3o4Rxv9WQhjkMgB808vhm8r+YIpVJoRYbCu4I4c5dWj
         GXvBO8UjsT7pXTMXcm9F9Hqlh9PI1CwoPo/hcZglbJ/Uge6eb5eP6BNIfAGVEImEFH0w
         rI/4tdY/gCu+1WES+xlVhjZV41mxtpAbADoKOuqozFUsSdWYhZbThtEO4OOLYKLaKacX
         u2kQ==
X-Gm-Message-State: AO0yUKX7Mffo2zFxz2e6ekkQFsBY7XgHzhvNOacfJBxfISbzDFcumZzw
        9+7hPp+cPEplbJqW4nvfCv6c1tYQrMeNhH9DIA==
X-Google-Smtp-Source: AK7set+yxzh1gwy3Di6AqA3Toblaj8fHvtWNIgRp8MBFkMZV9iKE7aE68IlyOkqEOGPBaz2VJFrIhA==
X-Received: by 2002:a05:6a20:a01d:b0:be:afe7:cde with SMTP id p29-20020a056a20a01d00b000beafe70cdemr8433749pzj.12.1675876974947;
        Wed, 08 Feb 2023 09:22:54 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id h1-20020a056a00170100b00593c1c5bd0esm11511128pfc.164.2023.02.08.09.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 09:22:54 -0800 (PST)
Message-ID: <4f48047d-50c2-5f59-82e0-dbafd3b380d3@github.com>
Date:   Wed, 8 Feb 2023 09:22:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: ds/bundle-uri-5 (was: Re: What's cooking in git.git (Feb 2023, #01;
 Thu, 2))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr0v7o0pp.fsf@gitster.g>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqr0v7o0pp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * ds/bundle-uri-5 (2023-01-31) 11 commits
>  - bundle-uri: test missing bundles with heuristic
>  - bundle-uri: store fetch.bundleCreationToken
>  - fetch: fetch from an external bundle URI
>  - bundle-uri: drop bundle.flag from design doc
>  - clone: set fetch.bundleURI if appropriate
>  - bundle-uri: download in creationToken order
>  - bundle-uri: parse bundle.<id>.creationToken values
>  - bundle-uri: parse bundle.heuristic=creationToken
>  - t5558: add tests for creationToken heuristic
>  - bundle: verify using check_connected()
>  - bundle: test unbundling with incomplete history
> 
>  The bundle-URI subsystem adds support for creation-token heuristics
>  to help incremental fetches.
> 
>  Will merge to 'next'?
>  source: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>

Apologies for not responding sooner, but I reviewed the most recent version
of this series and all of my previous feedback was addressed. Overall, I
think it looks good and is ready for merging to 'next'.

Thanks!
-Victoria

