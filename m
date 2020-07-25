Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FCDC433E0
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176D42070E
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 01:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s8JEaJge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgGYBsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:48:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64784 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgGYBsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 21:48:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FEDF77139;
        Fri, 24 Jul 2020 21:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NNBk0BEZMvbo
        Yjd4pWjKwnsb2Us=; b=s8JEaJgeS7MDTr0tH9GNKqJqS5GPxCM60n/40ID0PNFN
        KANlDpS/O5MmzA27A+7mwkFckHE35pKnTM+wnHWxbIU02Fr0waGhR/kEE+FHSylC
        CySvAiOHfSQnUYQZidmZ53ScfE/S7sCSbszmsJB+x/Nfx2Z9n3gTQzbehS9bMO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Z3Ccet
        X+5UConF8Y+FRJrC2j+1qaiBNqevDJTMgq7q7FQpiH+6MF5bbtjZJj0gwyy4VWTl
        A7ZRrrD/53ch4eD5XjF4j1NEGhsdM7xBWq40I+zd94vKZsicdMSvefezufEJ60VP
        yTKO3P4Zsyjxy1dLeb7Mat4M6+hFQn99q8dVI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84C3D77138;
        Fri, 24 Jul 2020 21:48:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F009977136;
        Fri, 24 Jul 2020 21:48:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/18] maintenance: add prefetch task
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
        <20200725013715.GA2436@danh.dev>
Date:   Fri, 24 Jul 2020 18:48:06 -0700
In-Reply-To: <20200725013715.GA2436@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcg==?=
 =?utf-8?B?4bqnbiBDw7RuZw==?= Danh"'s message
        of "Sat, 25 Jul 2020 08:37:15 +0700")
Message-ID: <xmqqv9icicvd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E2EF1C66-CE18-11EA-84D3-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> When running 'git fetch <remote> <options>' in the background, use
>> the following options for careful updating:
>
> Does this job interfere with FETCH_HEAD?
> From my quick test (by applying 01-08 on top of rc1, and messing with t=
7900),
> it looks like yes.
>
> I (and some other people, probably) rely on FETCH_HEAD for our scripts.
> Hence, it would be nice to not touch FETCH_HEAD with prefetch job.

Very good point.  For that, Derrick may want to swallow the single
patch from 'jc/no-update-fetch-head' topic into this series and
pass the new command line option.




