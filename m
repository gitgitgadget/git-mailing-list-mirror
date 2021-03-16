Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796E4C433E6
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 08:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419AA64FB5
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 08:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhCPIwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhCPIvL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 04:51:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F5C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 01:51:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h10so20474368edt.13
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=cYcRObTifP/y2F2izlBbZ91HchCz/VLRHOhy5hEuIKE=;
        b=Vg9k4Sl6JxLIRJm4GRALiCBBJGBeNNrP5mbwQBXyjhmTdSUW0Q4nOBBhL4efVUFpl8
         KiXD/tCRRK1PJnrBOXWwFJ9rSOcskbhNs8YthnETuWw7Etd7zPSUa8nGiz/uyTMTQarU
         lyZ/bzvEzOpZ3OrPU5gK8gHov0gMs+Esxc13pqhbv/fvNo4/yoE5KT8CK2qJ2hgwFjhP
         jRpA+6rJqIVj91814WQmgWJ4OImr/HDPLyR2h/iU9wFV3fqisHkkaVCSpT0a4FT/Yknr
         ARwfhOxc/Bhv5VuDNlTPqG8i3fMSlgz7r3X2ALBNHxLzPqNN195A/bBLzZOWQU3ZJ1o0
         +m1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=cYcRObTifP/y2F2izlBbZ91HchCz/VLRHOhy5hEuIKE=;
        b=Etp/jmoeq9NGEk3mBhhgPOxEAV4G2wL1c52q6V+5qyQYRQVK3OqlQrUoyyZwlE1TKt
         L/LzK7g6e4QhACB8UGc5IxNh5brIX10GlLjtwR943GJqltFXqu8yIBBbGheDZGiRvX9p
         qvVVt6pr73Id/YDsjE2H7ySPUxA/XqXwZ+zjbdvoqvjqfP55zjimG8ISiLwOQ5H1CGX3
         F/NOQ3d1xDFctxB4lJzzhnaOqJIYQ8oH80MmkrwDzm6BVxUastMYyNhhYcyP0UF8x+xG
         Nq3OYNkdqj2S1QWBwC0pc6PLpuJKDsOoOHPNyX512FJ4IAAgYVgUzl/2d3I2/GvjN8I5
         nSgg==
X-Gm-Message-State: AOAM531Vx+dkdXPiACGTbfQrhXNWPn5Ew0M4T21MmQI3XdhsfyA/fx/C
        I1VQtkNcr0YtWfko40OCSY8=
X-Google-Smtp-Source: ABdhPJxZu1l0fSKbPOrhvRiQiE6KS6MGsK2LGBQJ88FSk7IcO+pvG+T/KfPmDB2/8+FyShXeAJkheg==
X-Received: by 2002:a05:6402:17d6:: with SMTP id s22mr34383599edy.232.1615884669589;
        Tue, 16 Mar 2021 01:51:09 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g22sm4185708ejm.69.2021.03.16.01.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 01:51:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git v2.31.0
References: <xmqqwnu8z03c.fsf@gitster.g>
 <20210316051459.oqsl7bhwh6he5cql@glandium.org>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210316051459.oqsl7bhwh6he5cql@glandium.org>
Date:   Tue, 16 Mar 2021 09:51:08 +0100
Message-ID: <875z1rfpmr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 16 2021, Mike Hommey wrote:

> On Mon, Mar 15, 2021 at 12:30:15PM -0700, Junio C Hamano wrote:
>>  * Two new ways to feed configuration variable-value pairs via
>>    environment variables have been introduced, and the way
>>    GIT_CONFIG_PARAMETERS encodes variable/value pairs has been tweaked
>>    to make it more robust.
>
> For the record, this is backwards incompatible with git-programs in
> $PATH that were expecting the old format (e.g. git-cinnabar releases
> using an older version of libgit.a).

What isn't noted there is that we're still parsing the old format in
some cases, see f9dbb64fad (config: parse more robust format in
GIT_CONFIG_PARAMETERS, 2021-01-12).

But I suspect you mean that you have your own parser that expects the
old format only, I didn't find which way it was by grepping
git-cinnabar's sources.
