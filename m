Return-Path: <SRS0=eCeC=CH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5854C433E6
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 10:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8043120825
	for <git@archiver.kernel.org>; Sat, 29 Aug 2020 10:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9Qy3qKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgH2KNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgH2KN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Aug 2020 06:13:29 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4391DC061236
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 03:13:27 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id h3so2910063oie.11
        for <git@vger.kernel.org>; Sat, 29 Aug 2020 03:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjBMeHXydhmE86Rbm9NS5Eh7R/QHymkAy4JeffGMX6o=;
        b=c9Qy3qKwiJBkrJbyrU7gvjFqxHjlQXwmvsIxy9ycCd6iU9lfSWxd40gznJf/6bfD9E
         mgns6dWOohDkue/wLoaFybsXZTqo8IaIecAnUmZUwFo/Pq2bUNpI8zFj+UuYQ5sqmuZo
         Z9MkzE4yBi62vs0HhGqxREcmG8A5Lat5GE1L6kW6hnwme1sIvlLeD27TvcLVqr/Pi1QR
         BV5YmL9EpadP8avUjdWUPoXfr67chbqc4kZXd6bBp02gl20sxomUiCs61lmZ8JBck2HV
         YvmMQhMEBqHEw5jCcxa33I2hIlUfx4nzkGSui2+LcFqEicZNO8T/sa1gV8SmDdlUCoxY
         UE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjBMeHXydhmE86Rbm9NS5Eh7R/QHymkAy4JeffGMX6o=;
        b=FrDHTGjdz/ThAnD6ii5X1sotwR0+/nE+Rl6lYihdF4L+IuK3hrn+0b6buINAdsqwTA
         aLwSlc9ayYt0VeolpbM5M/6juDo8L6OyP1bnMCl2k1YuNm8qphzr9J0+dvgO5xQsVEMg
         C6R7J76W9d6XK+mjGRv9wL26KT0twsP1J26QCI+KqWuo50TV80hq8ccLN4diPFrqqspv
         rczv4c/jQvhITIw40MEPFu6B4Xed5G6EK5uHG+1AnXtv/g61ktzz3oadczgfA8xTLMEt
         GmtkcjgdTXBvvWJHxiV7UEAFGfjRyGVxOk+aEwgQTWNiG6QYgF1y0svIFUpvoDcrVLMo
         KMmw==
X-Gm-Message-State: AOAM533J9h0QoLXks+cCoCxxRnhimWgUFL56wpsber+U/mQHC81DjoYL
        YV10xXVdrJS+CChQlHMrd3CVX4G5a8Q9q/XP8fzdpAjCoVXL7g==
X-Google-Smtp-Source: ABdhPJwSVDRpG5GZhB6qYdM2MLiyapC8jkEyZWAWRZZrAj8en7Yj+TL7x3fglsoeMklUReGDALeIetKLgAJ4FH7/VSc=
X-Received: by 2002:aca:6082:: with SMTP id u124mr1682731oib.155.1598696004838;
 Sat, 29 Aug 2020 03:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 29 Aug 2020 15:43:13 +0530
Message-ID: <CA+CkUQ-SsxrJk+7e-ygm8FfCto6XZt2Ts9UcTMpgkmAQWZkLhA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Aug 28, 2020 at 3:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> [Cooking]
>
> * hv/ref-filter-trailers-atom-parsing-fix (2020-08-21) 2 commits
>   (merged to 'next' on 2020-08-24 at 79b27f3263)
>  + ref-filter: 'contents:trailers' show error if `:` is missing
>  + t6300: unify %(trailers) and %(contents:trailers) tests
>
>  The parser for "git for-each-ref --format=..." was too loose when
>  parsing the "%(trailers...)" atom, and forgot that "trailers" and
>  "trailers:<modifers>" are the only two allowed forms, which has
>  been corrected.
>
>  Will merge to 'master'.
>

After a discussion, we agreed on keeping the helper function instead
on duplicating code in "ref-filter: 'contents:trailers' show error if
`:` is missing"
There is a high possibility we might want to reuse helper in other places too.
Especially in the case of newly added "%(subject:sanitize)", if we
also want "%(contents:subject:sanitize)" to work.

Full discussion:
https://public-inbox.org/git/CA+CkUQ8Gst2RTaXY6t+ytWu_9Pu7eqnRYRrnawRwYd_NN=u0Lg@mail.gmail.com/

I'm about to send the updated patch series soon.

Thanks,
Hariom
