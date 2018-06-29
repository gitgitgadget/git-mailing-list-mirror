Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2F81F516
	for <e@80x24.org>; Fri, 29 Jun 2018 21:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935494AbeF2Voh (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 17:44:37 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:46505 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753650AbeF2Vof (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 17:44:35 -0400
Received: by mail-yw0-f182.google.com with SMTP id g123-v6so4201842ywf.13
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKBzz1jdJ+wdL+Ot6a77lwlWmZo6mbZlP3OT8blk7GM=;
        b=pu9w9kQsh7ZFB7jKPryePEnCD7unT15FHrknv/sOjN/0u/NMByHJSkXt/Ks88uEzBN
         tpmiuL5kwKie53exoJpR2Bb082iWgWZVv5nc7Ysg79ABEOkMRSFiYye18yAB9GNo0Dzd
         Q2ro7EzFmoibEehKDTktB/XioK47FEAeJirhZ2BPPaVbvCasVtH+fXfO956pOq6a1DoK
         gzt4s45J77gcRllOgAN2fN+XL4Y3e0C1HUNUvWfL0/oQVgmMbnwXtTuD30UemccdmkZq
         e7uebgPXOHZ5Ntdlb+6VWsiTk4PLoej3l1Zu1MeK0NS+wHxQh3ywFQ4ehhveVjhydT8H
         q42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKBzz1jdJ+wdL+Ot6a77lwlWmZo6mbZlP3OT8blk7GM=;
        b=V5cJU9gz1N2dh+3aKl5y146dh+69JLvkHWFo1OmLfP3oNlbeVG+3wa+79W0scHOYLm
         i0npT59OAS+shGsrxqD6sP0Xf1MX9TZxetMP57vM4sy8IItY333HzqfnqMHnjsrA9vZu
         LuXMNc7AYxl0pyRczyK8zvIce5rr6QzOEjmVe95ICXW0kgCv+ysfmX3Ce+7chx8daJc+
         wwCp66MHfscTVL3w0g0LUHEfRprga3mRY6uE3MW9uxd6uK7PWHa7MJ37hLmLFKbstOaT
         dXrNQZF3zNBt040KA8yh4uePYvCcBdm1JUHuN5RmHtnZUIsptoibk7HomqMg15mn09/Y
         HKVQ==
X-Gm-Message-State: APt69E0jt8KAMbsvfRycTAxmxZVMRe29IFcpUeaQ8dAhMggqRCFvgWyZ
        9zlWEpKKQWaLwj/q0qDvBuMc1i0mwvlfcVeVLMIHlA==
X-Google-Smtp-Source: AAOMgpe2VXw+iOQIdxkkkE7SIH/a7QeYWU+2wkiPheyXTtJsZnIPrlA2g1Ki38Licl6Pqo2HLhB5e/GskbJpa193hkI=
X-Received: by 2002:a81:3743:: with SMTP id e64-v6mr3119313ywa.340.1530308674763;
 Fri, 29 Jun 2018 14:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180629161223.229661-1-dstolee@microsoft.com> <20180629161223.229661-6-dstolee@microsoft.com>
In-Reply-To: <20180629161223.229661-6-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 29 Jun 2018 14:44:23 -0700
Message-ID: <CAGZ79kbMSnTqyJY8Ds6gsyy9saCmWW3jdELsS9RkO2a3isP5zA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/13] upload-pack: refactor ok_to_give_up()
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> -static int ok_to_give_up(void)
> +static int can_all_from_reach_with_flag(struct object_array from,

This method is hard to read; at first I thought you missed a word,
but then I realized that it asks "can all 'from' members reach
['something'] and we pass in the 'flag', so maybe

  all_reachable_flags

or something?



>                         /* no way to tell if this is reachable by

While at it, you may want to fix the comment here.
