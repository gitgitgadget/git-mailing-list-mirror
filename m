Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6720C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiETTp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345808AbiETTpz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:45:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F005FCA
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:45:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y13so16699635eje.2
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrsIea/YIrCimLqvws07iObSXb3n2BJQNJYySEHW6w8=;
        b=WVEhu6bLWtoA0OfxPObVZF6572YDkr9MqCvZyhigeoaXbnmtXGZOubD0UpmGWTHtKJ
         8KYepyFz/0pARZ+9inwH0CFXKZ+aTdWHJwOjcrEzPCn6BIhr0uxwgC4OgS6/hAmtRkN2
         8UM8OIFPcf83xbFza4NnGqm8e5qBdL9KMcEOw2yq8h5IeUOq1PYXwv1gxy5I8fhPTpDS
         yHD9n1dpKahUX9vP80MSF8vK5MxUVNPQzULIMG+SPJOpa32IJn7dtl+8ypU6QQ4Yh8v6
         0b5epJUHvYos1W6G5WFb3wcpAQ8+PL+SLifkWZ/CsJL43ikNTlWRAnkDRIX5Cvz658T7
         2iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrsIea/YIrCimLqvws07iObSXb3n2BJQNJYySEHW6w8=;
        b=Y50PATSp3f+wxPfv1WQTWN4XoCTmbUPmoiA/vyzSa5+jk37t3YBwzZyUY4qWRqPa++
         wBb7Yo8lDFQ31ecZB6+SkUHFHvG4wLN0z6yx8akd3ZAdqtFJCIhbJteKxwgZATEw/VDe
         b3I8GYs5NmLd44dWd4xtHHvbu7wCpSPPkMAlH1r8i4b8tbyT56fVvcQ2fPj5KnviP4pM
         PbbDeynHNPePPb3G9AaJgFOUFaboQ7Atr0HDh4O60retsZeeVg0WPMkKCh5RXIw56KQU
         jRE6feVVpiPIiQtuNvnlMNi12Mi8+AAzrNQW+7tstfw/1yZF/kIsPgih/zgoXZYQS7bD
         EQnw==
X-Gm-Message-State: AOAM5333be1fwcpfBqDhNlMb3yuuhUkMQYUUrQpD5flmT+M8Bv0zLqSQ
        Jg+AUbxy3rQfwviljX9Vvm6rChnFeJ+JEG/GNR4=
X-Google-Smtp-Source: ABdhPJxWbz9qRVvK0qGwN572JAS9Wjj8LhcrVssfbZHL0yPJfgkRoTTDuVsWvCBsbsVI6S1e5rYOgpGN4rEMGkVj27I=
X-Received: by 2002:a17:907:9808:b0:6f4:5e18:2192 with SMTP id
 ji8-20020a170907980800b006f45e182192mr9847343ejc.43.1653075950106; Fri, 20
 May 2022 12:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <20220510171527.25778-1-ggossdev@gmail.com>
 <20220510171527.25778-2-ggossdev@gmail.com> <xmqq7d6sm3e0.fsf@gitster.g>
In-Reply-To: <xmqq7d6sm3e0.fsf@gitster.g>
From:   oss dev <gg.oss.dev@gmail.com>
Date:   Fri, 20 May 2022 15:45:39 -0400
Message-ID: <CAAA5oLnJRTWzQ7AtX-7iDvOHFbGfZBEw+KiNoU0Y08rx16oSsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dir: consider worktree config in path recursion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Is this _complete() necessary?

It is not.  Though _complete won't actually change the buffer if the
trailing character matches, I've removed it.  The '/' is added prior
to each call here [1].

[1]: https://github.com/git/git/blob/277cf0bc36094f6dc4297d8c9cef79df045b735d/dir.c#L2329

> This function is repeatedly called during the traversal.
>
> How expensive is it to keep calling real_pathdup() on the constant
> the_repository->gitdir just in case it might be the same as our true
> GIT_DIR?

Using trace2, `real_pathdup` takes around 40 usecs on my machine
compared to 10 usecs for an empty region.

Please see the cover letter for v3 of the patch series for additional
details on both of these items.
