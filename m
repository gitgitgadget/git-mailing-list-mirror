Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6921F516
	for <e@80x24.org>; Thu, 21 Jun 2018 21:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933675AbeFUVeH (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 17:34:07 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:34268 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933477AbeFUVeG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 17:34:06 -0400
Received: by mail-yb0-f193.google.com with SMTP id n23-v6so1792220ybg.1
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stSyBbz18JffBIFfQidplQVGJdtc3iRIeZhhvZ/JAZE=;
        b=fCeLxhivEQeoyLpul6f4tugJydI2f+JK6uPzAHj3GD5wKPKnp6EdwNfKmDCVp1RUHa
         1q25+0jhYukoA27CFGt029omVwJ59otLzj/QffMUNMg0RrFNBU9TUpR92gKOl7GbWaVd
         foDQkD3bJFcIlOjR5CgRDPYTIUM+/7ecN3DC8bMZpo+DLl+LR+E0r6XMAyHIaurVdiNJ
         23pya+Om1rOkGcNzgwfSA4iup8sj1AtzOM9Xx3Qc7H4Vg1GC5ViWGsw0S4XW4RdsEhzD
         gSe0Pro+gsqDsJBqflCOchJ3gvRsLS2MxTIYYY75XErjYpLiI6FqorB5GDAIRQYSdVpT
         jYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stSyBbz18JffBIFfQidplQVGJdtc3iRIeZhhvZ/JAZE=;
        b=VJAj2MbcYJ1HDGfgY3M8YJtjXNqfEKuVOJVlZWolWKpETr6GeDAo+2ZM/NSZcQW87R
         GnoHHoL5n0gAOZzOb1HBpOiCFoP1sRXyvc+wqbJIJGRnaYjo6Uy2Zbyl9JzuLrii74ez
         xD+1Ca5ju3fGsc6oLvlJV0OVsUWOdSke91mhJKOlsdH7wf94Sm1nxePaDo4C29EeAcED
         6mpp+VV1Xtn4DyNhOYLmbdI7YFDQ9hDiTD4ISL9B+QRvjDJbOX864rd+96oZkTqlbSLU
         c5bK8j5wX4h5qnJ29olYcUH/AIPz/COVhzKIR/rmu+6q2VQZ0g14Wtk00b29TFw+8Zjf
         Q5jA==
X-Gm-Message-State: APt69E1WnGqXUVWLDvM9u/KcB7yvb+z3n5aqZ3mFn26G0R46sPnp9PPI
        k0R2WQABeU33UIutzD+K9nEYeOGtK2/oJG+o0AJi4Q==
X-Google-Smtp-Source: ADUXVKLCpvS4je3XJ5NPervgOmgRnyyseKzCLgPUIcBgMcBzXXl4HHy5Ao61Dy7BLX/cIMnoUtwfQWnFnQ/myDPx5GQ=
X-Received: by 2002:a25:dcc4:: with SMTP id y187-v6mr10664852ybe.515.1529616845102;
 Thu, 21 Jun 2018 14:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180417163400.3875-1-jamill@microsoft.com> <20180620201557.77155-1-jamill@microsoft.com>
 <20180620201557.77155-4-jamill@microsoft.com>
In-Reply-To: <20180620201557.77155-4-jamill@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 21 Jun 2018 14:33:53 -0700
Message-ID: <CAGZ79kbL5wjJvKj-=gtGgtMFCPs+zTwSAV-Aeo_2GNC_h=1nNA@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] mem-pool: only search head block for available space
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 20, 2018 at 1:17 PM Jameson Miller <jamill@microsoft.com> wrote:
>
> Instead of searching all memory blocks for available space to fulfill
> a memory request, only search the head block. If the head block does
> not have space, assume that previous block would most likely not be
> able to fulfill request either. This could potentially lead to more
> memory fragmentation, but also avoids searching memory blocks that
> probably will not be able to fulfill request.

Do we have any numbers on performance or memory pressure here?
(I would think benchmarking fast-import would suffice as that is where
the mem pool originated)

> This pattern will benefit consumers that are able to generate a good
> estimate for how much memory will be needed, or if they are performing
> fixed sized allocations, so that once a block is exhausted it will
> never be able to fulfill a future request.

Would this be a good candidate to contain parts of
https://public-inbox.org/git/DM5PR21MB07803E8D2627676788659E63CE770@DM5PR21MB0780.namprd21.prod.outlook.com/
?
