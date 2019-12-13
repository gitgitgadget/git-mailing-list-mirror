Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C0BC80D4F
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92C62477E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht+miJ20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfLMTfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:35:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44143 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfLMTft (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:35:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so132202qkb.11
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 11:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/cGVX6dEicBoV9EYtXaZl1yjbB+XIOw5zg3BNtQln00=;
        b=ht+miJ20vur6l8zWrsFDYhyFWL4fh517B//9KxgauVVfU0jMzrmqpf5NxpaPVstgv5
         MrxRg5SfcLLTfIIgHg3pw55rtQ03sOKfSHpy+XYAxol1n6gnjUegZ3LliUCD6JVBmLZg
         YwGx6c6j0rgsJt9EkSKSrXE/vN04eNZBDcs4/O483rB4AxWHIP5NnRF9L65SXExhwIZC
         X3xOQ5OLFLmt7DWv52QI7508hWerpX2FRWyVB7Ezu2hQUSuQ+A/KkveaoRvwiS7t9QB3
         XEPJddR4HYqFX4ZvQLuhvVeJvR0hgPdXzCgSO/y9YG9Qmghp712upUsvX5wIjxSmqzbt
         w6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/cGVX6dEicBoV9EYtXaZl1yjbB+XIOw5zg3BNtQln00=;
        b=lqG8iN8FnBHBR45no5MayYSkAQTIt4lY0DFo3RE6A51kqJRs4P0JY+vPxldwf7fH42
         65CS7/CKofJW6EiBpW7r0pkZ9GLTOWO0qBQsz01OiTRdoSE12aPeirv43QgkL6K718lC
         1OWxkgDJEYfk5mNkjb9WGSRUfrfgLzyGr4WbPWJdbN5tRqYTiEXdXnAW9IKnBCOYycu3
         27ecWJwWw6Ch5cPSpDdPMyULqHCKCX+LWEhLERfs7AW21nBZV+HG3ua/Bj+q/7Xlk02s
         5xqQyDDnW4f5YnUxJlT+POPgD1zX5v5FbIrzUtIvfhSuzJCrQWd91EyvFHE3GYNmFf1u
         Zsiw==
X-Gm-Message-State: APjAAAU0P51XcvckkO0g01SEjZmqY6Kd/+aMwZM2SWa09katRza9zGzw
        vRdYbuU8lvItfgr4zr70JnkuEICusbs=
X-Google-Smtp-Source: APXvYqzNxr9JSWWCIJ29qQRJ4wha64bORUCL1nGK3jLwHPD7YAYVu6NdMkMdFt96/NMqK05hRfdylw==
X-Received: by 2002:a05:620a:a0b:: with SMTP id i11mr15450304qka.11.1576265748756;
        Fri, 13 Dec 2019 11:35:48 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:1414:e94c:6df7:afb8? ([2001:4898:a800:1010:c549:e94c:6df7:afb8])
        by smtp.gmail.com with ESMTPSA id d25sm3704080qtm.67.2019.12.13.11.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 11:35:48 -0800 (PST)
Subject: Re: Parallel fetch and commit graph writing results in locking
 failure (even on linux)
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
References: <492636883.190386.1576264842701@ox.hosteurope.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bdb9201f-b77f-ab3c-251f-d902c76fa9bc@gmail.com>
Date:   Fri, 13 Dec 2019 14:35:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <492636883.190386.1576264842701@ox.hosteurope.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13/2019 2:20 PM, Thomas Braun wrote:
> Hi,
> 
> on git version da72936f (Git 2.24, 2019-11-04) and debian stretch I currently get every now and then the following error during fetching
> 
> $git fetch --all --jobs 12
> Fordere an von origin
> Fordere an von XXXX
> Fordere an von YYYY
> Fordere an von ZZZZ
> Fordere an von EEEE
> Von github.com:tango-controls/cppTango
>    37cc52f8..4550a743  tango-9-lts -> origin/tango-9-lts
> Commit-Graph Generierungsnummern berechnen: 100% (14/14), Fertig.
> Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.
> fatal: Konnte '/home/firma/devel/cppTango/.git/objects/info/commit-graphs/commit-graph-chain.lock' nicht erstellen: Die Datei existiert bereits.
> 
> Ein anderer Git-Prozess scheint in diesem Repository ausgeführt
> zu werden, zum Beispiel ein noch offener Editor von 'git commit'.
> Bitte stellen Sie sicher, dass alle Prozesse beendet wurden und
> versuchen Sie es erneut. Falls es immer noch fehlschlägt, könnte
> ein früherer Git-Prozess in diesem Repository abgestürzt sein:
> Löschen Sie die Datei manuell um fortzufahren.
> Konnte 'myFork' nicht anfordern (Exit-Code: 128)
> Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.
> Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.
> Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.
> 
> (Sorry for the german text, this is not easily reproducible.)
> It complains that it could not create the lock file as it already exists.
> 
> I've set the following possible relevant settings:
> 
> [core]
>   commitGraph = true
> 
> [fetch]
>   prune = true
>   writeCommitGraph = true
> 
> [protocol]
>   version = 2
> 
> Anything obvious I'm doing wrong?

I don't think so. I think you just found a bug where the
fetch.writeCommitGraph logic doesn't work with parallel fetch
jobs (only one can write at a time).

I believe the fix would be to write the commit-graph after
all of the jobs have completed, which should mean we need to
move the call to write_commit_graph_reachable() somewhere else
inside builtin/fetch.c.

I'll take a look now.

Thanks,
-Stolee

