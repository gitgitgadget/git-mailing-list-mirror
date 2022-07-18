Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E1DC433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbiGRNJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiGRNJR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:09:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1325A12D07
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:09:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b26so16983230wrc.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=idw5F4ihiqT9fao3wSxA0bl/C9ECqqkSscBG+BMh2ao=;
        b=M3X1tJtyt4iT/VadfRRteERCFCRechRmsGUkuICxuin88xSmO78vLzjKlgyNdXEXQ6
         WI6S+eIKhzhv9E+JICNfz8llz/4eO79A9ASiU/na+D16Y0x5wFG3s1FTl0QytuAdiMQu
         N+9WL/VG6NsfhLosSiUn54J33HtIRB9Cq15JB1m0h2vzt0FdwxnAozDsuLRngUYNcEjC
         2emGi2o8DgrxqAcipqfK0EgeoK4oj7/f8zmZhTdJkYfv7jVepp0KaAcY4fU9Z5WL57Tz
         VrLvpQzMb4ePgwPNW+oJ3xgUfUn7+cNxOY8Th7OvY0soBAfv35dWKMJ+G046hZVYNF1M
         HnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=idw5F4ihiqT9fao3wSxA0bl/C9ECqqkSscBG+BMh2ao=;
        b=hup/tyMyI4UnFnDQEHN5IticYPdEfA4Ar2m9YBeghbjEoOgNZ74+Jrg8szNWzetYNq
         k18hfiW9EzZppoQvmzTPOcXpJmU1s1j1qmlo6HRzftugmXaGX4QIaErYOD4IXzlhFHR5
         GnquLyIBoMJiAEhxL/gNn0o/Ps7WDNYaIGte503ac3VhESQHDD467MA1ZF3xXtYEXec/
         UjR3A5HPddQ3MF6rLRcuoycOAgA6UIiNbilZYa9HCrv9RD9eAfU8ZB8bv8QznNfsDOlg
         WGxtJqaWlXczV3WPuu6cwjji72gPCCodaZNHqLoN4hwgkoUlHcgP0hTrnCsq4iICtzHE
         1wZA==
X-Gm-Message-State: AJIora8hz/lRzRMENK4sqg7LiStq8a7KV+D0MG8MblUgXVho6Ls9EXZ/
        4ghD7YSWgBYSRTIy75JmNhI=
X-Google-Smtp-Source: AGRyM1tzinf3zY99/3eV0tS/5EkUhIBR2paddvrh/8GiU66nBKPxT3o1iuZHL6UYYmW/IwNiRAyUwA==
X-Received: by 2002:a05:6000:18ad:b0:21d:9aca:379 with SMTP id b13-20020a05600018ad00b0021d9aca0379mr22601097wri.312.1658149749687;
        Mon, 18 Jul 2022 06:09:09 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c545a000000b0039c454067ddsm16308719wmi.15.2022.07.18.06.09.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:09:09 -0700 (PDT)
Message-ID: <9f295edc-a821-ab46-3a93-e4b6d72a816a@gmail.com>
Date:   Mon, 18 Jul 2022 14:09:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 09/12] sequencer: rewrite update-refs as user edits
 todo list
Content-Language: en-GB-large
To:     Derrick Stolee <derrickstolee@github.com>,
        phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <29c7c76805abb9b8afd44a65cb39d8f9d3c95892.1657631226.git.gitgitgadget@gmail.com>
 <7a471a98-09d1-78cb-d6dd-a7faaa9071ba@gmail.com>
 <638f6b51-0045-f08e-fa63-d16a571d0099@github.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <638f6b51-0045-f08e-fa63-d16a571d0099@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 15/07/2022 14:13, Derrick Stolee wrote:
> On 7/15/2022 6:27 AM, Phillip Wood wrote:
> [...]
> I think both of these concerns would be excellent for a follow-up,
> since they would shave off some rough edges. I hesitate to add them
> to this series since it has been growing quite a bit already.

Yes that makes sense (and applies to pretty much all of my other 
suggestions as well). This series is looking good and it makes sense to 
get it merged and hopefully get some user feedback before making any 
tweaks. I'm going to off the list most of the next three weeks, so I 
probably wont reply promptly to any reroll. I think that what you've got 
in this version is pretty much ready so I'd be very happy to see this 
topic merged by the time I get back on the list.

Best Wishes

Phillip

> Thanks,
> -Stolee
