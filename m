Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB858C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 23:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703DE2065D
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 23:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PedLeKxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFMXxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 19:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMXxb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 19:53:31 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96703C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 16:53:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id l17so12502244qki.9
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 16:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ajMm5jJKNH3nSQCxyMYEAJVJRh7+ID4CF698pnRKVrY=;
        b=PedLeKxqmaQkuH0X8pRwH/utYNSLWZXtUvJ0pEt3XAqoH+GJE+tBDA81vAMfjyGCdb
         t6iZufFKUao1ASH72xD1m/GpC85MPC4AXYfExLNC4iMf0hDSbrJPXQklDWdOZPOj9iDf
         zdHQAec78o3yuqzHKl/D3JTsTM/YsDEJ/69ckamXfoYRYHaApaVXmeBRAuvLRwr4GAX0
         RxCsoDP6nFnuoP6TEjT63EKDtFL2rhH3ry0SCulWtgc9jnCTwv3ALZYTtOrf2W4hiqPj
         +kZlQuTw+oEs+t06mvgcqKDK4tluIvgsPMef3cVwmAFWWw4So6qN5u3JjxHXXGYgU6mX
         RibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ajMm5jJKNH3nSQCxyMYEAJVJRh7+ID4CF698pnRKVrY=;
        b=bN3BSWIsSBoR0AKQH7SOGefUIpeJIcl9erhtQCFXGOvAm8/1E8gcXF7pjSZ1PV2ZT/
         MKV9lMhxAHoC/NKi9aKpomdGJ4Hqfu0B6qxb1zdn8SRAxSAxjnHAMmlNk6ALPmUXKJ8R
         E1ppcI2Jhpb5jtTzXd9wtCnS5IURUeCnerL9NrcQefr7G97E+vpOoWnLQFtoLnQKGm4y
         mgZsKmLbepFZY3tb4pJF5AsTAJOn372tcwBQEbcDdWWvTDh5JgfM/rSY9qvMuEgSiVqF
         WQpWV48mVEYbTKGnoGG50C6JIx0QrR04wu5l0rQjyW40tJ/ViuUFzUd2CQrpBKB2UUop
         a4xw==
X-Gm-Message-State: AOAM531cvbBru79Su+7oylChzj07/h58QY2A8nMUvd6E0iJD1Y0W40Tn
        gXSqxkv8uTiYpmfL5YIEn36iMBtX
X-Google-Smtp-Source: ABdhPJyNLixmBBGuiaLrf8gOlyTS9XLyFpoMpQppDGbjZctI2GXahqNrcGiacxPavmM7rgsSNwIsfQ==
X-Received: by 2002:a05:620a:24c:: with SMTP id q12mr9487961qkn.172.1592092410037;
        Sat, 13 Jun 2020 16:53:30 -0700 (PDT)
Received: from [10.0.10.179] ([170.79.184.212])
        by smtp.gmail.com with ESMTPSA id i40sm8939225qte.67.2020.06.13.16.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 16:53:29 -0700 (PDT)
To:     simon@bocoup.com
Cc:     git@vger.kernel.org
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
From:   =?UTF-8?Q?S=c3=a9rgio_Augusto_Vianna?= <sergio.a.vianna@gmail.com>
Message-ID: <9accf436-4b7a-2de2-de79-e81ec090dfc9@gmail.com>
Date:   Sat, 13 Jun 2020 20:53:26 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The perpetually offended strikes again. It's very problematic to let 
people police other's language. This is something literally out of 1984.

