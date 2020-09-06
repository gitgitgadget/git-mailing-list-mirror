Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE160C433E2
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88D87207BB
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ntDP62MQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgIFV6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:58:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59077 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIFV62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 17:58:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4243679CE5;
        Sun,  6 Sep 2020 17:58:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=k1+ABF/UWCAmsMtTGCREAkn+AYY=; b=ntDP62MQR5SiLX4K5YxJ
        3sMcvi8zsWmkU2t9HAk8H7TtYA1O0mPHRxD+xsOvxm/ztowkqIOu1IFkpnsjU2o1
        UrAyyv4h/9Hc4IB0j5ocdEnY2IXBkQq7W1CCRbek2Kzj3UcwsyLcYoeDoMvGDUcq
        kbKudSw897ElsKUzhOoUgXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=uLQR1wLDBDnZmjukknhi4HUr1v327ZYVRNxt6hNt1Ik/Rk
        LiOyqYpCxJd9DJQX9Z1fZiUfZOWvVOthGIcznodwPOeXOTz8KKisEpf+NSywgkEN
        HUYzmCJTqJzmKCfY719Ld4g9GpIStw5TP62cCw2iuJWdL5HVO0lZ/SAW8XJh4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ACB079CE4;
        Sun,  6 Sep 2020 17:58:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BBDF979CE3;
        Sun,  6 Sep 2020 17:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Pratyush Yadav <me@yadavpratyush.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/3] worktree: add -d shorthand for --detach & improve documentation
References: <20200904070703.47898-1-sunshine@sunshineco.com>
Date:   Sun, 06 Sep 2020 14:58:25 -0700
Message-ID: <xmqqlfhm36v2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16DCDB5E-F08C-11EA-B0D4-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This series grew directly out of suggestions proposed in [1]. Its
> purpose is twofold. First, it brings git-worktree in line with the other
> "checkout a branch" commands git-switch and git-checkout by teaching it
> -d as shorthand for --detach (which those other commands already
> understand).

Hmph, "checkout" would not affect list of worktrees, but "worktree"
could be used to delete an worktree, so I (or any other naive user
like me) may mistake "-d" to mean "delete a worktree".

But it is not "teach 'worktree' that -d is shorthand for --detach";
it is "teach 'worktree add' that -d is for --detach".  And in that
context, when adding a new worktree, there is no room for such a
confusion to come into the picture.

So I think it is just the way the series is marketted that triggered
a potential negative reaction from me.

>   worktree: add -d short option for --detach
