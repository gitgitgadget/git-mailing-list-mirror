Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBD8C433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA772078D
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 16:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RROnMJlA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbgFHQWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHQWn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 12:22:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C8C08C5C3
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 09:22:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so19616221ljm.9
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9WU6nnyxAnRIPbJWAKa+Otwu4VD7bmy+67sSn15dZxE=;
        b=RROnMJlAIgvOY8aE9zssrQpO6tAFSRbwOFy/ejgdMbWYp1Rm0A9xBIip/mckiClfNb
         lOS8oPl98XZouyUM9A0mqJ6wh5FKbm/XEoMwmyK3vd+r6O8SbDJa4KzG8FQfzURjwAxZ
         i95jBEA37OzvE5Uo4M7UQ7NOpsL+3RLe9iM3cdDS4F4JJKJGFSxIJMPHFzzLKM1bHfGo
         kIAB5+6//NC/MPhZV6uSqS1qke/FekRTTmpFeTl+S+h1DI3o+ur4Fp+pqnjLCZNpOGk0
         eJW35K3YYfQ9Tr059UDaeKSTOnLW6rRyee++iFeXl58LAiKYtjavprHjG8+SUu4n7B52
         92MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=9WU6nnyxAnRIPbJWAKa+Otwu4VD7bmy+67sSn15dZxE=;
        b=kAvESmefNT39lmFAPCwjifP6LQ04dPnztXyTXtxyeK590uON5FsUxi2dqKgZNq4W3D
         9++YPLXTrPHRSZgTNVE8StFEbP45+w+s/EL1/ZL6+ec8P83O6jN2okGiXjSLMH9xSYUG
         EKQr5j+SU4FroDVaCI4i18T48s70c3IOf/ryouEN9re19g1kHCkCvV+V93MplboIS1yk
         BJvpYOXWtnzAO7ErPVAO5AOT+rd3DsS/b27YP7l3MUYIFUlx6lzI+4wnoFcQHhXmq4fz
         mq5f1ZSQ24GR9cV8hQcuZXsHQvwluCQVvca0EmVS4j2xZIqVwkRBQKdwduEtiVPgcDs0
         +/Nw==
X-Gm-Message-State: AOAM533bX1QwR7gdhJhr1i5KVW9CcRxL5R3aBfDRYTC1bNJ/rdNXBwMy
        Lj16MPb+4Mtu/Xc6Iuf1GVyzbBRer1o=
X-Google-Smtp-Source: ABdhPJyTvlST5uuTSLL5ppzEstL+CIeQthfZ3kK/1WTSPZCd4GBBqSNWZDZWZQhFeetPgEYWnpWIwQ==
X-Received: by 2002:a2e:b550:: with SMTP id a16mr12232021ljn.345.1591633361399;
        Mon, 08 Jun 2020 09:22:41 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id i23sm1562812ljh.56.2020.06.08.09.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 09:22:40 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSOC Patch v2 0/4] Move generation, graph_pos to a slab
In-Reply-To: <20200607193237.699335-1-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Mon, 8 Jun 2020 01:02:33 +0530")
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
        <20200607193237.699335-1-abhishekkumar8222@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
Date:   Mon, 08 Jun 2020 18:22:39 +0200
Message-ID: <85d069ttm8.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> The struct commit is used in many contexts. However, members
> `generation` and `graph_pos` are only used for commit graph related
> operations and otherwise waste memory.
>
> This wastage would have been more pronounced as we transition to
> generation number v2, which uses 64-bite generation number instead of
> current 32-bits.

It would be nice (though not required) to have some specific data:
benchmarks with time and memory (RSS maybe?) of Git commands using
commit-graph and those not using it, before and after this patch series.
Maybe time to run the test suite, or the perf suite...

But this is not a show stopper, in my opinion.

Best,

  Jakub Nar=C4=99bski


> Abhishek Kumar (4):
>   commit-graph: introduce commit_graph_data_slab
>   commit: move members graph_pos, generation to a slab
>   commit-graph: use generation directly when writing commit-graph
>   commit-graph: minimize commit_graph_data_slab access
>
>  alloc.c                         |   2 -
>  blame.c                         |   2 +-
>  bloom.c                         |   7 +-
>  commit-graph.c                  | 127 ++++++++++++++++++++++++--------
>  commit-graph.h                  |  10 +++
>  commit-reach.c                  |  69 ++++++++++-------
>  commit.c                        |   8 +-
>  contrib/coccinelle/commit.cocci |  18 +++++
>  revision.c                      |  20 +++--
>  9 files changed, 190 insertions(+), 73 deletions(-)
