Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743A0C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiLOJSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLOJSc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:18:32 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4858F4732C
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:18:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id u19so32279059ejm.8
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iiBmNYPnwResYFVFmjwnMb7qOC8TOlX9ivQr/W8uLMc=;
        b=f+VoOPRe8v6DsIE8EzK5knqzpNA7f/jIuM5CctR/EErm7cFtAx2yokXsuQoM6RXqpR
         WJr/NZv6zXKgsfiQN3ynIRXKnNCJc6GDlswUFsFR5vz+enWEZ79fD3IMmJV3AujXWUG2
         cKPRGPK5i1LbbEVGxAkxZvPEDIym41bglHjf+4dKNaKprIP1FY7Zo1Lk+G0X9ODkkWPv
         YWNw6bm+l7a4Q0kDTzcdZevleRL20tuPVHiRleWIW9O3YyDYfFJs452FsKp3tAwP3bGf
         CfJBYXU8swgy4zb2zghOl8j5b9fZdKJzkk4ItBB/4GtOA+D+Oyffv9P/6zfghSiDm5ev
         24MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiBmNYPnwResYFVFmjwnMb7qOC8TOlX9ivQr/W8uLMc=;
        b=4mHJOIzTC9tO2QbCQvvF97VNKwvYnvDTNwtmo9LxWEjpCSKXDexWRF4RKOZyBbW3MW
         aSecB8zA1GvyP3nUYTcfgPhLhoronPvMjOqepUKkt8WNrh4VvED1ey3pYlvpMOjp8rjl
         uXjjMhA/tdLYP7+30u+rMY2QxDkYE0DNLbETykvb6i28ypC/MlY1arDOo8dJzJubUq3M
         jtIhM6ZNXiaPH040/34c7J4f3HukrtAT/fpXculAoOMFpar9x/kuGwBewiA5mLawJIq7
         bLe9KTJGf/0AcJZwiP6v3QAWiTz9OF5iHJO09xNxHBVVrhQalla7fn1Mz2JvzulW0Pm2
         9NKg==
X-Gm-Message-State: ANoB5pl4+CJdA50ZJE3LzXIesRe1ekSZYUYBVNyIOF0yXNCEtDBRfrli
        WjHEbGM/oh9pvb1Ky2zJ9GM=
X-Google-Smtp-Source: AA0mqf7DP6mSAHSSwCKLN6nnDNerua4MQd1dASFJiRaG1/J8K7L5wXEan+vayYpg+p1y4SK6Asp6Dw==
X-Received: by 2002:a17:906:d15a:b0:7c1:32:3574 with SMTP id br26-20020a170906d15a00b007c100323574mr23335468ejb.12.1671095909801;
        Thu, 15 Dec 2022 01:18:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id lb19-20020a170907785300b007c0a90663d5sm6771455ejc.162.2022.12.15.01.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:18:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p5kNo-0069qJ-2F;
        Thu, 15 Dec 2022 10:18:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: ag/merge-strategies-in-c (was: What's cooking in git.git (Dec 2022,
 #05; Wed, 14))
Date:   Thu, 15 Dec 2022 10:14:20 +0100
References: <xmqqiliewbje.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqiliewbje.fsf@gitster.g>
Message-ID: <221215.865yed3tzv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 14 2022, Junio C Hamano wrote:

> * ag/merge-strategies-in-c (2022-08-10) 14 commits
>  . sequencer: use the "octopus" strategy without forking
>  . sequencer: use the "resolve" strategy without forking
>  . merge: use the "octopus" strategy without forking
>  . merge: use the "resolve" strategy without forking
>  . merge-octopus: rewrite in C
>  . merge-recursive: move better_branch_name() to merge.c
>  . merge-resolve: rewrite in C
>  . merge-one-file: rewrite in C
>  . update-index: move add_cacheinfo() to read-cache.c
>  . merge-index: add a new way to invoke `git-merge-one-file'
>  . merge-index: drop the index
>  . merge-index: libify merge_one_path() and merge_all()
>  . t6060: add tests for removed files
>  . t6060: modify multiple files to expose a possible issue with merge-index
>
>  An attempt to rewrite remaining merge strategies from shell to C.
>
>  Tired of waiting for too long.
>  source: <20220809185429.20098-1-alban.gruin@gmail.com>

I submitted a v9 of this during Taylor's maintainership, but it fell
between the cracks. I've submitted a rebased-on-master v10 now (there
were some conflicts):
https://lore.kernel.org/git/cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com/

It's just the "prep" patches, the real meaty part is converting the
merge drivers, which will come after. Some of the performance numbers
for those are really impressive...
