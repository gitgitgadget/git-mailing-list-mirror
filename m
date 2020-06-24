Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35909C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0750820724
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNWI0uS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391062AbgFXNvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391004AbgFXNvE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 09:51:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320DBC061573
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 06:51:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x62so1701368qtd.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2020 06:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=azls5S0w/2YYCdq9veSlZn9eq3jtNRYE6nhktzWbe/w=;
        b=sNWI0uS6sJg6hGUfYUhVX1wuq8dEr7AHtfT3Uq55QjW8YwLwJFiVG5iX3SFJB+jFmU
         aFfY20jctSHKJuA4qBGHIEDSgE9RE0l8ZVPQV1RHXKuZlOdqcZ12/aYIUEiNkt1m02tb
         eRTXVqOhCDNOkFcNHEz8NYj4kBoXDLDYDKd6q0XdbGgdJpSe44hjFcPJ6K77PIAL62ZZ
         K4Tn4TfHi/tHlCRUrFwP60WwscH6x7sY2szywdGhkM402w3dj/pq3AnMoLrTqed+WRH/
         KYSg10Yycb2da01IaLPTlPlAD89qmsFPKHX1J1b+PnW5iU94gXNgG94GYIwEjq67R3AX
         AbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azls5S0w/2YYCdq9veSlZn9eq3jtNRYE6nhktzWbe/w=;
        b=sP/tBRBZbzTA+ZunSnQmvEeRRwrpQNXSQRyOiu3XUrQxoCZUZI8u9hdhEe1iZmugPf
         gomd9b22tNKIYBBtnbl2mz36HYHgfUfScuhx91DB6gFBycQ0VRp8kp7rJYjog4zMCeAs
         CZvTse892JVgq2/JO1oWWZbDWZpqqy6IUAjpVQQIjAUUENs2KwrEHkShIAExHpWGBASg
         F3VwfscqMLDaeEa2XVDfIuci3/Q2X0ARLJ8qFJOem3ltZ/xZAAMoeACQVsgdzNyNbV2H
         u+8Oqkawg5MNDuwBHvDTVrDpe/P0ZGwO9F4vqLYdUrjH/i/LnT9Ahm3KAGOfUmQOAe+n
         0WqA==
X-Gm-Message-State: AOAM533lCbCZvNhi84Ahe+v+v+tpo+JTMgL/2VrqI/RD8WxCDZa+iADS
        VNJWAFFO94XktoyYopb+Zj4=
X-Google-Smtp-Source: ABdhPJz/wBa/gESHJDcOd/pch/RnyBxWaP0Rj3FMmVLyiuImiTCNNNzb+nXz67skeS8AykSNrqaakw==
X-Received: by 2002:ac8:75c4:: with SMTP id z4mr7453668qtq.371.1593006663199;
        Wed, 24 Jun 2020 06:51:03 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h197sm3306686qke.51.2020.06.24.06.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 06:51:02 -0700 (PDT)
Subject: Re: [PATCH] revision: reallocate TOPO_WALK object flags
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <29f8b1fc-fac7-12c6-4bfe-28aed7e709c3@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8e5b6b9f-a778-7b20-2c67-2d5d8ff0d8a0@gmail.com>
Date:   Wed, 24 Jun 2020 09:51:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <29f8b1fc-fac7-12c6-4bfe-28aed7e709c3@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2020 9:05 AM, René Scharfe wrote:
> The bit fields in struct object have an unfortunate layout.  Here's what
> pahole reports on x86_64 GNU/Linux:
> 
> struct object {
> 	unsigned int               parsed:1;             /*     0: 0  4 */
> 	unsigned int               type:3;               /*     0: 1  4 */
> 
> 	/* XXX 28 bits hole, try to pack */
> 
> 	/* Force alignment to the next boundary: */
> 	unsigned int               :0;
> 
> 	unsigned int               flags:29;             /*     4: 0  4 */
> 
> 	/* XXX 3 bits hole, try to pack */
> 
> 	struct object_id           oid;                  /*     8    32 */
> 
> 	/* size: 40, cachelines: 1, members: 4 */
> 	/* sum members: 32 */
> 	/* sum bitfield members: 33 bits, bit holes: 2, sum bit holes: 31 bits */
> 	/* last cacheline: 40 bytes */
> };
> 
> Notice the 1+3+29=33 bits in bit fields and 28+3=31 bits in holes.

This is certainly unfortunate.

> There are holes inside the flags bit field as well -- while some object
> flags are used for more than one purpose, 22, 23 and 24 are still free.
> Use  23 and 24 instead of 27 and 28 for TOPO_WALK_EXPLORED and
> TOPO_WALK_INDEGREE.  This allows us to reduce FLAG_BITS by one so that
> all bitfields combined fit into a single 32-bit slot:
> 
> struct object {
> 	unsigned int               parsed:1;             /*     0: 0  4 */
> 	unsigned int               type:3;               /*     0: 1  4 */
> 	unsigned int               flags:28;             /*     0: 4  4 */
> 	struct object_id           oid;                  /*     4    32 */
> 
> 	/* size: 36, cachelines: 1, members: 4 */
> 	/* last cacheline: 36 bytes */
> };
> 
> With this tight packing the size of struct object is reduced by 10%.
> Other architectures probably benefit as well.

Excellent improvement!

> - * revision.h:               0---------10         15                   25----28
> + * revision.h:               0---------10         15             23------26
>   * fetch-pack.c:             01
>   * negotiator/default.c:       2--5
>   * walker.c:                 0-2
> @@ -79,7 +79,7 @@ struct object_array {
>   * builtin/show-branch.c:    0-------------------------------------------26

The only collision is here in builtin/show-branch.c, and when I added
the TOPO_WALK_* bits, I didn't understand that these bits were
sufficiently independent from the topo-walk logic that we could add
collisions here.

I think I realized this behavior when doing the commit-reach.c refactor,
but I never revisited these flag values.

>   * builtin/unpack-objects.c:                                 2021
>   */
> -#define FLAG_BITS  29
> +#define FLAG_BITS  28
> 
>  /*
>   * The object type is stored in 3 bits.
> diff --git a/revision.h b/revision.h
> index 93491b79d4..f412ae85eb 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -37,6 +37,10 @@
> 
>  /* WARNING: This is also used as REACHABLE in commit-graph.c. */
>  #define PULL_MERGE	(1u<<15)
> +
> +#define TOPO_WALK_EXPLORED	(1u<<23)
> +#define TOPO_WALK_INDEGREE	(1u<<24)
> +
>  /*
>   * Indicates object was reached by traversal. i.e. not given by user on
>   * command-line or stdin.
> @@ -48,9 +52,6 @@
>  #define TRACK_LINEAR	(1u<<26)
>  #define ALL_REV_FLAGS	(((1u<<11)-1) | NOT_USER_GIVEN | TRACK_LINEAR | PULL_MERGE)
> 
> -#define TOPO_WALK_EXPLORED	(1u<<27)
> -#define TOPO_WALK_INDEGREE	(1u<<28)
> -
>  #define DECORATE_SHORT_REFS	1
>  #define DECORATE_FULL_REFS	2

Thankfully, the changes are very simple!

Thanks,
-Stolee
