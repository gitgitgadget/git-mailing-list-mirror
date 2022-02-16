Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE4BC433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 23:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbiBPXfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:35:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbiBPXfb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 18:35:31 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463DA2402DB
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 15:35:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 37-20020a630e65000000b0036c461afa9aso1948164pgo.20
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 15:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=kIG1U11yM0/LKDdzysekqAwz/P1rMrarnAYMp6xJMbQ=;
        b=ejHOeEdabB4qjUYysEPHYbeVOGurZN3f8K9d0Ft/CGjsrxHSm9mKrR05VR9e7xM9dX
         R2BFokg6ZJfsYocpFKFUwzWXnmaYe/7A8Zk2FtL2QBLTvwQLwSmdKazaFSVnc8jJRV3u
         LqdnZ6kNYlCtNqgZ6aFjOfF6Rt1+bqOfRAs6YdGv3QGXfvNytxM9PWvJwFPrBHtn8HRV
         wkoXMuqFc1iySoeUKql+JgJY9LCQ8gVWemx4Fj1WFcwhAP2ytvbdNhWb1ZWGVFxvog0z
         RpgSiykVY7/tm3MowR5cOu4H7Puecd3XZ6zy2zj5DXYkJHLQ3fu4WnFeXTsLTWTK8zzd
         WoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=kIG1U11yM0/LKDdzysekqAwz/P1rMrarnAYMp6xJMbQ=;
        b=QO4W1WWH+ALn1lldYychN/4bJziWLGnmuZKV++SLBK70Kc6rT7mQZvb9PUnTtkhI1V
         Xca+fOw5ngXGIIt/NL9/udmuezQtWqfA+TqysyemrI/AEoD+pI4Dn++W0wQjk393ctqL
         JbJ6+PNpQ08bCxTj+aXsf6t+pOeWxIwp6VV68OLWbnZzaXU7tHmS/DBk8CLIkvvK7kul
         ce8E3QR6CLCvNzLlkGN7qhLUZ33QR4ZXi+IjBb3KgXCEC+e3Z53Z7a1HY0pJIDQwSpXl
         iDAk3EZ4GqTVTVXvgCSnaXkGK+QLyBJa7Z4S2UpAjc0ShYWIU67apvljb6nAU7Se054P
         qEEw==
X-Gm-Message-State: AOAM531nLCYi8BRJgj70q3lRV24f2eRJqlaj9ec+zrs1HLSVcqqvsMxv
        nprWwWOXDhFYrmQ9cAfBWUJvNq+zg9mci3ORqRhH
X-Google-Smtp-Source: ABdhPJxTA/spQbOxjQCkJN47dGjDo33p8EdVNmb0yQHSGvxz5jY099fsRwW9RLyg7Zv6hDJNeCVYHGxcuZbJ6LS0k3Sx
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:1687:b0:4e1:45d:3ded with
 SMTP id k7-20020a056a00168700b004e1045d3dedmr210236pfc.0.1645054517699; Wed,
 16 Feb 2022 15:35:17 -0800 (PST)
Date:   Wed, 16 Feb 2022 15:35:12 -0800
In-Reply-To: <54fdee845bea7f67f46817417f8e5a504bd39665.1644565025.git.ps@pks.im>
Message-Id: <20220216233513.1973985-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: Re: [PATCH 4/6] fetch: report errors when backfilling tags fails
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:
> @@ -1628,8 +1630,19 @@ static int do_fetch(struct transport *transport,
>  		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
>  
>  		find_non_local_tags(remote_refs, &tags_ref_map, &tail);
> -		if (tags_ref_map)
> -			backfill_tags(transport, tags_ref_map, &fetch_head, worktrees);
> +		if (tags_ref_map) {
> +			/*
> +			 * If backfilling tags succeeds we used to not return
> +			 * an error code to the user at all. Instead, we
> +			 * silently swallowed that error and updated the local
> +			 * state of the repository. We now notify the user of
> +			 * any such errors, but we continue to make sure that
> +			 * FETCH_HEAD and the upstream branch are configured as
> +			 * expected.
> +			 */
> +			if (backfill_tags(transport, tags_ref_map, &fetch_head, worktrees))
> +				retcode = 1;

I think s/succeeds/fails/

Having said that, I don't think that we need to describe the past here.
Notifying the user if something has failed is expected and doesn't
require an explanation about how we didn't do that in the past.

Everything up to this patch looks good to me.
