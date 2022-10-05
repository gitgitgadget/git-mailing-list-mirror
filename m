Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7175C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 17:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJERPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 13:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiJERPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 13:15:16 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC522B37
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 10:14:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e129so15760121pgc.9
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wLpVkFIas8sGGDzDO/TlO1bSVZ/omedaUIJxeEIYJ8=;
        b=qs9DdRWD7PirLKb/Rrt7UT+nmfhSMWd8ni4BOhdbLovaX4Oosox1r2SjVwo0oSq6H1
         PZBrdcfD1MiEzj2fzED/s6VbK6CbvTJNgeniXzZxd2JWzgUR5aWHqxbwoFPrNYyFd5xg
         I3lKM/394r7F8TPHr8TzuNkDVW9PriQwRXCYzvARj7g31Dbo/ofJnZPmYx5jWoHqR5KQ
         Yn3zx5/M6sikKNjf1FjZmQqPVPOd5NqzmaZIe8btMHsd05EQLs1HVQCcM216OQblA5oK
         8ul2HCbxEyJHTkVxP8C5OQRQOLlDr3tdV0xnnFEiiNWanDFpGk6htQJOvJwhK6zS6jRY
         AGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wLpVkFIas8sGGDzDO/TlO1bSVZ/omedaUIJxeEIYJ8=;
        b=Gfbc+viK0pP3WKBbzZiVwok5qTz25u+bLrP6JkH13t9SNGxcMLNF6FyV2nKE3C3tUA
         L/Sq/bl17MoRKxb3xqcDvjyiMz2ethk0DkTNI+4h+hDvhf8+pzppZ7umuIeLecLkGbOH
         v3FnmPhzWRpj5DIGKXvsF+EhM7bOb0Sj+vlCKUHQWiRMosGL54RKF28yjhpN8XlCsfd8
         C03Qf4Pn0RvdvSQPVFS0rld4LdZAX8pD+SH7c7ddhwCVG6yCIp8uxza2N2yxNR/RgT8C
         zQcUciGYTpJZSVh513SN9H0aETh0qjiHTr1LvG6NJD0R/seNB5lWRZ1a17QElv46Q+Xp
         t2BQ==
X-Gm-Message-State: ACrzQf3QXX3tHAF3bV60yh8EGcXscbtyyG3ecQ45l7EJ5AZ60rZ7HcL2
        Tq+BhxLMVXcCTxqWEufi6O/BjQCBvAM=
X-Google-Smtp-Source: AMsMyM5rxKesu/+sYsoRm/0UhTGMbhb/Sdzx5wXejHTRB23K9lhFr78VXZxjTSOHGDEIGaWkVL34VQ==
X-Received: by 2002:a65:5b8d:0:b0:434:e318:80f with SMTP id i13-20020a655b8d000000b00434e318080fmr701921pgr.97.1664990093637;
        Wed, 05 Oct 2022 10:14:53 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902cf0a00b00177f25f8ab3sm10751045plg.89.2022.10.05.10.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 10:14:53 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] rebase --update-refs: smooth out some rough edges
References: <20220930140948.80367-1-szeder.dev@gmail.com>
        <05c5076b-eb78-5381-4eba-863a84190755@github.com>
Date:   Wed, 05 Oct 2022 10:14:52 -0700
In-Reply-To: <05c5076b-eb78-5381-4eba-863a84190755@github.com> (Derrick
        Stolee's message of "Fri, 30 Sep 2022 13:29:58 -0400")
Message-ID: <xmqqo7uqqjjn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> On 9/30/2022 10:09 AM, SZEDER Gábor wrote:
>> A couple of cleanups and fixes to a new 'git rebase --update-refs' feature
>> introduced in the current release cycle.
>
> Thank you for examining the feature closely. I think most of these
> are clearly improvements.
>
> I'm less sold on patch 4 which removes whitespace a bit too
> aggressively. I agree that the situation with multiple refs pointing
> to the same commit is somewhat wasteful, but I also think it is
> important to use whitespace to highlight the different groups of
> commits. It provides a nice break for the reader to quickly find the
> commit they are looking for within each group. I'm not sure how to
> add a whitespace break only at the transition point between the
> update-refs commands and other commands, but it would be nice to have.
>
> Otherwise, everything looks good.
>
> Junio: I don't think any of this needs to rush into v2.38.0, since
> they are mostly cosmetic changes and helping users get out of bad
> situations.

I earlier agreed with the last paragraph, but after having read the
series again, I tend to agree with the paragraphs before that.

Thanks.
