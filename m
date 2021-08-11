Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F3FC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0017E60F11
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 10:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbhHKKAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 06:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbhHKKAX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 06:00:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF65C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:00:00 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so3752851pjl.2
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sRgclx519awl47EGO/LkIBOsTg30tHSwX7E/0N5Oeso=;
        b=jRUl8fM15aKo+2MuBepbUnYuDLtYtFXjjuuU/UNrZz01fmyjZcPHtMTIveADZRNPX/
         VhTkByLct59KqLm+iOt7GL6EWHCzevVkkwyqbu59Zi/ZNgjDkB60lr9PJ01h9KkmmsiW
         p6zhhlJqw6o5uZcIm+4REstbNzbHlbBZ//Z3iWExyzssS05PYBhBfQK31wtPWrjP0G2O
         Z6nwrhvBQlKwxhyMEq712mT98kMBaTYqSnb359EtjMw7nRMMExDKcnwGD8H0bkHof2L/
         WAyriF5wKbWAoI+QVXHGEZ0Gz1PBVuwpYnS8Io9sKCJ+BWeUPd0DLju/oatWhKRkLYxK
         s0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sRgclx519awl47EGO/LkIBOsTg30tHSwX7E/0N5Oeso=;
        b=BfKJyt9quJli/AX/nrNlwwmHdgKDBxlfFrwGC/Ta69UbPXGwCcAwfFvUFLT4W7RKVX
         UlZgGjTe6c0pVDyI/M/7Y/QmPWyvPK5OElqMtjyYVBc5T9Htb8T6T6koReZAq8dLO/g3
         JDkWDXobRcERaI2SW3loIo38qxVi+sMjIFbXS3n6B+oZAqGrEhjc9LiEGdK5PFjKnNMc
         uIaukm0gTKAnrCk1KjRAqL0BINGLEJ3AIPhmPEnVDiUorlaJPgt2CtXgGMho8QfFE+dL
         uSk0Mbzysk9m+iD6CvXwgpYPkO0gO3i1lV9g2DCkwR8O8dSINHbWb6gv8lC2okSS7hJ5
         mDGg==
X-Gm-Message-State: AOAM5330szTvXgzq/x+pH23ObV/533Th9ncjtKzQZ46vEIzIJdpQ6ORh
        szNAT6CBtuPEppF1lBqnFm4=
X-Google-Smtp-Source: ABdhPJwckdDQyQznu5924P+VaNgVxJyjBf/zspBFzQ3xS3Bk/i/ON9Wz962sLjLhBO0AqP/RzeHnzw==
X-Received: by 2002:a63:f44a:: with SMTP id p10mr189757pgk.11.1628675999520;
        Wed, 11 Aug 2021 02:59:59 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-65.three.co.id. [223.255.225.65])
        by smtp.gmail.com with ESMTPSA id b8sm25115049pjo.51.2021.08.11.02.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 02:59:59 -0700 (PDT)
Subject: Re: [PATCH v4 5/7] packfile-uri.txt: support for excluding commits
 and trees
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, jonathantanmy@google.com
References: <cover.1628666093.git.dyroneteng@gmail.com>
 <8e5bf4010cb0d7e8b4f6c7285fe1f5365af955e8.1628666093.git.dyroneteng@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <5c6739f2-da8a-ae68-188d-5bb2fbe76ad3@gmail.com>
Date:   Wed, 11 Aug 2021 16:59:56 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8e5bf4010cb0d7e8b4f6c7285fe1f5365af955e8.1628666093.git.dyroneteng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08/21 14.45, Teng Long wrote:
> +The old configuration of packfile-uri:
> +
> +	`uploadpack.blobPackfileUri=<object-hash> <pack-hash> <uri>`
> +
> +For the old configuration is compatible with the new one, but it only
> +supports the exclusion of blob objects.

I think better say "The old configuration of packfile-uri ... is 
compatible with the new one, but it only supports exclusion of blobs".

-- 
An old man doll... just what I always wanted! - Clara
