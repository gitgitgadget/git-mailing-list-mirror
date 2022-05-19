Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C6C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 19:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243665AbiESTLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 15:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiESTLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 15:11:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1E5A2C7
        for <git@vger.kernel.org>; Thu, 19 May 2022 12:11:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s3so8124759edr.9
        for <git@vger.kernel.org>; Thu, 19 May 2022 12:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EycJWpKFCTySpOIP7UZrGpUrlar6bKIjgrgVKTPYVJc=;
        b=NZVLxbph8BQFyK6cbk32+ohJB9LhrrzXdf2p36gnMEG5vnvdeyBYFpczqoMQKz+AIK
         s/yF4BhVAb3jCvSOCxwsAXBqpjDFcs/oxmBU8Xjpnq8J4TUcjfY0Sy3OVt3zEuW48Q+1
         pAsx83zmOQqlwjrQ8a3D7nwvjkvG07PrLzIRFQVdN5eOQFyGOU7F7J6egwJR2IuD+QM2
         FvOyF9k4fhChQIFXOnd3ZFXbGHoFQnEfILj2YiS5vm5oyVNphF5k/xb57dZnpJjz90UX
         jnUORh68SNXShd9YYGL7feCud0PZMR2fC/TgZqDGyhW8p7CcMDI22p3GiyMBfDxu4/1B
         XqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EycJWpKFCTySpOIP7UZrGpUrlar6bKIjgrgVKTPYVJc=;
        b=rWLgk9YJNilPv4tjRYby+RT5WxT03TLn1ERoIOrIl6+TOLbSvJz85fUhRqZu+1/9Do
         3C92zNCIRzGcbmXSnhO7q+OjibZZQf/EyLE+vrtkU2N5nmd93RgU80ZhzcyGcgruqhAF
         WTnKUeITh33AG71uF5xtVfx9wVEdNfq7wVIEBF8zlWuCa+uHbPhlK9jQKAEyfBce9Qug
         Yl4y6N6EK/w/KzQNm0DBDtRHYyL3ZpAiNWe/h5L+BnAehERi6xDR0TFaAXfDTr/FYaa0
         YN2OEGJQSHVAoifkxpriil3tDPD31xQiU8XxSJw90+bHeuZwRALq/3A0/FDPSdtYkRCY
         euzg==
X-Gm-Message-State: AOAM531fjZr0N7rBQB/ghDRtb7ei9N6QYjYFkwTMelSKZemf5rNwq5zH
        tfqit/73qMRAX93wHKsOnMg=
X-Google-Smtp-Source: ABdhPJz3eA+/vMk9UOqfiaOzAzs088k/zajQZQdn0ROC+dGZfD2Tn6zwyg5Ks7LLDxntBc1p9hQbFw==
X-Received: by 2002:a05:6402:1ca5:b0:42a:a393:ff02 with SMTP id cz5-20020a0564021ca500b0042aa393ff02mr7244527edb.76.1652987502226;
        Thu, 19 May 2022 12:11:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id cy23-20020a0564021c9700b0042617ba63c8sm3246537edb.82.2022.05.19.12.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 12:11:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nrlYi-002HWV-T9;
        Thu, 19 May 2022 21:11:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        derrickstolee@github.com, jrnieder@gmail.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [RFC PATCH 2/2] hash API: add and use a hash_short_id_by_algo()
 function
Date:   Thu, 19 May 2022 21:07:51 +0200
References: <cover.1652915424.git.me@ttaylorr.com>
 <RFC-cover-0.2-00000000000-20220519T113538Z-avarab@gmail.com>
 <RFC-patch-2.2-051f0612ab9-20220519T113538Z-avarab@gmail.com>
 <xmqqbkvtr079.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqbkvtr079.fsf@gitster.g>
Message-ID: <220519.86wneh2v83.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 19 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Add and use a hash_short_id_by_algo() function. As noted in the
>> comment being modified here (added in [1]) the intention wasn't to
>> have these end up in on-disk formats, but since [2], [3] and [3]
>
> double [3]?

*nod*, sorry.

>> that's been the case, and there's an outstanding patch to add another
>> format that uses these[5].
>>
>> So let's expose this functionality as a documented utility function,
>> instead of copy/pasting this code in various places.
>>
>> Replacing the die() in the existing functions with a BUG() might be
>> overzelous, it's correct for the case of
>> e.g. write_commit_graph_file() and write_midx_header(), but we also
>> use this for parsing on-disk files, e.g. in parse_commit_graph().
>
> If we know the offending data can come from outside, not from
> literals in the code, then there is no "might be", such a use of
> BUG() is simply wrong.

Fair enough, we could change it to have 1/2 of this (the writing) use
BUG(), and die() for the other part, or just leave it as die() for both.

>> We could add a "gently" version of this, but for now I think that
>> worrying about the distinction would be worrying too much. If we ever
>> end up parsing such files that'll almost certainly be a bug in our own
>> writing code, so the distinction would be rather academic, even though
>
> It would be a file written by an ancient buggy version of our code,
> or a buggy third-party reimplementation of Git.  It could be that a
> new version of Git is using a yet-to-be-invented algorithm this
> version of Git does not know about.
>
> The distinction matters in that "The version of Git I downloaded and
> built last week out of the latest release tag said BUG" should mean
> only one thing: that version that reports BUG() is the culprit, not
> some random other thing we do not even know where it came from that
> left a corrupt data on disk.

Makes sense.
