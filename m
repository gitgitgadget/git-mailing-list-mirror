Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F47C77B71
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 16:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjDMQOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 12:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDMQOK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 12:14:10 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7DC9EE3
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 09:14:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v9so20956749pjk.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681402445; x=1683994445;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rg7lnwfUlW9PXKIHeb8gZEeoTsW3Xub4AKXesqRpQok=;
        b=XHPlIW+hw4wENnkFxZeoZpWEkYIJ7ybOZ7ldAjxaL3/bHNbTN1Tub1pq5JYrzbIStb
         dQp3RC4bgrsza84njlhJr1qWgwxkGWpic746B+LIXbeIGkRYWMF04d8Zv04uDmKbS1CI
         TQ/6abXWJ2srEZrlC5nlD0rJYIxmZfqZAEk5A469dfaKrPbiC50/bkmTYd0NrDaWlksy
         s6cl/trUDD6rCAEJgF+2YEMYofwM9XHgYyh154zgQnlpON9QjQFHM+R1aVIwTg82erJf
         sOlOGNwKIq5HOQtvPBzHdDJXGAEEFCSe8NGiBufRGuLIRsyBtXx4vCglGe/h/kXPlYv3
         phvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681402445; x=1683994445;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rg7lnwfUlW9PXKIHeb8gZEeoTsW3Xub4AKXesqRpQok=;
        b=PcDIkbDyyir97bJ1eHhqK6RXg2RwAcmavhPt5vWrhNExeikxGZQOFsOWFQuC34x1wI
         Um111m9tqn0e0CxIJPnK3r9UWafqF/TC53YwQZajf0BAMHhaojidn1k43aee6V4GZepO
         KJGBKuY/1T946zsQ2GIOv7A+EI/mRNjGnaAQh9xLoU+OtGefXBqVVZEDThANQffv4auW
         m8J3+GqeSbeQI7XpkazL34E/3r8QGb+fZSOmYOwM4IDSAdHa1x7jpLIP+UgOGAPwQ/F9
         V8dTABr64qKvOMEGt0T5zgT4KlaLldmBjMnHAq0KCUt1zCmc+eXT9zRs6wJyix8eevwd
         BueQ==
X-Gm-Message-State: AAQBX9crmjZaF5IhWgW2sV3UO0lMv/ODY8mJXTWLTC62/r3uQyYzJ0VC
        OY+Hg2z2AydlKyJsl53kncf1cbE8xUE=
X-Google-Smtp-Source: AKy350aTh5814QcSRsqZaWZyU3Fed4tYhCeGzryAyNESL1LqqSuqMO9ioD2Xx9d9PccgPSM5PD0wcA==
X-Received: by 2002:a17:902:daca:b0:1a1:7b8d:6719 with SMTP id q10-20020a170902daca00b001a17b8d6719mr3109533plx.27.1681402445411;
        Thu, 13 Apr 2023 09:14:05 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id j9-20020a170902690900b001a52e3e3745sm1631929plk.296.2023.04.13.09.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 09:14:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/7] config: enable `pack.writeReverseIndex` by default
References: <cover.1681166596.git.me@ttaylorr.com>
        <56a0fc0098e0b0551e01414c8e67c17fb1ba3054.1681166596.git.me@ttaylorr.com>
Date:   Thu, 13 Apr 2023 09:14:04 -0700
In-Reply-To: <56a0fc0098e0b0551e01414c8e67c17fb1ba3054.1681166596.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 10 Apr 2023 18:53:40 -0400")
Message-ID: <xmqqttxjyd2r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> They are useful in GitHub's infrastructure, where we have seen a
> dramatic increase in performance when writing ".rev" files[1]. In
> particular:
>
>   - an ~80% reduction in the time it takes to serve fetches on a popular
>     repository, Homebrew/homebrew-core.
>
>   - a ~60% reduction in the peak memory usage to serve fetches on that
>     same repository.
>
>   - a collective savings of ~35% in CPU time across all pack-objects
>     invocations serving fetches across all repositories in a single
>     datacenter.
>
> Reverse indexes are also beneficial to end-users as well as forges. For
> example, the time it takes to generate a pack containing the objects for
> the 10 most recent commits in linux.git (representing a typical push) is
> significantly faster when on-disk reverse indexes are available:
> ...
> In the more than two years since e37d0b8730 was merged, Git's
> implementation of on-disk reverse indexes has been thoroughly tested,
> both from users enabling `pack.writeReverseIndexes`, and from GitHub's
> deployment of the feature. The latter has been running without incident
> for more than two years.

What is missing is what extra overhead this adds to "git gc".  Does
it add 5%?  15%?  How big an overhead do we find reasonable?

Other than that, it looks like that the series is very well crafted.
It was somewhat surprising that we still need to add a few new
end-user facing or meant-for-testing knobs for a feature that we
claim is well battle tested.  It is understandable that we benefit
by having knobs to selectively _disable_ a part of the feature now
it will be on by default.

Will queue.  Thanks.

