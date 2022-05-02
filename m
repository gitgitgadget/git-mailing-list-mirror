Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14F5C433F5
	for <git@archiver.kernel.org>; Mon,  2 May 2022 18:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386966AbiEBSyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 14:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387067AbiEBSyP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 14:54:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF0E2BC2
        for <git@vger.kernel.org>; Mon,  2 May 2022 11:50:45 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 727FF184A34;
        Mon,  2 May 2022 14:50:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=308emf6jeFayORIttOqiCUZFRQx5G3hJU7kh4Q9fA4E=; b=O2N5
        be7914MXoN67eYqMwPYKKYzY438HK3TWMF05uuBsfwrsbAujPepZaqBcRUR1ruBp
        6VDm72J/bxpgK+lpkacC8EoLPBrZpTUhQ5mrUO1jf5Ck7F3buJlUXUVzNBjAKsEA
        A8qhl6MsY8+QbYUr2LPA3ORpq7H6EuTSye9tY3U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B33D184A32;
        Mon,  2 May 2022 14:50:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EAD2F184A30;
        Mon,  2 May 2022 14:50:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        justin@justinsteven.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
Subject: Re: Bare repositories in the working tree are a security risk
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
        <Ylobp7sntKeWTLDX@nand.local>
        <kl6ly1zno328.fsf@chooglen-macbookpro.roam.corp.google.com>
        <324301af-4ad3-739c-25bb-1ddbe069eb3e@iee.email>
Date:   Mon, 02 May 2022 11:50:40 -0700
Message-ID: <xmqqr15bydj3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4333CD4-CA48-11EC-9C4D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Can I check that storing bundles (of other repos) within a repository is
> considered reasonably safe?

I think the threat model we are protecting against is that we
shouldn't have to worry about "git clone" and then "cd" into the
hierarchy.  If you did "make" in there and their Makefile (or
"runme.sh" shipped as part of the tree) is malicious, that is not
something we can solve.

So, I would say it is safe to have a bundle, as in its statinary
state it does not actively do anything bad, even when you did "ls"
in a directory that stores it.

> I have been looking at how Git's documentation could carry with it small
> exemplar repositories that cover the commit hierarchies shown in the
> various man pages to allow users to see, explore and understand the man
> page examples. I'd settled on bundles as a reasonable compromise, with
> the exemplar repositories being generated via the test suite
> (obviously). With the recent focus on security issues, I thought it
> worth asking now.

A bundle would be an OK vehicle.  This depends on the size of the
sample project, but another that may be more suitable may be to
create the repository on the fly in the "test suite" you were
planning to use to extract from the bundle.

