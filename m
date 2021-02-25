Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F866C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B9264F13
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 13:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhBYN6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 08:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhBYN6g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 08:58:36 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B855C06174A
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 05:57:56 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v64so4084056qtd.5
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 05:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RTh5TDInT6PeaL9cu57tj/UoQ4t6RIwGUKmYzH5sdAo=;
        b=q+T3wgXrwtMEKFhcTSRcWiDjdXea1haIeS7K929kMHI/7Qm79QLH8+rg9vG2o6CM/8
         z8L6KOQZARRwwk1hbC4JUmkMitl7Drb4983sCjY6c/k8MVt8Wz96ReX+G/l+gdYYL+kR
         iOaVtUzj0r7JDlXA2iESnQOh+vK6kwNGr++sje5OLtP6DYBqxhdWJR8lXTymNaLnHwNC
         EGrtXUjKRLRzBuG94pROrT/3Zb55ImmeO3+TUQpEI81nxbE+inQW8xPYGLpTTxEKg332
         wk41AeS8xSuP0aEBpm19kj0pjNC/FaS1vzczR6b9oYFTkBu5Q+HKUK0qKLbYkqA7eLK7
         btiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RTh5TDInT6PeaL9cu57tj/UoQ4t6RIwGUKmYzH5sdAo=;
        b=Xe9FXvMi1RcgWgUOWcPDiT6uY6INBVZ8q4/D02wUPMF8OOcwtMp/avwULXDn7YEzWj
         1SltIa7OATiIMj0EAtfFf9r4AdWvCcqW17uZVz7bqX1EeKSJsgU3nKnlMN5fsoqtoGug
         zY3qU/IaeKyKUjCHFJodNddTXxY9Iuc/rQHNY2VtBoTi0U/gUxHxuJyvX5cppUinE7Ir
         kmkpiTFO+Zdv3j1rAYiigkzmK/fFr1CI92pCVUA47iH6jEPjzIAEhXcA3v2XT9j38vYi
         mRAx7x0+tLt6wFXl2qwaDT8QmKUuWs/Kn6zVePhvmDuy2zjAg3uSKwnNcmARKlydJ7RA
         EgCw==
X-Gm-Message-State: AOAM530LrOR0JrSvnSTU176kAXsy6eYon6WVLjpK5uoYFHVgb+JOSox7
        GJeq3pwi2ry7mWEZJVApft0aJQi6BmQ=
X-Google-Smtp-Source: ABdhPJwOeMOAgjhwnTjhvo2Vlcqw5kq+ht5c6yDbEfDF9Io70Q3CHgyutz4oNHzEPiw6gEVrth1YYg==
X-Received: by 2002:ac8:7a8b:: with SMTP id x11mr2324695qtr.253.1614261475210;
        Thu, 25 Feb 2021 05:57:55 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id p6sm3968159qkg.36.2021.02.25.05.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 05:57:54 -0800 (PST)
Subject: Re: Wrong configuration variable mentioned in git-push documentation
 (examples section)
To:     Adam Sharafeddine <adam.shrfdn@gmail.com>, git@vger.kernel.org
References: <CAAxrY9yjTKV8-K0AmO4fBmtDrSB4KkN_xKOMmtSb-dvixJNaEQ@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1fd7d816-1572-8563-1c4d-4be83926e4a2@gmail.com>
Date:   Thu, 25 Feb 2021 08:57:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAAxrY9yjTKV8-K0AmO4fBmtDrSB4KkN_xKOMmtSb-dvixJNaEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

Le 2021-02-22 à 00:07, Adam Sharafeddine a écrit :
> Hello
> 
> In the file Documentation/git-push.txt under the EXAMPLES section,
> specifically under
> `git push origin`::, remote.origin.merge configuration variable is
> said to configure the
> upstream branch for the origin remote, when in fact it should be
> branch.<name>.merge,
> where <name> is the name of the local branch at which HEAD is
> currently pointing to.
> 
> Here's en excerpt:
> 
>> `git push origin`::
>>          Without additional configuration, pushes the current branch to
>>          the configured upstream (`remote.origin.merge` configuration
>>          variable) if it has the same name as the current branch, and
>>          errors out without pushing otherwise.
> 
> 
> I'm still learning Git so I thought I would share this with you (I got
> confused reading
> the examples). Maybe I'll learn something new or/and correct the
> aforementioned error.
> 

You are completely right, that example seems to use an old and now non-existent
(at least, undocumented in git-config(1) [1]) configuration variable.
I encourage you to fix it yourself and submit a patch :) See [2] for a nice tutorial on
how to do this if you are interested.

Cheers,
Philippe.


[1] https://git-scm.com/docs/git-config
[2] https://git-scm.com/docs/MyFirstContribution
