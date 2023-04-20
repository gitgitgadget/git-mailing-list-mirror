Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4006CC77B73
	for <git@archiver.kernel.org>; Thu, 20 Apr 2023 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjDTRIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjDTRIk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 13:08:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD14A1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:08:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1a6e5be6224so341555ad.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 10:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682010516; x=1684602516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UmnLM2HlhK7iLhSwKPiqkTy41I/w55xAtfCck1IZTlA=;
        b=i0rH6ieVpEbjyXXkDHjG2hwJ/Zu4p/lp9J4im9/WAm3R3seTtr8vQGoic0+kRzH60O
         NeyemA6GkRBIpy4rOy/yYQo33ydmSCEN8ZX5W4+3ZuJLFoBR7vM2EN1SHj4C28yb3Z8S
         Ms9JVQbdJ28vC/zlIzAjDkBmeEjqmKSZ2cJIoAztu8UhhebjgwbOPlnZmnshLYZHQhb+
         CTdr+Rt+rHNPP+XQDz/2r0WBk2FNNIrMBTJ1jNha0o8/hTvK05mMXdn5g5plYNJOpPY9
         0GqYwXpU13LDnGhrhmaAZ9q9Ij9KCYlabPFFb3lRdig7SA2ZOuurEkkIoyupojdNlKd6
         ckfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682010516; x=1684602516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmnLM2HlhK7iLhSwKPiqkTy41I/w55xAtfCck1IZTlA=;
        b=kZO2XudQyrQiNJf0bfMVAjXrzyyzGsgUAUAZWkxKWtx5YOjq+tCkYYSQjVp9VspdLS
         pK0JXvdUlX46zmEbQNT9QDwvFLxu1fVgHtz2CYG1XxYjPlKnZY1XU+FXXACxRaQDed2O
         PsSVAjwmXvcQhtevz0xcZztA9EbY/xvR+tIyjgSK9vyvgc2B+KKuNbZyhgJWT/QKE0YM
         hhtA1hTiOpRYmpjH19BlekHfkCeKt4b+E33lc0kkZBMDuhsUBY9qbJ7JRmvUgMD55xL4
         ZJ+w7LVdiMW3FQr6VTKT/vvmtei/sRB9FMMwBcPTYnW7TFS6mNYXawAnB4ERm1eyIS73
         Wt1Q==
X-Gm-Message-State: AAQBX9c7FaFM4Yzt/MujnsY5UooQtsabI4G/UIvcbIdFkSs6qc1rH+MX
        aV/bGnpBtlvQf2brgATP7iJq8ajHpTCc6N/9FCJy4YIU
X-Google-Smtp-Source: AKy350ZwCelymyxxKMf6t85B0ShZ2W+ELqpBYtQiJX0Fv8T+CoOFyWC8A2CAfxefCA4gE5B7V4aVEA==
X-Received: by 2002:a17:902:f111:b0:1a9:343c:76e5 with SMTP id e17-20020a170902f11100b001a9343c76e5mr180244plb.18.1682010515950;
        Thu, 20 Apr 2023 10:08:35 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:99e1:822c:6ddf:2f60])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902bd4300b001a67eace820sm1408495plx.3.2023.04.20.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:08:35 -0700 (PDT)
Date:   Thu, 20 Apr 2023 10:08:30 -0700
From:   Emily Shaffer <nasamuffin@google.com>
To:     Git List <git@vger.kernel.org>
Cc:     chooglen@google.com, newren@gmail.com, cscallsign@gmail.com
Subject: How to discourage introduction of new globals? (was: Video
 conference libification eng discussion - notes from today)
Message-ID: <ZEFxjmt9zV6V384b@google.com>
References: <CAJoAoZnoz9rsEEUGoG4BKMwW7r_Q-H2JcD_SVxuA_ykDZ33J8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJoAoZnoz9rsEEUGoG4BKMwW7r_Q-H2JcD_SVxuA_ykDZ33J8w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 10:01:45AM -0700, Emily Shaffer wrote:
> *   How can we avoid introducing new globals?
>     *   Elijah: for example, diffcore added a new global for actually no reason
>     *   Getting rid of the\_repository is so daunting
>     *   Emily: should we introduce some CI rule around new globals in
> the diff? Update SubmittingPatches?
>     *   Glen: tests which enforce libification also make it difficult
> to introduce new globals in libraries. But in some places, like
> setting something across the entire process lifetime, we don't have a
> better pattern to replace it with, right?
>     *   Elijah: in the short term, we do have dozens of globals;
> should they go in one place (so we know where to get rid of them)?
> Should they go with the file that is using them the most, or
> something?
>     *   Emily: does putting all the globals in one place make it
> easier to tell whether a given path is using a certain global?
>     *   Cem: Putting it in one file makes it really easy to tell
> people they shouldn't introduce a new global! E.g. adding a comment at
> the top of `globals.h` like /\* are you sure you need to add a global
> here? \*/
>     *   Emily: can coccinelle help?
>         *   Glen: probably not, coccinelle runs over all files whether
> they're unchanged or not
>     *   Emily: does wrapping globals in a getter that traces help?
>         *   Elijah: but people will just bypass the getter, unless you
> restructure the code so the accessors are the only thing that are
> accessible
>         *   Cem: This is basically a global to singleton conversion -
> but there's no way to guarantee that new globals follow that pattern
> either
>     *   Emily: I'll spin this out into a separate thread after this meeting

Any thoughts from the rest of the project? To summarize goals:

- The path to library code stays about as hard as it is, doesn't get
  harder by the addition of more globals.
- It's very easy to tell when globals are being used in order to make
  cleaning them up less painful.
- The onus for avoiding new globals doesn't fall entirely on a handful
  of reviewers, who may miss something newly added.
