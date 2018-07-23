Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185BF1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 15:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbeGWQxO (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 12:53:14 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44236 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387995AbeGWQxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 12:53:14 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so920402ioh.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKHndRBOsak34+8dietjmNPOVC5qzC5+lzMlT2jynfs=;
        b=rAygBqPHLaNbPC/vGeN9oD6Q4cw0nufjBZtDAS+p73Ti+xxNv6QDF9ddJucbQFB3Bu
         xryX6Yqtb9NE+IN9NUFGrbo+29fgNommcJCPyUAaNbuAuAmknHfVnyCkTBPCYDzOFwRb
         b4YDDygsaxrWASeOIzOo3EjbkY3ax6+55Cewkxvey2gi3pNLqV364Na7+AHb2WP/SlnZ
         JAoYCJSxkUg7/tP1JKQu5yetoK9qcKGv+SwL9vaDsXSqIpMNErAkhZnyKGq3ubV1Hzi4
         xnjykMKwVbrS+ig3DvJhPicLG2EOod96BQXNTMrQ/WuVSIaMK399YHGIogZwmk4p5EPK
         JzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKHndRBOsak34+8dietjmNPOVC5qzC5+lzMlT2jynfs=;
        b=Wb1+D1vixsy+3J/lNqdoV1f70AGcB16ZzknN/LMA+mTerSSbYR3KfrKNJa6kBGn+qA
         d9habD6ir/zxeZ7hKLADBS4bXUS5cAPmqMBmpV2o8XUcqJENsjyaxXLToyveuNn+4W/0
         F/8aC3kXUnJfDDrHJ2I8ZP8D7Lc9UmurpZhOxUP46EhbpMrvzlF/rf6JHg35/gqQAV6M
         Q3dqKrDKmah76x+FroaJunEVOG9gYIZtTzxZIRdw8ZP0aocgwrTI7WCFqZ8ZNVtZRMTl
         O1HzX5Cqm3kXI9hH6AFu+QEn8pJ2MvBL7rldQbcmId/h/3wiKt5AKriwAUfZESo/FmYj
         cIww==
X-Gm-Message-State: AOUpUlHW+4VKvlsBDIvrxpi4vSWL2oiQevCVIwZz0MfPTNxTAqCsfS+w
        7jTWbaD7yU9mlEmtlxPoC9yfVG/6uw7PdiBYMOE=
X-Google-Smtp-Source: AAOMgpfAUoWC4/Gy09PABQ5OULS4TD+iYuxtJib3d6XWgx+RvHMSj5TaTm6I9RmVJgAhwbHKXmYXsUwVyehPlmvoh+w=
X-Received: by 2002:a6b:a2cf:: with SMTP id l198-v6mr9515086ioe.282.1532361083781;
 Mon, 23 Jul 2018 08:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BGJAWXOCPsej=fWWDJkh-7BAV9m8yEDiy2NVkGTRCmk4A@mail.gmail.com>
 <20180723123423.32186-1-newren@gmail.com>
In-Reply-To: <20180723123423.32186-1-newren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 17:50:57 +0200
Message-ID: <CACsJy8BxKoHOk7xPkSv1ibTSrtf1Km6hkx+TCeDJUjH2=SUORA@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: fix performance issues on packing large deltas
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 2:34 PM Elijah Newren <newren@gmail.com> wrote:
> This patch provides a stop-gap improvement for maint that increases the
> delta size back up to 32 bits (still an improvement over the 64 bit size
> of the original).

The "still an improvement" is actually not true. Due to padding and
stuff, struct object_entry's size is increased by 8 bytes, even though
you don't use all of it. It's possible to maybe shuffle fields around
a bit to keep this struct smaller. But it's not really worth it since
this is temporary anyway.

> I think Duy's comment that I'm responding to suggests he Acks this
> patch for maint, but there is that little 'if' he put in his statement.

Yep. Ack'd by me. It's up to Junio to decide if it's worth doing this
or not, of course.
-- 
Duy
