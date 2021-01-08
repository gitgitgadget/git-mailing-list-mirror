Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A833C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1CC123406
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbhAHHm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbhAHHm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 02:42:26 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB593C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 23:41:45 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ga15so13317934ejb.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 23:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=BojWEUGQAclCm+Ny+0D/6ivjv+9T+Vyu35fN106+nB8=;
        b=ZKNdd0EznSQ540iKGiafG4tYfVFhFAh98RVrJzcTouTwNS4dEQkXU2uDfOBziUqowB
         rZuL0Mqlm+Bl3JnASqL8oCiHryXmjMmRCJodFDXVP6hcjuGfYL5qY4r4W5M5gjwEir07
         zlbGrog5aYBDv3IJWSdTCUsdP/H2di77IHJK7h0vCv91COc4KyKXVTlHD8PAhwBWSpnt
         D6Fyt3cO5swJV0h8559+bEfs0KPxtKNOqsXntUNoHiwV/JdenZ1BuKPkxRBludbfA+WV
         9MbCm6Erg3wCzj41xMjb0oqqe7vaQdd0dwyGJAxsR9BBBnSJxskMSTwH1++NEJV70QxS
         MQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=BojWEUGQAclCm+Ny+0D/6ivjv+9T+Vyu35fN106+nB8=;
        b=mnEUWRjIuDBG97StpsQj0o1y4RmgBY23kCLf1Tp6lb4lIdJmDFLEgFgBzxQ1d++yIy
         mJuQ9FuLsZddR9g8QLS/v/vwVl+o4ezhSfdjqgMF+VWBKvD81uJj8Oitcc92XaBojS4g
         bVzaAFdSue28IAaU/Mr8Gs17HtUoCZ/jXRnAXjRgTvNr3h57LXjHv17Wyxn1L5UImwY7
         ZuGEy762FgcDMPy9+Q1oUp/jYSxUFR8Ll1Zc9Q/TlBADBw2FLxSIb1qZsMZWjxp4xaqO
         XOpbcKCGj0NxhesUwD+rym2lKdVn5169+dmIZ0iFRJEX3zFgQK40K+kjSdxV8DhRnfpl
         ASSg==
X-Gm-Message-State: AOAM533cykclAFDqFBqv1prZ+RTBge4WPEfxXLdCf+y+mcgoUEk6lQJc
        8g13KMFG30J4AjVHN6wDr4e8C2R7DD0M4A==
X-Google-Smtp-Source: ABdhPJy8zfB/hJLwe87H8dSWzs/f7Py44HUc8u7BOW21z1oCKtVo0lNRNSul4q463HQ6TuQYsyBFuQ==
X-Received: by 2002:a17:906:16d6:: with SMTP id t22mr1849962ejd.154.1610091704358;
        Thu, 07 Jan 2021 23:41:44 -0800 (PST)
Received: from cpm12071.local ([212.86.35.64])
        by smtp.gmail.com with ESMTPSA id m24sm3257596ejo.52.2021.01.07.23.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:41:43 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-2-rafaeloliveira.cs@gmail.com>
 <CAPig+cT0hkrDBptLXNjgdzA+QMx-uGcqOLezJJ5ASGnjGTZtng@mail.gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/7] worktree: move should_prune_worktree() to worktree.c
Message-ID: <gohp6ky2h4pjlb.fsf@gmail.com>
In-reply-to: <CAPig+cT0hkrDBptLXNjgdzA+QMx-uGcqOLezJJ5ASGnjGTZtng@mail.gmail.com>
Date:   Fri, 08 Jan 2021 08:41:42 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Eric Sunshine writes:

> On Mon, Jan 4, 2021 at 11:22 AM Rafael Silva
> <rafaeloliveira.cs@gmail.com> wrote:
>> diff --git a/worktree.h b/worktree.h
>> @@ -73,6 +73,16 @@ int is_main_worktree(const struct worktree *wt);
>> +/*
>> + * Return true if worktree entry should be pruned, along with the reason for
>> + * pruning. Otherwise, return false and the worktree's path, or NULL if it
>> + * cannot be determined. Caller is responsible for freeing returned path.
>> + */
>> +int should_prune_worktree(const char *id,
>> +                         struct strbuf *reason,
>> +                         char **wtpath,
>> +                         timestamp_t expire);
>
> A few more comments...
>
> It would be good to update the documentation to explain what `expire`
> is since it's not necessarily obvious. The documentation could also be
> tweaked to say that the worktree's path is returned in `wtpath` rather
> than saying only that it is returned. If you choose to make these
> changes, they should be probably done in a separate patch from the
> patch which moves the code. This is a very minor issue, not
> necessarily worth a re-roll.
>

Good idea. I will include these changes on the next revision. specially
the documentation about the `expire` field.

>
> Now that this is a public function, it might make sense for `wtpath`
> to be optional; if the caller is not interested in it, then NULL would
> be passed in for this argument. The implementation of
> should_prune_worktree() would need to be updated to check that
> `wtpath` is not NULL before assigning to it. This change, too, would
> be done in a separate patch. However, this is just a "would be nice to
> have" item, not at all required, and I don't think it should be added
> to this series since it's not needed by anything in this series, thus
> would just be noise (wasting your time and reviewer time). It's just
> something we can keep in mind for the future.

Agreed. These seems like reasonable changes and might not be good fit
for this patches but definitely something that we can follow up after it.

-- 
Thanks
Rafael
