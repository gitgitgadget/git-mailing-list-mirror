Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEC7C433DF
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527362077D
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 19:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfQdVRpV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgFETBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgFETBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 15:01:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A99EC08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 12:01:00 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so13067816ljn.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ncVNZ/RMYpGow7tVF4PjbSfBXNR3RPPDZYOt05QzOsM=;
        b=XfQdVRpVEcg8VQsAszKBq3rRHYTYv+RLhVW6hXUO4WEyVoX4qLErcv0Q6/UvchU0SW
         PBTXTFyMJyqr6r5B+Nfj77DvCnaHTxgFgP6z2he/mIVrBK98iQEyeaEP05GplHXMym0U
         CiszyMXVTuWXMqyyu9cAOObZNbzjP20wdQjcOG2MTMLeYUe2m7Ahtzsyy148HfjISCXy
         grk0aW9i0ZBTNxZgWG5ijtS6ww5CVIiJs7TZn3H4KdZNkNwkVXA2SES/SVIB3BOSFS4g
         tfWyVg0eUd2+YHtKLgU7dgg2EWOWXsBL+BBJbXawELelB+1aBwiSFzjoPRtzF3DdenOT
         gA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=ncVNZ/RMYpGow7tVF4PjbSfBXNR3RPPDZYOt05QzOsM=;
        b=gfdMa1WVfqvaklsvuYjRE9JTQA+eaNx3rQ0edsQy6QA+vhS8P3J6MznLtic7OgYU+z
         nJe1qRUXDNVd6kFeCSuCH05QWe81zuSshdk5N7e87XXPDLW+xCE9ZvDdhbtilX8OVVdo
         ZHqoMX29FuZ0/61UFkm13KKHmnqbCysufPwr1BjxcJzOHjsQS1QV8wgBHag4QrzIHgFQ
         B3Qn6GQRqfdnHWgITZBEdiwuBhCSBm1QAFd9ogWS8aRaBkLwRPtUfMqetQvleSrFZIpG
         uGk9e3ulvfcaWsL+VtrkZYG3HZG13j4Iip6zOJe/bja+YNyDORjl13AAhfv4BOntav6M
         0jnw==
X-Gm-Message-State: AOAM530ThDNAw9cDaiaazKjHbUjuZZt163e0mNd+SHd3Kpzv2ilhZZos
        uCtETIgHhxMaltoRWw1lvJs=
X-Google-Smtp-Source: ABdhPJyioi6E9+Zwl4ifOkNk9hyfivLpgptcH+Y5leogfT9zhhEObgvHznne2eOz6xP46W/waLiGnQ==
X-Received: by 2002:a2e:8290:: with SMTP id y16mr5662206ljg.340.1591383658326;
        Fri, 05 Jun 2020 12:00:58 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id y4sm1104924ljd.111.2020.06.05.12.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 12:00:57 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [GSoC Patch 0/3] Move generation, graph_pos to a slab
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
Date:   Fri, 05 Jun 2020 21:00:56 +0200
In-Reply-To: <20200604072759.19142-1-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Thu, 4 Jun 2020 12:57:56 +0530")
Message-ID: <85ftb9wd5j.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> The struct commit is used in many contexts. However, members generation
> and graph_pos are only used for commit-graph related operations and
> otherwise waste memory.

Very minor nitpick: this sentence would read better if the names of
`generation` and `graph_pos` fields (but especially the 'generation')
were quoted.

>
> This wastage would have been more pronounced as transistion to
> generation number v2, which uses 64-bit generation number instead of
> current 32-bits.

Good.  Moving reachability index value into a commit slab was one of
prerequisites to switching to the generation number v2, see [2]

[2]: https://public-inbox.org/git/cfa2c367-5cd7-add5-0293-caa75b103f34@gmai=
l.com/t/#u

The other prerequisite was proper handling of commit-graph format
change, either by using "metadata chunk" as more flexible replacement of
mishandled format version field in the commit-graph file header, or as
proposed in [3] (and subsequent posts), removing "CDAT" chunk and
replacing it with "CDA2" chunk.

[3]: https://public-inbox.org/git/xmqq369z7i1b.fsf@gitster.c.googlers.com/t=
/#u


Also, we should probably stop mishandling the format version field, that
is do not error out [4] when commit-graph version of the file does not
match version supported by git code running the command, but just simply
not use the commit-graph (like it is done for Bloom filter chunks).

[4]: https://github.com/git/git/blob/master/commit-graph.c#L253

>
> The third patch ("commit: convert commit->graph_pos to a slab",
> 2020-06-04) is currently failing diff-submodule related tests (t4041,
> t4059 and t4060) for gcc [1]. I am going to send a second version soon,
> fixing that.
>
> [1]: https://travis-ci.com/github/abhishekkumar2718/git/jobs/343441189
>
> Abhishek Kumar (3):
>   commit: introduce helpers for generation slab
>   commit: convert commit->generation to a slab
>   commit: convert commit->graph_pos to a slab
>
>  alloc.c                             |   2 -
>  blame.c                             |   2 +-
>  bloom.c                             |   6 +-
>  commit-graph.c                      | 116 +++++++++++++++++++++-------
>  commit-graph.h                      |   8 ++
>  commit-reach.c                      |  50 ++++++------
>  commit.c                            |   6 +-
>  commit.h                            |   6 --
>  contrib/coccinelle/generation.cocci |  12 +++
>  contrib/coccinelle/graph_pos.cocci  |  12 +++

It is nice to see the use of Coccinelle scripts.

>  revision.c                          |  16 ++--
>  11 files changed, 158 insertions(+), 78 deletions(-)
>  create mode 100644 contrib/coccinelle/generation.cocci
>  create mode 100644 contrib/coccinelle/graph_pos.cocci

Best,
--=20
Jakub Nar=C4=99bski
