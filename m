Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE2620401
	for <e@80x24.org>; Wed, 21 Jun 2017 18:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbdFUSsb (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 14:48:31 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36174 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdFUSsa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 14:48:30 -0400
Received: by mail-pg0-f66.google.com with SMTP id e187so20771796pgc.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I9n5XblVKrzG2cFibyKQOcKB8p+Cy98L+PUxXhhZ3lE=;
        b=JluG31MVpomgxyg9lwtlPKGL1R6XBckuaMUPnANniggpGg6ZX5wC4XC7gldUAFk5aw
         fhbiopCaZBDO34ZDlky0o3yQ7oaykp9iYNVy9F+eWlPz0WOXgAvmbANvrZNzx019Q4gT
         hXhvV+qya/wmeUpmJ76xq4ha0pfNExkyWxckgZIz2EpPNgQZofHiFWGIqQmqX5YmFvy8
         XpWrHshksG1rj8/41lTwciFPJCIKbmyIVmKBs0w6k6CuzSLXVHK3A/Cgnh54CNAtjTUa
         J5SRnV5E/Z4AGCy6PktO0MrkO4h9fNdc62pTN9NadFWRf9l/6JpCeLmLgGwKGe3gEBBJ
         72ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I9n5XblVKrzG2cFibyKQOcKB8p+Cy98L+PUxXhhZ3lE=;
        b=Hr6x03iE1mfI+FEXk8e6TrWM1pR0nwQa/eVZz30y0jCF3UHdGU/7f94DMOi+KF+UKE
         ypMcwMno2O2UY5pvHLhFNDkFJN2wYbd2BwDqiKxm3TRs1QBOGMKl18fmH+Asj4gy+zbe
         hyTSKs23hzNNYfLdjVTU8LcZ30sUwiMFXmN7loqjDgGtZkVDi5vyAWdKKkHEuYEUiWs2
         825i22awAyczkAc9YuA/7X5TmXmBnXYizIzUl2dkF3hzILOcfCPEmBI04BcVnnddgGsO
         j1rJLm4ZbmY1MehtMeBR/eyEYMVg0ruPmGF93H5MZ4FssE8DTdV3nA/K1a1Xl6ye5gii
         Btnw==
X-Gm-Message-State: AKS2vOy6Q+VD7UfiePkn4VeKllNhlsUO/crIiSK6RiQhbzU+QfaQ35o7
        Ykp+KjcLGDdd7A==
X-Received: by 10.84.241.66 with SMTP id u2mr28705502plm.30.1498070909365;
        Wed, 21 Jun 2017 11:48:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id 69sm33182839pfy.119.2017.06.21.11.48.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 11:48:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 11/20] path: construct correct path to a worktree's index
References: <20170608234100.188529-1-bmwill@google.com>
        <20170620191951.84791-1-bmwill@google.com>
        <20170620191951.84791-12-bmwill@google.com>
        <20170621021024.GC60603@aiede.mtv.corp.google.com>
        <20170621154330.GA53348@google.com>
        <20170621175740.GE60603@aiede.mtv.corp.google.com>
Date:   Wed, 21 Jun 2017 11:48:28 -0700
In-Reply-To: <20170621175740.GE60603@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 21 Jun 2017 10:57:40 -0700")
Message-ID: <xmqqmv91p477.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Brandon Williams wrote:
>
>> So your suggestion is to completely avoid doing any location when asking
>> for a worktree_git_path, I guess those code paths which request those
>> paths should be aware enough that if they need something in commondir to
>> use git_common_path instead.  My only worry is that it may be difficult
>> to catch misuse of worktree_git_path during code review, at least that
>> was one of the motivating factors for originally respecting
>> GIT_INDEX_FILE and the like.
>
> Correct: I'm saying that when someone calls worktree_git_path, the
> intent is to resolve a path within the worktree git directory.  File
> relocation just gets in the way of that.
>
> I am not too worried about misuse because the only reason to call
> worktree_git_path is to access a worktree-specific file like HEAD or
> index.

Until somebody has a brilliant idea "git_path() can be implemented
in terms of worktree_git_path()---give it the current worktree!" ;-)

Just joking.  I agree with the general direction you've shown in the
thread.

Thanks.
