Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F8421F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeIDX63 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 19:58:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47092 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDX63 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 19:58:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so5089182wrc.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=R9MCNU1z7DQmRiLP7JwBxQ2b454Xm/k6M8HKXyOgyME=;
        b=kN1uHV7v56s8wDkktBTuTGf4s+5NdhVktfLouIE20Z+tmLPF0sFtTWSIBhE8Ednk75
         mtwU/EFujWj6MtOsJlc/3oe/uJ1DxEQDFRCn+XgngwMZq6wVS6/cR2loAsTADM+SE57z
         y4a3v4ETaWM3RKj9YW53ESJjsbh59Q7YmcsBn8EEfUyxZKWbGKJKtzQJU+dMzePPERe0
         xMbNAheUQ7NgBdBzkocusVrAG4SHCkHU1FzeeLGjaUjT/ckKUCMarN3XtV4yijCLCFWI
         pePoiYJoD2CI6gORSmRxc/HqduscGOH1nYGFuirtJFfR1dNey2lEqsKzrKDGK2M3D40+
         3bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=R9MCNU1z7DQmRiLP7JwBxQ2b454Xm/k6M8HKXyOgyME=;
        b=iVsffEtHHeAzc3YBSvtVag3hNrZA/pgQGmNGuF37vfsrrxDa0g8tLI5RWd88fTS9AC
         CXNuSD7O8hvmnuLMaSyiiJeIA2GCg1x9tSXohdilfk5sMY1+mVLZ9WZU4mrVzJbyHNiu
         EILSAZTaOEMkhJ8LRnxoIrN3CxP4SSg9ouzRTRv1QhVIXm+f+xpdwDDTWrjitOHNTmNY
         6jAL+ChAyE1XMW70vs59EkGe+30MTqauyWT2jFYbYuazc/2j+1Emr3BKWQnnhB+yShSf
         mHUks/uT1RQtqXKOotg8trrKCRAA2yTXdNcb6P1tBBxUR+UmmH31LAAk51qzVFIXAXi6
         Sg4w==
X-Gm-Message-State: APzg51B0eggiqqnJ3IahChgqRQ1k6Thrp8GIaLTVueUSdZnbXNFqfmnJ
        wjwydmSwf0+eM/JixS/nkbApIxmF
X-Google-Smtp-Source: ANB0VdZGpyMLI46W4aQmQg0vJo3bNe3MDKQXT06B0Movn3dHSqdnMi52ywW/abiddLR6kijdWEgOzQ==
X-Received: by 2002:adf:ce06:: with SMTP id p6-v6mr24923457wrn.118.1536089515566;
        Tue, 04 Sep 2018 12:31:55 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r140-v6sm55619wmd.7.2018.09.04.12.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 12:31:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Ben.Peart@microsoft.com, git@vger.kernel.org, peartben@gmail.com
Subject: Re: [PATCH v2 1/1] read-cache.c: optimize reading index format v4
References: <20180825064458.28484-1-pclouds@gmail.com>
        <20180902131933.27484-1-pclouds@gmail.com>
        <20180902131933.27484-2-pclouds@gmail.com>
Date:   Tue, 04 Sep 2018 12:31:54 -0700
Message-ID: <xmqq5zzl9hzp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Index format v4 requires some more computation to assemble a path
> based on a previous one. The current code is not very efficient
> because
>
>  - it doubles memory copy, we assemble the final path in a temporary
>    first before putting it back to a cache_entry
>
>  - strbuf_remove() in expand_name_field() is not exactly a good fit
>    for stripping a part at the end, _setlen() would do the same job
>    and is much cheaper.
>
>  - the open-coded loop to find the end of the string in
>    expand_name_field() can't beat an optimized strlen()
>
> This patch avoids the temporary buffer and writes directly to the new
> cache_entry, which addresses the first two points. The last point
> could also be avoided if the total string length fits in the first 12
> bits of ce_flags, if not we fall back to strlen().
>
> Running "test-tool read-cache 100" on webkit.git (275k files), reading
> v2 only takes 4.226 seconds, while v4 takes 5.711 seconds, 35% more
> time. The patch reduces read time on v4 to 4.319 seconds.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  read-cache.c | 128 ++++++++++++++++++++++++---------------------------
>  1 file changed, 60 insertions(+), 68 deletions(-)

Thanks; this round is much easier to read with a clearly named
"expand_name_field" boolean variable, etc.

