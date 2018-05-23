Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A19EB1F51C
	for <e@80x24.org>; Wed, 23 May 2018 01:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753591AbeEWBI5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 21:08:57 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43090 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753512AbeEWBI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 21:08:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id r13-v6so10983145wrj.10
        for <git@vger.kernel.org>; Tue, 22 May 2018 18:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aouCvfdY1rpU+J1Q5XvHaqPGI9ZZlGofu2ieWTSfNzU=;
        b=czodnwcyowCX7EAAFEbhwdbgmWI+x1/R17KLS99gQssZ8gV94OdjvnHen6N6O93bm2
         d9G8foqGub+doHpsnCUbreAWMIJVJ0ZpY7+woFLKEKHvuNa1LQbsAPdvxtR04VgAEKF4
         enJ71DwmB2wdd71GDOYQLFlAoovO4VTceKmqoaP/1kEdlGN/y/q2pakh0iAdZrDFATzm
         SBioT8fT8bLIpNpRHA5/sqilSsuQSdcPGiTQW143ogIV9C/QpdQlNJ5JG4wOzm/DSnuS
         x6bXHz2NeK/Yq5tv68O2nFwzV92tW/k1f0ikqXpajp3X5iht9ESamhmwFvnIzD2xt/nJ
         E55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aouCvfdY1rpU+J1Q5XvHaqPGI9ZZlGofu2ieWTSfNzU=;
        b=sFpI5ZqOXaQCWJkMZOYjvjPdDCVQlxk0aJz+oi0eUC/9AaRhQUT+bOyKFzSmTL/Lws
         voPqi9EGTJbSj8qU/Yg331Y/j7IAjVNfiZvKru3TrLEOKuJmnkHKJo9zezoQtn9DhMFb
         c/YH+iLH+iTdLS3IDwY+SeQ7IcuAg8YMfAym1U3gCNHUulC238jn4szwI9PGIiSq7lgf
         SQuh8mciqsBZ3MugPJGJPUaoR8QL+kb3H9ZU8j0YW3EWQvGbhHH4neWR8oAEnRT53JFv
         kQPx44YS/vkhN2W/O8ocA0CIyDjWkxuIvRMcwnUFCsQWCzLOO/wx/O+pPso+2ppPHVuN
         oZvA==
X-Gm-Message-State: ALKqPwfhO4GBw7lb240naN11wrz4eW4QJ3QE/nkrqtwLgo1g7Kqop5fX
        lqcCsXNuf0B66Qsik+zNmg1TnZDQ
X-Google-Smtp-Source: AB8JxZpOe/E0m9+KTCdEyF4qDAJuSIpa4WLbVauLXnaFgtCQ91TN5Fj97wfjC+3rBbwI/5acpkmEjQ==
X-Received: by 2002:adf:8e27:: with SMTP id n36-v6mr467887wrb.27.1527037734950;
        Tue, 22 May 2018 18:08:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o9-v6sm18657481wrn.74.2018.05.22.18.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 18:08:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] fetch-pack: space out sent "haves" in negotiation
References: <20180521204340.260572-1-jonathantanmy@google.com>
Date:   Wed, 23 May 2018 10:08:53 +0900
In-Reply-To: <20180521204340.260572-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 21 May 2018 13:43:40 -0700")
Message-ID: <xmqq36yjxjoa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> I was thinking about fetch negotiation in some non-ideal situations
> (specifically, when the client repo contains two or more independent
> branches that meet only somewhere far in the past) and thought about
> skipping over intermediate commits, using exponentially larger skips as
> we proceed, when generating "have" lines.

I recall a "wouldn't it be wonderful if we had..." discussion on
this exact topic much earlier in the project's life to skip
exponentialy (I think fibonacci was what was suggested in the
thread) and then backfill after overshooting, but I do not recall
anybody following through and coming up with a concrete design
and/or implementation.  Maybe protocol v2 in place we can have
something this time around.

Looking forward to read the remainder of the message and the patch
;-)

Thanks.
