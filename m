Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74D3C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E0C420BED
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwZejw3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgIYO1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgIYO1e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:27:34 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2EC0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:27:34 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c13so2958781oiy.6
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=koKq9uuUazP1W9y5k7G29Yj4vFpE2DUA1+7bPnIxglk=;
        b=gwZejw3Bm72AL3HD21p6ZRiT81JhEejP/bE6v30ze5bDQXFZYHz97TdzzNzTCtmAKf
         U+Jm/8HtfPsh22u3xfmU4WsWFFa+EK9LJq2LUSYeXYADYBt3fDMrKgod9sBIO0LvNWrD
         77O1RhgLbNd/KowypqxQJgjK+OuQVAKqpDyS0pIzzBgzU5Z3RCgjBR4qS84mTZziWETK
         ZmROKyOJ9oeKIGxokntwUHKkZkWmm74Je76V56H1FoonEB83nePkCwwSq09VFh9G7hA0
         Sxl422sCEG4k9LP/8IuqaN0NaBsH1pJurjN6Wu8+TbWaNDfu/eJp7a55XZDgPaM380DX
         Jahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=koKq9uuUazP1W9y5k7G29Yj4vFpE2DUA1+7bPnIxglk=;
        b=AQUW7rVEh2E6uUUn3SZ+HEO6+i7BF6QQmJzKW5BKjeGQ1R2QLhWK2RzuteO6jQsfOR
         UC2GyFpfvdxZi89hql+/LlfdgGEfhKKu1IjyoUKbGqkahAB6zrP0XratUgw4YYbF/pVg
         JvoTeohIldSU8aZzfIF7oOvNg93UgkuHFD5oNanNlC+pxodoZQVki8tQ7E3dQYLJC2VZ
         8xuxEeMgITxQsMlTwcmrIkXu56a3I0jWBa05fpvF/AwaDs6aP3eW29OplKLHE4Jl6An0
         9ZeCZYqAv/EONli7KSskUsa18lL6yH6YWvkZ3vPteY5y2d5WxTwCW7p0Q3G1NWgrLYds
         uM8Q==
X-Gm-Message-State: AOAM530+Rinu9ohEjrfNdwlRWu0pK+Q3FZkL7e0//mWZMVY9Ch7Qxlkc
        fSOw0S1y0zFIuXYE8gPjnswr6zGJ8bbMRQ==
X-Google-Smtp-Source: ABdhPJyTZboEcZRpNOKpJNPbs11Kl4Q6kuqn66MedHa343H0sLIXRphl9z8OFVRlO163BKAbQtSuOg==
X-Received: by 2002:a05:6808:20c:: with SMTP id l12mr424730oie.70.1601044053087;
        Fri, 25 Sep 2020 07:27:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bdc6:8b77:8b68:f0f3? ([2600:1700:e72:80a0:bdc6:8b77:8b68:f0f3])
        by smtp.gmail.com with ESMTPSA id q81sm601118oia.46.2020.09.25.07.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 07:27:32 -0700 (PDT)
Subject: Re: [PATCH 0/8] parsing trailers with shortlog
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200925070120.GA3669667@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7e40593e-b41f-1c01-4005-5aa80d88302d@gmail.com>
Date:   Fri, 25 Sep 2020 10:27:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <20200925070120.GA3669667@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/25/2020 3:01 AM, Jeff King wrote:
> Somebody mentioned at the inclusion summit that it would be nice for
> mentoring/pairing relationships if we could more easily give credit to
> multiple authors of a commit. When people ask about adding multiple
> "author" headers, we usually recommend that they use a "co-authored-by"
> trailer. But you can't convince shortlog to count it for anything. :)

This discussion was worthwhile, and could even have measurable effects
on this community, depending on how Junio creates the list of
contributors for the release notes.

> So this series adds support for counting trailers to shortlog. You can
> do a number of fun things with it, like:
> 
>     # credit reviewers
>     git shortlog -ns --group=trailer:reviewed-by
> 
>     # credit authors and co-authors equally
>     git shortlog -ns --group=author \
>                      --group=trailer:co-authored-by
> 
>     # see who helps whom
>     git shortlog --format="...helped %an on %as" \
>                  --group=trailer:helped-by

I built Git with these patches and played around with these and
other options (such as `--group=author --group=committer`). I
could not find any bugs or other ways to improve these patches.

Thanks,
-Stolee
