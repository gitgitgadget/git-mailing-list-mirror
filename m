Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8624C433E8
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D8B206D8
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 20:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C30wlQYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXUr2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:47:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53514 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgGXUr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 16:47:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF71075347;
        Fri, 24 Jul 2020 16:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k/mAyYaSF2kTu1+/VnBoWt0vMgs=; b=C30wlQ
        YspZYj8Prg3ft/1R+xmwW3mvb08sqlus2X1LSkfZgUfMnBEse7IoJBfHkFoI1Ysh
        pnSQaZNTscQlw4vMV2SZg9ZPFSigoVMVIVvdmxtxONugL2XsxlfRzQJTx8QPAr7P
        FyBdg2dirGhURS2Mkum0xE/n1xIydSGhlM/vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y4NP5JVNFQbU4a/I+e8WdUaDbpOi1HC4
        +CV+wk74mpCWkvlZl3cjyToEKHRznnoRezvKjBYYT/ljHs1jyvhP7X0K4beZFB/z
        qOKhhdhEU/WQRIM3sNnzQQRC23scb6rkJnG1ixM7fpTqeeXvu1HXwrSLAq8UY7VA
        r7EfAr10VYU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E21C575346;
        Fri, 24 Jul 2020 16:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66CEA75345;
        Fri, 24 Jul 2020 16:47:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 08/18] maintenance: add prefetch task
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <3165b8916d2d80bf72dac6596a42c871ccd4cbe6.1595527000.git.gitgitgadget@gmail.com>
        <xmqqwo2uosvz.fsf@gitster.c.googlers.com>
        <52fc3f5a-281c-a0cb-d897-3866315913a1@gmail.com>
Date:   Fri, 24 Jul 2020 13:47:24 -0700
In-Reply-To: <52fc3f5a-281c-a0cb-d897-3866315913a1@gmail.com> (Derrick
        Stolee's message of "Fri, 24 Jul 2020 10:25:52 -0400")
Message-ID: <xmqqr1t0k5cz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1537D36-CDEE-11EA-9F18-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I don't anticipate users specifying --task=<task> very often, as
> it requires deep knowledge of the tasks. If a user _does_ use the
> option, then we should trust their order as they might have a
> good reason to choose that order.
>
> Generally, my philosophy is to provide expert users with flexible
> choices while creating sensible defaults for non-expert users.

Sounds sensible.
