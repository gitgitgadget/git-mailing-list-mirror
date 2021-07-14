Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBC9C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F274061289
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhGNL5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhGNL5W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:57:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD494C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:54:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dp20so1023686ejc.7
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oVtq7c9k7dz8bmFABMo8RXKxDVr98O0tkhZIxswAEPA=;
        b=MuGRJTRMfq4f/GDX93C2TTL2fLYxNvblOsx9YJc0jAsGq7MUAM5MBOXxnVSxkKJ0Ve
         zv8rFdVf59b6XB0o3W+Ee/1SAlj8SFzzCCQ/Is3HnVCuynMfBUR41Pi+5SkwFjl4ut/E
         0DPj2QPjVYZL1uNtlJgh46gm79rreX3+4o/vHsYDdWE0pKWEbM8O9jyHgjxtCwg8Yvh3
         RBdS0SQ88Afj5c7xnNaXmVMD73rshGtco1eLgc7TORq6dS0i+0pdU0GjQFgiEwD5LCFd
         /Y9q1BeIWMTUFNXdJo6dKYvos5R7wNemEp5THb0lORRThbhqcTacc5T4Ox2qw6XjK7xY
         TwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oVtq7c9k7dz8bmFABMo8RXKxDVr98O0tkhZIxswAEPA=;
        b=VDIBvJ5RVhosNEQYIgtp3kX3FsdmYaDzO3E7khoO41k7XGvkXbJg9aggfO0vxDFKSb
         w+VWDWZzSiKttP5mxGPTlM0uoqxFeTDuJAn9NumXKiRwo7f0DF+grrxJ3GJAMuCrQpd9
         9SYQ9B1GOSzCN+zLITu8qZwvBGez3meyXzNya0rDVvgnLq2EVjrXC5ZERcJyyaLa4+Lg
         xVo2DzHOPft/0unj5lQ67fY9eStoXbn3VziQiZYrv1EDv2C87+Y9JycXyVU1zV3z87KJ
         xxOI6dQ5Ql2v6F7KlQHk8mFIb2sSP6MPuXDErA2SyF2l+NkoclYUGtrC2RyvmgzYJqaG
         XBGA==
X-Gm-Message-State: AOAM532+kxdGFEQ47FIs9G7Ietbgjox059WtEdqrGXQbynP/j2T4PulS
        jbIruOxQFBkRaCg+hFGkG1I=
X-Google-Smtp-Source: ABdhPJxtzSz5GrA6iO1shNdtx55wVokCAQtpXmoM7bv5buWJFs2pjuemXSTFWG0sN5uvlQJFPUlA4w==
X-Received: by 2002:a17:907:9604:: with SMTP id gb4mr11970112ejc.142.1626263669367;
        Wed, 14 Jul 2021 04:54:29 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b25sm920005edv.9.2021.07.14.04.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:54:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Date:   Wed, 14 Jul 2021 13:53:01 +0200
References: <xmqqmtqpzosf.fsf@gitster.g>
 <CAFQ2z_P=9Suh0kO6E44hUOyNFOAKcmcUg_x6AQFP9jhHrBA6RQ@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_P=9Suh0kO6E44hUOyNFOAKcmcUg_x6AQFP9jhHrBA6RQ@mail.gmail.com>
Message-ID: <87im1d156t.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Han-Wen Nienhuys wrote:

> On Wed, Jul 14, 2021 at 3:07 AM Junio C Hamano <gitster@pobox.com> wrote:
>> [Stalled]
>>
>> * hn/reftable (2021-05-20) 27 commits
>
> I have some updates for the series pending, but I'm waiting for the
> preliminaries (test fixes, the errno stuff) to hit master.
>
> How do other folks deal with dependencies between topics?
>
>> * hn/refs-errno-cleanup (2021-07-07) 6 commits
>>  - refs: make errno output explicit for refs_resolve_ref_unsafe
>>  - refs: explicitly return failure_errno from parse_loose_ref_contents
>>  - refs: add failure_errno to refs_read_raw_ref() signature
>>  - refs: make errno output explicit for read_raw_ref_fn
>>  - refs/files-backend: stop setting errno from lock_ref_oid_basic
>>  - refs: remove EINVAL errno output from specification of read_raw_ref_fn
>>
>>  Futz with the way 'errno' is relied on in the refs API to carry the
>>  failure modes up the callchain.
>>
>>  Expecting a (hopefully final) reroll.
>>  cf. <CAFQ2z_NzykfcBSvtHQ10RZWxLP48+qArZk9HbDJQB4tNX-GtYA@mail.gmail.com>
>
> AEvar posted the corrected patch as part of his follow-up series.
> (https://public-inbox.org/git/patch-04.17-270cda29c3a-20210711T162803Z-avarab@gmail.com/).
> Would that work for you?

I re-rolled this just now as depending on:

    https://lore.kernel.org/git/patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com

And submitted a s/v6\?/v7/g at:
https://lore.kernel.org/git/cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com
